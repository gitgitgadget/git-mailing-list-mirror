Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBAAC7EE25
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 18:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjFGSQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFGSQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 14:16:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FE7210B
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 11:15:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba88ec544ddso12644882276.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686161685; x=1688753685;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeVnGEGq+eSsIla+izN1OzX/5MxJ1IHPYt0cFGOsTDM=;
        b=Ln3ZzDmZ4Tc46+8YAikx243VXhXf3aqNz5Fj2Nq+tDxbc10/FtCGqDB+/Hflej1aUP
         kqtEMkE1N3HZzRa42kDg3vLiVTV3/WQQgelyu1CLlSXLoH6IOv4gb4d5YntinaY9Ghz3
         o0RRIMvt/6t8XFrZ8UQlMNnaNTUpEgSBD+OK4ePTcgqKceCez7rz4BFGvkgAIV4JC9EB
         OfQ/z5yzYNJrhZeMf2afAr4gLnXUaihO5mte6IENZBQALQmeH7K/E0a81K2jSFAeA08Z
         STjUV6woLVFEz1f9Hi1FRitv3cPNbvtCqNWZvW/8p0ObyBKrrV9oHqOhHLGDy84YzuYf
         t/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161685; x=1688753685;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oeVnGEGq+eSsIla+izN1OzX/5MxJ1IHPYt0cFGOsTDM=;
        b=hlzOEGtukl9DCJsZq+Ep4TgMrYD++3CJqdBkvEeZsaBY4qhh2Z4L4Q/jGadcJrn9eT
         md8GlR0osJ/g6pbYXoBiEEuVkmLTOtpvyM+LDGM0cDu12Tq2aEoT4OGiSLjgTBdy1gdI
         kZxEDYRDIJe3++umRM8Pbr8uisdN5PFGhCmOhGSpR0eKgPNzfxC2CiFb8Vg8Wvn4C80/
         J82z7jwj/EaoZ/Ua4UPcb8nytbanKtjUf1LBIWub2tw4gD44BfC9mCKvja9zGF0SqVg8
         fpL8PeDqtaOqZjeHkoDGGAYeHlwiszjkUopct/+nspRQ4R0g2zpzpskYd5t3sGcQtBV4
         JEXA==
X-Gm-Message-State: AC+VfDxKUC4/OhFkaJVaiUNa8Cv6JNnbARMgZDmGsZYasrFtctGQSVV3
        GTU1yh5rR4vE+nvuU4tPxyKYgeSq+4Q=
X-Google-Smtp-Source: ACHHUZ6bx/zb776MHE6qB9Ks++P5xZbuJUAH2Xy93dVnUTjmedWotPTbgyz3njAEx4TF3lcnAig8ijHyWSA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:72a:b0:bab:cc56:76c2 with SMTP id
 l10-20020a056902072a00b00babcc5676c2mr3721537ybt.8.1686161684794; Wed, 07 Jun
 2023 11:14:44 -0700 (PDT)
