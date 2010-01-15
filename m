From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] difftool: Use eval to expand '--extcmd' expressions
Date: Fri, 15 Jan 2010 09:40:44 +0100
Message-ID: <4B502A0C.50108@viscovery.net>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com> <1263539762-8269-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 09:40:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVhjh-0005Vg-9u
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 09:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab0AOIkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 03:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755698Ab0AOIkt
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 03:40:49 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33043 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751709Ab0AOIks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 03:40:48 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NVhjZ-00076h-Gb; Fri, 15 Jan 2010 09:40:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 243AF1660F;
	Fri, 15 Jan 2010 09:40:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1263539762-8269-3-git-send-email-davvid@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137060>

David Aguilar schrieb:
> -		$GIT_DIFFTOOL_EXTCMD "$LOCAL" "$REMOTE"
> +		(eval $GIT_DIFFTOOL_EXTCMD "\"$LOCAL\"" "\"$REMOTE\"")

The new code is broken if $LOCAL or $REMOTE can contain double-quotes. How
about this alternative:

		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'

which I find more readable as well.

What's the reason for the sub-shell? Do you want to protect from shell
code in $GIT_DIFFTOOL_EXTCMD that modifies difftool's variables?

-- Hannes
