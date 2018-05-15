Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176B41F42D
	for <e@80x24.org>; Tue, 15 May 2018 09:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeEOJlz (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 05:41:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36979 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOJly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 05:41:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so20330493wmb.2
        for <git@vger.kernel.org>; Tue, 15 May 2018 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hkw37lSAV2TNuuCPAztnNPezPapewhud4EFiMabXdaM=;
        b=R+nFmQ0Z6w+1IPnkTx4E7af4CPZcQ1oj0hIUQTEVh7FGtiUVYg9a12bK9ZiEOkHdNV
         T1LfGtzbZq4agBQ6ldmpZ84ivXSRgp+9tJAE8Ous53wKsUXZCh/HIDu0NIGbX8FynRvm
         x0CObBQRCL1yjuqsli12vQkGNHrFHKGmZ63Q3m1rtDOnssbJMn6xjKI8KY7IGFKal+EW
         S15cmvamPNfnKHk0gFV5HriWcPlygNFcJ7cFNpUB9Po3G6uiSKDlhPYe7TJ5RUlk6Of6
         pdC1j8XRYPw3uovruPKyg6QxaC8u0uhJlqOcEObUfToPBZKInSpz2GEK8mMQ1muRlGYd
         zirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hkw37lSAV2TNuuCPAztnNPezPapewhud4EFiMabXdaM=;
        b=IKBPUiIyH7+Dv1d4w4Maq7L9X6/qnT13PV0wjbHHn7hDg+9XCNExqi0w1ARC3CQVwV
         PpippZYVWK2TtPEXT6h0ccmIYvKpYpLeibxpoockkLLbnZ1zmqqA5g4LNop39lNO/9l6
         uV5cZ1NWKHpfqjkL0yhnxbz0sx+cxFCZZ1NBz2XTNvwK9k61or02lmFR8iRk56k6z8M1
         +UpOsRDrr8kmwpiE2pv2+LKlLFTC9DTayZbDYk1ezWNpM5yb8dGVY8mhkk3VJk8qh4RF
         nVVV+G45tjTYq++ZPHVsfsdZ1Y0+7ZfX+y5nichHYg10IYm56rLUypDGL3DHfrvMdqTp
         gSJA==
X-Gm-Message-State: ALKqPweoVk/5wndV1i8qzXCOvtGpg1vZmzE4f+pYFtIPej1YSLM3UP7z
        ZulzfxP93MXmyU3XGthyL3I=
X-Google-Smtp-Source: AB8JxZqne9gbBVMtkWIISXHL8WovUPjXoQT6fO98Zr+aVf+etXcN/XK8JvEPn9bFqcWXM+DebLIrJg==
X-Received: by 2002:a1c:9cc3:: with SMTP id f186-v6mr7777428wme.94.1526377312791;
        Tue, 15 May 2018 02:41:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm9561758wmc.16.2018.05.15.02.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 02:41:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/35] refspec: convert valid_fetch_refspec to use parse_refspec
References: <20180514215626.164960-1-bmwill@google.com>
        <20180514215626.164960-6-bmwill@google.com>
Date:   Tue, 15 May 2018 18:41:51 +0900
In-Reply-To: <20180514215626.164960-6-bmwill@google.com> (Brandon Williams's
        message of "Mon, 14 May 2018 14:55:56 -0700")
Message-ID: <xmqqa7t18dcw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Convert 'valid_fetch_refspec()' to use the new 'parse_refspec()'
> function to only parse a single refspec an eliminate an allocation.

s/an/and/, perhaps?

> -int valid_fetch_refspec(const char *fetch_refspec_str)
> -{
> -	struct refspec_item *refspec;
> -
> -	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
> -	free_refspec(1, refspec);
> -	return !!refspec;
> -}
> -
>  struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec)
>  {
>  	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
> @@ -242,3 +233,11 @@ void refspec_clear(struct refspec *rs)
>  
>  	rs->fetch = 0;
>  }
> +
> +int valid_fetch_refspec(const char *fetch_refspec_str)
> +{
> +	struct refspec_item refspec;
> +	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> +	refspec_item_clear(&refspec);
> +	return ret;
> +}

Makes quite a lot of sense.  The function name may eventually want
to become parse_refspec_item(), though?


