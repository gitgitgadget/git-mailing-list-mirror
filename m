From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Sun, 13 Feb 2011 22:15:11 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102132205110.4253@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vd3mz33xb.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102111811300.26684@debian>
 <alpine.DEB.2.00.1102132047500.4253@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 04:15:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoouN-0004qx-C1
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 04:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab1BNDPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 22:15:17 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60805 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1BNDPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 22:15:15 -0500
Received: by vws16 with SMTP id 16so2764863vws.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=UvX+9V/b4zw0Zg8CdIAtemmi4rgNlB1W/NJIoJslXQM=;
        b=FQnmOXojQqKFQ5k71krEog6Jqnt2Qc74af7d/VdSnarzn0xfjQ/QpkNEe9NSf7UGv3
         eirP/ZYZ5MsUdBXe+OOl/j+kss4Y6sGQhyuRNMZYq34tZC0q90KL+YfRsM7m8rqdF3Tq
         D6yDMtrMzw6vQEyAQ5XER2AVz6vc4LOrf36XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=fdimSVBNG0tB1aK2XaPEwawplynP1gHxlCff3c1/YeIu/jFJNZcFQkfXz5l8nX4pdD
         pA27FbgSk/GrMFEU6HQxAfWhCjOy1KN0uHA5sPx2z4ZzZSAAzW51H/BxNyj+E4KB/ZV4
         01nJud+LwPGxIHTux4i3Eo6hqsvPAoGdmhtQk=
Received: by 10.220.181.9 with SMTP id bw9mr259728vcb.13.1297653314969;
        Sun, 13 Feb 2011 19:15:14 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g2sm1570746vbz.10.2011.02.13.19.15.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 19:15:14 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1102132047500.4253@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166687>

On Sun, 13 Feb 2011, Martin von Zweigbergk wrote:

> On Fri, 11 Feb 2011, Martin von Zweigbergk wrote:
> 
> > On Thu, 10 Feb 2011, Junio C Hamano wrote:
> > 
> > > I am not sure if forbidding "-v --continue" adds any value; would it be
> > > too much effort to allow "--continue -v" instead to achieve the same
> > > degree of consistency between the two?
> > 
> > I'll have a look at it when
> > I get some time.
> 
> This would apply on top of mz/rebase after dropping 95135b0 (rebase:
> stricter check of standalone sub command, 2011-02-06). If you agree
> with it, I will include it in a future re-roll.

Sorry, anyone who intends to test it, squash in this missing
test_must_fail first.

-- 8< --
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 1581f00..02ac92f 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -95,7 +95,7 @@ test_expect_success 'rebase --continue --no-rerere-autoupdate overrides' '
 	git reset --hard topic@{1} &&
 	test_must_fail git rebase -m --rerere-autoupdate master &&
 	test "$(cat F2)" = "Resolved" &&
-	git rebase --continue --no-rerere-autoupdate &&
+	test_must_fail git rebase --continue --no-rerere-autoupdate &&
 	test "$(cat F3)" = "Resolved" &&
 	test_must_fail git rebase --continue &&
 	git add F3 &&
