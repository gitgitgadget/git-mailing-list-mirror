Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878DC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiK2NT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK2NT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:19:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A991EE2A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:19:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5so12637549pjo.5
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYC8PGQAlSIl+QTq8mjMD25yjzS/z3OSgTh7xRVq2kM=;
        b=nTAhE0elT+UXK4zMGMeJ21A7P4JKjceEDBMz4V3o2IMVYnuqUCitdXTihfvUw47xZ6
         YMjVZBYOZQ6/WsBu7KjYPAqUK/qdhOJPkOsSvbH6Md5UtlIyDP6FZKt4/0oIPKqygh8h
         G1LcvT3IZvlboYutAvNcN6JuUL+abZa648NoKO5mRZEOu/Cw5cPtNgyveElsalICKwBe
         r/FAScoYOoGXCi1TY01MEYcJFz83ROdYQ1w6OBum9eW/9V4hf7hs8MhOBwg0QyrUozvw
         qQwjp45ltaaPQhWCtp1VZeA7R3FtirIaQ2BYcWrWMMex6m1IEEepcz4NKB2ZBNEG8RQ+
         TCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYC8PGQAlSIl+QTq8mjMD25yjzS/z3OSgTh7xRVq2kM=;
        b=F4iG2vR58Vmd58clKG2W3gdT0R1xKtjHjR+rGK3cqBBnER0lj7+KLPLTtsGm+tZrnB
         dU3v4cDf8jHwzaGmgfHcvGy6slYCAoUXXe4ARjw/kVQ4idP8/9gTnSOPOPQ9k+++77GF
         9JvFIworC02eU9IxZB33nCPjlKRz3QGBKqOnYnoqBPPLJPUQp39hDJp1KVasFXKqbDJd
         z30k/cGFowZL+wLwnbW4HTfqpZtC9QotXz4FaaqOpbbuYhhMeH8TNX9QUjRNdx2wWAQR
         oK2gRBZ65h2vgPvPjE9HwnHoPFg9biJ69aYdi07/rwv8bai7bjunlY2cgD0+UnifKHRs
         mfAQ==
X-Gm-Message-State: ANoB5plOoV8Sw6RhwQeKgCxU05Yb0b9U8lLJEgYH1QdsqrXwGxWaksrY
        rSbSMPIiHhr/3s8bsJjhOz8=
X-Google-Smtp-Source: AA0mqf5CSv6bT1E07TeLaWShlg3FG3RtOTcHR2T+Yf2jsSkJhP7zgqEPBxHeS/DWKvyR01vla3QZEQ==
X-Received: by 2002:a17:902:7009:b0:189:71b9:6183 with SMTP id y9-20020a170902700900b0018971b96183mr18597579plk.121.1669727996384;
        Tue, 29 Nov 2022 05:19:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b00188f07c10c9sm10830251plf.192.2022.11.29.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:19:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
References: <cover.1667980450.git.dyroneteng@gmail.com>
        <20221129125738.81212-1-tenglong.tl@alibaba-inc.com>
Date:   Tue, 29 Nov 2022 22:19:55 +0900
In-Reply-To: <20221129125738.81212-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Tue, 29 Nov 2022 20:57:38 +0800")
Message-ID: <xmqqh6yh3nk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I personally do not have much opinion on this topic, other than that
>> "--no-blank-link" would be a horrible name (i.e. uses concrete words
>> to pretend that it clearly describes what it does, but is utterly
>> unclear where these blank lines are etc.) for the feature to help
>> end-users discover it.
>
> I have some a candidates might like '--newline' and '--no-newline', or
> 'splitted-newline' or 'no-splitted-newline', but I think the latter is
> a little long.
>
> Thanks.

I do not care much between blank and newline.  

Both alone are equally horrible, in that the option would have no
effect when "git notes edit" is used and spawns an editor, or "git
notes append -m one -m two" is used and the command adds the second
paragraph whose text is "two".

Just like "git commit", the argument to each "-m" option becomes a
separate paragraph by default.  I personally feel that those who
want to make them separate lines deserve to have an option like this
one, so that they can do

 $ git notes add -m foo HEAD
 $ git notes append \
	--each-message-is-line-not-paragraph -m bar -m baz
 $ git notes show HEAD
 foo
 bar
 baz

but the point is "blank-line" or "newline" does not say which
newline in the resulting notes object you are mucking with.  It is
not like in this example:

 $ git notes add -m "title of the note"
 $ git notes append --no-blank-line -m "body of the note

 that span multiple

 lines" HEAD

you are removving the blank lines embedded in the body of the
message, but from the option name, it is hard to guess that.
