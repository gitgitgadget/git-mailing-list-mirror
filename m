Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CAE12023D
	for <e@80x24.org>; Tue, 23 May 2017 01:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760598AbdEWBC7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 21:02:59 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33886 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760155AbdEWBC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 21:02:58 -0400
Received: by mail-qk0-f177.google.com with SMTP id k74so120302398qke.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LdhuZC5RkrLJkgozRfSSm82iUrSDW6LaGAQdmzKAg4o=;
        b=bDoRMdiiOxI8l+ej0SwvYIFvquXY4yE1UFNxOuer1d1U7keGT1tH1tpVJ1JXRTBLcX
         fFIGSG02FT1snRRT+JAXeeNentt6XugEwNUMI4Yv/r3lpK/ftUSxgmNnxgd4ohc2OoZm
         HE4AnTuaPAVqmOXU2RJY3F8ePIwBFBTpYxJaZ3xGHaFSOENLTd3V5jtst64lQ9JxWL25
         nuLJ5TX/6PBG1dpICl3QNWV2+CNm6Y+N/3x2WZe1jtwimeEK7dQAuBpCVsdtGCGPAyYm
         fm2xXGPkWqzM+yUWtO+yfcgfDrFqooJVBagkpy8wOrarcU0xMStHTH+zaEZ0I2q9iGgc
         7XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LdhuZC5RkrLJkgozRfSSm82iUrSDW6LaGAQdmzKAg4o=;
        b=CskEBgWAb+vCY3yy7behvqhDWKH5FcGGGHlzhufTC8SaXOP64r6XIzXQigstlbxFh4
         hS0cKPFNV2yCu80mAVLiq7dwM4iBwehSMtlDnzMHucPcP6kYPPJ+6tnfBo/oyqT6WBRB
         hshGtcMqfvTUgaXiu9+fWOW9EfnKCt/zf7Rv/GONGVL1nicGQbsS7IPbtfkITq+lxMvu
         fDRsVZkpuPOMKh+WKxrVW3U2n9obB+jWVGQsV3QqTyabCyHDogNEWwnOmKkJJInG90As
         I0n2X4LuB0sMLUGFcfHRVTW6Wm7B3TpFri9oKHShPfV0+xZxft1Y05x7tPhIHzxsw1CC
         N2/g==
X-Gm-Message-State: AODbwcDlGdMjy5HpawKuSEOHBPuCmyhUYLwTPzEdZVyM+X6ogukQIQjG
        baSsPFt7q5mKWFZWgmRSmmqQejbblg==
X-Received: by 10.55.76.140 with SMTP id z134mr21717799qka.35.1495501377408;
 Mon, 22 May 2017 18:02:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.2.129 with HTTP; Mon, 22 May 2017 18:02:56 -0700 (PDT)
In-Reply-To: <20170516030200.fivl7p5iukfxk2jb@sigill.intra.peff.net>
References: <52ef158a-0719-c71a-b72b-4961cf8f96d5@ramsayjones.plus.com> <20170516030200.fivl7p5iukfxk2jb@sigill.intra.peff.net>
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Tue, 23 May 2017 03:02:56 +0200
X-Google-Sender-Auth: hiJ55hB0dAqQV2FVDVxMmK8GO2U
Message-ID: <CAExDi1QdoxZFLtU5ja_2QpdCKkaOd69uHg6QMapk05MzGdrybw@mail.gmail.com>
Subject: Re: [PATCH] usage: fix a sparse 'redeclared with different type' error
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 5:02 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 16, 2017 at 02:11:40AM +0100, Ramsay Jones wrote:
>
>>
>> If you need to re-roll your 'jk/bug-to-abort' branch, could you please
>> squash this into the relevant patch (commit d8193743e0 "usage.c: add
>> BUG() function", 12-05-2017).
>>
>> [Just FYI, sparse complains thus:
>>   usage.c:212:6: error: symbol 'BUG_fl' redeclared with different type
>>   (originally declared at git-compat-util.h:1076) - different modifiers
>> ]
>
> Hmm. Our model here is the die() function, which gets noreturn and
> format attributes in the declaration, but only noreturn at the
> definition.

It's because a deficiency of sparse: the format attribute is simply ignored
while the NORETURN is treated as a 'modifiers' not much different than
'const' or 'extern'.
But the real problem here with sparse is that while it indeed compare
the declaration with the definition, this is done not by checking compatibility
but by strict equality. In other words, the NORETURN, but also a 'static',
in the declaration should be somehow inherited in a subsequent definition
but sparse doesn't do that yet.

-- Luc Van Oostenryck
