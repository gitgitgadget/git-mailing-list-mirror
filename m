From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 16:34:01 +0100
Message-ID: <4B912469.8060705@viscovery.net>
References: <4B90C701.3070308@gmail.com> <4B90C974.2050405@viscovery.net> <20100305151248.GA24748@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiri Slaby <jirislaby@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 16:34:18 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnZXa-0004Vs-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 16:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab0CEPeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Mar 2010 10:34:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37649 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752875Ab0CEPeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Mar 2010 10:34:05 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NnZXO-0001rF-7u; Fri, 05 Mar 2010 16:34:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F0C031660F;
	Fri,  5 Mar 2010 16:34:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100305151248.GA24748@progeny.tock>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141584>

Jonathan Nieder schrieb:
>  =B7 Otherwise, git treats the pattern as a shell glob suitable for
>    consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards in=
 the
>    pattern will not match a / in the pathname. For example,
>    "Documentation/*.html" matches "Documentation/git.html" and
>    "tools/perf/Documentation/perf-diff.html" but not
>    "Documentation/ppc/ppc.html".

This is not correct: When the pattern "Documentation/*.html" matches
"Documentation/git.html", then it cannot match
"tools/perf/Documentation/perf-diff.html". This is because patterns tha=
t
contain a slash (after stripping a trailing slash) are anchored at the
directory that contains the .gitignore.

Said pattern would match the latter name only if it appeared in
tools/perf/.gitignore (but in this case it wouldn't match the former na=
me,
of course).

-- Hannes
