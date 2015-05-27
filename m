From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated
 commits
Date: Wed, 27 May 2015 15:23:01 +0200 (CEST)
Message-ID: <1660192861.39291.1432732981552.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 15:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbIY-0000RB-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbbE0NXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:23:01 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57704 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542AbbE0NXA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 09:23:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AE99048821;
	Wed, 27 May 2015 15:22:58 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fGuXqHMsWmid; Wed, 27 May 2015 15:22:58 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 96C36487F8;
	Wed, 27 May 2015 15:22:58 +0200 (CEST)
In-Reply-To: <CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: Warn removed or dupplicated commits
Thread-Index: BNakz7Hc/YTAz+CnC+FmPL0z4m8zRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270045>

Eric Sunshine<sunshine@sunshineco.com> writes:
> Shouldn't this case also 'die' when rebase.checkLevel is "error"? And,
> why doesn't the user get advice about configuring rebase.checkLevel in
> this case?
Stephen Kelly<steveire@gmail.com> writes:
> I sometimes duplicate commits deliberately if I want to split a commit in
> two.
Matthieu Moy<Matthieu.Moy@grenoble-inp.fr> writes:
> The more I think about it, the more I think we should either not warn at
> all on duplicate commits, or have a separate config variable.
Put in common because two config variables would have an effect on the
'die' and advise part.

In this patch we didn't put the 'die' in the duplicate commit part
since there was only one config variable and there are cases where the
user might want to duplicate commits.

After the code reviewing of Eric Sunshine and Stephen Kelly, we also
came to the conclusion that we should use two config variables, one
about missing commits and the other about duplicate commits.

This way if you deliberately want to use duplicate commits, you can
just set the value to 'ignore' for duplicate commits and still have
'warn'/'error' for missing commits. Moreover, each part would have its
'die' depending on the value of the corresponding config variable.
