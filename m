Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C57561369
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFQOso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhFQOsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:48:43 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A2C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:46:35 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id h9so6807215oih.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=d7E2dpJysIO9nn1fFW7CTBnoG9UIZ6aKtGz5EBNGY14=;
        b=tR5GP58I5UTYblAr/AUy84KYljobR/06ihUrT6R5n7JwDTuNa3n2iC0A59Z7x37055
         30VQC7IhfT7PFY4Rp+5yz0njG7pyXhlWi5vPFVjz8F+Zq92in0r43G1zdf+AZSwGiZum
         yds464ADKJ1ozfKO2Pp/CzpIpgydAYuICXwlUlP/oQGdMWhsPFvk2crA43NuQVq04+mM
         q9+sRak8Hbs1xtQc7N9rM9mh025M/6IqPp5MP73sK/x8YNJ8FWC+WhlRzEp46f3yCjlA
         OUYFeN7ui2oznDTT2ijag81FXgWPGJ5eCsNMMa5loGNg6YmeFNd++8sJdXjG0u6oveth
         h7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=d7E2dpJysIO9nn1fFW7CTBnoG9UIZ6aKtGz5EBNGY14=;
        b=Udsk6H45tHxd8vdxh/pyvjWt1w/9W8MlaaR9IOtRcTZJ6JF7iBrcl+8gSmUEg2hRmw
         12kBl37fvPahm/8/7vJZScfdYoOjFBNNbDFyOzH/uz8+oa/dGZW0V/iDFG7nr4gGJFS3
         m9VAwBXn7lGKQakZfPP53xXkty/RRv8HqAPL4vVRG+7aHphCEmShc2zV2Dy9bbMwDDhU
         C1HwLLYHzrMQg/zbrnDW9P7p/TkxAn9c4zmtBp2P358vi7NMwtG8Wd6wadiuyIli+23G
         kwK0OSy3lEbt14QpNO1ndHhmBT6rGA1pqSHVPr5Wd7M2iVOrkkCnk2Np566XkS9C/SO2
         rKhw==
X-Gm-Message-State: AOAM531+4aBg/LFlWn1zEsIKOI+VHYjyIH4Bz+afKoBxjbcbzG899eAb
        XA4kgxWUy7T6FaMBCnxeSJY=
X-Google-Smtp-Source: ABdhPJwgQt6A9WRrecqdQm+6QeTqkCwx+sBGHsBWAGUa2DjA5HeKu8pLg5Y7ExpafqD8pUnj6iqrjw==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr10941555oib.63.1623941194898;
        Thu, 17 Jun 2021 07:46:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w11sm1170289oov.19.2021.06.17.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:46:34 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:46:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60cb603f471c2_1259c2084c@natae.notmuch>
In-Reply-To: <xmqqsg1iseza.fsf@gitster.g>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > On Tue, Jun 15 2021, Derrick Stolee via GitGitGadget wrote:

> By the way, I do not mind toning down "if you absolutely need to
> ... resort to" that discourages "singular they".  I just wanted
> writers to consider that the language evolves slowly, and if they
> think "singular they" is the best vehicle to phrase what they want
> to say even after considering that it may sound distracting to
> foreigners,

Once again, it's not just foreigners. Even native speakers who are
professional lingusits see a problem with some usages of singular
"they".

Like mushrooms: not all uses of singular "they" are good.

-- =

Felipe Contreras=
