Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB66EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 18:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFPSUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjFPSUN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 14:20:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC96235A0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 11:20:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5187aa18410so1258147a12.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686939610; x=1689531610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kDpRp7eE9nLsF0eLSHZo05xdoQs/KD8tGSX3N2A3oc=;
        b=Vg7/7VjWY5D/dxq4dU7h8xJomCf2DsG8ziM5NNtkDtE3NSkb7wF9TDYx1eGvQt3vwy
         JUepDi58Sbt/ZQfCS7R23EKQxZlAiQHXpHDlAQsIEUEQx8cR7UmCswAgN24pLTsefJpq
         mj35vOlYR5ueZRIodOQk/77hhdQVr3PmFl1Flev+/jdK2ptSA8KgivRVe6qhvg2KUp9h
         OU3Vlqmy5Z8bhSPKyhGR6KneQHvnX/g9WO/5OpcJJYU3fip6yDWtXDXWMcoogytyKHUu
         Q+2z5eUxSu7gZW3+jmXl+WQ7TibO+ZMIwXNcVVdn07kHCNHQUxtN32k28KomVR1uDJO6
         aJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686939610; x=1689531610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kDpRp7eE9nLsF0eLSHZo05xdoQs/KD8tGSX3N2A3oc=;
        b=bxK6Ae6LDtcy4n/uQGVjeVnLpR2aFyf1pdVmNjuzbEwJdw7o9A4TYNNm+sDpJL/rd7
         94bB+TSumO6u3K1Bd6TrjxD0xkDAQ/DPyrfSKAa8xTPL3QI8KEr7tJTL48W1Ed/CN2cK
         KU2PyK+y3aFnjiQsXOk6l27rXcq8SAZ8rdLYPma0ntv80menfsqgJv0cmn5gyr8rSgOs
         nUbfiVtRiVpNcwCZ5jZuYHoAs1CPDrXP8BduFzwjBXlH9gRdxHssK6FDx1tjgNSEJje8
         V1A6ybJLQ6K8YcnJ6Z63s6QiiayZ4WijaW5lIqZl+GeC8Py516xjNQE0762qL6aYMKnz
         Z2/A==
X-Gm-Message-State: AC+VfDzLJ510vB15vMk3cVIf9eS301H6Aqzj40nv9Egv9O/8gxSO1KYZ
        T8rsPjRZkRjNoPqNyJkVMJLy/upNGrfNAENtxtg=
X-Google-Smtp-Source: ACHHUZ4Kq4BAPQICKfUkF9LDkSPdKHgHQ1Z/OZRkSAMysNu1jlBG2WGxyr0TPGzTwCWslRxSJjFzVNFMYCEaqEYBi/8=
X-Received: by 2002:a05:6402:6cb:b0:51a:1ee6:551f with SMTP id
 n11-20020a05640206cb00b0051a1ee6551fmr2000987edy.38.1686939610149; Fri, 16
 Jun 2023 11:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com> <20230616042407.GA54009@coredump.intra.peff.net>
In-Reply-To: <20230616042407.GA54009@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Jun 2023 20:19:58 +0200
Message-ID: <CAP8UFD2JYAFv=iTDzvn4fzwYpJHt7TBLMXV0GV1-S7tXd7Bp=A@mail.gmail.com>
Subject: Re: Possible bug regarding trailers
To:     Jeff King <peff@peff.net>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Christian Couder <chriscool@tuxfamily.org>,
        "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 6:24=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> It's possible that we should be more strict about the separator, but I
> think the real bug is that we are respecting a separator at all in this
> example.
>
> That "---" handling is meant for format-patch/am-style processing, where
> the commit is embedded in an email. And there it is an unfortunate but
> accepted limitation that you can't put "---" separators in your commit
> message, or the parsing will get confused.
>
> But when we run "git commit --trailer", we know that we have a complete
> commit message, not an email. And so we should not look for "---" at
> all. But we do, and the commit object we write is broken (the trailer is
> in the wrong spot):

Yeah, I agree with the above analysis.

> On the display side, I think "--format=3D%(trailers)" is doing the right
> thing here; it is not respecting the "---", because it knows we have a
> complete commit message from the object, not something we're trying to
> pull out of the email format (so it finds nothing, because the trailer
> is not at the end).

> Likewise, "cat-file | interpret-trailers" is doing
> the right thing; by default it respects the divider. These examples
> probably ought to be doing:
>
>   git cat-file commit HEAD^ |
>   git interpret-trailers --parse --no-divider

I agree that here we know that we will only pipe a commit message into
git interpret-trailers, so we should use --no-divider. The doc for
this option says:

"Use this when you know your input contains just the commit message
itself (and not an email or the output of git format-patch)."

> to tell interpret-trailers that we are feeding it a pure commit message,
> not an email.
>
> So I think the only bug is that "commit --trailer" should not respect
> the divider. And the fix presumably:
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e67c4be221..9f4448f6b9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1043,7 +1043,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
>                 struct child_process run_trailer =3D CHILD_PROCESS_INIT;
>
>                 strvec_pushl(&run_trailer.args, "interpret-trailers",
> -                            "--in-place", git_path_commit_editmsg(), NUL=
L);
> +                            "--in-place", "--no-divider",
> +                            git_path_commit_editmsg(), NULL);
>                 strvec_pushv(&run_trailer.args, trailer_args.v);
>                 run_trailer.git_cmd =3D 1;
>                 if (run_command(&run_trailer))

Yeah, that looks like the right fix.

> I cannot think of a reason we wouldn't want to do that (though obviously
> it would need a test to become a patch). But it's possible I'm missing
> some use case (e.g., would anybody feed format-patch-ish output to "git
> commit --trailer ... -F" and expect it to handle the "---" divider? That
> seems odd to me).

Yeah, I don't think you have missed a use case.
