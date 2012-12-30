From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 1/2] dir.c: Make git-status --ignored more consistent
Date: Sun, 30 Dec 2012 15:01:22 +0000
Message-ID: <CAOkDyE_N-fOMsrSaHKyu=M1PAN5h0JAYJ9ekN=q7skg9SOzSKg@mail.gmail.com>
References: <20121229072249.GB15408@sigill.intra.peff.net>
	<1356878341-12942-1-git-send-email-apelisse@gmail.com>
	<CALWbr2w=CWkpbJhC5sjd9HnErmWj9JQnD6UUiDM91ovJ_-16vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 16:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpKOX-0000BS-Nj
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 16:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab2L3PB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 10:01:27 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:47527 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab2L3PB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 10:01:26 -0500
Received: by mail-we0-f173.google.com with SMTP id z2so5541898wey.18
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=iDg1MsIp6Tf1kNNws+1MbJ2LOVuAdOpDqiRjIdanSVY=;
        b=TMmSuQZGZIrD0Auw8zh6h2POzNGaVunwFOh7P1UtwXaU3GzyvYp+gD6kxeTfI9vjms
         SEOnjz70lFGtDtA4fwAJ7grJpCNw2O047IiRAdw7gqxsXApwZvImH59QAOGEprCld0Xl
         PUbQDPmYwGF89prnk+wmctTmk3p8mQl2bQFtw7GOQbXAjgh09i6LQW40B2LTWxK3lyuA
         +AhGyTaItIrxDVC5aoy+py0RzkLds/E5M5VK6qufGHHcsFbaGFoHiKPvt+NUJ3a0nGJZ
         G7znLhAr+S22rijcRBA81oX2WVb0iW/BsFA/BwwG4eLj/UtBQtWh0P3m33cbkl0LB0mO
         O7/g==
Received: by 10.194.88.98 with SMTP id bf2mr61311514wjb.49.1356879682414; Sun,
 30 Dec 2012 07:01:22 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Sun, 30 Dec 2012 07:01:22 -0800 (PST)
In-Reply-To: <CALWbr2w=CWkpbJhC5sjd9HnErmWj9JQnD6UUiDM91ovJ_-16vA@mail.gmail.com>
X-Google-Sender-Auth: GJQ9baZgrWoLTtunaEgnqQWucvc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212335>

On Sun, Dec 30, 2012 at 2:54 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> By the way, that merges without conflicts with Adam's series, but it
> will not compile as he renamed functions that I'm now using
> (path_excluded() -> is_path_excluded() that is).

Ah, renames!  I forgot about those.

> By the way, Junio, how do you handle this situation as a maintainer ?
> Do you keep a note to manually make the change every time you remerge
> the series together ? That is the kind of use-case you can't handle
> with git-rerere, and I've been trying to find a solution to it.

Not sure if it helps to note that I am already basing my patch series
on top of Junio's nd/attr-match-optim-more branch.  Nguyen created
that branch which conflicted with mine, but then resolved the conflicts,
so I am basing mine on his to avoid having to continually resolve the
same conflicts.

So you could take the same approach and rebase yours on top of mine,
e.g.

    git remote add junio git://github.com/gitster/git.git
    git fetch junio
    git rebase junio/as/check-ignore
