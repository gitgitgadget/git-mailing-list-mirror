Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDE5C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 00:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbjELAtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 20:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjELAtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 20:49:13 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC645BA9
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:49:12 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643a9203dc2so5108639b3a.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683852552; x=1686444552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONZkOOksCNFmZjx1mMh2OhwfNq6XX5LqCWj6fVKXDOk=;
        b=n05YwQDtGZ6h9q4MOIKo1wpDt5vNI204nE+amQfx9+2Rh+Lfwe1jPsVu8kMaJBXDyF
         9etJoqay0ZI20hgyR8l53byd/QyqRHY/6OU3EMApn8iMcJUmQlQAJUYoVzNQDD2/D1zm
         tqRh9jPwX/9iGsmh3Vy7iNjGmxMCAhidXk+QaaqeAtugEqPwfnShQoxnGz5OszuikwO9
         +NKtyrhL96+lju00X9JCcgZNEJhQ4sJJZq6JOTZEg++5ufvm531Fetdna2Dsg+6zRBxt
         cfgkgibSQz2cIFTk1Pv+2Is5ENS9sl7FlXDjkM/yTTmLcW7X7+9LilPTlYAeEYHTjhwr
         9T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852552; x=1686444552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONZkOOksCNFmZjx1mMh2OhwfNq6XX5LqCWj6fVKXDOk=;
        b=UYWxDRlt5TBMUhqbVpKjRFH0DoxJ5e6uEQcDf12/NYXcBup0rhSShIFuShoRxevf0C
         27CX44S98elzxHW/oKbZU3c6Q7/Qdgze86k0LZMZbjc7vH4XST3+9SCqbUaVZFIUqjML
         u72HIiiBqSoqC5x952nRONlgi6oQIBwFjMryAsLVUKLdgSiKkb8GSSi3NqQaZKBp9aqt
         GwMWtgbSXFQOjqcEHSXG3q2uQsNnvKqJggVX5KenhXpjWvBW4gEKsgNvDVhYyTYhzqQJ
         25pXiGW3nVPRgd0soovELYXMGuxjjCtOM70mtTFm1VKpr7kz5WzDA2+4xhD2tuNUTI+H
         DsnA==
X-Gm-Message-State: AC+VfDysgAHP0ybe+IcNQcuCDvc8CaZpVLH00elzBj2+TL9RTrtxr9ot
        7YH1tPTGmKi+BPI9OCpcY9cvc4zYjmVXzQ==
X-Google-Smtp-Source: ACHHUZ7gfoigAUQdRBa+ClAudvxl5OSovpVtcAKBSZTWX9pt+1jai9TuixIXxrB2uZpGn6zqNlmVfhpifF88ew==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2bc:b0:643:a260:a5d2 with SMTP
 id q28-20020a056a0002bc00b00643a260a5d2mr6327856pfs.0.1683852552275; Thu, 11
 May 2023 17:49:12 -0700 (PDT)
Date:   Thu, 11 May 2023 17:49:10 -0700
In-Reply-To: <bb1a591c2f46b78eb26eb72ec677c65d10cb714c.1683721293.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683721293.git.ps@pks.im> <bb1a591c2f46b78eb26eb72ec677c65d10cb714c.1683721293.git.ps@pks.im>
Message-ID: <kl6lilcyz855.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 5/9] fetch: refactor calculation of the display table width
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When displaying reference updates, we try to print the references in a
> neat table. As the table's width is determined its contents we thus need
> to precalculate the overall width before we can start printing updated
> references.
>
> The calculation is driven by `display_state_init()`, which invokes
> `refcol_width()` for every reference that is to be printed. This split
> is somewhat confusing. For one, we filter references that shall be
> attributed to the overall width in both places. And second, we
> needlessly recalculate the maximum line length based on the terminal
> columns and display format for every reference.
>
> Refactor the code so that the complete width calculations are neatly
> contained in `refcol_width()`.

Through no fault of yours, I have to admit that I found this refactor
quite hard to read. I ended up redoing the refactor and ended up with a
result very similar to yours. That was probably overkill since we have
pretty extensive tests in this area, but I'm quite happy with the change
since it's far more readable.

> -	/*
> -	 * rough estimation to see if the output line is too long and
> -	 * should not be counted (we can't do precise calculation
> -	 * anyway because we don't know if the error explanation part
> -	 * will be printed in update_local_ref)
> -	 */
> -	if (compact_format) {
> -		llen = 0;
> +	max = term_columns();
> +	if (compact_format)
>  		max = max * 2 / 3;
> -	}
> -	len = 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
> -	if (len >= max)
> -		return 0;

The one thing that changed for the better (vs keeping the lines in the
same order as before) is that this comment that used to be anchored on
"if (compact_format) {"...

> +		/*
> +		 * rough estimation to see if the output line is too long and
> +		 * should not be counted (we can't do precise calculation
> +		 * anyway because we don't know if the error explanation part
> +		 * will be printed in update_local_ref)
> +		 */
> +		len = 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
> +		if (len >= max)
> +			continue;

is now more accurately anchored to the check that throws away the line.

Looks good.
