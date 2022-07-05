Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A01C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGEVDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEVDt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 17:03:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AE12615
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 14:03:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4EF945C0059;
        Tue,  5 Jul 2022 17:03:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Jul 2022 17:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1657055026; x=
        1657141426; bh=9bMcc7AmPb6A8tVsNdROcRciCpjXnJL+7acPfRoCcKs=; b=L
        d0x2q5OZRsx8ejjPhJALrwjrKh8TFHbgoqT6THJqLRNgi08YceJsZxs+FXtMNSp9
        V849E2bvh+AJy7SHjsgSa8yZssNTmGI79wMj0woej7lAqjf7cm4l0Jp/ei7+fXYc
        +ZHsBXv4Tv7ELTIZ1G40WZ/6uhWeuCpLZaricA0IBaFS44ff/Ws0scvSvl8yDPBL
        C0qNijfifwiPhPfIYOylJQc9578C0hsIzoUss5P+30yUpB/HmRD4zofrq1nJCiJ+
        5MHelNdg9YOBBW1dklD8eiLFG4vDDpNkhE1HIqb1Nn5qHI0P9zh0bUBWCiXUdVZM
        s9Sc+ZaEHMyVqqTemhdJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1657055026; x=1657141426; bh=9
        bMcc7AmPb6A8tVsNdROcRciCpjXnJL+7acPfRoCcKs=; b=KPPoVJvm8RTKCOA0o
        67/4N3KsvHEdwvkrFn4OjwuYtVcG0n2cBnu7a14aC3RQnX+mrCgyKZZ+iT1C3lz+
        X5ZIP+HHa7C8u2iU2PiEWrOwPdJBOewJIlMFauXztm1WWbAifGgeh3yJfipUrsT6
        YTTdhiWGCS3AL/UwizKZDaDdGLfc9q65opNztjJ2M+vmrzEiGZR9m/gbK2kngsFL
        r60EftmYDkwpvikrWJO151SYx33aKa4F6t37NGhOcV/TLirfO37YT8W70ZaNIJ4f
        cv/+WUVk+XKXyPTXSKXPLnl24Y4VPCqrFqx5SNz3lelSjVh+Go7lmCkIdAZF+V4e
        qhPyg==
X-ME-Sender: <xms:MqfEYoijb0L_vCL2dAO1a4dxntga7FOhkhz54VelX3LOJjmyXjygag>
    <xme:MqfEYhDtyo-wtf-pI-mmhryf5GUjhhK8BZsI8hv5lj62HLrnrGODLmuytfYXYYc-e
    vlJjzfUQDJVyO4zQOw>
X-ME-Received: <xmr:MqfEYgGog-wKxNlIKYBMq6YAhmFKODGRztkTl1ypgKTdVmu0EIGOLmg64Q5FNKSEQ7T6RMmcBALTEi1UcoKxh5E_yF-ST2hQQKSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiuddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffokfgjgggtgfesth
    hqmhdtredttdenucfhrhhomhephghilhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgt
    hhgrnhgulhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhephfelteegffetueeifeejfe
    fhledvjeeifffhlefhueevtdffteehveettedtveeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepfihftgesfihftghhrghnughlvghrrdhorh
    hg
X-ME-Proxy: <xmx:MqfEYpTazgBqui-TUoQ0noiYd0K8PeNvlWIiQDv83vbMyiOxLyj-xA>
    <xmx:MqfEYlzNJ0UOTgRK0Oqv_WnSH_n18i8OrS4YSZFIUp5tnP0js_Yekw>
    <xmx:MqfEYn60Kc5lhVDaMTHU9sl5VOlmKvMsHQKC1avIvWu4K396GFdH3A>
    <xmx:MqfEYg-qxDEUgSluKuuspAK6ITBK8j-MSEtZ_3NR55WTt-CeiBN8Hg>
Feedback-ID: ica594744:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 17:03:45 -0400 (EDT)
From:   Will Chandler <wfc@wfchandler.org>
To:     derrickstolee@github.com
Cc:     git@vger.kernel.org, peff@peff.net, ps@pks.im
Subject: Re: commit-graph overflow generation chicken and egg
Date:   Tue, 05 Jul 2022 17:03:44 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <DD88D523-0ECA-4474-9AA5-1D4A431E532A@wfchandler.org>
In-Reply-To: <a154e109-3f4c-c500-3365-d47879abf30d@github.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I think I've reproduced this problem on v2.36.1 and main.

First, remove any existing commit graphs:

  $ rm -rf .git/objects/info/commit-graph*

