Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00D3C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiFHUIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiFHUIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:08:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2187CDDA
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:08:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y12so20094831ior.7
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rlAgE+WmCqhjHihrPhlUZ51JERrk+u9TY2niYF7+4mw=;
        b=ahzBu+e0vwtBEgjy/XfdlusGPEbzTfMnLuAUxNrUqG8aH7C2yZWR0ntzonolnTC51s
         +MdXCF/YETkOp9NsSv019CoeSOM7NQgXOPOzF2eMY2eR2IpB9zSWPPX8lWtyxb6wdURr
         avk7bnpwbU0qebMly1dtUMBVAUYdxGt4/uqEINU2gUZmzngFS9P84meB73OY5m2ht0Wr
         hnTYPmOAMqU1gaDKMm9UNxFANl+nPSvfV+GsPEulko4EUGnJcHMC4mRPMzztVQf/lx30
         ib1wZrX/dL35Om65V8NeRhHQLuH9OUBpTDIHXbrGf3lbFzPeZUseqXSNJGd13j+sA0hk
         0jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rlAgE+WmCqhjHihrPhlUZ51JERrk+u9TY2niYF7+4mw=;
        b=u0+0oCYa2+Kq5eprCWKVhs3mCpIXawvmADy961Qe9fxkbdXKjzDkpgjWePhgbZ/Ulp
         XGlSL4KkL+YP7v15XjWyfrncYuc23La5TJUR+NQ1oSrk8IfSP22iDFeWn/tms9sX9iQP
         wRcC7fSRJOPj206D2CJu9QF1AGe9TMSeI0II7ga27mD+S7a+65l1J/4tSPaGPjvjD27r
         qFzUhxiWYSx6dnEFutwgKLF0cTCL3ueJfpEuqcYxPAa0EIf3xlnJGELB6KQo5Y3DpyCZ
         5bryyJ9Ggs6XxurHmua1Qec1IIqJkMvIZ+Z1oxcMylypTFySM92ECPp2wpf5oczWG89I
         lWZw==
X-Gm-Message-State: AOAM533RC/60pO11C47eLUTjKQeAkATZgD5aJhVdrZGiFvGE9RIAjncB
        NhW+C8vFWfI+DEzU1ViXfmMdhoKYP+A+
X-Google-Smtp-Source: ABdhPJx05+O6vACIj6oXNhrCzzeO/HVmSdJPPWW9TVNZ093BPkOQyKctg5NJXILlYOgjSYQUAIPSpg==
X-Received: by 2002:a02:c809:0:b0:331:4d19:d070 with SMTP id p9-20020a02c809000000b003314d19d070mr19633505jao.92.1654718886842;
        Wed, 08 Jun 2022 13:08:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ef:16b:eb19:f653? ([2600:1700:e72:80a0:90ef:16b:eb19:f653])
        by smtp.gmail.com with ESMTPSA id g6-20020a056e020d0600b002d3b759dc7fsm9218507ilj.77.2022.06.08.13.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 13:08:05 -0700 (PDT)
Message-ID: <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
Date:   Wed, 8 Jun 2022 16:08:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: commit-graph overflow generation chicken and egg
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 3:33 PM, Jeff King wrote:
> I hadn't touched my git.git repository for a while, so I upgraded to the
> most recent version of Git (v2.36.1) and was met with this:
> 
>   $ git rev-list --all
>   fatal: commit-graph requires overflow generation data but has none
> 
> Not very friendly, but OK, maybe my commit graph is out of date. Let's
> regenerate it:
> 
>   $ git gc
>   fatal: commit-graph requires overflow generation data but has none
>   fatal: failed to run repack
> 
> OK, we can't get far enough in the gc to rebuild the commit graph. Let's
> try doing it manually:
> 
>   $ git commit-graph write --reachable
>   fatal: commit-graph requires overflow generation data but has none
>   $ git commit-graph write
>   fatal: commit-graph requires overflow generation data but has none
> 
> Yikes. Here's where it happens within the write process:
> 
>   $ GIT_PROGRESS_DELAY=0 git commit-graph write
>   Finding commits for commit graph among packed objects: 100% (360229/360229), done.
>   Loading known commits in commit graph: 100% (78366/78366), done.
>   Expanding reachable commits in commit graph: 78366, done.
>   Clearing commit marks in commit graph: 100% (78366/78366), done.
>   Finding extra edges in commit graph: 100% (78366/78366), done.
>   Computing commit graph topological levels: 100% (78366/78366), done.
>   Computing commit graph generation numbers: 100% (78366/78366), done.
>   fatal: commit-graph requires overflow generation data but has none
> 
> Now being the enterprising fellow that I am, I was able to get out of it
> like this:
> 
>   $ rm -f objects/info/commit-graph
>   $ git gc
> 
> But I wonder if this is a foot-gun waiting for some other user. I'm not
> sure how I got into the broken state exactly. The repo was last touched
> in December using a version of Git running 'next'. It worked fine with
> versions of Git prior to 6dbf4b8172 (commit-graph: declare bankruptcy on
> GDAT chunks, 2022-03-02). It's entirely possible that the bad state was
> generated by a version of Git that wasn't ever released, and this isn't
> a problem that normal humans would ever run into. It does feel a bit
> unfriendly that neither gc nor commit-graph could unstick things,
> though. Especially because 6dbf4b8172 says:
> 
>   [...]a previous version of Git wrote possibly erroneous data in these
>   chunks with the IDs "GDAT" and "GDOV". By changing the IDs, newer
>   versions of Git will silently ignore those older chunks[...]

