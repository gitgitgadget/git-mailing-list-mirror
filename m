From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 17:03:38 -0700
Message-ID: <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 02:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UffU0-00013J-3j
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 02:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab3EXADj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 20:03:39 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:51134 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661Ab3EXADj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 20:03:39 -0400
Received: by mail-vb0-f47.google.com with SMTP id x13so2671026vbb.34
        for <git@vger.kernel.org>; Thu, 23 May 2013 17:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=JaDvP2hWyG7oigYKoR5vzDMljiL4FWX3Wr2tWZhX6jE=;
        b=LL2itJerlN/C41+4DdwYk5WLxev3Jo34CzbEA9y2RJjtXHHWVOndAq5ov/7F2r+YuR
         yC0VyoMSTBsqWvmKbDy79uz6obkrHXc784Hl+bMyZmhu0lmi+3tfEM7QKqH298ALMzF5
         AHQdeA/+6auB5Y9SKpfyLeCGNaPZA+gOSQbc7mrbddqi+mgRWeS425wtPu/HoLRams7o
         mFh6TH1buP7Lelo1vO8JwrNnCQ3zkFSiDViwAhoocvd4mUPD9oaq+8/4Os+J74YPoiDE
         oPKoPXbUx8PvT29ta0ho5neASyB2QD05AXf+fFBqQrqj1p1NmLvcgQwgNR6jZZsAJtj8
         uitQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=JaDvP2hWyG7oigYKoR5vzDMljiL4FWX3Wr2tWZhX6jE=;
        b=C/FALNjJJvzDrrWzcWCiPqq9HaEfyNaDu7tK1Tv8aLikOMypR+XMuRcjTRHmQGkNDD
         tE8xIOHXqZXW4PqMtdyMZ3nqj3ytwP85I4xuxD4O0+JrooOLVtMq5zMLB7PAYS6xP6Xr
         zPij4Pw+jjCaS3Nw2ZO7oroIDbzbSmgvXjHkU=
X-Received: by 10.52.240.211 with SMTP id wc19mr5983185vdc.12.1369353818169;
 Thu, 23 May 2013 17:03:38 -0700 (PDT)
Received: by 10.220.125.7 with HTTP; Thu, 23 May 2013 17:03:38 -0700 (PDT)
In-Reply-To: <7vli75cpom.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: YDBp6-wV4MryssjcDK0tdAbZfKs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225322>

On Thu, May 23, 2013 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If the proposal were to make pull.rebase the default at a major
> version bump and force all integrators and other people who are
> happy with how "pull = fetch + merge" (not "fetch + rebase") works
> to say "pull.rebase = false" in their configuration, I think I can
> see why some people may think it makes sense, though.
>
> But neither is an easy sell, I would imagine.  It is not about
> passing me, but about not hurting users like kernel folks we
> accumulated over 7-8 years.

It would be a *horrible* mistake to make "rebase" the default, because
it's so much easier to screw things up that way.

That said, making "no-ff" the default, and then if that fails, saying

   The pull was not a fast-forward pull, please say if you want to
merge or rebase.
   Use either

        git pull --rebase
        git pull --merge

   You can also use "git config pull.merge true" or "git config
pull.rebase true"
   to set this once for this project and forget about it.

That way, people who want the existing behavior could just do that

    git config pull.merge true

once, and they'd not even notice.

Hmm? Better yet, make it per-branch.

                   Linus
