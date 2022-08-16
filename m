Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61F5C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 21:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiHPV6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbiHPV6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 17:58:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31C8E99C
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:58:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cb8so9225651qtb.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=RjStQqp2mY8epolnAXqok19rHd8EFWPU4npIvbMgLZQ=;
        b=ITk+EcmybKN+29DESCK6Hg+Zrl2eF8SukbkBm4e/TmbWO0bkgVPdUSQ7QRuqra30e6
         q2bOFsduVsPdAYnmBT1Oy/483oVzt+/VCvIGtGvUOzF2pTelXPWLE+BJ8vgva/WnyPhJ
         HJabzVS+RHm7ykZiqKTnp+9JOgbqIxLznpW3PnRrDv8blmc7VkkJc7B6k1dbfDKv2Dfg
         KsOb4Zo/HrerEhGz0MqaepZ8CQqleizu9WtZVE5+iXhGBwb2W7ZCa+jpEOjOWCE6xN5u
         BDQtS5KVmAFcnZx7uD/c5AsGvJbeFUP3JOvagrE7lKq1u1ZKB/ubv5PvhJxwzLE+UJB6
         24CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RjStQqp2mY8epolnAXqok19rHd8EFWPU4npIvbMgLZQ=;
        b=NMQ5/r4kA99AGzaG6yP0xi/FHjffIYZVU4Y+o25SsrNd9xsErO4iwA91TCUe9T1GyP
         +Cj/HFXSjGdm6wVeK36UVtrJBjNn9gWs5GhFPZkN3SiI6MvZcH5jZTNiCHEpg9iSjpm3
         aUCeXPqAAp3FtCs4iruDcoLEl6dEuhXtJzbNJzvZw5iYvUwBNLMs9E+xkrzqsXATBVal
         tQfNVJMyusB31D40TWdBQfmg6+Fuz7yhoXJmWMWsrMVU4mZ3ie7HYnxsC+B+zaKIyw7M
         4NmJKV0An+2rIOJF8/fzgMujE0GVrp7/X+wtfpQcU1jBZ4BpavHN6N0F4Y2XRKrtEfXA
         WJVw==
X-Gm-Message-State: ACgBeo3XXoRdf4X29pdEoe1Lc5x9y+1uRhoN5uFUuGX/Rjg5vEQVLUJe
        /1jDX58x0LRMPsrRk6+W2kKHGg==
X-Google-Smtp-Source: AA6agR7NV5m2mDFszwllvgcZqva0ILmYc9raHvtmSMTkVcjj4jfojdmG34ZdW1IE0Mju+A1bYP7yvw==
X-Received: by 2002:ac8:7d8a:0:b0:344:65fe:834a with SMTP id c10-20020ac87d8a000000b0034465fe834amr8137097qtd.649.1660687082989;
        Tue, 16 Aug 2022 14:58:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t8-20020ac85308000000b003447c4f5aa5sm768012qtn.24.2022.08.16.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:58:02 -0700 (PDT)
Date:   Tue, 16 Aug 2022 17:57:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Message-ID: <YvwS5RlEMvgDm93m@nand.local>
References: <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
 <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
 <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
 <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
 <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
 <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com>
 <CAPOJW5z99b0_NGBYDbZUvmzbWECJKxGvB4RffoPJYszfFB0cEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5z99b0_NGBYDbZUvmzbWECJKxGvB4RffoPJYszfFB0cEg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Sat, Aug 13, 2022 at 04:29:32PM +0530, Abhradeep Chakraborty wrote:
