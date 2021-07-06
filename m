Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0CC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BF761A11
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGFUEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGFUET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:04:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB7C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:01:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c17so36045928ejk.13
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EN4e6aBEFzYOK74FxXkf2RgNh1zKkzg5uX3Pbux9Bw0=;
        b=Xch7pnuBlApManT4fW+RbuiyckKq8Nm6fojwVvm8ld7OtPm3ymJEfd8SLe0/kkNXTi
         yw6+arN+COOXDaEe6KLTbPeViAtqlx5MrPwpJiSE/ghww6jB0k00zmfRXKC/NJtky2It
         S7stYHOjsNmhUyK3Co/OYxLXpv2wgkZx1fwmaT9gfVkUs9R/T+ud7/GL/9ppst5katkh
         7eQhEEWOwl/VsMJC/yk4kab9wMvAsdF/Jd1IpelhNrWIEIOwrn23ijBBfM/qJB8S2WIw
         vzE9OebWublidWVhVpWJrn7aWGWILFvINttxrz+J/wyyAVbEIdkpwKJHwepR2coC6h54
         uK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EN4e6aBEFzYOK74FxXkf2RgNh1zKkzg5uX3Pbux9Bw0=;
        b=Z6+JlqAnWFnEUeIl810He4AbHFK/TUqosLxzS4afqTI/5L4+sh7GGtH6UAkXORVEmY
         j8l0G1rGkFrdpM/38GYrbp9uQwosAjg21wMBJ/sIH2qhAQ4f8Wf4FiolJdViujBuLuMn
         8OugYwjtvoJGIcVg6zs90yGcYCHcQWHbyOSFwLOCKhYYZ6b9phq7vF26mc1BA9/oQwCK
         H7wsW4EGUw8xc9Eo0vTWEWegTUXhhnbsXCuZxptBE5coYTqV7Wee073NG0rxQga/QB/k
         Bjpf8c2MtmUfKecjzKaWYN+oE4KjPB+4OONbuySoJoUFCkjfQr6aWKqU1Wytcgka7nb0
         VyJA==
X-Gm-Message-State: AOAM5312bareMoPQsRFX6WSOQjQKen5g7ETA8wGwqkrkZoio7vTpHs9i
        oRqS391CLGVHQvTU1uinftY=
X-Google-Smtp-Source: ABdhPJyr86EIj/5iYNOiIoORmFyfyKPH8spXQhG84R6kMXklklmd9maKBqpk2rGbbT8fp1lScxtQFQ==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr20528944ejc.110.1625601697962;
        Tue, 06 Jul 2021 13:01:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p8sm1662311eds.15.2021.07.06.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:01:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
