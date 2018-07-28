Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D73D1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 01:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbeG1C0V (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 22:26:21 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46440 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbeG1C0V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 22:26:21 -0400
Received: by mail-wr1-f43.google.com with SMTP id h14-v6so6677310wrw.13
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LSZb/csWZNLm1kI9R151oHQzXAwnJHTdXXYDE2gWLg4=;
        b=kcVX8OvjXVpCGCiztTBryn+GwikaEEGkCkrqb2v5SrFxw+r9qqe5gZyF216yYx24tp
         OdCjijM6Ow/YgucoDzz/97R3D1O6mHIVeLrevLjGADIYO3kfni5LCVgca8Jt18ADZBsi
         zpduBeHkRAdYkIy+9zZ1JL8xHZErt/4a9IX0nPmZaAddjVajDUXElrKg0sjjammPOfAy
         URpk1s6s3grPJqM23xQKHxVayUH+cSjDsfyzFsOUGNU2XC2d7/mDcOXowzoWF/rFMmMe
         ziBkhpYQ+caL7TS4Ydvop4qoFZBRXFTZE678WNvZHMKaiW1j0mqX2VC/pdX6irWkGEjg
         9tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LSZb/csWZNLm1kI9R151oHQzXAwnJHTdXXYDE2gWLg4=;
        b=Bf4bz2061wnI0oJOnYRj0UUi2SrdniWBuWyWX4mCbSLuhcREWjmN6EfIwWFnW95Hpq
         qufIKzfBmEA3TGGVSY+zERj0S4V4TWQ8TYtLPckO9dPbyw04yppGPppzjQXwieJdRo4g
         3hJ7JnUnhxT0jp0Cc2N95NTnHMi57BSV5QURVHGKj25Hchj9cbRJeXEV0xgFurBPUHUG
         Cla2FfOwi2YOlbN9axSBpVjh97mLxnSzUk/cP0RX7PF6AGknJT6l45sL3gnUjqLqx0qB
         QETgdMXyeRvvJc2Dp7EoGk959ycmugpOg/abBjETVjxW5FHbqMdPxuScJlfCfhPqWG7u
         g0nw==
X-Gm-Message-State: AOUpUlHQGmVKM0rNJMaQCal8NjMP6i9MFw+KDewO+meOcz3uQerlYlnc
        woL/+T5YzJcNV76mNuqdW54=
X-Google-Smtp-Source: AAOMgpeTeJfbYZhlsmSTwTVHEvzbxx1ItSsuh2BSEZoI5n/34suA38+eXr9CfsGy4TJHv6UeGaHDZw==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr6946299wrq.225.1532739714836;
        Fri, 27 Jul 2018 18:01:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w9-v6sm3725555wrr.77.2018.07.27.18.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 18:01:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@google.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
        <20180727233606.179965-1-sbeller@google.com>
Date:   Fri, 27 Jul 2018 18:01:52 -0700
In-Reply-To: <20180727233606.179965-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 27 Jul 2018 16:36:06 -0700")
Message-ID: <xmqqlg9wjhq7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A use reported a submodule issue regarding strange case indentation

s/use/&r/;  Is this "indentation" issue?

> issues, but it could be boiled down to the following test case:
> ...

> +test_expect_success 'old-fashioned settings are case insensitive' '
> +	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
> +
> +	cat >testConfig <<-EOF &&
> +		# insensitive:
> +		[V.A]
> +		r = value1
> +	EOF
> +	q_to_tab >testConfig_expect <<-EOF &&
> +		# insensitive:
> +		[V.A]
> +		Qr = value2
> +	EOF

It is unfortunate that we hardcode the exact indentation
in the test to make it care.  Perhaps a wrapper around test_cmp that
is used locally in this file to first strip the leading HT from both
sides of the comparison would make it more robust?

> +	for key in "v.a.r" "V.A.r" "v.A.r" "V.a.r"
> +	do
> +		cp testConfig testConfig_actual &&
> +		git config -f testConfig_actual v.a.r value2 &&
> +		test_cmp testConfig_expect testConfig_actual
> +	done
> +'

I think you meant to use "$key" when setting the variable to value2.

When the test_cmp fails with "v.a.r" but later succeeds and most
importantly succeeds with "V.a.r" (i.e. the last one), wouldn't the
whole thing suceed?  I think the common trick people use is to end
the last one with "|| return 1" in a loop inside test_expect_success.