You've done enough homework to discover exactly what's going on here,
including talking about the commit that I was going to point out.

> Presumably we _are_ ignoring those chunks, but some other part of the
> commit-graph file has a dependency on them (and of course we don't have
> the new GDA2/GDO2 chunks to read in their place). If that's true, then
> the solution may be a more graceful "we can't use this commit graph"
> error return rather than the "fatal:" message seen above.
> 
> I have a copy of the broken repo state if anybody would care to look at
> it.

I'd love to see the full binary, but for the sake of sharing on the
list, could you give the following output?

	xxd .git/objects/info/commit-graph | head

or any other command that shows the first few hex bytes along with
their ASCII equivalents. Here is one that used Git 2.34.0:

00000000: 4347 5048 0101 0500 4f49 4446 0000 0000  CGPH....OIDF....
00000010: 0000 0050 4f49 444c 0000 0000 0000 0450  ...POIDL.......P
00000020: 4344 4154 0000 0000 002d cf0c 4744 4154  CDAT.....-..GDAT
00000030: 0000 0000 0080 3bf8 4544 4745 0000 0000  ......;.EDGE....
00000040: 0089 6484 0000 0000 0000 0000 0089 6660  ..d...........f`
00000050: 0000 0246 0000 0498 0000 06c8 0000 0908  ...F............
00000060: 0000 0b4b 0000 0d58 0000 0f9e 0000 1207  ...K...X........
00000070: 0000 1423 0000 168e 0000 18d3 0000 1b36  ...#...........6
00000080: 0000 1d67 0000 1f9b 0000 2219 0000 2456  ...g......"...$V
00000090: 0000 26a2 0000 2908 0000 2b5c 0000 2d96  ..&...)...+\..-.

and here is one with latest master:

00000000: 4347 5048 0101 0500 4f49 4446 0000 0000  CGPH....OIDF....
00000010: 0000 0050 4f49 444c 0000 0000 0000 0450  ...POIDL.......P
00000020: 4344 4154 0000 0000 002e 20b0 4744 4132  CDAT...... .GDA2
00000030: 0000 0000 0081 2090 4544 4745 0000 0000  ...... .EDGE....
00000040: 008a 5970 0000 0000 0000 0000 008a 5b4c  ..Yp..........[L
00000050: 0000 024c 0000 04a1 0000 06d6 0000 091a  ...L............
00000060: 0000 0b60 0000 0d70 0000 0fbb 0000 1229  ...`...p.......)
00000070: 0000 1448 0000 16b6 0000 1905 0000 1b6c  ...H...........l
00000080: 0000 1da3 0000 1fd9 0000 225b 0000 249d  .........."[..$.
00000090: 0000 26f0 0000 2956 0000 2bac 0000 2dea  ..&...)V..+...-.

If you have a GDA2 chunk, then we are somehow incorrectly writing the
offset there. However, I don't see this happening in the latest code.

We have this macro in commit.h:

#define GENERATION_NUMBER_V2_OFFSET_MAX ((1ULL << 31) - 1)

and this in commit-graph.c:

#define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)

being used here:

static int write_graph_chunk_generation_data(struct hashfile *f,
					     void *data)
{
	struct write_commit_graph_context *ctx = data;
	int i, num_generation_data_overflows = 0;

	for (i = 0; i < ctx->commits.nr; i++) {
		struct commit *c = ctx->commits.list[i];
		timestamp_t offset;
		repo_parse_commit(ctx->r, c);
		offset = commit_graph_data_at(c)->generation - c->date;
		display_progress(ctx->progress, ++ctx->progress_cnt);

		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
			offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;
			num_generation_data_overflows++;
		}

		hashwrite_be32(f, offset);
	}

	return 0;
}

But this hasn't been changed since eb9071912f (commit-graph: anonymize
data in chunk_write_fn, 2021-02-05) and 90cb1c47c7 (commit-graph: always
parse before commit_graph_data_at(), 2021-02-01) which were not meaningfully
different from the first implementation in e8b63005c4 (commit-graph:
implement generation data chunk, 2021-01-16).

However, the lack of the large offset chunk could be due to the bug fixed by
75979d9460 (commit-graph: fix ordering bug in generation numbers,
2022-03-01). Perhaps that was the thing that was missing from your version?

But otherwise, I'm stumped. I'd be very interested to see a repro from a
fresh repository. That is: what situation do we need to be in to write such
an offset without including the large offset chunk?

Thanks,
-Stolee