Generate a commit graph without GDA2:

  $ git -c commitGraph.generationVersion=3D1 commit-graph write

Peff's bad commit graph included bloom filters, so let's update the
commit graph to include them and add GDA2:

  $ git -c commitGraph.generationVersion=3D2 commit-graph write --changed=
-paths

The commit graph is now broken:

  $ git rev-list --all
  fatal: commit-graph requires overflow generation data but has none

The header has a GDA2 section, but no GDO2:

  $ xxd .git/objects/info/commit-graphs/*graph | head
  00000000: 4347 5048 0101 0700 4f49 4446 0000 0000  CGPH....OIDF....
  00000010: 0000 0068 4f49 444c 0000 0000 0000 0468  ...hOIDL.......h
  00000020: 4344 4154 0000 0000 0015 43b4 4744 4132  CDAT......C.GDA2
  00000030: 0000 0000 003b 8270 4544 4745 0000 0000  .....;.pEDGE....
  00000040: 003f c24c 4249 4458 0000 0000 003f c3cc  .?.LBIDX.....?..
  00000050: 4244 4154 0000 0000 0044 03a8 0000 0000  BDAT.....D......
  00000060: 0000 0000 0049 79df 0000 010e 0000 0216  .....Iy.........
  00000070: 0000 031f 0000 042f 0000 0535 0000 0623  ......./...5...#
  00000080: 0000 0730 0000 086d 0000 096d 0000 0a8c  ...0...m...m....
  00000090: 0000 0b8e 0000 0c96 0000 0d9c 0000 0ea2  ................

Viewing the GDA2 block, the overflow bit is set for virtually all of the =
commits:

  $ xxd -s 0x003b8270 .git/objects/info/commit-graphs/*.graph | head
  003b8270: 8000 0000 8000 0001 8000 0002 8000 0003  ................
  003b8280: 8000 0004 8000 0005 8000 0006 8000 0007  ................
  003b8290: 8000 0008 8000 0009 8000 000a 8000 000b  ................
  003b82a0: 8000 000c 8000 000d 8000 000e 8000 000f  ................
  003b82b0: 8000 0010 8000 0011 8000 0012 8000 0013  ................
  003b82c0: 8000 0014 8000 0015 8000 0016 8000 0017  ................
  003b82d0: 8000 0018 8000 0019 8000 001a 8000 001b  ................
  003b82e0: 8000 001c 8000 001d 8000 001e 8000 001f  ................
  003b82f0: 8000 0020 8000 0021 8000 0022 8000 0023  ... ...!..."...#
  003b8300: 8000 0024 8000 0025 8000 0026 8000 0027  ...$...%...&...'

Stepping though, it looks like this is the scenario:

compute_generation_numbers correctly calculates the generation, e.g.:

  {
    graph_pos =3D 0,
    generation =3D 1502820840
  }

Because the existing commit graph did not include generation data,
graph.read_generation_data is 0. When compute_bloom_filters executes, it
will call fill_commit_graph_info which checks that value and falls back
to the older generation calculation if false:

  if (g->read_generation_data) {
  	offset =3D (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uin=
t32_t) * lex_index);

  	if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
  		if (!g->chunk_generation_data_overflow)
  			die(_("commit-graph requires overflow generation data but has none")=
);

  		offset_pos =3D offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
  		graph_data->generation =3D item->date + get_be64(g->chunk_generation_=
data_overflow + 8 * offset_pos);
  	} else
  		graph_data->generation =3D item->date + offset;
  } else
  	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> =
2;

This re-writes the commit data to:

  {
    graph_pos =3D 0,
    generation =3D 17631
  }

The smaller generation value underflows when the commit date is
subtracted from it by write_graph_chunk_generation_data, causing the
overflow flag to be set:

  static int write_graph_chunk_generation_data(struct hashfile *f,
					     void *data)
  {
  	struct write_commit_graph_context *ctx =3D data;
  	int i, num_generation_data_overflows =3D 0;

  	for (i =3D 0; i < ctx->commits.nr; i++) {
  		struct commit *c =3D ctx->commits.list[i];
  		timestamp_t offset;
  		repo_parse_commit(ctx->r, c);
  		offset =3D commit_graph_data_at(c)->generation - c->date;
  		display_progress(ctx->progress, ++ctx->progress_cnt);

  		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
  			offset =3D CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_da=
ta_overflows;
  			num_generation_data_overflows++;
  		}

  		hashwrite_be32(f, offset);
  	}

  	return 0;
  }

We've already decided by this point to skip writing the overflow chunk
based on compute_generation_numbers, so the commit graph is now
invalid.
