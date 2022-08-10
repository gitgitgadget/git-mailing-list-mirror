Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF5CC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiHJPBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiHJPBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:01:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF375FE3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:01:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D42F5C0120;
        Wed, 10 Aug 2022 11:01:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 Aug 2022 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=masklinn.net; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1660143697; x=
        1660230097; bh=j2y5vIKi6nuq7nGzFUMuL6rXFpudURwfIst/yoNamF4=; b=W
        lFi0trsIO4yZh8L9AWUlB/8KKlueU//xq3nNcRiXH062m2FKc0lujwE9CWxQ365O
        Rwkout6V5/CJ5vJcnixqASVlnb4yBjG2GpeGYeGNwnn2YPRG+4H+0ADWCIegJzel
        kIP7HxDtLMjSBMhxDYcrLBM0DDkSYOunewrH1zletsKqZHrhGCH9uy76BRbSxdMV
        GduWq3MZgB5aO7Uqy8G7cd+x9oZ2AaOAVIpg0uzdCv8TE7bfaEdU/ZuDmIit1fHk
        eUPgmRVRcdgINd/IK3o4o4Qgn2HaucEu58YDQ5LhHnyZSkJOiLMXHPH03vTwB/bB
        4RymC4r/ziOZp2NBouqXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660143697; x=
        1660230097; bh=j2y5vIKi6nuq7nGzFUMuL6rXFpudURwfIst/yoNamF4=; b=P
        XYjrIriALrUL5cW7m5/HazN7iEkKFNK1peihDo6Pn+GDg2nR5yvaxCQIinBM8v1n
        Fw1ztUJNTjIk/t1E2cfiLHRgAUWbpV47K5oRhGGUlZpb0SWPa6Bzt3B4a/CKw+s+
        HpxHizlPYGvugk8wwHvkDXJ6Pi09rjLAUp+w6DsQpd3H5xZJvnGFQsycq8UK3wa3
        kHJ1iEi5rzWSfFpL/mmFmnhEU6b0CHPDDpX+9eG8BJ9iKU/egqoE3de8m1A7gsw3
        JEyLqSeLBIPXO8UvMkaBF9cncT9uohXMLQzVWisSivU+iGOp0YixKqJnk3TOnOAa
        Ccry3tRZpLz9kwyyKKgag==
X-ME-Sender: <xms:UMjzYrNdNU7-gKrnuXmSI5VBnlCqXGLS4NzGhTQb3igxVZkoSF_2pQ>
    <xme:UMjzYl_T4SFugB7Wnr5xRpquxZt1NS1Vfc17fp41vT2LILi_RE-JT6CpuE8Kd_m3q
    tYlmANxlDInZCzfZs8>
X-ME-Received: <xmr:UMjzYqSxAoZ5ySu-y3C71qNopsa0mmKK34gvPZEkCjQIedurDy2Ctij9Xmr9p7DsNFD8rmKiosfHLOtkndIwWr0qSePZuc3i9GYVTiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesth
    hqmhdthhdtvdenucfhrhhomhepiggrvhhivghrucfoohhrvghluceogigrvhhivghrrdhm
    ohhrvghlsehmrghskhhlihhnnhdrnhgvtheqnecuggftrfgrthhtvghrnheptdelteehhe
    ekuefhtddvjedugfevfedvfeeigeetfeeuteffleeijeeltdekkeehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgigrvhhivghrrdhmohhrvg
    hlsehmrghskhhlihhnnhdrnhgvth
X-ME-Proxy: <xmx:UMjzYvtm0rpzfNYt8R_t1twQJBKVNb1pK_698syckQiF_8cFPCN2ow>
    <xmx:UMjzYjcfw2l88h2s2kP-Oi_Z0LMkxlUIVv3Sq45ABkvqBsWQaEqWkg>
    <xmx:UMjzYr1Quk88Oxioa_JL24qW5ARcZsOyVsWUNZNzenO4IifL_4wMcA>
    <xmx:UcjzYjnfrqNHvNKP-h6c28mTry8XqqvQOJ4qiXmRJKsZir6u3rXt1Q>
Feedback-ID: i3619468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 11:01:36 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: fsck: BAD_FILEMODE diagnostic broken / never triggers
From:   Xavier Morel <xavier.morel@masklinn.net>
In-Reply-To: <YvLttyyaZWm4pitu@coredump.intra.peff.net>
Date:   Wed, 10 Aug 2022 17:01:34 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6688857F-B899-4253-933B-0DFE25155D13@masklinn.net>
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
 <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
 <YvLttyyaZWm4pitu@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> We probably need to provide version of decode_tree_entry() which =
gives
>> the non-canonical mode, and to call it from fsck.

That makes sense.

> Perhaps something like the patch below.

I fear I'm really not able to judge so I'll let you fine folks decide on =
what to do.

> Note that these are treated with a severity of "warning", so fsck =
won't
> give a non-zero exit.

Yeah from what I understand it is classified as a warning already
(just not emitted), like the zero padded filemodes. And that can be
upgraded to error using fsck.msgid=3Derror so shouldn't be an issue.

> I think it still enough for transfer.fsckObjects
> to mark them. I kind of wonder if fixing this at this point might =
create
> more problems than it solves though (e.g., if people have broken modes
> in historical objects that servers may now reject).

Maybe downgrade to info or ignore by default then? It might still be
an issue for people who wilfully upgraded the diagnostic to error
hoping to catch the, but hopefully if they did that they'd rather get
the notice later than never?

That's pretty much the `-Werror` problem (or one of them anyway)=