Date:   Tue, 06 Jul 2021 21:56:38 +0200
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210702142556.99864-3-lenaic@lhuard.fr>
Message-ID: <87h7h75hzz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpPbiBGcmksIEp1bCAwMiAyMDIxLCBMw6luYcOvYyBIdWFyZCB3cm90ZToNCg0KPiArICogICAg
IOKUj+KUgeKUgeKUgeKUgeKUgeKUgeKUgeKUs+KUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUkw0KPiArICogICAgIOKUgyBJbnB1dCDilIMgICAgICAgICAgICAgICAgICAgICBPdXRw
dXQgICAgICAgICAgICAgICAgICAgICAg4pSDDQo+ICsgKiAgICAg4pSDICpjbWQgIOKUgyByZXR1
cm4gY29kZSDilIIgICAgICAgKmNtZCAgICAgICAg4pSCICppc19hdmFpbGFibGUg4pSDDQo+ICsg
KiAgICAg4pSj4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pWL4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pS/4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pS/4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSrDQo+ICsgKiAgICAg4pSDICJmb28iIOKUgyAgICBmYWxzZSAgICDilIIgImZv
byIgKHVuY2hhbmdlZCkg4pSCICAodW5jaGFuZ2VkKSAg4pSDDQo+ICsgKiAgICAg4pSX4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pS74pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pS34pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pS34pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSbDQoN
Ckkgd29uZGVyIGlmIHdlIGhhdmUgZGV2ZWxvcGVycyBmb3Igd2hvbSB0aGUgbm9uLUFTQ0lJIGhl
cmUgaXMgYW4gaXNzdWUuDQoNCj4gK3N0YXRpYyBpbnQgZ2V0X3NjaGVkdWxlX2NtZChjb25zdCBj
aGFyICoqY21kLCBpbnQgKmlzX2F2YWlsYWJsZSkNCj4gK3sNCj4gKwljaGFyICppdGVtOw0KPiAr
CWNoYXIgKnRlc3RpbmcgPSB4c3RyZHVwX29yX251bGwoZ2V0ZW52KCJHSVRfVEVTVF9NQUlOVF9T
Q0hFRFVMRVIiKSk7DQo+ICsNCj4gKwlpZiAoIXRlc3RpbmcpDQo+ICsJCXJldHVybiAwOw0KPiAr
DQo+ICsJaWYgKGlzX2F2YWlsYWJsZSkNCj4gKwkJKmlzX2F2YWlsYWJsZSA9IDA7DQo+ICsNCj4g
Kwlmb3IgKGl0ZW0gPSB0ZXN0aW5nOzspIHsNCj4gKwkJY2hhciAqc2VwOw0KPiArCQljaGFyICpl
bmRfaXRlbSA9IHN0cmNocihpdGVtLCAnLCcpOw0KPiArCQlpZiAoZW5kX2l0ZW0pDQo+ICsJCQkq
ZW5kX2l0ZW0gPSAnXDAnOw0KPiArDQo+ICsJCXNlcCA9IHN0cmNocihpdGVtLCAnOicpOw0KPiAr
CQlpZiAoIXNlcCkNCj4gKwkJCWRpZSgiR0lUX1RFU1RfTUFJTlRfU0NIRURVTEVSIHVucGFyc2Vh
YmxlOiAlcyIsIHRlc3RpbmcpOw0KPiArCQkqc2VwID0gJ1wwJzsNCj4gKw0KPiArCQlpZiAoIXN0
cmNtcCgqY21kLCBpdGVtKSkgew0KPiArCQkJKmNtZCA9IHNlcCArIDE7DQo+ICsJCQlpZiAoaXNf
YXZhaWxhYmxlKQ0KPiArCQkJCSppc19hdmFpbGFibGUgPSAxOw0KPiArCQkJVU5MRUFLKHRlc3Rp
bmcpOw0KPiArCQkJcmV0dXJuIDE7DQo+ICsJCX0NCg0KVGhpcyBzb3J0IG9mIGNvZGUgaXMgbXVj
aCBtb3JlIHBsZXNlYW50IHRvIHJlYWQgYW5kIHdvcmsgd2l0aCBpZiB5b3UgdXNlDQpzdHJidWZf
c3BsaXRfYnVmKCkuIFRoaXMgaXNuJ3QgcGVyZm9ybWFuY2Ugc2Vuc2l0aXZlLCBzbyBhIGZldyBt
b3JlDQphbGxvY2F0aW9ucyBpcyBmaW5lLg0KDQo+ICsjaWZkZWYgX19BUFBMRV9fDQo+ICsJcmV0
dXJuIDE7DQo+ICsjZWxzZQ0KPiArCXJldHVybiAwOw0KPiArI2VuZGlmDQo+ICt9DQoNCkkgc2Vl
IHRoaXMgaXMgcGFydGlhbGx5IGEgcHJlLWV4aXN0aW5nIHRoaW5nIGluIHRoZSBmaWxlLCBidXQg
d2UgaGF2ZSBhbg0KX19BUFBMRV9fIGFscmVhZHkgaW4gY2FjaGUuaC4gUGVyaGFwcyBkZWZpbmUg
YSBpTEFVTkNIQ1RMX0FWQUlMQUJMRQ0KdGhlcmUuIFNlZSBlLmcuIDYyZTVlZTgxYTM5IChyZWFk
LWNhY2hlLmM6IHJlbW92ZSAjaWZkZWYgTk9fUFRIUkVBRFMsDQoyMDE4LTExLTAzKS4NCg==
