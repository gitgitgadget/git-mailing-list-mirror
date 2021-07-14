Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43008C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCEC600D4
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhGNPBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbhGNPBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:01:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB28C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 07:58:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k27so3493629edk.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/2LMp9Ai8EbcWXstIdpb2ze1OU6pnYu4ke86ClZk9Dc=;
        b=fUeRtIWjAx/C2VixQ6BfJojC5femvBvhBRN5sZ+c5sRgXkxnMlG9mi7NBkZI2MlADU
         p4+fBVCSrAQkGDhGx2oBiLk8q1oU8k2K4xniabSaDHvkp9tiTQcIJbg727DtuAzIQXqA
         jSFk6iyPnehWi9HyhZKfBLRG+6b3daDQJ1/ubWr98Ju5PT/kXdDzf0nx28cbSyvNnZHS
         EK8t2qFO7XEgKthuDaElDeEWyXCtFJ8gFYS1AZ/BiQkdygQFRhhobjsVABLQ9p/c3a6w
         218WUqmsRgMFXWbgCGwZst0BznmQ4KPOzjHbOdO2YLajYY50AwaaBRhLQdlBlkzyPWcG
         Ps0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/2LMp9Ai8EbcWXstIdpb2ze1OU6pnYu4ke86ClZk9Dc=;
        b=OfcQfRk1h/ReWjyiCk3l6TGhhK6CtqRirZxYOVM0lypDVWMk505qZX2gZBiikIP4NQ
         6FwKgeoqlul3TTZRLUY/d6vPMf575j7EjwdWh9fGrXh32p6TOU+fAZb5c9foI6K82unA
         MP9ZPzEO0XAtAT3KjL/BaZ+1fAo2n1iy7ixXApHRAlD2I4d8brVab4y/bIimbF5HrVA8
         nyfY//aGKxWOoZX7fisYdkss9AFdCmbUoSVW5lHj/64NDVOKTEmY5/jMPugdB8xcp3kB
         y+aRsxpMkWhN7JMXr8bVdx9DV3Ml39/WTh//6vHFnjrelNL9AY3c+jaYZNgGr7sO7fL1
         9wow==
X-Gm-Message-State: AOAM531/YOOx/0GSTzWUXq8lAAvLZw4W8NDtdSPUBh+fZ5gfnBYBPC2z
        +0y2jW7Yq2jgWQhZn0pNX1w=
X-Google-Smtp-Source: ABdhPJzb7hssewT/GVimqC44p5CAjdQbg01nbyyLINVZ56fCbSCyQrME7p6ut4YmitEY/2XmVblPdw==
X-Received: by 2002:a05:6402:138c:: with SMTP id b12mr14491865edv.268.1626274704274;
        Wed, 14 Jul 2021 07:58:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ba25sm1122876edb.1.2021.07.14.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:58:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Date:   Wed, 14 Jul 2021 16:32:30 +0200
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
Message-ID: <87czrl0wob.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Derrick Stolee wrote:

> On 7/13/2021 9:07 PM, Junio C Hamano wrote:
> [...]
>> * ds/gender-neutral-doc-guidelines (2021-06-16) 2 commits
>>  - SQUASH??? replace neutering tips with that of =C3=86ver
>>  - CodingGuidelines: recommend singular they
>>  (this branch uses ds/gender-neutral-doc.)
>>=20
>>  Attempt to give a guideline for gender neutral documentation.
>>=20
>>  Comments?
>
> I've said before and will repeat here that the draft in your
> SQUASH??? commit looks like a good compromise to me. It can
> replace the other commit in this branch.

Just doing that would leave the commit message that says "change X",
when we're now changing X, Y and Z. I.e.  With the squash it changes
from narrowly focusing on the pronoun question into a start of a general
prose and style guide for our documentation.

Whatever anyone thinks about the proposed end-result I'd say that's a
bit too much work to dump in Junio's lap.

I also had a question for you here >2 weeks ago:
https://lore.kernel.org/git/87o8bog7li.fsf@evledraar.gmail.com/
