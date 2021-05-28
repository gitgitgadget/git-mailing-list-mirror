Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63103C4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319756135C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhE1B2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 21:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhE1B2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 21:28:30 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207EC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:26:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so2700590oic.13
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=k6AR0jJFNkmTmviZbY+4AqwoqQ8kDS4lAjPQInI5Orw=;
        b=uTvL5VC8/1o/2/U1E1JCZbso6faSuu39JkwB0l3/40oZwYY4qsQqYdkrBgIsq7bx8u
         CBvecf0hKaVS/B7VnJZksZDK/XdKH697ceoNqUzpZMP5KFy456427yaKFNnlhyHgiq/J
         0Z81ejvy9SwjlEvAoKHKyc+TCimyCK0+CIkeZtv0IZqpPX9a48C9B8YVEvQodG9nH1dZ
         gavaDcC92WBhsmdyd0x4j4NaGPDe1mHjj8zlViQA7WENLRP9/UcrHO8R6wrdHWS3trG2
         o7+nf7NrCRsQUsEmybWCmzOfnvtbDRa3Oh9rvcoYS0Xa4ztM8QNu0oLpb5Ulb7NsZ+Nx
         CRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=k6AR0jJFNkmTmviZbY+4AqwoqQ8kDS4lAjPQInI5Orw=;
        b=Sv6Oq+0HI7nJX7yI4rWEfREzUDRop7oSw9duGbI3NshrMLBD5PMCWtXSfeoWt8kJD7
         5ozijo6yMZtsaWj+Je997INQV4eDTvFcoW5sWha296dhwbk4jEOjsL9YOmUA1mxV9bZ2
         c24NEwf0rfEwc1WZx6OMBREFIAumZTsdPgTLtfEkgLvtCRjg2XOGqPv8Xu8FAHYVkMMA
         yyvOKnUya1zFzXtdBAkmGsswp4QuiVHFdNtOKzwY6wwBgB0fL5wVTgqoLr6rcGlN14so
         1HcL/pShf09QOSBC/Y3SU366+eQDwOkcVoWwo9zYQK41L9ujCN3q75qv2ktxJ3JU2OS+
         mlcw==
X-Gm-Message-State: AOAM533dYdbbCKE/lNPneBXNKa60NCp49Y9nHe341mSm8RBasEkvnHWM
        6zxKJcPL7lk7nuGfsLgxAqY=
X-Google-Smtp-Source: ABdhPJxuzlrrZkD+8C5lAETQa8AdGN2F9G0M8Im+HuV4OhtMT36lyt7loskkj5zdPhmGiVfPMSV5qA==
X-Received: by 2002:a05:6808:b08:: with SMTP id s8mr7082112oij.162.1622165215320;
        Thu, 27 May 2021 18:26:55 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z9sm822131oog.25.2021.05.27.18.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 18:26:54 -0700 (PDT)
Date:   Thu, 27 May 2021 20:26:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
Cc:     Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60b046dd3f5f2_40592208df@natae.notmuch>
In-Reply-To: <87im33ltqr.fsf@evledraar.gmail.com>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <YK6XvmrtrdkJvsnI@nand.local>
 <YK6o/j7P0JIGW0Q0@alpha>
 <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
 <87im33ltqr.fsf@evledraar.gmail.com>
Subject: Re: Should we do something with #git-devel on Freenode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I don't see why we'd advertise #git@liberachat and not #git@freenode in=

> order to achieve that goal, the latter doesn't seem to be a graveyard
> and is probably still more active. I don't see why we'd need to pick
> between the two, any more than we'd pick between advertising
> #git@liberachat and the git-users mailing list. Both currently seem lik=
e
> useful venues for git users to go to get help.

Agreed.

The primary purpose of an IRC channel should be to help users, and if
right now the person that could help a user is on freenode, so be it.

If the people with some political alignment want to emphasize
LiberaChat, that's fine, but keep mentioning freenode.

-- =

Felipe Contreras=
