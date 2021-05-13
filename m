Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF0C43460
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0B61433
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhEMX1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 19:27:31 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52353 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhEMX1a (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 19:27:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 62DC210AB;
        Thu, 13 May 2021 19:26:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 May 2021 19:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=4uc
        CQWBkUFNGlzlR7jzr+sOAd1ACFZ34jySAF/jDei0=; b=QhoQ2Ol7fVRs2mK1vsN
        ctEsiomPIiYyTCRz4ek9u0nvEmIKew979k80a3hmKhW/cEecerJnIJS3fTBWvspd
        kqZJENQ5c46V6YWti1mehjy9/nzhgVylKcdWUTQFhref7i7FBsap9Vwt/E3MhqKX
        h8UMlW3NPYCFL6otqLxtsjngJihYDcl74wA8W2TAILrFK7mNAEWltkplrpcwnAAV
        1KrKJw+MtZMSCHTfUlV4Ita1ths+f1yjfn4MaimQSUhU3dr7Kd90krfP9c9FnqjT
        S4Lh89Ri21Zm2XPUvmG9ot5Ebo4G0QPX9YaNSKhgEm5B+6GaSwY84o+JFoIblUn5
        hrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4ucCQW
        BkUFNGlzlR7jzr+sOAd1ACFZ34jySAF/jDei0=; b=O8Mx/8Sq/+eS/6AR1KiS0V
        N9yxkonX+nO7/JUqb6AIcSuA12VCyRXWBuI7KYTpPI+/qn1FeP19Bs03eVp7vebs
        9E9kVl/arQd6efwLvGyPGDxjeJzr5BKGlH1lyJFmmuPddZkH32xXIRvwsqm10Bju
        iMdlbg/zhuIUusjS3ms2VkTx5d51NBxp9r2dBPMQlbYERUbFIVR9EseKdUhv/FZA
        vd3Cmnm+P/OyOcs30+AyOcdxniiup1WEorXBCX23Vlg1IPT1w8wsiI0Q8lEhudBk
        ooUjVazjy44WDHOXbYLbkz/sig860YAHLvAc5B/dyayqLQKebAnzysm/HV+uAszg
        ==
X-ME-Sender: <xms:mLWdYLPT5YnxgsBAGNoUAyiruhHU6ekMIeqyivmsi21E9TzPBVBRsQ>
    <xme:mLWdYF8RCN73tuVQfrN9C_P-5hTCCnofvmbNgnmFa3JKlc1th1711sIN_sSmy5FYy
    X6s3jZlGwM29e9a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
    necuggftrfgrthhtvghrnhepgfdtkedvkedtfeevheeifeeggfffheejkeffvdelhffffe
    efleehvdehheeileelnecukfhppedujeegrdehvddrudehrdefjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhroh
    hgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:mLWdYKQX_yUdXaUWyoIDW09ctQ7KvodX5R02-q5kJQqytxEP8ekyng>
    <xmx:mLWdYPvU7aTNuXLf-S6Fj8yY59nqZilNNtG-O8SLsRX3Z_r8kGpr6Q>
    <xmx:mLWdYDf1RCRP4kmvFl-oIYwAFKt6i-NZO988O1teiQon5r0aFfo_rw>
    <xmx:mbWdYDkFksQ7S_UncVzqLmIy3v7B80xU1dkw3BL33UPMurPFAo_GtQ>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 19:26:16 -0400 (EDT)
Date:   Thu, 13 May 2021 16:26:14 -0700
From:   dwh@linuxprogrammer.org
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210513232614.GF11882@localhost>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
 <xmqqo8de9wis.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqo8de9wis.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.05.2021 06:03, Junio C Hamano wrote:
>dwh@linuxprogrammer.org writes:
>
>> I think Git should externalize the calculation of object digests just
>> like it externalizes the calcualtion of object digital signatures.
>
>The hashing algorithms used to generate object names has
>requirements fundamentally different from that of digital
>signatures.  I strongly suspect that that fact would change the
>equation when you rethink what you said above.

I agree with you. Object names are exactly that: names. Names for
resources/data must be persistent, as well as global in scope and
uniqueness, and autonomously assigned. What this means is that once an
object has a name, that name shall never change as long as the object
remains unchanged. The names must be unique in the scope of all objects
(e.g. all copies of a repo) and generated without coordination.

Calculating object names using a digest algorithm meets all of these
requirements. Choosing a strong digest algorithm creates a strong
cryptographic binding between the name and the object contents. Using
self-describing digests allows for a repo to switch digest algorithms at
arbitrary points in the history.

I think that objects named with SHA1 digests should remain named with
the SHA1 digest. I do *not* advocate going back and rewriting history
to change all of the object names to a digest with a different
algorithm. Git is a provenance log and history matters. I recommend
preserving all existing names, even if they were created with known-weak
digest algorithms, and making the change to a new algorithm at a
specific point in time (e.g. at a tag). Using self-describing digest
encoding and externalizing digest calculation future-proofs
repositories and allows for preservation of history while allowing
algorithm agility.

To illustrate my point, I envision that a repos could have a history
like this:

object 2923f6fa36614586ea09b4424b438915cc1b9b67 (naked SHA1)
  |
<many objects named with SHA1>
  |
object 5f167fb6b3e96273b564fff0b041fb94fee4d3de (naked SHA1)
  |
<modify Git to ext. digest calculation and self-desc encoding>
  |
object 98c2e1c0965e60b0f137577ac5dd0a5c96ce224d (naked SHA1)
  |
<many objects named with SHA1>
  |
<a project decides to switch to SHA2-256, maybe marked in a tag>
  |
object IAOdLVxteOxQwKa-xn8yCBUkuPkjAqcuQ2V7fKAlao8o (self-desc.SHA2-256)
  |
<many objects named with self-describing SHA2-256 digests>
  |
<a project decices to switch to SHA3-256, maybe marked in a tag>
  |
object EK832G0PFhBFf-Dfgr205UKpUMqmVXJX9ltLwQo4Awct (self-desc.SHA3-256)
  |
<many objects named with self-descring SHA3-256 digests>
  .
  .
  .

Neither decision to switch to SHA2-256 nor to SHA3-256 would require any
code changes. If we continue down the current SHA-256 road, we will have
to repeat that multi-year effort in the future to switch to SHA3 or
something else. Most importantly, the choice of digest algorithm would
be left up to the maintainers of a given repo and not limited to the
algorithms we have hard coded into Git.

Brian's work on the SHA-256 switch is valuable. We can leverage a lot of
it to switch to externalized digest calculation and self-describing
digests and never have to worry about doing that again.

Cheers!
Dave
