Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DACC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 08:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiAJIXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 03:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiAJIW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 03:22:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D7C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 00:22:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso20043360pjm.4
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 00:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egJ1ez/H6xKgB5GwD7WAU4W0HZSYJOXF4uBEIf1ZRCY=;
        b=bUDLt265G/53l6QseumBE4ebJLCP6OeLEQKJXWilcyqCDVzR7sHnoVl1O4Mmrq3rk5
         BbYuLRA30DtBi/8B19/aUXCJknDtPmBW1wv5R9O8I12Owcnzp1P6j5pz3b0NX9jUV4oD
         0p0C71cDTHTJ3eMWZ0Rj8CZttr8+SNDQOWDyozNTfJT0oC4bKzaDBK6Tr6in2juUYVUi
         KiuSckjxRoU+Pv9Uam+OE1ZvvBZZ0MY/D1uw8J28gyfP4dNSf893YEk87IsZAT2nAiaM
         pn10Wko42bziZHtiHl2tM3s6Ut6NuzoM1pwKumqE3f3xEmw5o1Htz+vv2ZQdedkcfDMC
         f2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egJ1ez/H6xKgB5GwD7WAU4W0HZSYJOXF4uBEIf1ZRCY=;
        b=HCacYjB3tWQFYwW0tpONVGnaXPCcSY5YAnPJ5VpO4WM4przFaWocVQRFqk6u0wcc/P
         3oM+nA20XiCCCUriKZHlLwESI2B0gLiAuA+aq2/2/ohBcitak8DyM9dEXBsBkpi++Cwn
         nvszq4Ty9ujtC+BvaRujl9vFBw0X4ebdwc434K8l6vH2Ty6xfnsdbqM9Owkm4a8abkEI
         6oh0456ZI4rq8p/2UBk9gf/wRYnj+wzZeMi5/tsVoTYOOevbPVmbVbXCskefckcwlI2t
         NkE+l1cOOhx6ghY2wHfnoRJni6x6FFxG5PF5dP6MgM6ZNQIQqkbJQ1aTQjY8EpkYdi/k
         LKcg==
X-Gm-Message-State: AOAM533NciX3seLKBFgE5NSxu04rdfgQgYe7lR0LhsK9mkGdTjhyll+r
        xM+MZKfjZCkklkOYcjXVptk=
X-Google-Smtp-Source: ABdhPJyPdNwGCXatLM+tabZVx1Z7bKlO9wzNQ02RbjshYnofdeQdonbcEjWTBtocNHQKXQytItbTEA==
X-Received: by 2002:a17:902:d2d0:b0:149:48e4:f039 with SMTP id n16-20020a170902d2d000b0014948e4f039mr73435136plc.137.1641802978926;
        Mon, 10 Jan 2022 00:22:58 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s34sm6172841pfg.198.2022.01.10.00.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:22:58 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     avarab@gmail.com, congdanhqx@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Date:   Mon, 10 Jan 2022 16:22:54 +0800
Message-Id: <20220110082254.54400-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.399.g7b04f8a8c9.dirty
In-Reply-To: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I am not sure whether I have sent the email repeatedly, because it is
not shown on mailist. If so, sorry to bother you.

Johannes Schindelin writes:

> Doing this in 9/9 is too late, by this time you already introduced the
> code site that requires this workaround.

Yes, you are correct.
Will fixed if the patch is still remained to next one. 

> At the same time, I wonder why you want to defend spinning up the
> full-blown `printf()` machinery just to pad text that you can easily pad
> yourself. It sounds like a lot of trouble to me to introduce this patch
> and then use an uncommon method to pad a fixed string at runtime. Too much
> trouble for my liking.

I may not have explained it clearly in the cover. Sorry for that, I'm going
to explain some more here, please correct me if there is something wrong or
the method is not recommended or is not best practice in community.

Firstly, the patch needs to be introduced I think and it has nothing to do
with using "      -" or "%7s" here, because the fix recommandation is not
accurate in terms of the "static-analysis" report if someone just uses the
"addf" api:

-               strbuf_addf(line, "%7s", "-");
+               strbuf_addstr(line, "-");

They have different execution results and bring confusion to people. 

Then secondly, about the using "strbuf_addf(line, "%7s" , "-");" or
"strbuf_addstr(line, "      -");". I think you prefer the later and I prefer
the former, right? (I'm not a native English speaker, so I just want to make
sure I understand whole your meannings).

If I understand everything correctly so far, it's good :)

As I metioned in a previous reply [1], I think there is no performance
issue here..

Why I prefer more of the former that is because, for the single line,
it's more readable I think. Maybe it's not going to modify very often,
but If someone want to know what this is, might have to do a count. So
I don't think this is any more readable than "%7s".

Here's what I think and looking forward to your reply.

Thanks.


[1] https://public-inbox.org/git/CADMgQSRxko6nC0zfDiVVfL2ZkdQVbBq0s59Er+6Nmg9vz4uJKQ@mail.gmail.com/
