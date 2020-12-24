Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA7DC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171662246B
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgLXPib (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLXPia (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 10:38:30 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E5BC061575
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:37:50 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d20so2093150otl.3
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=M86iHojF3eXV6NlI3XJSUTRi9y1+Bvn+2GHFboUIe8M=;
        b=ZWm6lnonmx5IE1Sn97CHbmZ77A3AeDN8GJhxfTM80LMDJg7N5bUTuKANPhyPH/5v43
         EjBA7lRfreRZfxsHnO2+9Y9dgjCk5pbNPrUtQoj9JMLeVkcTmTl53Zqjws2whlcBxuf2
         dteqcwZDzYZuKkjY3jZ1QbQKXzo+1IJHc7V5YlLBXP7DHYtnfOJHjuEEhm04sbPt6oJP
         HiJQDLonQeuFVRuSJ3d6pS4NqhNtq+w1b2ZLuC5oKzFXR2HmuB8lrGQQvddPcCTMqjPF
         ZWQCBNepfrMbECYHdViKNeOsieOPCTfHB6HFxkPH+3/teGHpsHVmxaFayVMalpuLlJA7
         9maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=M86iHojF3eXV6NlI3XJSUTRi9y1+Bvn+2GHFboUIe8M=;
        b=oMSdPxCP9W/22zgIsLw5elGuwyORr+6x5Ej2X3JqeKaMcKXtw+b3ZXkqVsuPnogXuu
         7S7kCOMRNxEDR2eJlUWrZkYfcsDWafCmshbMPILDNWJwwbl4lht2y+nfL1Ek4SlnbOCN
         JVKxZO2kean+85b+z/cnmM5idq8MExlCJyNoHDP3C6JtJUnTl7JD2oAOz2hkn0Jc8RCN
         TYxn5SU/pXSbbfDw4JGt9A79z2CIP8/AMXIcWD8iyDu90ZHOT4tAY6zxqujFg2OxAYk8
         i0WPMs4nd4I71pSzv6iRT3GGSTPg2wXJiyn2DNKem1jMg3FTovP12urtq3tUGaT77h4I
         cBcw==
X-Gm-Message-State: AOAM531mxHA0OBVROVcuJ9xOqG7o5oEiHrMsG9qV3ikGzx3jyZ1FuRwy
        F4LtihGGtDYvhLNvLABO+2Y=
X-Google-Smtp-Source: ABdhPJzZspog52JibXcmXW3fkC208q6fu2yQSo1VLZiGI45j9xjYiX3iFLuGO65AriOPjuPbgwDTww==
X-Received: by 2002:a05:6830:10d8:: with SMTP id z24mr23514751oto.359.1608824269772;
        Thu, 24 Dec 2020 07:37:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 31sm6850632otd.24.2020.12.24.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 07:37:49 -0800 (PST)
Date:   Thu, 24 Dec 2020 09:37:47 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Pratyush Yadav' <me@yadavpratyush.com>,
        'David Aguilar' <davvid@gmail.com>,
        'Seth House' <seth@eseth.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        'Christian Couder' <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe4b5cbacf0d_19c92087f@natae.notmuch>
In-Reply-To: <00f401d6da06$be415560$3ac40020$@nexbridge.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
 <5fe2d89c212e8_18dc12083e@natae.notmuch>
 <xmqqzh248sy0.fsf@gitster.c.googlers.com>
 <5fe36790793ae_2354120839@natae.notmuch>
 <87r1ngufmf.fsf@evledraar.gmail.com>
 <5fe424d0528a2_7855a208d3@natae.notmuch>
 <00f401d6da06$be415560$3ac40020$@nexbridge.com>
Subject: RE: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On December 24, 2020 12:19 AM, Felipe Contreras wrote:
> > We can narrow down the part I'm talking about:
> > 
> >   d. I *agree* that a record of the contribution is maintained
> >      indefinitely.
> > 
> > I don't agree with that.
> 
> Clause d is important to maintain compatibility with GRPD[1] rules
> about maintaining identifying information. This clause is more than
> about the contribution. It is about consent to maintain your name and
> email on record indefinitely, as part of the contribution, in the git
> repository, without the ability to rescind the permission at some
> point in the future.

I didn't mean I don't agree that clause (d) should be there.

I mean if in a particular contribution I don't agree that a record of
the contribution is maintained indefinitely with my name, then clause
(d) is not met. And it is not actually my true contribution, but a
bastardization of it made by somebody else.

You shouldn't assign to my name changes I don't agree with in
perpetuity.

-- 
Felipe Contreras