> One thing that really worries me is what if the failure is not related
> to calling `oe_map_new_pack()? I did all my work assuming that this
> function is the culprit. But I don't know if it is.

After much consternation, I was able to rule out `oe_map_new_pack()` as
the culprit.

(Your find that we call `add_packed_git()` with arguments corresponding
to pack(s) that we've already loaded is good, and I think that is
definitely something we can and should consider cleaning up. But it
ultimately doesn't affect correctness, just the memory efficiency of the
process).

When I took a close look at the process to generate MIDX bitmaps, I found a
couple of interesting things. The first more trivial fix is that we
incorrectly propagate the "preferred"-ness bit from packs in an existing
MIDX when generating a new one. If the identity of the preferred pack
changes, we should not drag forward those bits on objects already known
(and preferred) by the existing MIDX:

--- >8 ---

diff --git a/midx.c b/midx.c
index 3ff6e91e6e..40e520534c 100644
--- a/midx.c
+++ b/midx.c
@@ -619,6 +619,9 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,

 		if (m) {
 			uint32_t start = 0, end;
+			int orig_preferred_pack = -1;
+			if (0 <= preferred_pack && preferred_pack < m->num_packs)
+				orig_preferred_pack = info[preferred_pack].orig_pack_int_id;

 			if (cur_fanout)
 				start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
@@ -629,7 +632,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 				nth_midxed_pack_midx_entry(m,
 							   &entries_by_fanout[nr_fanout],
 							   cur_object);
-				if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
+				if (nth_midxed_pack_int_id(m, cur_object) == orig_preferred_pack)
 					entries_by_fanout[nr_fanout].preferred = 1;
 				else
 					entries_by_fanout[nr_fanout].preferred = 0;

--- 8< ---

But a more interesting problem arose when I took a closer look at the
psuedo-pack order of objects generated according to
`prepare_midx_packing_data()`. With Johannes' fixed $test_tick value, I
was able to see the following in runs that succeeded:

    27bb4ecd3e96cd0b3bc37d92a78cb5cbf34c418afa67f74cc52517ff7df418e1 (12 in pack-63c460f99a5c08f631396b1828c64006170a9d543b064506fd11b504a62acf52.idx)
    c68154d69c19f010afce786c6debe926ae6e7decfb946a4549085a792cf9de7e (202 in pack-63c460f99a5c08f631396b1828c64006170a9d543b064506fd11b504a62acf52.idx)
    a0b85b314ede46aa9f9b5796a284a4cf0b86ebb8fa32f87ae246e21b5378b11c (392 in pack-63c460f99a5c08f631396b1828c64006170a9d543b064506fd11b504a62acf52.idx)
    [...]

and the following in runs that failed:

    46193a971f5045cb3ca6022957541f9ccddfbfe78591d8506e2d952f8113059b (221 in pack-3fc052de674e3d48096af7cc5125675c0ae1082aa798eb9358de357b2655f9ad.idx)
    67df8a01ac84cf5f028855c48384eac3336bb02a52603bac285c4b31d66b3ab5 (12 in pack-2021cdedb33b542b244eacf3d009d1384471a53286b0c1235c91d124355dc818.idx)
    1556b5f0ad7cb0c25a1fc47355fcffc00775e90d94ae8c511e5776b204796ce6 (200 in pack-2021cdedb33b542b244eacf3d009d1384471a53286b0c1235c91d124355dc818.idx)

In the successful case, pack 63c460f99a... is preferred, and its objects
appear in ascending order of their pack offsets. But in the other case,
pack 3fc052de67... is preferred, but its first object starts at offset
221. Huh? That's not right:

    $ git show-index <.git/objects/pack/pack-3fc052de674e3d48096af7cc5125675c0ae1082aa798eb9358de357b2655f9ad.idx
    221 46193a971f5045cb3ca6022957541f9ccddfbfe78591d8506e2d952f8113059b (1f4bd28e)
    12 4d332072f161629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf (fadf885b)

Indeed, there is another object there at offset 12. Missing that object
(since it comes from a preferred pack) is an invariant violation (since
all objects from the preferred pack should be selected when multiple
copies are available).

It's missing because the existing MIDX selects that object from a
different pack, and when we get to fanout 0x4d (the one which should
include that object), we skip over seeing its copy in the preferred pack
because that pack already appears in the existing MIDX, though it wasn't
preferred.

I think there are a couple of ways to fix this. The easiest thing to do
would be to force the identity of the preferred pack to be the same when
generating a MIDX bitmap *while reusing an existing MIDX*, since that is
the only time this bug can happen.

But that's a little magical for my taste. I think a more reasonable fix
would be to include copies of all objects from the preferred pack
including in the case where that pack was non-preferred in an existing
MIDX and at least one object in that pack was selected from a different
pack in the existing MIDX.

Abhradeep -- let me know if this is something you want to look into. I
think it's a very worthwhile bug to fix, since it is definitely
trigger-able in the wild (notably, only with `git multi-pack-index write
--bitmap` without `--stdin-packs` and only under certain circumstances),
and not just limited to SHA-256 mode.

If you are busy experimenting with CRoaring, that's no problem and I can
fix this up, too. Either way, it would be worth you and others weighing
in on which fix you think is worth pursuing.

Phew.

Thanks,
Taylor
