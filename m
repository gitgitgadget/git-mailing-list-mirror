Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DE1C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FB364EC4
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBSGK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSGK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:10:26 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27232C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:09:46 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id n19so1038843ooj.11
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxH0sfGrOHrYl1Xy0UQRlU7dLk5ShWos5FFFUmJfM5Q=;
        b=a8Tf15YKYAjkBB1rzdhm6EQPW6aUJJd/TpvavNKh7Ubm3IhLlRvPmo6Bzy+L8i4HWK
         3+oxCtVcvXeaLc4BdZa+D/Bak216sR8T7vyTmxf9W5HcvV+C5flX22cBsdIN1r9exDwT
         7+Mdvt9gwBgj1kUNpWFZkhiiTk59l8K++CPo3KZq4+5jhpoacKHooyZZD/h5xGAOceg4
         +KxdpH08/uAu2kJ4MnDxXDnBCtzoWtNO7I5PAlXOvnqMr6ftIWaA0ReYwZRQRSFWOdsr
         Ix12PEPjy7QVzzryNo3phiTMBVWt4FjeMbfMtIpjC0vdEvbNfCk8n11xONy3gWD7tp0V
         FWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxH0sfGrOHrYl1Xy0UQRlU7dLk5ShWos5FFFUmJfM5Q=;
        b=H0Z27iSNIlNBr1VeSysODrmLIW3djtZyZ0edDsVfuNYj/VlMT+KNpQ1E537uZlftqm
         uYKx8CDxWBaZMAQYMVwuz06qp+DbCw0OQY+OOf6zpl2dxWX4moetE4ee4/kR3qPWlsvO
         mAK6wJPEfphFt5GPMvpKET65AzS0Ra86czfPvBF6sRgVimVVr2m12KWvNmGOXIeBw6DI
         hyXfPqsCe2gxVCq+pyzN102RTv8XP5LyunzkDaaPpMa748UVWzM1aTb2YEH0AS3hZEkC
         eR0TiB1FntxqyjhmZ4N56EooD25K6yYYo5M35vluN4YBA5OOjLQ8Dj16PNg3hhY706lo
         C+QA==
X-Gm-Message-State: AOAM5326/6a1JXkjtZuxlKoN8kKwVirIxcjAg5ekPwIGkLO1xiTmRjT7
        1AyU4nyNHt98sG+6TsDG8cyvCKqxvdj1YN2Tw5FlflzDaow=
X-Google-Smtp-Source: ABdhPJzj8vYfo7dl+i2vUTRyGdor90p/5Y5rZSF9oi3QiDLV3DlGDgwgo8mAcCheAukhBzXhODCcyaCTC8I1zH1C/vc=
X-Received: by 2002:a05:6820:347:: with SMTP id m7mr5756171ooe.75.1613714985441;
 Thu, 18 Feb 2021 22:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-2-charvi077@gmail.com> <xmqq35xulbj0.fsf@gitster.g>
 <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com> <xmqqpn0xfal8.fsf@gitster.g>
In-Reply-To: <xmqqpn0xfal8.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 19 Feb 2021 11:39:34 +0530
Message-ID: <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Feb 2021 at 00:49, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> In what situation would a user use "-m 'appended pieces of text'"
> option, together with "--fixup=amend:<commit>"?  I am wondering if
> we want such a "append to" feature, or is it easier to understand
> for end-users if "-m", "-F", "-C" and "-c" (the common trait of
> these options is that they contribute to the log message text)
> are made incompatible with --fixup=amend:<commit>.
>

For end-users "-m" or "-F" will make it easier to prepare an "amend!"
commit. Because using the "-m" reduces the cost of opening an editor
to prepare "amend!" commit and it can be done with command line only.
So, I think we can keep -m/-F options.

(Explained more about "-m" use in next thread)

> > ...Thanks, for pointing this out. Also, in the above method for
> > alnum I think we can initialize an array of alnum[] instead of
> > alphas[]. Or otherwise I was thinking to instead check:
> >            if (!isalnum(*c) && *c == ':')
>
> Sure a loop is fine, or alnum[] is fine, or just alpha[] is OK, I
> would think.  Do you foresee you'd need --fixup=chomp124:<commit>?
> I somehow doubt it.

For naming the suboptions, I don't see any use of alnum. Earlier, I
thought that it could be possible to add the option of _commit
name/ID_, although I am not sure about any particular use case of it
for future. So I thought of changing it to an alnum[] but I also agree
that we can use just alpha[].
