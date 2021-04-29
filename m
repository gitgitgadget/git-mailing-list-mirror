Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D264C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E4B6144E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhD2Rak (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhD2Raj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 13:30:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7045C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:29:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q6so20258238edr.3
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hg+/QeTJW2bU9Xrtl05ubOlLRxsZY3lzYYgkZytQqys=;
        b=JfbiIgSDcV2C6p56tcKGx8A9Oew+3V8nQFzuFFH0WBHXfUuQuNfA/+SDZNmvKJwWhn
         F8jSckfoVjRM2YaZzvJxTEDvQvZQM4mPA9YIlk27EwDL28QkVRmdzhAT4WhN5jfApLxp
         xCWhtF9r4mx7Y1KWmD/8KD6BUZjzkI2rzXxe+I1m+vz+0bZjp1RFFgd5TqI46k1Mn0UA
         f/xEmEK63o0x9mTC2wy2vABem5IhajFosBYInpybKt6iU2rUSgFBdk7hfKczgTZ39427
         xnsd9s7mAKaUUbrUJ49IeQVv5fNsKgB4yB4Cxq6d1w/GBD0JWGDNyNgf8lnHAPIYPmlO
         dfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg+/QeTJW2bU9Xrtl05ubOlLRxsZY3lzYYgkZytQqys=;
        b=awZQhApppiPfbGMt/3ADxcW9w0Fzz0YxqQjW6N9WfFwhRLXkN+vEPC4GLCqhP9YLzj
         juPtTYFLatiX8ixa26Jh02DBYTlh8HrPNrZMa7cHkv+KEBmnglVW26cU39nVtiluwko5
         fqfD1nyXYs/J5wi65JT5WgG/aLFnlXJQ7KhcP01W6d45eFUJW8u5pjaNdVenSKoYNITL
         U+XPinKgX963FSVz15933LVSaSacd6z59jS9GIH91IEtSG4pYAangkZJOXl0PcQxU7Vt
         Vl904EU9zztmsXCFrmki88nRrbeo0+pmtKJPuhFBYtwhqY5VU0a1KUje3xgVCCPbZ/Jx
         mn1Q==
X-Gm-Message-State: AOAM530+A5I/Id0nKPPFO7/xlXFaYhXuLob1L4+DxmIQJ3wPyj2bSguV
        NfYoTM7H9A4HQYdd/NvFS29N3F5QUqcQQ8OwzOw=
X-Google-Smtp-Source: ABdhPJzatFke+ab/fV344y9IF1zCiOcp76cGEf5mI/mbl2WC7YgoA3fPqU87Ob144y5hXhgnD03zPM6i7DbU8icyPp8=
X-Received: by 2002:aa7:cd4d:: with SMTP id v13mr875034edw.218.1619717390377;
 Thu, 29 Apr 2021 10:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210428145824.43c4t7hkjfqjyspb@tb-raspi4> <20210429073905.837-1-tzadik.vanderhoof@gmail.com>
 <179cd4f0-def6-1b3a-2802-139b19d3301d@diamand.org>
In-Reply-To: <179cd4f0-def6-1b3a-2802-139b19d3301d@diamand.org>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Thu, 29 Apr 2021 10:29:39 -0700
Message-ID: <CAKu1iLWUZqRu5fpGxdwLKjMwRCexcFJdz+uxo+AF3u32W4dOtQ@mail.gmail.com>
Subject: Re: [PATCH v6] Add git-p4.fallbackEncoding
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pete Wyckoff <pw@padd.com>,
        Anders Bakken <abakken@netflix.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 1:36 AM Luke Diamand <luke@diamand.org> wrote:
>
> I think Andrew Oakley pointed this out earlier - but in the days of
> Python2 this was (I think) never a problem. Python2 just took in the
> binary data, in whatever encoding, and passed it untouched on to git,
> which in turn just stored it.
>

Unfortunately, I just became aware yesterday that Andrew Oakley was
also working on this issue (his CC to me 2 weeks ago somehow ended up
in my Spam folder, and I only dug it out of there after finding out
that we both created a test with the same number).

When I first became aware of Andrew's work (yesterday), I thought it
would make mine unnecessary, but upon further investigation, I don't
think Andrew's work will solve this problem.  Please see my reply
yesterday to Andew's thread:
https://lore.kernel.org/git/CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com
