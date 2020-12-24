Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2745C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 05:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737B9227BF
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 05:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgLXFT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 00:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLXFT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 00:19:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB15C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 21:19:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l200so1401523oig.9
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 21:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+q1FadWX5jpwWxKVF4dWBLJe1H4JFu1FDHioZmOUJc4=;
        b=kMUWhaIzh3ueLPUq2RhOq+nHeyZFoc/SY+KbAtmpt0BcKDyqCBJuI8O/8IsMJp17Zg
         Hva28SZiqwAvqL7p+4hwF/c/uLdHx9z6kZZUYjukc0d/Q/mAa0u02vQNxrtmUgfIZKSu
         UyO1KurLyfFTTmvcyjP3SMAmPWmUTiXu+nyd5QHOXeXQz8CD758arxzuwR/KR6vYdk5r
         W6ir7PlZESNQE1fDxXnYohXkoSOMKNE8fO0dw+CdE5H5+5EAY7PSeHTsLSbni9qCDheH
         qAnghRXHY7+cnyGd+InY2yZC1joqFYTdqnaXNrdN8kSh9iO7cDiuVL4BRK+7BjTvRjei
         WiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+q1FadWX5jpwWxKVF4dWBLJe1H4JFu1FDHioZmOUJc4=;
        b=r1KK8lYVeRrvdienN0ZhYMtzSQp9VhFxjLkOI5eVLQRjyItzcXkiXcgdqTalsRRjsz
         qe4sg1DzX+LFub+9asm/mLaL4HzxdErkm9718qfm0ZT/Hkh7ISPAjTkD/Tlwqa2szNo6
         1R4NEPpPAyVOL5UOukAmWVW+EnDF2+vW1voscFszdqQOU+WNIWnWHcN2zAv+XhjPQuj9
         KvHoaxGMmvlkd0YMln/mXsAS7Dmpu3cuvYCOp0UnYEvH93afLv16XzS8wgqdmAzBu9H+
         Vn6hbr7ddU3m6ODFGmiaHa46IzU5DWgidE3Sfw2ZImBilr5t6vcL9Vxv/MfwKPNCT15c
         ZkYQ==
X-Gm-Message-State: AOAM533F7PTbn9SLR5i74mVqTea0TqbslkkfBDUtprKmhlBy5sffzi0X
        HP/R5ozkv5roxKHLart71Mg=
X-Google-Smtp-Source: ABdhPJzZePBAvcTa6rYBuQdlQlA+NNTOfYGN4mJdasLdrMIiKtRVASVOlpgoOVBevotHdoGRC6yeRw==
X-Received: by 2002:aca:b657:: with SMTP id g84mr2021780oif.86.1608787155254;
        Wed, 23 Dec 2020 21:19:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h11sm6791994ooj.36.2020.12.23.21.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 21:19:14 -0800 (PST)
Date:   Wed, 23 Dec 2020 23:19:12 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe424d0528a2_7855a208d3@natae.notmuch>
In-Reply-To: <87r1ngufmf.fsf@evledraar.gmail.com>
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
Subject: Re: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Dec 23 2020, Felipe Contreras wrote:
> =

> > When I express my dissenting opinion I'm not saying nobody should wri=
te
> > a patch on top of mine. Of course they can. Anybody can take my code =
and
> > do whatever they want with it (as long as they don't violate the lice=
nse
> > of the project).
> >
> > What they cannot do is add my Signed-off-by line to code I don't agre=
e
> > with.
> =

> I don't think that's what Signed-off-by means, per SubmittingPatches:
> =

>     To improve tracking of who did what, we ask you to certify that you=

>     wrote the patch or have the right to pass it on under the same
>     license as ours, by "signing off" your patch[...under the DCO:
>     https://developercertificate.org/]

Yes, but the DCO requires (d):

  d. I understand and agree that this project and the contribution are
     public and that a record of the contribution (including all personal=

     information I submit with it, including my sign-off) is maintained
     indefinitely and may be redistributed consistent with this project o=
r
     the open source license(s) involved.

We can narrow down the part I'm talking about:

  d. I *agree* that a record of the contribution is maintained
     indefinitely.

I don't agree with that.

Moreover, the relevant definition of "sign off" in English in my opinion
is [1]:

  to approve or acknowledge something by or as if by a signature (sign
  off on a memo)

If I didn't put my "signature" in a commit, then it's not signed off by
me.

> So I find this rather unlikely, but let's say I author a patch for
> git.git and send it to this ML with a Signed-off-by.
> =

> If someone else then takes that patch and changes it in a way that I
> vehemently disagree with and gets Junio to accept it into git.git in it=
s
> altered form, that altered patch should still carry my Signed-off-by, a=
s
> well as that of whoever altered it.

I don't think so.

Even if you disregard clause (d) of the DCO, in English you didn't "sign
off" on that particular version of the patch.

> "No Discrimination Against Fields of Endeavor" is an integral part of
> free software & open source. In our case it means that when you
> contribute code under our COPYING terms someone else might use in a way=

> you don't approve of.

Yes, you just have to make the record straight; do your changes in a
separate commit without my "sign off".

> E.g. I'm sure that arms contractors, totalitarian regimes etc. or other=

> entities some might disapprove of are using git in some way.

Yes, and you can modify my patch and keep my s-o-b, I'm not going to sue
you.

I just don't think that's right.

> That non-restriction on fields of endeavor also extends to individual
> patches licensed under a free software license & the necessity to
> maintain a paper trail about who their authors are and if they certifie=
d
> them under the DCO.

Sure, so if you need to keep a paper trail about the copyright of the
code, why would you risk that simply because the author didn't agree on
the further changes.

Just do them on a separate commit. Problem solved.

> 1. As an aside, I haven't needed involvement from others to later
>    realize that an integrated patch of mine with my SOB maybe wasn't
>    such a good idea after all :)

Oh, me neither. But in this particular case I'm sure X is wrong, so I'm
stating unequivocally that I think X is wrong.

Plus, in my experience I usually think X is the case, and it's not only
after I roll up my sleeves and get my hands dirty that I realize what's
actually the case.

Changing your mind after you get your hands dirty is usually a good
thing. Which is another reason why I like Linus Torvalds' phrase: "talk
is cheap, show me the code".

Cheers.

[1] https://www.merriam-webster.com/dictionary/sign%20off

-- =

Felipe Contreras=
