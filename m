From: ydirson@free.fr
Subject: Re: Commit notes workflow
Date: Wed, 15 Jun 2011 11:57:30 +0200 (CEST)
Message-ID: <450570199.1013051308131850322.JavaMail.root@zimbra44-e7.priv.proxad.net>
References: <243233943.1008861308129613120.JavaMail.root@zimbra44-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Dirson <dirson@bertin.fr>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:57:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWmr3-00078W-1i
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 11:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab1FOJ5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 05:57:40 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:51604 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab1FOJ5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 05:57:38 -0400
Received: from zimbra44-e7.priv.proxad.net (unknown [172.20.243.194])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8F7E74C803F;
	Wed, 15 Jun 2011 11:57:31 +0200 (CEST)
In-Reply-To: <243233943.1008861308129613120.JavaMail.root@zimbra44-e7.priv.proxad.net>
X-Originating-IP: [80.150.211.114]
X-Mailer: Zimbra 5.0 (ZimbraWebClient - SAF3 (Linux)/5.0.15_GA_2815.UBUNTU8_64)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175818>


> I'm still unsure what that limitation brings to us.  OTOH, it has at least one
> funny downside: when someone tries to refer to some forbidden ref using --ref, it
> gets silently requalified:
> 
> $ git notes --ref=refs/remote-notes/foo add
> $ find .git/refs/notes/ -type f
> .git/refs/notes/refs/remote-notes/foo
> $
> 
> It just seems so wrong...  Surely we can mitigate it by considering a ref starting
> with "refs/" to be absolute, and thus never prepend "refs/notes/" to it, but it rather
> sounds to me a symptom that we may not want to filter things anyway.

While playing with this, I realized that when editing the template
does not name the notes ref being edited.  When looking at the code,
I notice that, contrarily to commit.c which uses stdio, notes.c uses
write_or_die(), which is a bit less flexible for formatting.

I'd think we could me things more consistent - is there any objection
to switch notes.c to using stdio for this ?
