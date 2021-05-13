Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15599C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89566142C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 17:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEMRSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 13:18:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54647 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbhEMRSU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 13:18:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D382929EB;
        Thu, 13 May 2021 13:17:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 May 2021 13:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm3; bh=welksklg73XuLbet19Lv7tB2HlXuigzfObm/kpvi
        U1g=; b=KNIxwgQ3JKhzU8hrrw9TVMo4AxiGDOnTexPjti8T4ssJvK1MW2X+ockU
        9/w+iktJiez/9gFcIq83K6uZ3saystj8voviXRN4C9stOiKH9wXzvr/KBU0LSC/8
        TWn1NA4ht/EhGXhNNji5qygAXeuXWw/UaHCK8UVeER09rvSqH3Per3YIhwA4zAYC
        xn+dyWmbaN3xbTL+0raEqd96WBz0FCs/pDSy0h5rCU4DdpJi6WjT52dle0trj7jL
        dlEEhGfjtJL54Kzu+M78wz+XSp+kGh4cseWkywRkxtWSyYLoH1i2N9n0XPMaIQpY
        UJIGx6t13F+Z32yifgZY590FOaS9rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=welksklg73XuLbet19Lv7tB2HlXuigzfObm/kpviU
        1g=; b=u7Qva1Stc1Gk5rTFlI6kkImFffSylnl7Dd4mS5wXL8qknp3rsK85FTuLn
        ndPQoP2qlpy3/hYJFBceBLURhHqlNc+ULRwUiqhK53i4TqaeYSgcQCN4QOUHZSUH
        qNSUpMJXFmHHYBgfvJotNuQ+Xmh8/Mb+8Ubv0wtQEYchTmnu9QP0vzYqqYpRLDZB
        m6goD/z0R2RCl1B4xf7evW+a7P4rvrbxaDkTf/SFZhYzIiTcS5NCv9ObQGYDN2YS
        z9MoxAG1pPioXCIddpjekxMQwcsq4Wp5wnPKbVF/jI/PEsTY2H6YT3MQVfxbVzt+
        Hx3xHrQBM40hlmNqa+vJ+pzGfcnog==
X-ME-Sender: <xms:FF-dYGyA0fZERq2jqHmrt66a4xf3XcgGCj0_dJ-gNzHb41o613aBSg>
    <xme:FF-dYCTSGqRdWalOTlrAwAWN0cJmjCyknKlCVIujmmnnBG52tZFdNEYo_gDy1kP-O
    3c8KoLGbUN3kYsN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjggfse
    htkeertddtreejnecuhfhrohhmpeffrghvvgcujfhushgvsgihuceougifhheslhhinhhu
    gihprhhoghhrrghmmhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepheegudefteekvd
    egudeiheeiuefhkeeludfhffetvdekuefhhfetveelteegtefhnecukfhppedujeegrdeh
    vddrudehrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:FF-dYIUpyOAYyIrWTZ4p8q89Pynp6RiaWE_KRzPzU5U7ilQqIBCGlQ>
    <xmx:FF-dYMiXBmzIQ9T1do_Wmbu7T3rqzy68MoMkfbAaWKIFHO65-qpnfg>
    <xmx:FF-dYIAU0IMEK19WAOTkfn7RYxIg95srSRK7rMZN-18hjFaY_QbfYQ>
    <xmx:FV-dYH7-7PWFCip0L3M1nnKH5SMFUwe561ioFgMJA_4UYrfABr2asQ>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 13:17:08 -0400 (EDT)
Date:   Thu, 13 May 2021 10:17:06 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        felipe.contreras@gmail.com, stefanmoch@mail.de,
        philipoak@iee.email, bagasdotme@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
Message-ID: <20210513171706.GD11882@localhost>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
 <xmqqy2cjcwn4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2cjcwn4.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.05.2021 09:20, Junio C Hamano wrote:
>I've read this version over, and did not find much that is
>objectionable, but as some others said on the previous round, there
>may be overlaps and repetitions we'd rather get rid of.  We should
>be able to cover discussions around patches in the SubmittingPatches
>document without introducing a new document, so all that remains is
>what to do with non-patch discussions.  I suspect that it might even
>be sufficient to (1) taylor descriptions introduced in this patch
>for discussions around patches and reviews, and add it as a new
>section to SubmittingPatches and (2) mention that the same principle
>applies to non-patch communication in the same section as a sidenote
>but obviously others may disagree.

I realized last night that there is an important distinction between
using email to work *with* Git and using email to work *on* Git. The Git
ML has its own etiquette and rules and MUA tweaks that may not apply to
other projects that use Git and a mailing list. The files
MyFirstContribution.txt and SubmittingPatches are clearly focused on
using email to work *on* Git. The file MyFirstObjectWalk.txt is also
about working *on* Git, although unrelated to email and the mailing
list. Maybe it's time we make the *on*/*with* distinction more obvious
by creating a Documentation/WorkingOnGit subdir? Just throwing that out
there.

It sounds to me like adding a MailingListEtiquette.txt file isn't the
favored approach. I can tailor the information in here to fit into new
sections of SubmittingPatches.

>Ævar, you also have some updates to SubmittingPatches in flight.
>
>Can I ask you to work with Dave to figure out how well this update
>fits in the entire picture as a stakeholder to the document (i.e.
>not as "the guilty party who is involved in conflicts", but as
>"somebody who has been long enough to be qualified to guide the
>evolution of the document, and obviously is interested in improving
>the document")?

I saw Ævar's patches last night and had the same thought. Since it looks
like this is probably all going into SubmittingPatches, I'll connect
with Ævar and see if we can come up with a patch series for (1) Ævar's
re-org and pruning (2) my Mutt MUA settings and (3) etiquette related
information for discussions around patches and reviews with a (4) side
note for any general etiquette for non-patch communication.

Thoughts?

>Thanks.

No, thank you. And thank you to Felipe and Bagas for such thorough
reviews.

