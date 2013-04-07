From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 00:36:59 +0530
Message-ID: <CALkWK0=v6SD_zEw=taauYWvYD5pHzdrED0vrhuFHKeS2zfgxSw@mail.gmail.com>
References: <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de> <20130407185905.GK2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 21:07:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOuwV-0003Fp-Mw
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 21:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab3DGTHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:07:41 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:36530 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab3DGTHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:07:40 -0400
Received: by mail-ia0-f176.google.com with SMTP id i1so4517199iaa.21
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=x0Yq/ZlpAZ5Y6Vr5/2NqKZ9daXXlvM6E/gOrUsF0FdM=;
        b=SDKRtwBgLCN/Ucx2aEoB+rLPpdzb/w+AbNtLxuAWJdzSzP8DgSBDmwQsvntuJx8IiY
         iUZ9UQIlz1j+Fct/lobaod4OBM4oFNR4zcXbu+3C2ynhvKV5DXOOkKmVwSxJa8kUW3+6
         P6XAdTlDmhGYsP7Lu6G2sCVM86p5M9eT6WX+8kDmk5m6t65YaykrumEPYqeyiOSrRBKA
         MuohSKTByeyjLkiSJZfhqBVAxqYlZBlkkNVnbuLJS33pQzho6UeIyymcYWcJAuU5um9J
         A22fZlI9EnjN9cXXZ+k1iSoUF8xyaIXVoOjcJZcgBoVupzRybPkI9Zc6LNSmGlg2PYMe
         yHog==
X-Received: by 10.50.17.71 with SMTP id m7mr4922092igd.14.1365361659854; Sun,
 07 Apr 2013 12:07:39 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 12:06:59 -0700 (PDT)
In-Reply-To: <20130407185905.GK2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220361>

John Keeping wrote:
> With the clarifications Ram's provided in this thread, I think there are
> also some important regressions in functionality in his proposal (at
> least as it currently stands), particularly losing the .gitconfig
> overrides.

If we want the entire feature list in the very first iteration, it's
going to be huge.

> The only proposed change that seems to me to be impossible with the
> current .gitmodules approach is the "submodule in a non-initialized
> submodule" feature, but I've never seen anyone ask for that and it seems
> likely to open a whole can of worms where the behaviour is likely to
> vary with $PWD.  The current hierarchical approach provides sensible
> encapsulation of repositories and is simple to understand: once you're
> in a repository nothing above its root directory affects you.

That can be implemented in the current submodule system too, fwiw.

> It doesn't seem to me that "it's harder than I'd like to add a feature I
> want" is a good reason to subject all users of submodules to a lot of
> pain migrating to some new implementation that doesn't work the way
> they're used to and which will mean they have to deal with complaints
> when people using an older version of Git can't clone their repository
> (and I doubt we want this mailing list to be flooded with such
> complaints either).

Like I've said before: there is nothing that _cannot_ be done with the
current submodule system.  To see the real advantages of this new
submodule system, you have to think like a developer, not an end-user.
 Focusing just on end-user happiness is a very myopic way to develop
software, and I think the git community is better than that.
