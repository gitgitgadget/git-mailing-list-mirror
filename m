Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7586C47086
	for <git@archiver.kernel.org>; Tue, 25 May 2021 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC54613F5
	for <git@archiver.kernel.org>; Tue, 25 May 2021 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhEYWPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYWPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 18:15:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF609C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 15:13:47 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c196so23567894oib.9
        for <git@vger.kernel.org>; Tue, 25 May 2021 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gX+vZVFy3b3KQxmWaYxGgyslHp6F3Wr5d83dkZc7Ru4=;
        b=c1JGrQtVNV5xpQTDIYQyKx8sdSHJZIvAarnMwGx/7zn3KXe/dmKV2ZYWxEpHZhksyP
         WOUY9zMPZKYEC4P0jbK075jxDPiGkWR020Nc/L5QlaffXvNCh2z438Mx59ORnYxB6AQW
         AroEF8xzPs+Ad48NDdWWMQnymnPuIH48xo8TfTwA40Ju7qrp1h0ajoRo764UtnZcTV+w
         ndFY/GJAjq0ZNc6x2zuVzXjEtNf0k8F0qbefH8blPSiIakNZoVI5MA8ELGvOOzTiFToS
         Bqnv9QEyZjzn8hyZCNhDLxOj+I4zwRf+df+md59N0yWFChB/fCka2O/eveu3sCLwNGax
         4OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gX+vZVFy3b3KQxmWaYxGgyslHp6F3Wr5d83dkZc7Ru4=;
        b=BtYaPdKu1Wk11RPC9D8PPO16LIn2YEikJSJDxHGar9ojWkKFY7wHhvcIIg3nRm+ynK
         u0623AJf070txgXEgzbp7CVQlhkNAfiZ+6DAR4l17hFrR0cenjuM3bW8SF7YUotRjdK3
         UhIMlHHIOzEB9m5FtAU/UMt/seafCmnmk4lvMAiBujTSD3HBrR8PSDcX28r6F3e09H8u
         fcnz86aqbD70QVYfW8fEuTKg7thGiPrMR8TTS6ctZik4nTFnPHmr7HfdvJhNFBlbAM1y
         2K5ECUCcGubguElnufIIcLkqrhs4syT5f/v51AvCDc4Nbx8ylRMrA3DoI/7zxrXeSM/5
         lYVg==
X-Gm-Message-State: AOAM532hKZopIAsfvqeL1mXlshFZ/Kh5tYOIAgKol+vyo41M7Ck6iu55
        WyOr1UCK4YC62r0Rf45HtqI=
X-Google-Smtp-Source: ABdhPJzAq/TTcgnrMOPeSXvRpuQe9JoycW1do7mRvJu0826rem+zJhQqAFRZq3afKgyZE14FV0c2JA==
X-Received: by 2002:aca:2b17:: with SMTP id i23mr333078oik.160.1621980827305;
        Tue, 25 May 2021 15:13:47 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e22sm3967004otl.74.2021.05.25.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:13:46 -0700 (PDT)
Date:   Tue, 25 May 2021 17:13:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60ad769938b70_294de208fc@natae.notmuch>
In-Reply-To: <xmqqim36eo12.fsf@gitster.g>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <20210521222941.525901-4-felipe.contreras@gmail.com>
 <xmqqcztgj9za.fsf@gitster.g>
 <60abf32038579_1b209208d2@natae.notmuch>
 <xmqqwnrnh626.fsf@gitster.g>
 <60ac9f332eeec_225d820832@natae.notmuch>
 <xmqqim36eo12.fsf@gitster.g>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >  * helped-by: 17% (1336)
> >> 
> >> I actually think people use this one to say "person X gave a
> >> valuable input in the review discussion", which is exactly the case
> >> here, and that was why I wondered you needed to invent a completely
> >> new one.
> >
> > I think the opposite: "helped-by" encompasses virtually anything...
> 
> But your own stats disagrees with your opinion, so don't invent a
> new thing, period.

Stats don't have opinions.

You and I have had this discussion before, between the status quo:

	die ("could not find author in commit %s",
	     oid_to_hex(&commit->object.oid));

And:

	die("could not find author in commit %s",
		oid_to_hex(&commit->object.oid));

Eventually you yourself updated the documentation to explicitly state
that it's fine to not align the subsequent lines to the opening
parenthesis: f26443da04 (CodingGuidelines: on splitting a long line,
2014-05-02).

It is wrong to demand something that is not in the guidelines,
especially if later on the guidelines might include the very thing
supposedly frowned upon [*].


In this particular case the guideline is not missing, it actually sides
with me:

  You can also create your own tag or use one that's in common usage
  such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".

If you want to forbid certain commit trailers--or limit the allowed
trailers to a sanctioned list--then update the guidelines first to
reflect that.


But I don't think it makes sense to do that, because commit
trailers--just like words, and hundreds of other things--follow a Zipf's
law, where the 10th most common word appears around 1/10th of the time.

If you graph the frequency of commit trailers vs. a Zipf distrubtion
with a 80:20 rule, it follows it almost perfectly [1]. That means 80% of the
commit trailers appear 20% of the time.

My script can calculate any quantile and for example found out that just
two lines--Acked-by and Reviewed-by--acound for 47% of all the lines.
They are the top 1%.

The top 10% is constituted by 16 lines, and the top 25% are 33.

The median is 1 appearance. That means of the 155 unique lines, half of
them have just 1 appearance, in fact, more than half: 100 of them.

For more details see the mail I just sent [2].

Unsurprisingly commit trailer lines follow the same pattern as income
distribution and musical bands popularity; the rich get richer.

As much as you might despise the poorest among commit trailers, they are
the majority, and they will keep being the majority.

Cheers.

[1] https://i.imgur.com/1wQgSlP.png
[2] https://lore.kernel.org/git/60ad75ac7ffca_2ae08208b@natae.notmuch/

[Footnote]

 * Granted, my patch back then did not match the new guideline
   perfectly, but also it wasn't wrong for reasons stated then.

-- 
Felipe Contreras
