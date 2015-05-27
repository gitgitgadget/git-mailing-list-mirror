From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a
 commit
Date: Wed, 27 May 2015 16:53:06 +0200 (CEST)
Message-ID: <1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 27 16:53:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxchm-0003Z9-1N
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 16:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbE0OxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 10:53:09 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59130 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752133AbbE0OxH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 10:53:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 918FE4882C;
	Wed, 27 May 2015 16:53:03 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4Hj2w3IvCPr; Wed, 27 May 2015 16:53:03 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 79601487F8;
	Wed, 27 May 2015 16:53:03 +0200 (CEST)
In-Reply-To: <c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: Add key word "drop" to remove a commit
Thread-Index: 9Zd2gaXb1FPIDqKe7QsuRP0l/ANPXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270056>

Thank you for reviewing the code.

Johannes Schindelin<johannes.schindelin@gmx.de> writes:
> Please note that you can already just comment-out the line if you need to keep a visual trace.
> 
> Alternatively, you can replace the `pick` command by `noop`.
> 
> If you really need the `drop` command (with which I am not 100%
> happy because I already envisage users appending a `drop A` to an
> edit script "pick A; pick B; pick C" and expecting A *not to be
> picked*)

It is true that drop has the same effect as noop or commenting,
however we thought that drop is more understandable for average users of
git. Moreover when using git rebase -i, the 'help' displayed below the
list of commits doesn't mention neither the noop command nor the
effect of commenting the line (though considering what removing a line
does, it can be easily deduced).

The drop command was inspired by the drop command from histedit in
mercurial.

It also has some effects with the second part of this patch (checks
removed and/or duplicated commits): if you comment the line, the
commit will be considered as removed, thus ending in a warning if the
config variable is set to warn/error; however this problem won't
appear with noop.
