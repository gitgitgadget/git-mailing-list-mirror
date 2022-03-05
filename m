Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFEC433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiCEObJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEObJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 09:31:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D030F79
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:30:19 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id yy13so14248139ejb.2
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5XhRULwAABdkPLAkZXabZw1pOMlmbip2x0tfmaILsFU=;
        b=GZ4pf2OnqgCg0vG25UglHIqh+fD8uDDwjIbB9m9ppgrlWtjRxBBN1UpwE9KH/SrwaX
         uBJpkm1f28uYeBC8jWNwVZX9bpCpR+PutmsuJKXaLnJHr5HFCsaZuKMLTWDa5VawThxk
         NX1JtR/n4drVAvgYitj1hEpnV4CSeXf+VRLfYq4zffqsmkLHvP88Oj34ClpmxyQQMlmg
         65OGiq5PAwGI9wQh71zTxxCPSjNCYIjyLw05CVoTzIM2bU+XyXgSYtVd+SsaaJA4ZTeB
         hMCovkLLBy8xTehfy9xbkcnOcs1zLqqJY8s5TI2OfRkainXFJ5Ebs+6qEg4T7wix13T/
         zLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5XhRULwAABdkPLAkZXabZw1pOMlmbip2x0tfmaILsFU=;
        b=08U+2TXPgjm80bp36H7wTR+RJk35llY+Te90Wj1CHGKnYnyJxoKNM5M02ZohMKD/aw
         /+Vo0ntl30jaAfMmG04UdBFfST6F2wzqVf3mr+QTChFcPaFpaPmxiwp3nDuIF+d2TUFR
         /NPQjmcjwKaeQwyfLk8XGrq2z5ndn/eF9NowYoJXiubDrSCiUaHRv9pSABSQuUCkpTTi
         xzphNhCCev9LQ8G1/a0TJubkkGCWXBwrVlcvdQZoCcVzrucK8U35ZDtirZSnEP6CT/un
         XaZFZ/i3KqQr/MeHXe6FlnQBiy4VR0oDjGvIH8XxwivcTdFTBenAeu/69SipDTfvaKRI
         haYQ==
X-Gm-Message-State: AOAM530hhqv2e1cg0LojoMuTEkSqYJU2m8D90p7KU145WH9n7Iw5lrpB
        0oCSAY/qCDK1MX08y+nz6NbQ/i6t6Qpanw==
X-Google-Smtp-Source: ABdhPJza+DlBQGykikti85UJIxGoVxoeaUr4/8colEOEKAziECe/YoJgZUexx+rka0KU09HcEcU+FQ==
X-Received: by 2002:a17:906:c14e:b0:6da:970b:cc33 with SMTP id dp14-20020a170906c14e00b006da970bcc33mr2865688ejc.307.1646490617663;
        Sat, 05 Mar 2022 06:30:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm3483785edz.29.2022.03.05.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 06:30:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQVQG-000XMm-DW;
        Sat, 05 Mar 2022 15:30:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH v3 1/2] builtin/remote.c: parse options in 'rename'
Date:   Sat, 05 Mar 2022 15:28:31 +0100
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <cover.1646346286.git.me@ttaylorr.com>
 <b76da50b549d71b3e61f74c6250fea595ee2b2c1.1646346287.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b76da50b549d71b3e61f74c6250fea595ee2b2c1.1646346287.git.me@ttaylorr.com>
Message-ID: <220305.86tucc3213.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Taylor Blau wrote:

> The 'git remote rename' command doesn't currently take any command-line
> arguments besides the existing and new name of a remote, and so has no
> need to call parse_options().

I think nothing needs to change here in the body of the test, but just a
correction: We do in fact use parse_options() here in the pre-image. I.e.:

    git remote -h
    git remote rename -h

I.e. we'll detect "-h", emit the appropriate usage etc.
