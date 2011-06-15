From: ydirson@free.fr
Subject: Re: Commit notes workflow
Date: Wed, 15 Jun 2011 11:20:13 +0200 (CEST)
Message-ID: <243233943.1008861308129613120.JavaMail.root@zimbra44-e7.priv.proxad.net>
References: <201106141215.50689.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Dirson <dirson@bertin.fr>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWmGy-00061i-VH
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 11:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab1FOJUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 05:20:22 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:46917 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab1FOJUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 05:20:21 -0400
Received: from zimbra44-e7.priv.proxad.net (unknown [172.20.243.194])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 90C644C8182;
	Wed, 15 Jun 2011 11:20:14 +0200 (CEST)
In-Reply-To: <201106141215.50689.johan@herland.net>
X-Originating-IP: [80.150.211.114]
X-Mailer: Zimbra 5.0 (ZimbraWebClient - SAF3 (Linux)/5.0.15_GA_2815.UBUNTU8_64)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175812>

> > A (minor) problem with the second possibility is that this naming
> > convention could evolve, eg. if we end up with something like was
> > proposed in [1] for 1.8.0.  Is there any real drawback with the
> first
> > suggestion ?
> > 
> > [1] http://marc.info/?l=git&m=129661334011986&w=4
> 
> My gut feeling is to keep some sort of limit notes refs, and if/when we get 
> around to implementing my proposal in [1] (or some variation thereof), we 
> will of course extend the limit to put "refs/remotes/$remote/notes/*" (or 
> whatever is decided) in the same category as "refs/notes/*".
> 
> In the meantime, I'm unsure if it's a good idea to remove the limitation 
> altogether (allowing notes refs everywhere), since re-introducing a limit at 
> a later point will then be MUCH harder...

I'm still unsure what that limitation brings to us.  OTOH, it has at least one
funny downside: when someone tries to refer to some forbidden ref using --ref, it
gets silently requalified:

$ git notes --ref=refs/remote-notes/foo add
$ find .git/refs/notes/ -type f
.git/refs/notes/refs/remote-notes/foo
$

It just seems so wrong...  Surely we can mitigate it by considering a ref starting
with "refs/" to be absolute, and thus never prepend "refs/notes/" to it, but it rather
sounds to me a symptom that we may not want to filter things anyway.
