Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EFBC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483EC22288
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgLXPRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLXPRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 10:17:35 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFEC061573
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:16:54 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x13so2018251oto.8
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NAPP3oUsy+Wd+jhKz02YDTh1FKXJpIPRnBCzc580jYI=;
        b=OWcO6BQ+PRidHYFJTofy8lWporq2zfUP+f8RlkxD4o2OBz95H2fo5h/pBebszHeju4
         Fvv7IaSoF4ya0w4yS6TMlKDwaljyigQBkcz8uMPB99/qyqks8dE/a13POvvBIRN6ZAse
         8r3azcMdsVuzSjRdo/BctPkHUYgnVpVeuQXNgDw1Dk/AKZtg8jcKeccGDRBSJ+ZB54ZB
         MG08fGZPQ3qDo6Re40Bh2la06vIchi6IZfhqwmvodcH6AV1kJxRPanxXDU7jZ1lL5TpM
         pDY5RI98085yhFMX1/8lheTc7mlpojQOVCrF98msZtzCBuTOMHk6Nq8DfNcSN4Kwrz69
         YcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NAPP3oUsy+Wd+jhKz02YDTh1FKXJpIPRnBCzc580jYI=;
        b=KPsBKPvWRXtA6T8bQGmc2JyxU8wMYAGizSyYfTF/AtXkoTX4Fa8c1MJDTcaOACTD/X
         ZHEq+9uHFsvVMv8hXTHe0p3c9qeHAPPDVpMbZVbxkabdsU+bCP0rODCJ71NkIIeXkkYi
         VW/CQR7IFN8TATdVGLNS+XgzHf87RSsC8oCGU23Khy0TnbX4HCM21qXJg99l1eXOtRJF
         M3LfcqjGjtdMY3+BABf+MHL7M7NzNu4I/ZVWX5rYq8IysXOE12/PcrJiKRRbsRea0w04
         cCsdtycnp7aurbPo/TzTcHaMOfTK6GwxmJGGzSl++fumiAfAug62l99uj4tjmtaGZIYP
         0U5w==
X-Gm-Message-State: AOAM531AUCYqrhpYB82bXUlog0By/C2AxtI9HqBRMSQt0pXWRhAsqDZa
        1NnKsAWUO1P0uDKgkN+u9Xw=
X-Google-Smtp-Source: ABdhPJwgeB70y3uEjK8OoMvB0/NHCcvACnxRsg0QySRBiIwj2juhyK3hwqCr2oSD84SIDaWz+ksiaw==
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr22544707otd.180.1608823014341;
        Thu, 24 Dec 2020 07:16:54 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e10sm6000222otr.73.2020.12.24.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 07:16:53 -0800 (PST)
Date:   Thu, 24 Dec 2020 09:16:52 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Christian Couder' <christian.couder@gmail.com>
Cc:     'git' <git@vger.kernel.org>
Message-ID: <5fe4b0e45fb85_19c9208c8@natae.notmuch>
In-Reply-To: <00ed01d6da03$f8928fc0$e9b7af40$@nexbridge.com>
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
 <CAP8UFD3aHEpHZWxzwz=RQr7DNAmJhLeoiOzubRqk1=7gRyG4_g@mail.gmail.com>
 <xmqqblej4t1a.fsf@gitster.c.googlers.com>
 <xmqq7dp74so8.fsf@gitster.c.googlers.com>
 <00ed01d6da03$f8928fc0$e9b7af40$@nexbridge.com>
Subject: RE: [ANNOUNCE] Git v2.30.0-rc2
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On December 24, 2020 1:36 AM, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Christian Couder <christian.couder@gmail.com> writes:
> > >
> > >> Most of the suggestions below are found by GMail.
> > >>
> > >> On Thu, Dec 24, 2020 at 12:08 AM Junio C Hamano <gitster@pobox.com>
> > wrote:
> > >>>
> > >>> A release candidate Git v2.30.0-rc2 is now available for testing at
> > >>> the usual places.  It is comprised of 19 non-merge commits since
> > >>
> > >> Maybe: s/is comprised of/comprises/
> > >
> > > Funny.
> > >
> > > I do recall somebody else (perhaps Peff but I may be misremembering)
> > > helped me grammofixing the use of verb "comprise" in the sentence when
> > > I started listing the names of commit authors back in v2.3.3 or
> > > v2.4.0 era.  Perhaps I failed to follow the advice given?  I dunno.
> 
> NonStop test cycle in progress on both platforms.
> 
> And "comprises" is considered correct as the present tense according to
> Merriam-Webster. "Is comprised of" is more formal and tends to get edited
> down to "comprises" by current grammar checkers to reduce use of the passive
> form of verbs that pervades technical documents and thesis papers.

Techically it's wrong [1]:

"The whole comprises the parts; thus is comprised of is wrong."

But many people use it, so it's not *that* wrong.

[1] https://www.merriam-webster.com/words-at-play/can-you-use-comprised-of-grammar

-- 
Felipe Contreras
