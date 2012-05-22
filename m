From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Tue, 22 May 2012 18:27:08 -0400
Message-ID: <CAOnadRGgduprp_Dbjzf_TsyQQQjivzKxCgUq4y_HevvtKd7h7Q@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com> <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?ISO-8859-1?Q?Ville_Skytt=E4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 00:27:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWxYD-0000SE-CT
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 00:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091Ab2EVW13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 18:27:29 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62345 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2EVW12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 18:27:28 -0400
Received: by weyu7 with SMTP id u7so4201736wey.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 15:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=dkim-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:x-gm-message-state;
        bh=QcGgeMwpQgJdTUqPJ1CHrw5RXLJBLULYQGPjAGBIthA=;
        b=CGwwR62F4XaNTmysz0H3DZsHWFJCiVFjZWTQtk3oD6Bc6Isxx3fDrcmsJEC794dAat
         E2FvfwXAl2ZMJGoUUU/DkyLcyigDKaAaVg9+peu7F6DrpjEXCXip4GE//m0BoXncoeBB
         SGKJ3jq67/aSQ5A6KpynoKWFzbLq0pQDh+YyCt3KI2QIUfSLikk8tSzNMUx+E/SfvoLs
         Z2YBBVsnAJFB3JSb1onBu7u1qhywhvg1zHEtqhwMO02UZv8QCj79Kl5y6z/Elqfnosej
         dV5tQp6mmrhAipWOkE/Kb/Lgd1yZLgsHx+m9iOibJpsWLobw+8k+2D2XvYpx+eDw6zR3
         xK1Q==
Received: by 10.180.100.230 with SMTP id fb6mr38073994wib.3.1337725645355;
        Tue, 22 May 2012 15:27:25 -0700 (PDT)
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com [74.125.82.174])
        by mx.google.com with ESMTPS id et10sm35789492wib.2.2012.05.22.15.27.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 15:27:24 -0700 (PDT)
Received: by weyu7 with SMTP id u7so4201727wey.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tedpavlic.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QcGgeMwpQgJdTUqPJ1CHrw5RXLJBLULYQGPjAGBIthA=;
        b=ghkt5yRlGT5EtY6Zqxs09FJR0BIwAlnPdfPf8EenjRZcRYjafA1NdjWmWErn9WZa0n
         td3bUIXPOVfZOXVuseecpwniPjjCxD42C3uLRq6424+S+MxKLEVgM1ZUmjP2OFKLtsH+
         riRhyz1isA7GDQXT4WKkv2xKo1n9NimYwLWLY=
Received: by 10.180.85.129 with SMTP id h1mr39005400wiz.2.1337725643997; Tue,
 22 May 2012 15:27:23 -0700 (PDT)
Received: by 10.216.131.211 with HTTP; Tue, 22 May 2012 15:27:08 -0700 (PDT)
In-Reply-To: <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
X-Gm-Message-State: ALoCoQmHQbQHDE5YEvio+RDl8d/ZZ3n1uvYmyLPykO3FL5SEQUuqGo8CZD3TCRZWZSLglAdCXzW+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198261>

> The solution, proposed by Kerrick Staley[3], is to split the git script
> in two; the part that deals with __git_ps1() in one (i.e.
> git-prompt.sh), and everything else in another (i.e.
> git-completion.bash).

Seems like this solution has popped up on lots of forums for about
every Linux distribution around the time the new bash completion was
introduced. I'm not sure Kerric Staley deserves sole attribution
(sorry Kerrick; I mean no offense).

Moreover, every time the subject of splitting __gitdir out comes up, a
side discussion about all of the complications that could cause comes
up... and people give up and hope that the folks upstream (i.e., here)
will come up with a better solution.

If it was so simple to just split __gitdir out, I think it would have
already been done.

> The only slight issue is that __gitdir() would be duplicated, but this
> is probably not a big deal.

That seems ugly. I know that splitting __gitdir out is also ugly, but
I know that there are going to be a lot more people who use git
completion than git_ps1. Consequently, in a duplicated __gitdir
scneario, I worry that __gitdir will receive more attention and may
relatively quickly diverge in implementation if not very careful in
approving patches. Moreover, a __gitdir of the future may not be
atomic and will pick up side effects and become impossible to manage
in two places.

So maybe a split out "git-gitdir.sh" that both files include would be
"better." Either that or the functionality of "__gitdir" gets pulled
into git itself. (perhaps a git-gitdir added to the main git
distribution)

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

As the patch is from you, there's no need to sign off on it too.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>
