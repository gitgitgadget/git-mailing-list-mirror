Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA5C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiKHSgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiKHSgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:36:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F322CC9C
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:36:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r14so23854300edc.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfDtKEI7K/IAIAKqCN2g9XZ09FB8Qz7opnCmtCTv4Wc=;
        b=b3BHPT79ltzWzJBsK/gkTCdbJQqsS8R7c/FAB9qmnORZD9QqShHT01asJAyqDpOlIZ
         L8zikezwbaJYjl/zWejDEzndm9Jk4jvczzq4TcvCf7/DX5cbtLm8iZ013WC94vLqUTm8
         ya0Gx+uJlKxf9OSh61BcEEpVbmfNosWl1rH15LgaaqynJoDDixQqSB7zSFs9y7UTY3ZU
         cpqCqqc9bixcb0Fp/hWYSLCZYNeN4XYmct1lwpWFBoLcD8YEfQkudRSefAu7eJo2hOGX
         CSoZKthFzyfBy9dgM2RqZGG+OayZrm762LaYHazcZBK4kIAt1nuYd/e4lcG9uWmOuepJ
         tjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfDtKEI7K/IAIAKqCN2g9XZ09FB8Qz7opnCmtCTv4Wc=;
        b=HFE5mVu4dP9YWjE4oBP2pZ2WDGNN+ENE6uKp4elvMW83dvv2jm7C6zK5+wu8COJI2V
         9OFpNN5U0N58FrjMI6xTh5w38Lxy61Qe4/zqMWE+7AA89+X7MZyqWO5M1UhlY90V64Vw
         d16qz3F6rcjiWSS0BCye4eXuzZNG52iebYzoqLPcMqLOUimYKbGICGDDejQDFIczkoDX
         GfQfY+ffWfCFSFWilXbrwqfmg0ZzrZF8tOZQA/mMji0GIY5XQkBNni4R3WAaBV5tvymh
         FPriggW8q8kxqR8UMofJUWRtP9BaRDyW5tQITdhMaAyX7JeoEthVBoP9iwv/JpAr6Vmr
         H+qQ==
X-Gm-Message-State: ACrzQf32HwT2tGDlVWpcQtUQoU8XJtLyCeqnPu+6/z04GGSeFUTYcxF1
        d5NR/yPcq5SuMW+N009oVFZFdCrCloNm5w==
X-Google-Smtp-Source: AMsMyM7viumyszH4yCNKgOPYDua8oU7AOt2hTR+5puA+Tz7Z1FlijNDZLJN1JHb0JXpfYuJBHq49vw==
X-Received: by 2002:a05:6402:26c1:b0:461:97fe:a331 with SMTP id x1-20020a05640226c100b0046197fea331mr996351edd.238.1667932590533;
        Tue, 08 Nov 2022 10:36:30 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b0078c213ad441sm4970704ejb.101.2022.11.08.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:36:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osTSX-000h5D-00;
        Tue, 08 Nov 2022 19:36:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] submodule: tests, cleanup to prepare for built-in
Date:   Tue, 08 Nov 2022 19:34:08 +0100
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
 <kl6lh6z947ud.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lh6z947ud.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221108.86v8npqonn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Glen Choo wrote:

> [...]
> Thanks! This addresses all of my comments from v1, and I didn't 
> spot any other issues during a quick 2nd pass.
>
>   Reviewed-by: Glen Choo <chooglen@google.com>

Thanks for the quick review!

One thing I completely forgot in the v2 CL: The 3/9 here is new. Stictly
speaking we could skip it, but I wanted to be able to mark the new test
I added as as leak-free, and fixing the only leak it ran into was
trivial:
https://lore.kernel.org/git/patch-v2-3.9-a3529d7f9e0-20221108T140501Z-avarab@gmail.com/

So rather than having another "small leak fix for submodules" topic
depend on this topic, I think it's OK to just bundle that up with this
one.
