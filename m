From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 15:59:42 -0400
Message-ID: <CAPig+cQ0jEt10p--K8jNrFBi21PkmFXuHpUPewuOWrpx+3Ma7g@mail.gmail.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
	<CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
	<CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 21:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Doq-00086E-8w
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbcEJT7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:59:44 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35310 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbcEJT7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:59:43 -0400
Received: by mail-ig0-f195.google.com with SMTP id jn6so2256418igb.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hbeIYySE8dTT4+IULKwLI0zyUzgl0UYrh8OeFtT8s3Q=;
        b=Q+7Hz5KqsYZbJ+PEHzdxtJ6iC/qdTEwFFqT8E2TaK/IR8SzoiPFYMmrVfX0SPe0USr
         DfVNAsxIA/85tH3F1RI4SuOAsJaxK7jyLjmrtwMce9rTH4Enxr+2mwuWGulLAcTc4xVC
         LGZWDz3EviXKmcYAHaWiX0qUTuW8M2o2RBo4At3B6gu9mDcxgBia2F/IWW7BoP4SvJAt
         K2YxTRxOww+2EROupb3TweiVSe9EFsmMZPGFbgLNIjputsCi/P7sq9zi8FhzK3EMVAxN
         ic5tJMXTttf+IF+NPMLYRlQTMIjE2SYb43wWF7gpYZdbt6Dr+dyrlyzvrUx7YD/FntUL
         QVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hbeIYySE8dTT4+IULKwLI0zyUzgl0UYrh8OeFtT8s3Q=;
        b=cREGACoyJQ6YKhTPzzW+nzWVDveb+QQLBRD4S6j2m/sReB5QRhp6vuBYjiV/3MMqJH
         x+zkbIndgcNnRUys1mCeywDE0YSrNk/8BPTk0YRpq8udv94pVjfN4927qd14JEFD/Vff
         Jpbnd8D5xKCvnBdMU34HRfJ0g7Buuu2+lubUZ3oRFLvzGM0bhzDuEF4KgR+DV47TOQOl
         RlaHgMmBGv/c4LSZfljJSVvHOqfB4R4xlh8IcynKlwUR4u2HdzoQeDnkZcKBNmAtThXX
         bH8xpkVyFqyAbzU1DWlPQgW4QNLTX1+ck0F14ShazPr7V50tUl6gyWH1ts5f+XyRWIx/
         UBzg==
X-Gm-Message-State: AOPr4FUmJciMXMbBC+SkXnHyyg9XU2sWY2TPLnWaydo7v3JOZsy9uZQwbdzfAs/yqbyiM9e81jSG+QqhTWlCPg==
X-Received: by 10.50.3.105 with SMTP id b9mr18969178igb.17.1462910382948; Tue,
 10 May 2016 12:59:42 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 12:59:42 -0700 (PDT)
In-Reply-To: <CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
X-Google-Sender-Auth: 4i8_sQa4T0U7-T9IDjGkV0CQYi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294181>

On Tue, May 10, 2016 at 3:48 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Actually, I think we can have improved encapsulation and maintain
> readability like this:
>
>     case "$1" in
>     ...
>     -g) env="$2"; shift;  shift ;;
>     ...
>     esac
>
>     ...
>     test_expect_success "..." '
>         if test -n "$env"
>         do
>             test_when_finished "unset GIT_DIR"
>             GIT_DIR="$env"
>             export GIT_DIR
>         fi
>         ...
>     '

At this point, I'd also rename 'env' to 'gitdir' to be more meaningful.
