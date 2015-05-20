From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 13:09:29 +0200
Message-ID: <20150520130929.Horde.vYwOuIDRpi6hr15rOUbW1w7@webmail.informatik.kit.edu>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
 <1432112843-973-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 13:09:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv1sk-0003ph-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 13:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbbETLJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 07:09:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43016 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751628AbbETLJp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 07:09:45 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Yv1sb-0005bc-3J; Wed, 20 May 2015 13:09:41 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Yv1sP-00057B-4n; Wed, 20 May 2015 13:09:29 +0200
Received: from x590cf2cc.dyn.telefonica.de (x590cf2cc.dyn.telefonica.de
 [89.12.242.204]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 20 May 2015 13:09:29 +0200
In-Reply-To: <1432112843-973-2-git-send-email-davvid@gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1432120181.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269459>


Quoting David Aguilar <davvid@gmail.com>:

> +translate_merge_tool_path() {
> +	# Use WinMergeU.exe if it exists in $PATH
> +	if type -p WinMergeU.exe >/dev/null 2>&1
> +	then
> +		printf WinMergeU.exe
> +		return
> +	fi
> +
> +	# Look for WinMergeU.exe in the typical locations
> +	winmerge_exe=3D"WinMerge/WinMergeU.exe"

This variable is not used elsewhere, right?  Then you might want to =20
mark it as local to make this clear.

> +	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=3D=
' |
> +		cut -d '=3D' -f 2- | sort -u)
> +	do
> +		if test -n "$directory" && test -x "$directory/$winmerge_exe"
> +		then
> +			printf '%s' "$directory/$winmerge_exe"
> +			return
> +		fi
> +	done
> +
> +	printf WinMergeU.exe

Please pardon my ignorance and curiosity, but what is the purpose of =20
this last printf?
It outputs the same as in the case when winmerge is in $PATH at the =20
beginning of the function.  However, if we reach this printf, then =20
winmerge is not in $PATH, so what will be executed?


G=C3=A1bor

> +}
> --
> 2.4.1.218.gc09a0e5
