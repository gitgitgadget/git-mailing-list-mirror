Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7DC2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbdBNKFe (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 05:05:34 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33082 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbdBNKEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 05:04:37 -0500
Received: by mail-ot0-f193.google.com with SMTP id t47so808593ota.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RWcoy4a5E0OOucgvW3A11bwOducSO9en2OPp83pChFQ=;
        b=NMngKjHLn82+Z+gQw8JuMuvuP+CsMEbPXxlddwj74lVjBkhSs5rvSVZmLiPehDuRd8
         LFikkaVNKSP0mDp45gKF9+I7M2XkRN81W+aZvBq27ccxaYn659t41QT3q1QoawLUj7cG
         oILXigR8elK3BBOkJkkliTgOI7EVxgjRVkLmANzkhmXf/rkgr410mivC0D6ROd4tYI5s
         BZOhKNkvg9yfpKbRRWENOdnK40HlYdSowuihmjxcqBAPMhdoxtG9HzeSY3YqRaW5VNwO
         GrvNRoBx7tldlX2l39g2MEYHYxnCFDgIZ/LKezxo//PrsUtjqBu7FSauPL6LdbwGdQn3
         OOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RWcoy4a5E0OOucgvW3A11bwOducSO9en2OPp83pChFQ=;
        b=jcFQuWEBmKnJA84N8byzcX+id3JhkbotUzxmYC+2kFYfBKTrNPGcoSw3fKMKYhELXo
         bficJ/Z96OtF23OzH95vR7fTVZ3l+69OaXyTNXJgYhzNXG1U5PH1yXIM7DR7M2e82EBX
         5d0imAzAXwf1MlJowFF4/qQ+Cp16yYCCU2+/xNjJKGab/5sMQyhQTNm4JGA0pAEYCxmA
         ioueHfAxPlLt5kdUYufrM4fOeAK+ARFh2P3HbIHfReEh9zFyuRu5j7mYVt52R/+AmGQd
         jzV45fEGxBy7FGX/N08ZQUaH2xoRfprxovcvGpEXi5EGpoAH9Y1UaLbgGtG5acbuD0OW
         Kvvw==
X-Gm-Message-State: AMke39kujaPTQgGPmgYPSpQny7hnBfoVCNTaFKLrxMuqqfE45x8VnMoOTk6vDVa7edpnawa3XSdT6GZG61WBJQ==
X-Received: by 10.157.27.11 with SMTP id l11mr1590640otl.199.1487066676660;
 Tue, 14 Feb 2017 02:04:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 02:04:06 -0800 (PST)
In-Reply-To: <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-12-pclouds@gmail.com>
 <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 17:04:06 +0700
Message-ID: <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] refs: split and make get_*_ref_store() public API
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 6:55 AM, Stefan Beller <sbeller@google.com> wrote:
>>
>> +/*
>> + * Return the ref_store instance for the specified submodule. For the
>> + * main repository, use submodule==NULL; such a call cannot fail.
>
> So now we have both a get_main as well as a get_submodule function,
> but the submodule function can return the main as well?
>
> I'd rather see this as a BUG; or asking another way:
> What is the difference between get_submodule_ref_store(NULL)
> and get_main_ref_store() ?

Technical debts :) In order to do that, we need to make sure
_submodule() never takes NULL as main repo. But current code does. On
example is revision.c where submodule==NULL is the main repo. In the
end, I agree that get_submodule_ref_store(NULL) should be a bug.

> As you went through all call sites (by renaming the function), we'd
> be able to tell that there is no caller with NULL, or is it?

Direct call sites are just middle men though, e.g.
for_each_ref_submodule(). I'll attempt to clean this up at some point
in future (probably at the same time I attempt to kill *_submodule ref
api). But I think for now I'll just put a TODO or FIXME comment here.
-- 
Duy
