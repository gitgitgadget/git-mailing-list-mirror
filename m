Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC4C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C26161130
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGSjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFGSjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:39:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD8C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 11:37:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c13so13498325oib.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Gvdh8iN5uIw5t943IiBCqSOhAUy2LkyGJOjvHR3VrdU=;
        b=bsZzniMEH6Vgo6bGBtsd4FbzJqek+KwSYgCKDgndDd2eG4esU7DC7OqvrGTnrJrSGO
         HKPRbYOuccUThTQaiS5WkJh8TrurjqtefcSuyzHKJKDibY5t9wQYVCGdfL9EwJjYm8gR
         52EyeIdnOvUxdBl7A7jrwZ9dpezc1Y8PPBSQSdjgL2sNsGB/aQQlBTC+u2bdc2rlWxN+
         mK8D2rcZdaf71eOkKlytA/mZEDblOk6cTQTHa/wj+3l3MaTsaw3DKkiQA9krbQZVx2d0
         MptXLIUaZYk3k/W/bnSZIiRliqtDgTFZzyfQJuDbOKRlLi5MZ5MrtmK4fUeM/ernZXAP
         CB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Gvdh8iN5uIw5t943IiBCqSOhAUy2LkyGJOjvHR3VrdU=;
        b=lhBvFoE8z/OHlz0uurkc96kdhon+WrKPORFvaGsz0PMXo9MoVSC0E3upWCr89Sk3dL
         pGiIvr/DCwmho/YJKfaTDXjKSAa26rgi6P3HvitV58OaU7lLxg1S9OK86F3ApjEPOObz
         JcqGhH6CsOd8PAg53Bqf6jmEwSfmtF7s/4tqt0KfM6MQ54RAAjcC5aal3ONFkQMs6kEq
         RMU42YEcLChb0di90wTXVs92QdMUf9oKhut2+nOdVZNixm5qBSRXZbpcv2zezBeYFdQC
         oR/JbbxG9J9ewwiSmUhq+B+gE33X3ruG5ygAUbyOLEK83FjUD6BZlX+CMA2eoVomw82Q
         4NPA==
X-Gm-Message-State: AOAM530ga0lv+9UfQTRmneNU+iycAYLK8Muo/tLW1Z/oOF00UVXeeS6A
        cBfhOrID5RMOWP97gtTgbu4=
X-Google-Smtp-Source: ABdhPJyc560yfRtl4wNpaTns7OX5J8TDHLwe+2ou4yZ9QbSdNy2TlwDZv8106X7ZiAz2eWIPCW08bQ==
X-Received: by 2002:aca:b107:: with SMTP id a7mr321777oif.170.1623091050675;
        Mon, 07 Jun 2021 11:37:30 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x9sm2515821oto.79.2021.06.07.11.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:37:30 -0700 (PDT)
Date:   Mon, 07 Jun 2021 13:37:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60be6768d74bc_3bc33208cf@natae.notmuch>
In-Reply-To: <87h7i94ola.fsf@evledraar.gmail.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <60be3b2d6e1e6_39c0a20883@natae.notmuch>
 <87h7i94ola.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jun 07 2021, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> >> and I think the commit messages should discuss whether we break this=

> >> promise of having consistent output between "status" and "branch -v"=

> >> now.
> >
> > But we don't with "branch -vv".
> =

> I think the wording there needs to be changed in any case, I'm not sure=

> what it's supposed to mean.
> =

> I think the "show the relationship between" there is referring to the
> ahead/behind relationship, or maybe it's just speaking more generally
> about the short (branch -v[-v]) v.s. long (git status) blurb we show
> about the branch status overall.

I was going to do this, but given than most of my proposals to update the=

documentation are rejected (or similar), I think I'll just do the
minimal changes for now.

-- =

Felipe Contreras=
