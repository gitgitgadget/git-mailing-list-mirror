Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A422DC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiCBO6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiCBO6E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:58:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754615C345
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:57:20 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id a6so1903808oid.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rtoh4ksVbxSQ4VEKfxrLDaJu8LKPgEStyxwL3NeRTJQ=;
        b=UhAur0uE3g2+5FTDtxwNi4oaj0/pq0UipisXKwIiOnFttb3/W0chJX8aRtdDcXejqb
         6TGFJwj4FxoIJoODRrQaoqj1OHVsp875bVpIPYLBayRL31xV23zBACiJk+HUX3DAW+am
         wBv0ZPXslzSyWGXLbLgfm53jN+Vlgm50NKbAMR1hP576erW30Z1Vpj+RNsSZpvCV5sTT
         VRgqENXSvrmdYeF/U3hvHv8yp+PIzRg4+fI8FxP32T6RtklxI2XIiYCDmD33wwx5gXaE
         ePPFKpZygIvuwdoyE3f5AXgZZ7NP6/HKtDKiBPDu7aRjovumVqxm+3dPglIiOAOUxiru
         NggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rtoh4ksVbxSQ4VEKfxrLDaJu8LKPgEStyxwL3NeRTJQ=;
        b=pgQo1eVTATtMQsQbHXbSO9fGp2hErhBgCVv5EijZzg207yuX0OyvLEP8B6s3wQgH0J
         PIpaNp2u1s2hAuqBtJxn9sC7oAHCP8NtIj+1v3t+bVY1mWQH6qGGefi3DHMW/nL0B3Wm
         kN+jrT7IZWmHJs2CYgv42nt6sjX29bzhj534+pQH2VpLmkwDEkaqfX5W/KBC3IjQB7to
         y1uSlSIRbXrBpKyFXWnPKPRnKbi9pkvkO78OQPUvphlw7jSUxUPInCKQMf8uAKCF/ZAS
         ufRTUT+fLVzh5BQwjg34vL1gMjrzKDOD5f8r2jvgq/Cb1VU+CSpwwWsfCCqYSOG2TmZv
         +HPA==
X-Gm-Message-State: AOAM531OqEDrWGRa9delVp+/5jHYUcXxK/6zDuxf2F87dp+IKtDVCI9d
        35V4anvmUthbnRrgfUT03RRkal4VvGy9
X-Google-Smtp-Source: ABdhPJyQgpVE/9IPIi+MVOUFSmNc4t2zh1CPUSgsO5ZY4wvyv8kf2/ARLKknEX2DkpODpCr1bLvqWg==
X-Received: by 2002:a05:6808:d51:b0:2d5:3fbe:7d43 with SMTP id w17-20020a0568080d5100b002d53fbe7d43mr173661oik.118.1646233039756;
        Wed, 02 Mar 2022 06:57:19 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u36-20020a056808152400b002d94715f853sm1160696oiw.31.2022.03.02.06.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:57:19 -0800 (PST)
Message-ID: <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
Date:   Wed, 2 Mar 2022 09:57:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase> <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps> <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com> <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com> <Yh93vOkt2DkrGPh2@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh93vOkt2DkrGPh2@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 8:57 AM, Patrick Steinhardt wrote:
> On Tue, Mar 01, 2022 at 10:25:46AM -0500, Derrick Stolee wrote:
>> On 3/1/2022 9:53 AM, Patrick Steinhardt wrote:

>>> Hum. I have re-verified, and this indeed seems to play out. So I must've
>>> accidentally ran all my testing with the state generated without the
>>> final patch which fixes the corruption. I do see lots of the following
>>> warnings, but overall I can verify and write the commit-graph just fine:
>>>
>>>     commit-graph generation for commit c80a42de8803e2d77818d0c82f88e748d7f9425f is 1623362063 < 1623362139
>>
>> But I'm not able to generate these warnings from either version. I
>> tried generating different levels of a split commit-graph, but
>> could not reproduce it. If you have reproduction steps using current
>> 'master' (or any released Git version) and the four patches here,
>> then I would love to get a full understanding of your errors.
>>
>> Thanks,
>> -Stolee
> 
> I haven't yet been able to reproduce it with publicly available data,
> but with the internal references I'm able to evoke the warnings
> reliably. It only works when I have two repositories connected via
> alternates, when generating the commit-graph in the linked-to repo
> first, and then generating the commit-graph in the linking repo.
> 
> The following recipe allows me to reproduce, but rely on private data:
> 
>     $ git --version
>     git version 2.35.1
> 
>     # The pool repository is the one we're linked to from the fork.
>     $ cd "$pool"
>     $ rm -rf objects/info/commit-graph objects/info/commit-graph
>     $ git commit-graph write --split
> 
>     $ cd "$fork"
>     $ rm -rf objects/info/commit-graph objects/info/commit-graph
>     $ git commit-graph write --split
> 
>     $ git commit-graph verify --no-progress
>     $ echo $?
>     0
> 
>     # This is 715d08a9e51251ad8290b181b6ac3b9e1f9719d7 with your full v2
>     # applied on top.
>     $ ~/Development/git/bin-wrappers/git --version
>     git version 2.35.1.358.g7ede1bea24
> 
>     $ ~/Development/git/bin-wrappers/git commit-graph verify --no-progress
>     commit-graph generation for commit 06a91bac00ed11128becd48d5ae77eacd8f24c97 is 1623273624 < 1623273710
>     commit-graph generation for commit 0ae91029f27238e8f8e109c6bb3907f864dda14f is 1622151146 < 1622151220
>     commit-graph generation for commit 0d4582a33d8c8e3eb01adbf564f5e1deeb3b56a2 is 1631045222 < 1631045225
>     commit-graph generation for commit 0daf8976439d7e0bb9710c5ee63b570580e0dc03 is 1620347739 < 1620347789
>     commit-graph generation for commit 0e0ee8ffb3fa22cee7d28e21cbd6df26454932cf is 1623783297 < 1623783380
>     commit-graph generation for commit 0f08ab3de6ec115ea8a956a1996cb9759e640e74 is 1621543278 < 1621543339
>     commit-graph generation for commit 133ed0319b5a66ae0c2be76e5a887b880452b111 is 1620949864 < 1620949915
>     commit-graph generation for commit 1341b3e6c63343ae94a8a473fa057126ddd4669a is 1637344364 < 1637344384
>     commit-graph generation for commit 15bdfc501c2c9f23e9353bf6e6a5facd9c32a07a is 1623348103 < 1623348133
>     ...
>     $ echo $?
>     1
> 
> When generating commit-graphs with your patches applied the `verify`
> step works alright.
> 
> I've also by accident stumbled over the original error again:
> 
>     fatal: commit-graph requires overflow generation data but has none
> 
> This time it's definitely not caused by generating commit-graphs with an
> in-between state of your patch series because the data comes straight
> from production with no changes to the commit-graphs performed by
> myself. There we're running Git v2.33.1 with a couple of backported
> patches (see [1]). While those patches cause us to make more use of the
> commit-graph, none modify the way we generate them.
> 
> Of note is that the commit-graph contains references to commits which
> don't exist in the ODB anymore.
> 
> Patrick
> 
> [1]: https://gitlab.com/gitlab-org/gitlab-git/-/commits/pks-v2.33.1.gl3

