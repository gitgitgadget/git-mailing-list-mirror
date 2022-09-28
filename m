Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7CEC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiI1USM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiI1USL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 16:18:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB586D9DA
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:18:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u24so4044523edb.11
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=TJDMypBJV4cibsbzMZQSrlYTgZctknPNJxSvkHzH09I=;
        b=PqgfEOV47OGnaT1O8s6G70C34O+ihmKyODfzSM2lBGLS8btyy/yOIwcknTTG5RcVE4
         bhllJoUL7K0Ej+03yp2aHDSBRUqGVZZq5Ad8TmhearUawy6nCKuR0fmCs7pUvnSgSbXt
         nIqONhU90hDNGrmwkoOL7gS1AlwbSz5ChjP6hRDnw5CIsqctzrSHMxdKImUB027BV4nf
         XHWH/0F+loSUtfG0vrb5eynBsxfD3htPROd3Ke0tZ5BDSnRs6wip/GgxzfE802sI0U8R
         7l4w0/dPMXfAfsipBavKvsxI1pObQfQV+IW2M4T9IMH+tiD6IZFp6Bfia0ccjajTEv3c
         Waxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=TJDMypBJV4cibsbzMZQSrlYTgZctknPNJxSvkHzH09I=;
        b=5/X8E8tjNhDNCpPvsSgT8yLY1l4ApKq0hWAC3z1LtlVeky8ZU601jZlxP/EtuGpS06
         xOcUCejA73CDh16rCdW2lDOz6ks73eA62IlNVaLHgfXkpjSHcXz4LdlnLtAl+tZdeuHh
         CmBQFTG+ee1zVT0pclrVnE8UA1/4znVa81/jA4a/DXcq4SRGu4NXYSW2uDTzBv6ksG4g
         8rk+Mzh1XS4qJ8UffEzXoq6hQ+9wepCRM82jLW2R0XHTtkresIhHy5LnrS5+A8BLSy40
         9eiNJeWTbqjj4UzXNwoceVzIAOAtrwIZLhNPUWLH54bmBNQLkVr8uvzERtQEn3fH7X8h
         sfKw==
X-Gm-Message-State: ACrzQf2MP7q+MfCVBR9Fa0Fwqbh9y8Be3bVFmrUjaZt2GidRXTjWQ9Up
        mDO2tcVG7pITT5FmS29MlmVOZ7aC2IUbcQ==
X-Google-Smtp-Source: AMsMyM5VKGyrXu4gaYZsRrv3T70r8YgIWMBjsVZuwnnxpRL4J5Wt/Wf7bOZxvZF0GcOrXSIE77aaUQ==
X-Received: by 2002:a05:6402:3988:b0:44e:6f08:ddfb with SMTP id fk8-20020a056402398800b0044e6f08ddfbmr34558179edb.89.1664396289045;
        Wed, 28 Sep 2022 13:18:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709063e9400b0078175601630sm2871830ejj.79.2022.09.28.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:18:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oddVP-00164E-1Z;
        Wed, 28 Sep 2022 22:18:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 00/35] doc/UX: make txt & -h output more consistent
Date:   Wed, 28 Sep 2022 22:10:33 +0200
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <xmqqk05ntlye.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqk05ntlye.fsf@gitster.g>
Message-ID: <220928.864jwrw8w0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Victoria: I decided not to go for your suggestion of trimming this
>> series down in [1]. Reasons:
>>
>>  * It would take me time I don't have to spend on this, as some of it
>>    isn't easy to cleanly re-arrange. E.g. the later "make consistent"
>>    commits rely on earlier whitespace/basic syntax fixes.
>
> A devil's advocate question.  If even the original author feels it
> does not deserve his or her time to clean up the series, how does it
> possibly deserve reviewers' time to review such a series?

So, I'm clearly doing a bad job of explaining this (and I'm not saying
I'm not also lazy!), but with the latter part of that I meant that I
took pains to optimize this for overall reviewer time.

I.e. at the start of the series (made up example, but it'll suffice) we
might have stuff like this:

	*.txt usage: (foo|bar) <file>
	-h usage:    (foo | bar ) <dir>

The start of this series fixes a bunch of misc issues like whitespace
issues, so we can e.g. turn that into:

	*.txt usage: (foo | bar) <file>
	-h usage:    (foo | bar) <dir>

At *that* point I can include the s/dir/file/ change on one side in a
"doc txt & -h consistency" commit, and end up with, say:

	*.txt usage: (foo | bar) <file>
	-h usage:    (foo | bar) <file>

So, I can say for the "doc txt & -h consistency" that we had the "(foo |
bar) <file>" version in-tree already, but that's only the case if you'll
buy the earlier whitespace-only change.

I think that's easier to reason about & review than a bunch of "here I'm
changing the label, and some whitespace issues, and blah blah".

I.e. the reviewer only has to pay attention to the first change being a
whitespace-only change, and can then be assured that post-whitespace
change we're just changing one side to be consistent with the other.

We then test that consistency at the end of the series.

>>  * A major advantage of reviewing this in one go is that the 34-35/35
>>    tests at the end are asserting everything that came before
>>    it.
>
> Yes, but it does not assert anything about the other patches not
> doing unrelated things while at it.  So tests cannot be blindly
> trusted (in other words you have to be also trustworthy, if the
> reviewers are expected to swallow this huge series uninspected).
>
> I'll give it a read-over when I find time.  Thanks for working on
> it.

Right, I didn't mean to say that these could be blindly trusted, just
that the series was working towards splitting up little fixes like
whatespace fixes, and at *that point* the reader should be assured that
one side of the commits with "doc txt & -h consistency" in the subject
is in-tree already.

Of course that at the minimum needs a review for *which side* we should
pick :)
