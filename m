From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 04:42:56 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102160421300.14950@debian>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102151606.21040.johan@herland.net> <7vipwlp3yv.fsf@alter.siamese.dyndns.org> <201102160154.24744.johan@herland.net> <vpqy65gs6hs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 16 10:43:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppdug-0003NL-34
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815Ab1BPJnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 04:43:05 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60189 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374Ab1BPJnB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 04:43:01 -0500
Received: by qyj19 with SMTP id 19so3409726qyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=WU2XWkbaVlhhJg80KfrkaZ2W/veuL+ErcM2p83Xltks=;
        b=grbxoOJafaSD3TWRsuS5K1Rr2v4oypcz+eMj2op3zhuAuUVQ8F4MuC3N3P4pUrAml1
         tBFV19q1BIRTcnJVX1YwypoJr2U4o8oYPT5iqtl/6yZkA5EONqVK+3YQ2wi3ALe9hEA6
         7O6tiPOrZv9kjTRwppcpfeA6yPWv1uKx0YukA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=o4tunayvF5+khPE1ielOIdlJtHGp/R2xqzjZhUQRn4mgKoWHhKEQG1GouX/JCboj6M
         7F/Qzy1PKoWJPhZ08YvvUGsp+G5tLwCNw7OxoVVnifNpCynJxlzerE6iavoIVDo8gyqr
         gxw+cf118nU4S881Gu0IT54U6zuRQ1OMSb2lo=
Received: by 10.224.10.197 with SMTP id q5mr459223qaq.261.1297849380005;
        Wed, 16 Feb 2011 01:43:00 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h18sm3476991vbr.14.2011.02.16.01.42.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 01:42:58 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <vpqy65gs6hs.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166939>

On Wed, 16 Feb 2011, Matthieu Moy wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > In order to make this more understandable to the user, we rename the
> > push.default == 'tracking' option to push.default == 'upstream'.
> 
> While we're there, shouldn't we also rename 'branch.<remote>.merge' to
> 'branch.<remote>.upstream'?

I have a draft proposal not exactly to rename it, but to replace it by
a new branch.<name>.upstream which would point to local ref rather
than a ref on the remote, so one would have e.g.
branch.topic.upstream = refs/remotes/origin/master. Maybe I should
clean up that proposal and send it soon. The topic comes up quite
frequently.

My biggest concern with it is that it breaks the use case where the
remote is not named, i.e. where one has a configuration that looks
like:

[branch "topic"]
	remote = git://git.kernel.org/pub/scm/git/git.git
	merge = master

I don't know how common that case is, so I don't know if it would it
be acceptable to break it. I would of course not suggest no longer
fall back to reading branch.<name>.(remote+merge), but at some point
we would drop support for that and then we would disallow that use
case.

I'm also not sure the benefits are that great; this is just one of
those things I think "we should do differently if designing git from
scratch".

What do you think? Should I even bother sending a formal proposal?


/Martin
