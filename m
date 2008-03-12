From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Simplify MSGFMT setting in Makefile
Date: Wed, 12 Mar 2008 01:51:53 -0400
Message-ID: <20080312055153.GS8410@spearce.org>
References: <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <47C7000C.1000809@gmail.com> <20080305071915.GI8410@spearce.org> <7v63w0gs87.fsf@gitster.siamese.dyndns.org> <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 06:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZJtF-00030T-9N
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 06:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbYCLFv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 01:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYCLFv6
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 01:51:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38874 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYCLFv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 01:51:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JZJsX-00060e-Ny; Wed, 12 Mar 2008 01:51:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4886620FBAE; Wed, 12 Mar 2008 01:51:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76928>

Junio C Hamano <gitster@pobox.com> wrote:
> To prepare msg files for Tcl scripts, the command that is set to MSGFMT
...

Thanks.

>  * I am planning to close 'master' for -rc1 by the end of this week, so
>    please plan to tell me to pull if you have accumulated changes,
>    thanks.

Please pull.  What is in my master right now (7276607 which is
this patch) will likely be gitgui-0.10.0.  I'm unlikely to have
any further changes (beyond perhaps updated po files) between now
and 1.5.5 final.

>  Makefile |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 4e32174..95e99f2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -221,14 +221,9 @@ ifdef NO_MSGFMT
>  	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
>  else
>  	MSGFMT ?= msgfmt
> -	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
> +	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $?),0)

Missing a $ here, it should be $$? not $?.  Fixed up when I applied.

-- 
Shawn.