Thank you for your diligence here, Patrick. I really appreciate the
work you're putting in to verify the situation.

Since our repro relies on private information, but is consistent, I
wonder if we should take the patch below, which starts to ignore the
older generation number v2 data and only writes freshly-computed
numbers.

Thanks,
-Stolee

--- 8< ---

From c53d8bd52bbcab3862e8a826ee75692edc7e4173 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Wed, 2 Mar 2022 09:45:13 -0500
Subject: [PATCH v3 5/4] commit-graph: declare bankruptcy on GDAT chunks

The Generation Data (GDAT) and Generation Data Overflow (GDOV) chunks
store corrected commit date offsets, used for generation number v2.
Recent changes have demonstrated that previous versions of Git were
incorrectly parsing data from these chunks, but might have also been
writing them incorrectly.

I asserted [1] that the previous fixes were sufficient because the known
reasons for incorrectly writing generation number v2 data relied on
parsing the information incorrectly out of a commit-graph file, but the
previous versions of Git were not reading the generation number v2 data.

However, Patrick demonstrated [2] a case where in split commit-graphs
across an alternate boundary (and possibly some other special
conditions) it was possible to have a commit-graph that was generated by
a previous version of Git have incorrect generation number v2 data which
results in errors like the following:

  commit-graph generation for commit <oid> is 1623273624 < 1623273710

[1] https://lore.kernel.org/git/f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com/
[2] https://lore.kernel.org/git/Yh93vOkt2DkrGPh2@ncase/

Clearly, there is something else going on. The situation is not
completely understood, but the errors do not reproduce if the
commit-graphs are all generated by a Git version including these recent
fixes.

If we cannot trust the existing data in the GDAT and GDOV chunks, then
we can alter the format to change the chunk IDs for these chunks. This
causes the new version of Git to silently ignore the older chunks (and
disabling generation number v2 in the process) while writing new
commit-graph files with correct data in the GDA2 and GDO2 chunks.

Update commit-graph-format.txt including a historical note about these
deprecated chunks.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/commit-graph-format.txt | 12 ++++++++++--
 commit-graph.c                                  |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 87971c27dd7..484b185ba98 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -93,7 +93,7 @@ CHUNK DATA:
       2 bits of the lowest byte, storing the 33rd and 34th bit of the
       commit time.
 
-  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
+  Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
     * This list of 4-byte values store corrected commit date offsets for the
       commits, arranged in the same order as commit data chunk.
     * If the corrected commit date offset cannot be stored within 31 bits,
@@ -104,7 +104,7 @@ CHUNK DATA:
       by compatible versions of Git and in case of split commit-graph chains,
       the topmost layer also has Generation Data chunk.
 
-  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
+  Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
     * This list of 8-byte values stores the corrected commit date offsets
       for commits with corrected commit date offsets that cannot be
       stored within 31 bits.
@@ -156,3 +156,11 @@ CHUNK DATA:
 TRAILER:
 
 	H-byte HASH-checksum of all of the above.
+
+== Historical Notes:
+
+The Generation Data (GDA2) and Generation Data Overflow (GDO2) chunks have
+the number '2' in their chunk IDs because a previous version of Git wrote
+possibly erroneous data in these chunks with the IDs "GDAT" and "GDOV". By
+changing the IDs, newer versions of Git will silently ignore those older
+chunks and write the new information without trusting the incorrect data.
diff --git a/commit-graph.c b/commit-graph.c
index b86a6a634fe..fb2ced0bd6d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -39,8 +39,8 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
-#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
-#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f56 /* "GDOV" */
+#define GRAPH_CHUNKID_GENERATION_DATA 0x47444132 /* "GDA2" */
+#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f32 /* "GDO2" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
-- 
2.35.1.138.gfc5de29e9e6




