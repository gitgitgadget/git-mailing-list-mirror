Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D49C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB58C206A1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ/GJj2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgE0X6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE0X6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 19:58:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC789C08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:58:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z64so8067016pfb.1
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RAGcb//ENt+aaKF+Lm4COz7mAk3FCuymyvv9LHmL6rU=;
        b=bQ/GJj2Szam1OFd2lsYRMeYz5FYm44RHmLwL7yEAXUhXNYOPLLhL2a+7QSk23gz6tx
         inWT3v+FIHNFQbq4VIKBApbRwA07MhV6jLqTXxeY4ZIDfazP7kOw+2uZD1HDX1rjPdjx
         tV+5mJ74mjCdp/9EEKnkpdha17fBS4xKruRliBOUzQYL/UoHUALHZ8MqccS0IWGSrlZ2
         BnOvEeTce3xT8yTvwqptuwboDbaeLI25fXuDlknsoWCALwYm8LK8p4mrz3rdE/XB9Naw
         eF7U31QWsl9ITMX9iEmbyVWge+1kvi6Cx64tTgZnm57F6CRoQmwrrZUVUCLe6zKmrhcm
         Wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RAGcb//ENt+aaKF+Lm4COz7mAk3FCuymyvv9LHmL6rU=;
        b=Fc9BkgbZSutViDm5NaeFTpM9iMkCs7hnkSrtbEVgjRvjqb+uRgpN/nrW8SP41kFM4g
         mkA72Cmh4MkvcTgCUcMGkYFG6y4ll2PDZE5tY88rtLvISlBRiAbYKB2Xn1ke1fEpVT3R
         ehtYWc5OcXh5HpES+1EsMQTz6a9AhHvU5GF9xXpkTdr0cKx+tmFyG/W49zWyTM4nZTNL
         ad08CXqmozH9XZapjUoDWSGyKszPLDaFab60WLGAJPi47jFKy/fzkmWK2E/hKfFO+Eiv
         tIYd+29HWczYzyi8q5eemS7py6CtdxP5sNtVw5dPf00YgjBLE5M5kYJ6bjpCPWm07XgC
         F8GA==
X-Gm-Message-State: AOAM532R4Fq0Y3IEsAAvPivITU8ZSjbHV1uN32wOwCn5kEvfthEbzYzR
        pToxZXWcLWZiEtlQRaJhSh0=
X-Google-Smtp-Source: ABdhPJzFDnmjBDfpqFOZXshb4/N6BBbo3HvWWhzqxXk1Lv9qjs/eJX0fPgCRSPsp+bSK452gH6Q6Gg==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr274744pgp.146.1590623891134;
        Wed, 27 May 2020 16:58:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 7sm3037150pfc.203.2020.05.27.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:58:10 -0700 (PDT)
Date:   Wed, 27 May 2020 16:58:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: jn/experimental-opts-into-proto-v2, was Re: What's cooking in
 git.git (May 2020, #09; Tue, 26)
Message-ID: <20200527235808.GD56118@google.com>
References: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet>
 <xmqq1rn5kpzi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rn5kpzi.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Tue, 26 May 2020, Junio C Hamano wrote:

>>> * jn/experimental-opts-into-proto-v2 (2020-05-21) 1 commit
>>>   (merged to 'next' on 2020-05-24 at 53cd664dfe)
>>>  + config: let feature.experimental imply protocol.version=2
>>>
>>>  "feature.experimental" configuration variable is to let volunteers
>>>  easily opt into a set of newer features, which use of the v2
>>>  transport protocol is now a part of.
>>>
>>>  Will cook in 'next'.
>>
>> Given that the `feature.experimental` option is supposed to increase
>> testing in the wild, sort of `next` but for users rather than developers
>> who build their own Git, could we maybe integrate this into v2.27.0,
>> still?

Yes, that was my hope when writing it.

> I have been wondering about the same thing, and if it were not using
> its own custom way to read the configuration, it would have been a
> non-brainer to merge it down before the release.

Hm, do you have more detail about this?  git_config_get_bool feels
very standard and non-custom.

Do you mean that you would like it to go in repo-settings.c?

>                                                   But this late in
> the cycle, I'd rather not.

Sure, I can understand.

Would this be something to put on "master" soon after the release?

Dscho, do you think it would be useful for downstreams such as Debian
to apply it?  (For Debian in particular, it's not hard to get "next"
from experimental, so maybe not.)

Thanks,
Jonathan
