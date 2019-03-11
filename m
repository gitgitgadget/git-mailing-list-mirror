Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CA320248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCKJh5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:37:57 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:32875 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfCKJh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:37:56 -0400
Received: by mail-pf1-f174.google.com with SMTP id i19so3299053pfd.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5IyIYMDd56HBMgKuLw9DNSI9DcuglbHYKg32ElvlXTg=;
        b=bl9BYahVDhKgmWmEJVrr1KKSLCTZxhaT6HIk73dKDun1eOmSDIsFAMWnNVWmwqv1YN
         2UssNr50o2DNY+vXr++DlvHUg/Xj+9msbdxFWQIryTRi+93VKDzqlhircNHZSlTGNArd
         pT3mLf3zugNO2lri2Vvbundl4P7y9E+kt+azKsCkaMb77MkxHsFPpzPZjYXj1rsw8g4d
         /gt5g4jfVcbZNq8EeW1h8jEcuxHfDNov7r1Ph0oJ9z1PQqSV0juKiu5RzdPEyKOJ1pxd
         hSUQw3jr2jp4d2h6DDQJS2wj+IywHEkeqTiJ+zkbs2PjC6F2Kc4Z4Cm8dPnKW6zJ7jBP
         DVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5IyIYMDd56HBMgKuLw9DNSI9DcuglbHYKg32ElvlXTg=;
        b=bIus2yrJfxFfJ2vsYeADMG9tF/cICoESgaacYfeaf3adl25YsvrIHh1/diLTh9w8oF
         cZz4RLQtklEqCXExLtXy9rBpLdAFjkrPH2YtqJI3xieKtB9U6Qym7IQ46sXolmLDY1FZ
         4w0b8eUG7mQh/aWE7p2r/MUTIKment/xelKMMVVhbAZc+W47/sYNRtEEh8cuXfLqts/K
         Uhwk16AVey+ANQmdhWBOX7zzmSTLUeJLTjmwcKF0lK+sD5I0ASNuhCDJVULvxN+ZGwCM
         p3qrGl6aWOq+QtI7uQr7Fb1pkN+vEKjs6Iya5V9b2BBBbSzVeKUQH21nMgAR8wO3ZScF
         gi0g==
X-Gm-Message-State: APjAAAW2dre8IgekoqpSkxXvcOCzNNMBvlUlgXxiXkyBOTiX/ZVeMuW6
        mhFOJroEbSFl/7V8a+UPuJi5LV7s
X-Google-Smtp-Source: APXvYqyfcf9F/48TQj82wVMXOiFEYrvdwAMN1m41Xor08uOtM2YfEknTkbRY/GT7HTuo3GJ9xIphyQ==
X-Received: by 2002:a65:410a:: with SMTP id w10mr28573890pgp.206.1552297074723;
        Mon, 11 Mar 2019 02:37:54 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id f65sm8394772pff.21.2019.03.11.02.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:37:53 -0700 (PDT)
Date:   Mon, 11 Mar 2019 02:37:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Deprecating git diff ..; dealing with other ranges
Message-ID: <20190311093751.GA31092@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I was in the process of deprecating `git diff <commit>..<commit>` as
discussed here[1]. However, I ran into a weird case that I'm not sure
how to deal with.

In t3430-rebase-merges.sh:382, we have the following test case which
invokes git diff:

	test_expect_success 'with --autosquash and --exec' '
		git checkout -b with-exec H &&
		echo Booh >B.t &&
		test_tick &&
		git commit --fixup B B.t &&
		write_script show.sh <<-\EOF &&
		subject="$(git show -s --format=%s HEAD)"
=>		content="$(git diff HEAD^! | tail -n 1)"
		echo "$subject: $content"
		EOF
		test_tick &&
		git rebase -ir --autosquash --exec ./show.sh A >actual &&
		grep "B: +Booh" actual &&
		grep "E: +Booh" actual &&
		grep "G: +G" actual
	'

It gets caught in my attempt to only deprecate ..'s. Technically, it's
undocumented behaviour and it only happens to work because git-diff
accept ranges but it doesn't operate in an intuitive way.

I was just wondering what we should do about this case? Should we
deprecate all invocations of `git diff <range>` except for the special
case of `git diff <commit>...<commit>`, or should we _only_ deprecate
`git diff <commit>..<commit>` and allow all other forms of ranges, even
though it was undocumented behaviour?

Thanks,

Denton

[1]: https://public-inbox.org/git/xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com/
