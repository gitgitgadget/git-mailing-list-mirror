Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F1ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiH3RVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiH3RVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 13:21:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18376775
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 10:20:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l5so7875048pjy.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=xKXsQMcwhyT45M8zBtVOP+BVj16yvTLupVhjKgtVJ4w=;
        b=T0jbTHQq82YG4L13orFkPS7UjROA6kJmP0ik8hEHvAmbr2QSGV9/VCoLk+22vLrKOT
         UcNx6DcTo25nJbXZD9bk4h7TyVU6OgHjOkMlgeERKt1L/taqjOKxWVe+TpQK0SurR8//
         d8ejlKvqgjicrQ5VfWFjPEehDavnNkr1mwyDrFo4J8edWvRfbe+pT24aEV/TUHZj67We
         dr4txrwvyor+43saI1JijX3hTfNpUTKwm2Td9FazCFv4fYrV7j4kykEY3qJPVGiXJmmI
         S0gVPHpof0TtXuEUHIwYAHVNY18j5BtTTW/G8x3278PvdIx7gMj/PM9wQi7iqW+xk67Z
         3D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=xKXsQMcwhyT45M8zBtVOP+BVj16yvTLupVhjKgtVJ4w=;
        b=DlG2K/eQ1PyjA9dyLP7wpezrFzd8cGwYrXRCwaP6XVX1m7DKEsESrPxuDAmcKi9ytg
         29I8aAghqQl7FoFWNDEnLNhQJQH9d/fifBNyIV+5CIIL2Csd0yuyS8fFcUeOhod6rXhO
         RWulnXxRRn5qIo5M5FFWzkq7EZzW47vmS/WyBwO708/ogvJd/cdyWI3Jhs1zleTFgUmr
         qklfwz2oM/lVU1yzH72DYVqO8qUoy0qBB50QjJLaaue1aCDzRq6BRGTCY10JQgeGcy5g
         1IRt/RLV+xr2Bx8SbHRLz7L8XSiH8UWJOKaaIJ5QJBtU6Abh0+yfVzscd75aSTBh0SET
         kCbQ==
X-Gm-Message-State: ACgBeo173ULIksFtKbUjtJIU9t60vKSoBJoXFgjPBw/NuVUmqp9mmuZO
        4/t2Q0EmVAt+wWr3uW5sHYo8p2K6zsw=
X-Google-Smtp-Source: AA6agR5pJB3ETOAvGAA+eHaqTRU37jpYXqAFXj7tEcRj4r/ai0SS60CjWNkMRDcXRp5Bv1VYY8TvcA==
X-Received: by 2002:a17:90a:174a:b0:1fd:f273:de03 with SMTP id 10-20020a17090a174a00b001fdf273de03mr7405415pjm.188.1661880015245;
        Tue, 30 Aug 2022 10:20:15 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b00172cdcdc183sm7561482pls.93.2022.08.30.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:20:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] Documentation: clarify whitespace rules for trailers
References: <CAP8UFD0EfhDo9ZMNSYp8YVHXJs6mYtSBs=hwoFZWWF3xZ0wjpg@mail.gmail.com>
        <20220830105046.324041-1-christian.couder@gmail.com>
Date:   Tue, 30 Aug 2022 10:20:14 -0700
In-Reply-To: <20220830105046.324041-1-christian.couder@gmail.com> (Christian
        Couder's message of "Tue, 30 Aug 2022 12:50:46 +0200")
Message-ID: <xmqqh71tlkc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>   - rebased on top of 6c8e4ee870 (The sixteenth batch, 2022-08-29),
>   - added my "Signed-off-by: ...",
>   - clarified that there can be no whitespace before the token,
>   - clarified that "any number of regular space and tab characters are
>     allowed between the token and the separator".
>
>  Documentation/git-interpret-trailers.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Looks good.  Thanks.  Will queue.

>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 956a01d184..6d6197cd0a 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -60,10 +60,12 @@ non-whitespace lines before a line that starts with '---' (followed by a
>  space or the end of the line). Such three minus signs start the patch
>  part of the message. See also `--no-divider` below.
>  
> -When reading trailers, there can be whitespaces after the
> -token, the separator and the value. There can also be whitespaces
> -inside the token and the value. The value may be split over multiple lines with
> -each subsequent line starting with whitespace, like the "folding" in RFC 822.
> +When reading trailers, there can be no whitespace before or inside the
> +token, but any number of regular space and tab characters are allowed
> +between the token and the separator. There can be whitespaces before,
> +inside or after the value. The value may be split over multiple lines
> +with each subsequent line starting with at least one whitespace, like
> +the "folding" in RFC 822.
>  
>  Note that 'trailers' do not follow and are not intended to follow many
>  rules for RFC 822 headers. For example they do not follow
