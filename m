Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9BC1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPVJ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:09:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52942 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVJz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:09:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so10412053wmh.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2dntZynxI4Dlo8nfCObB+c5oBZ3lUDIkfar0ZNAFlqY=;
        b=PcKHugMLNYl3cNUmMkBVXasfcMytOrgXGBHDGkMEtrPO9Y3dEwSqyGD9rWlx1PMNIb
         civKzU8ZL/3oV8C9wxqa3dnbxU6FyHQoa1zJcmkKP6U2K+2Ujkdr7MKZ50DeZ2fGukju
         pYrvc2tUQeriHpr10osU0u4GfBigRds5hsflCe+kSoiVKM/RH4qgqndB8qMp/7VPmmIN
         JnkUntdSwzkDTFJJ6LKM3hHE/bkaPmQJ5U1PfgNvvWUr/X5nkCcb9fSdkTEC1bCXi+ha
         EgkF/2Krre3irqjAx8wwtM94DjbaDPi/rJbPoZtUvkbbPrdPU3ShImw2/XixWA0Swuy5
         h5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2dntZynxI4Dlo8nfCObB+c5oBZ3lUDIkfar0ZNAFlqY=;
        b=fvvAWjxWUe3UO8EQNLrrmgDxezdRrDpRF4RxD6+tXalP+DNWorOxlXmmh64QMMd7UA
         IbaO4HGjutl2BSSFXaWwobtHAaV2zjNO/eEZ6mlFrFtIbBtcbGyAaf8nKYjrQu46DGZr
         nlmPLhY+JTIamTEy+040WqbCRWREziWRfR5h5x4Akn9/moAD7GsWKCXvj/jj5MoIgplc
         tcSlrIhho117u67nPYZcaHU4BIDOHBzW8vl4+PbY3NqeF2Ev/P8CJoxy7mXhjKzWSRoP
         My10QQvYtB9xhld0p9L0HZZFb7nCMxIi5ZcCmtIyt4KLRs8w+C1qzrCqbBP0O98xj4xk
         CRRA==
X-Gm-Message-State: AOUpUlET2bZYw51itePEjGNO0tSaeiLvDDWsUivFt59/L9Eteu57/N27
        sC/zhffKcqVeqDYTvpfnncY=
X-Google-Smtp-Source: AAOMgpcLZFpILnL5L8Lje62GRCIhSpqqVZfex8SsCyrdqANPkUIRL6Hp1Se03Dhqb2xNrhV7IHXHQQ==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr10705910wmi.28.1531773649266;
        Mon, 16 Jul 2018 13:40:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r1-v6sm8437094wrs.39.2018.07.16.13.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:40:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/7] gpg-interface: do not hardcode the key string len anymore
References: <cover.1531470729.git.henning.schild@siemens.com>
        <cover.1531470729.git.henning.schild@siemens.com>
        <6fb618aefcf34695cd46b3135829b5ac3f703573.1531470729.git.henning.schild@siemens.com>
Date:   Mon, 16 Jul 2018 13:40:48 -0700
In-Reply-To: <6fb618aefcf34695cd46b3135829b5ac3f703573.1531470729.git.henning.schild@siemens.com>
        (Henning Schild's message of "Fri, 13 Jul 2018 10:41:26 +0200")
Message-ID: <xmqqzhyqsylr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> gnupg does print the keyid followed by a space and the signer comes
> next. The same pattern is also used in gpgsm, but there the key length
> would be 40 instead of 16. Instead of hardcoding the expected length,
> find the first space and calculate it.
> Input that does not match the expected format will be ignored now,
> before we jumped to found+17 which might have been behind the end of an
> unexpected string.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  gpg-interface.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Very nice.


> diff --git a/gpg-interface.c b/gpg-interface.c
> index 699651fd9..93bd0fb32 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -89,10 +89,11 @@ static void parse_gpg_output(struct signature_check *sigc)
>  		sigc->result = sigcheck_gpg_status[i].result;
>  		/* The trust messages are not followed by key/signer information */
>  		if (sigc->result != 'U') {
> -			sigc->key = xmemdupz(found, 16);
> +			next = strchrnul(found, ' ');
> +			sigc->key = xmemdupz(found, next - found);
>  			/* The ERRSIG message is not followed by signer information */
> -			if (sigc-> result != 'E') {
> -				found += 17;
> +			if (*next && sigc-> result != 'E') {
> +				found = next + 1;
>  				next = strchrnul(found, '\n');
>  				sigc->signer = xmemdupz(found, next - found);
>  			}
