Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA50C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 22:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjDSWZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjDSWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 18:25:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE7118D5
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:24:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso333640b3a.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681942935; x=1684534935;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAbXqKEftnoYffCuW69zwR/WAGUqtdpeRzCttsu+bsU=;
        b=HqljLWXyXW/HAOChNvxJBQvqzx5dWsqwp9kCvVYFiPzy2dhPJE5pu9B6wV52PqS9BP
         hzO84g0ghsI98XaMoNfgrpxNMFD76s6QvBf5LKGr0iIzjKXSCLgPX0kVD94RXOlCKgCe
         xbXl0u+jrR83KMQ88pr7wqogLduFPjcAJI/mESA/NNyIT4OvtnWM2zp/e2wvWNzoLs5I
         xYWkzULiCJ06jLZ+0C3YPI0XvxVMdOoOGKE+2iPzGtzu+ZaikBeSb3dDcH9iLsi+WrSm
         q7oKDeIKt349jEPSdOeg7Hj/UbNRxZI+urZYQHRosFopX1D7dPbSucm0aPwAqVgtqUno
         NkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942935; x=1684534935;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MAbXqKEftnoYffCuW69zwR/WAGUqtdpeRzCttsu+bsU=;
        b=Ja2qo0o78lSkVyXmknBKXb+csMj0LHW6+yD50ZDov+EpQ95muTVzyPdCu8lB0swakL
         eG3RMzb1eJxhsIo3SCTbXJH9/em5o9nM35pUuZkGiIIkHE4jcprAubqIqtasRk/4r7Qy
         fcbaeh+pghtmSRrx+zvDPyWRa92wYKAAnM1vFx1KzXqXUL+EUiFdvQZPASre1Kq3aPev
         cwTMfxMgqdRXo8nGu3ZxZ6FEoWX/fjFLakvzMZE/lUJZdsQBuonnhY8siypqOM12AKq+
         5TUBNnkpfdP54p9jO6CMNUmjMdghRUl0CDo9c2T/flGmA9CcqLWV3wUld7Dr9ICptp3t
         uSTw==
X-Gm-Message-State: AAQBX9dtox7r8OugvhEtmTE1aRDq7P3v21aIRKPnvwCRxplXJ42kZFk5
        6g1Orj4ulPaaNKgvYINobsg=
X-Google-Smtp-Source: AKy350YWC9/JZCuyVj9P/L2sa1VAEQUOjAmvYezT+1MIskZAQUiO1QqRjTNcBuv/qBDCnDSQu7KqOA==
X-Received: by 2002:a05:6a00:848:b0:63d:260d:f9dd with SMTP id q8-20020a056a00084800b0063d260df9ddmr6747379pfk.33.1681942934648;
        Wed, 19 Apr 2023 15:22:14 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id h1-20020a62b401000000b005ccbe5346ebsm11379864pfn.163.2023.04.19.15.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:22:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
References: <cover.1681764848.git.me@ttaylorr.com>
        <cover.1681850424.git.me@ttaylorr.com>
        <b6784ddfe2906f7c04b3050bd9ba63a884ddb047.1681850424.git.me@ttaylorr.com>
Date:   Wed, 19 Apr 2023 15:22:13 -0700
In-Reply-To: <b6784ddfe2906f7c04b3050bd9ba63a884ddb047.1681850424.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 18 Apr 2023 16:40:57 -0400")
Message-ID: <xmqqh6tb7bsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index e52bc6b858..17b4d39f89 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -14,9 +14,6 @@ feature.experimental::
>  +
>  * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
>  skipping more commits at a time, reducing the number of round trips.
> -+
> -* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
> -garbage collection, preventing loose object explosions.

Being listed here is a definite sign that a feature behind a
configuration variable is considered experimental.  Do we have (and
if not, do we want to establish) a procedure to mark and announce a
feature that used to be experimental no longer is?  If it is enough
to mention it in the release notes, then I can take care of it, of
course.
