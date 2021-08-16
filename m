Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E241CC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA61D60EE0
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 13:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhHPNat (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbhHPN0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 09:26:24 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E34C0363D5
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 06:11:46 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n11so14116852qkk.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfSfaJPOzzelsOMsOvt93lccitdxgdGNAKfOMGmNvxo=;
        b=PxzRSP+FGsLytmzzpt7I2+C6yrPnGqEfIl3pzyqNnGScIu5w3LF3J2qD3PyG5Fr/YZ
         rMLb0wheXI0UzbHKNPObcFZPzLUqidivj0psEZlSc5QFfGF8WEgANmZ4FEpmQdBApclO
         fUCnWl3qmK8mJpcIaPx6WVBYhAdgN6gcdQ7zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfSfaJPOzzelsOMsOvt93lccitdxgdGNAKfOMGmNvxo=;
        b=If18Tem0FcD8ZWf4C/0Dl4vHLvcoWHbS9hN5pH5Ijv1hKbM68drmKOSr+q5+JO8c0d
         SOA90IXAnfcsSJB0eZBevEbO2ikcVDoaX4e8zvioy2h+eoGxwr7xAOppdYR4qiQX8a6t
         EyQO6fFouDn7NfC1IUeMC7vOxPJ6KlOGvdVrBgR1Jon379QGuoyRxCW9jh3aQGuN+BAy
         O4SKjYhaQWQ3IghdvCRGFmPEn5SnGoaOh2ssjNAfRk4cVnbKAtaNDiiVrGetGrb/nBYO
         bi75KojELmOBCosRBK1U4NyWr///6kjeoJ5EqMBiSwInYJLi9TC185zOYirGIsXTfsiu
         E1zA==
X-Gm-Message-State: AOAM532KWvaHYdLocQDQWgT3GeGRo9FkXzZi9OuwLtl4DyjCrkEn62dT
        fX5OV65mgnu6MVdHf2bIPZ5Jew==
X-Google-Smtp-Source: ABdhPJyHe/AYTAaQMX0dhqMLiB7TZGch3nWoL02eGOMJarRzghEulU1cpKqtK1skp5YytV0t1X+2zg==
X-Received: by 2002:a05:620a:448c:: with SMTP id x12mr15371694qkp.39.1629119505086;
        Mon, 16 Aug 2021 06:11:45 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id n124sm6266215qkf.119.2021.08.16.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:11:44 -0700 (PDT)
Date:   Mon, 16 Aug 2021 09:11:43 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
Message-ID: <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
 <20210813180056.ctzivmakj4bj5apa@nitro.local>
 <xmqq35rbtx84.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35rbtx84.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 14, 2021 at 04:36:43PM -0700, Junio C Hamano wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
> > I know that this is confusing terminology, but "tls" stands for "StartTLS",
> > which works on port 587, and "ssl" starts for "smtps" on port 465.
> 
> This reminds me of an earlier discussion we had that somehow petered
> out before it resuted in usable improvement,
> 
>   https://lore.kernel.org/git/xmqqtuo9kgo0.fsf@gitster.g/
> 
> I do not think it is feasible to immediately rename the two choices
> to SSL/TLS vs StartTLS without transition period, but the first
> patch in the three-patch series there to update the documentation
> alone may have helped this case.
> 
> We may also want to error out when seeing an unknown option other
> than 'ssl' and 'tls', as the necessary first step to make it
> possible to later safely accept StartTLS as a synonym for 'tls' and
> 'ssl/tls' as a synonym for 'ssl'.

Is it easier to just add less ambiguous aliases, eventually phasing out old
terminology?

tls -> starttls
ssl -> smtps

This way we don't have to change anything, and "smtps" is a valid way to refer
to smtp over ssl (e.g. see /etc/services for 465/tcp).

-K