Date:   Wed, 07 Jun 2023 11:14:42 -0700
In-Reply-To: <CAPig+cRE8=_WW_1_ER6=ObGaFzMdmQmESe5Gsb=dwo4DEx4u=A@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1542.git.1686099081989.gitgitgadget@gmail.com> <CAPig+cRE8=_WW_1_ER6=ObGaFzMdmQmESe5Gsb=dwo4DEx4u=A@mail.gmail.com>
Message-ID: <owlyr0qnnnql.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: typofixes
From:   Linus Arver <linusa@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RXJpYyBTdW5zaGluZSA8c3Vuc2hpbmVAc3Vuc2hpbmVjby5jb20+IHdyaXRlczoNCg0KPiBPbiBU
dWUsIEp1biA2LCAyMDIzIGF0IDg6NTbigK9QTSBMaW51cyBBcnZlciB2aWEgR2l0R2l0R2FkZ2V0
DQo+IDxnaXRnaXRnYWRnZXRAZ21haWwuY29tPiB3cm90ZToNCj4+IFRoZXNlIHdlcmUgZm91bmQg
d2l0aCBhbiBhdXRvbWF0ZWQgQ0xJIHRvb2wgWzFdLiBPbmx5IHRoZQ0KPj4gIkRvY3VtZW50YXRp
b24iIHN1YmZvbGRlciAoYW5kIG5vdCBzb3VyY2UgY29kZSBmaWxlcykgd2FzIGNvbnNpZGVyZWQN
Cj4+IGJlY2F1c2UgdGhlIGRvY3MgYXJlIHVzZXItZmFjaW5nLg0KDQo+PiBbMV06IGh0dHBzOi8v
Y3JhdGVzLmlvL2NyYXRlcy90eXBvcy1jbGkNCg0KPj4gU2lnbmVkLW9mZi1ieTogTGludXMgQXJ2
ZXIgPGxpbnVzYUBnb29nbGUuY29tPg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vQ29kaW5n
R3VpZGVsaW5lcyAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4gICBEb2N1bWVudGF0aW9uL2Nv
bmZpZy50eHQgICAgICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4+ICAgRG9jdW1lbnRhdGlv
bi9naXQtY3Zzc2VydmVyLnR4dCAgICAgICAgICAgICAgICAgfCAyICstDQo+PiAgIERvY3VtZW50
YXRpb24vZ2l0LWRlc2NyaWJlLnR4dCAgICAgICAgICAgICAgICAgIHwgNCArKy0tDQo+PiAgIERv
Y3VtZW50YXRpb24vZ2l0LWZvcm1hdC1wYXRjaC50eHQgICAgICAgICAgICAgIHwgMiArLQ0KPj4g
ICBEb2N1bWVudGF0aW9uL2dpdC1scy10cmVlLnR4dCAgICAgICAgICAgICAgICAgICB8IDIgKy0N
Cj4+ICAgRG9jdW1lbnRhdGlvbi9naXQtbWt0YWcudHh0ICAgICAgICAgICAgICAgICAgICAgfCAy
ICstDQo+PiAgIERvY3VtZW50YXRpb24vZ2l0LXNwYXJzZS1jaGVja291dC50eHQgICAgICAgICAg
IHwgMiArLQ0KPj4gICBEb2N1bWVudGF0aW9uL2dpdC1zdGFzaC50eHQgICAgICAgICAgICAgICAg
ICAgICB8IDIgKy0NCj4+ICAgRG9jdW1lbnRhdGlvbi9naXR3ZWIudHh0ICAgICAgICAgICAgICAg
ICAgICAgICAgfCAyICstDQo+PiAgIERvY3VtZW50YXRpb24vdGVjaG5pY2FsL3JlbWVtYmVyaW5n
LXJlbmFtZXMudHh0IHwgMiArLQ0KPj4gICBEb2N1bWVudGF0aW9uL3VybHMtcmVtb3Rlcy50eHQg
ICAgICAgICAgICAgICAgICB8IDIgKy0NCg0KPiBUaGVzZSBjaGFuZ2VzIGFsbCBsb29rIHNlbnNp
YmxlLiBUaGFua3MuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyAtLS0gYnV0IG9uIHNlY29uZCBp
bnNwZWN0aW9uIEkgbWVzc2VkIHVwIHRoZSBmaXgNCnRvIGdpdC1mb3JtYXQtcGF0Y2gudHh0LiBU
aGUgdG9vbCBzdWdnZXN0ZWQgImludGVyYWN0aW9uIiB3aGljaCBJDQpmb2xsb3dlZCBtZWNoYW5p
Y2FsbHksIGJ1dCBJIG5vdGljZWQganVzdCBub3cgdGhhdCB0aGUgcmVhbCBmaXggc2hvdWxkDQpo
YXZlIGJlZW4gIml0ZXJhdGlvbiIuIEkgaGF2ZSBhIHYyIG9mIHRoaXMgcmVhZHkgdG8gZ290IGJ1
dCBHaXRHaXRHYWRnZXQNCmlzIGRlbGF5ZWQgZHVlIHRvIEdpdEh1YiBleHBlcmllbmNpbmcgYW4g
aXNzdWUgYXQgdGhlIG1vbWVudCwgc28gZXhwZWN0DQpzb21lIGRlbGF5IGJlZm9yZSB0aGUgdjIg
Z2V0cyBwdXNoZWQgdG8gdGhlIGxpc3QuDQo=
