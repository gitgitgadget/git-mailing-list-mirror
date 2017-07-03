Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C4A201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 17:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbdGCRLQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 13:11:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35122 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755334AbdGCRLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 13:11:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so26460917pfs.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=47goeNcf7ySSd2wJZhwukdXlDPfxczWFcezpMHqQeMk=;
        b=WugA/7ib3IYs2cn7tcJqmd3Yq/DsdIsWGFmw48M8AKibDfZ0A+2SQ7MGSa4yb3DMO+
         SSD0421gQMgSYaIt1oFT4VjOXpCmKV9nVuKlX0W0eOfKutbtGP7Tz1MukAIeH+7s9dl7
         zY7jENJ8yjwMYeNSOgalvaM99bEAOgQx56koyhg3NHtWnwFl3uC7tDzXY+igxFc4qidM
         A3RJpeqDEGcoeA6YokdDDajgZdweh1L4sxTsbue92ydWSEUFRrFzFWSAKmgY53t7iMku
         /lCIdDvzg12Kbtyr+/ZRTMeeKvXfivPVEkhCgaLdBb8c1nGZNIqblSePQDVOUk3Onyf3
         SKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=47goeNcf7ySSd2wJZhwukdXlDPfxczWFcezpMHqQeMk=;
        b=PeWCWhflo7f10VYu7LzBsKgkPYcbvgFtZCfWShFsv+vQTUiazkKgMqy3WIffek1afK
         POwf4K+f6ATkfI6Fjeiy+WMKyddkHTf5bMQyjkzoY0T/Msjk8NaPgP5gUj8ZgVnNs4Mt
         +PnMdAp4DOiA1Jy5BOIyQ4ULZ36JU7n0C3G9WXSr2sTjZxGnQFO2DLbhan3xOn0fnyIm
         WsYvlhL341/TDlnow7F5P5V0Gsw0JGQaXH0utB3D4IiRygnvoLzEk6auzaXvY7dOceBx
         Apbq/fpcsElivqfxgNt42nJsVz9+EfESFV2aiJAL75G1NzaEruGuUMvian8YJuYvYtT+
         4KYA==
X-Gm-Message-State: AIVw111Ks2CxHwMj3CiNTCu0TfYSS08+raN1676x06rkd/IV6EyqyfPP
        /wOE1vyIrNoTGg==
X-Received: by 10.99.117.71 with SMTP id f7mr3169318pgn.245.1499101874789;
        Mon, 03 Jul 2017 10:11:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id h123sm29010018pgc.36.2017.07.03.10.11.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 10:11:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170701220547.10464-1-avarab@gmail.com>
        <20170627121718.12078-1-avarab@gmail.com>
        <20170701220547.10464-3-avarab@gmail.com>
Date:   Mon, 03 Jul 2017 10:11:12 -0700
In-Reply-To: <20170701220547.10464-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 1 Jul 2017 22:05:46 +0000")
Message-ID: <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add an option to use the sha1collisiondetection library from the
> submodule in sha1collisiondetection/ instead of in the copy in the
> sha1dc/ directory.
>
> This allows us to try out the submodule in sha1collisiondetection
> without breaking the build for anyone who's not expecting them as we
> work out any kinks.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .gitmodules            |  4 ++++
>  Makefile               | 12 ++++++++++++
>  hash.h                 |  4 ++++
>  sha1collisiondetection |  1 +
>  4 files changed, 21 insertions(+)
>  create mode 100644 .gitmodules
>  create mode 160000 sha1collisiondetection
>
> diff --git a/.gitmodules b/.gitmodules
> new file mode 100644
> index 0000000000..cbeebdab7a
> --- /dev/null
> +++ b/.gitmodules
> @@ -0,0 +1,4 @@
> +[submodule "sha1collisiondetection"]
> +	path = sha1collisiondetection
> +	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
> +	branch = master

Do we need to say this "branch" bit?

Other than that looks good to me.

Thanks.
