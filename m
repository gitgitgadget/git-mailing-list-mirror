Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52927C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD48613CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEEAJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEAJR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 20:09:17 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE9C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 17:08:22 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t8so646762oij.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xptVCUebyZwR1CR2lUGcxhnXLNbkZqhsPUE+LW05jtk=;
        b=TA+bI7+i/EV8lRTuc1ATvL51bNd193OhGQ1P9mco4F9fI6N5TIMEMG/c2EHqYmor4m
         2VfhUwmnh0WlVd8j/CsxbAj4YegCjWQj6eADQ+3wIkRkl4vnJ1iuqZAcOt/W9PFdah0Q
         6QeajAyDogyfqNsxHbu9e8owZGCI3bv46So/1cBcJ2bEQmT2+hLQUxL8eRGo1u00DZ6j
         dP/popmfhsrl2kIIlaDoPrATNUtDDHoeMlL56/G6n0sGvhMbD+Qv0UgmiXcnHGWPcAEE
         3Jodl50xQTiRvYhO1vrY68QVug8VYB1eumh8vTiu6DSgdFqwzdHxa2nZ8smMBqeORoTc
         lY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xptVCUebyZwR1CR2lUGcxhnXLNbkZqhsPUE+LW05jtk=;
        b=DaL+uuGX5d3qZXG9Vfv6GJx25xRfQUkAT6UBp9mEOZNyK52Gl6kgEHir2xD5YQMiQ+
         4bayZnlszeFXepH4brVP9r0e79O3Gjm736Nf4rqtHLHD2Kk99qu+U9EQPXz/8PzIh33O
         oSmvaSqw+GtBXehU6sBevErjx7ZyR9zdi/LWVtPzhOeht806lN8zZ/hGZclF6A40V1OS
         ogRFYIx1RPXgyQhhMWtt21VqSxv8nMw9TskOFtOUBXjt/N+58KVfPJdInjmp6kF3o0Ec
         8cbeviJLIiCOFXvMPrGgJonQaPEEagv4CeI/09TUYcgIH599k+82OWOCXe8QiTmqri5v
         63ow==
X-Gm-Message-State: AOAM532QH7tzsmCfJoe+y71nLcUv3HPgzda1vkfTiiA+PVizKdaFyE3Z
        jCI8sqIDYPu1DXfI/uNgRt4=
X-Google-Smtp-Source: ABdhPJxgmyJ04gNYDsyGvTwzjHDA1+Cw1TX1sxpla+VcH//0/WI5r6zXR3jHqDyG7XDfcqfnaS0p/g==
X-Received: by 2002:aca:385:: with SMTP id 127mr4874669oid.143.1620173301670;
        Tue, 04 May 2021 17:08:21 -0700 (PDT)
Received: from localhost ([201.162.245.67])
        by smtp.gmail.com with ESMTPSA id t18sm1092503otq.77.2021.05.04.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 17:08:20 -0700 (PDT)
Date:   Tue, 04 May 2021 19:08:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <6091e1f12ddf9_cc8208b9@natae.notmuch>
In-Reply-To: <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
References: <xmqqfsz4a23x.fsf@gitster.g>
 <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g>
 <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
 <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-04 at 15:09:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
> > My aim here was to discover if we had any reason to think that "local=
"
> > was less universally implemented than other POSIX/C89-plus features w=
e
> > rely on. It seems that it's not.
> =

> "local" is missing in AT&T ksh.

It's not missing, it's supported only in "functions", which have a
different syntax in ksh:

  function f { local x=3D"foo"; echo $x; }; f

-- =

Felipe Contreras=
