Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB605C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9237060F9D
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhI1NdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhI1NdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:33:13 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669DC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:31:34 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b65so40167308qkc.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vkiVlwquF9bfZcqOWOWvPpau7L152gtX0AX8Kc5f2yo=;
        b=QAqwaGzz2yf9ijmhNXU8cRVOW5zF/Q3Ygz1/4eXbPdAIYN1tZD9u2oLXZxlLb53k4x
         azSvMQR0LR5uJnujVrP4GPlQ6LXwReQfw5/Au8SMCnsmNGmzEZSJxqMy4MRckrzcZ/X0
         oWwNgz2UtM41kyqkEU295NxoMfGoTdG+2jBe7rzW8w0QknwJnaJ7gMWTXrN5SuY7ybyG
         yy5EwYbz6ZnoEHeMeSBlC+mZmNZ/MpHvrleQ4ynl7S3ZZmn47xothNErGR1gyg4WZRrH
         VY+qVPJRNamb0l6aUJhFqvdATexyRBxHLEpMpoMOjgB5V3K/e03eUJ33rmKuMYiCUdEl
         bi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vkiVlwquF9bfZcqOWOWvPpau7L152gtX0AX8Kc5f2yo=;
        b=KVm3uB78EuArwjAPwXEyxsoHNV35jrNZ+uXO0zMJC12Z77Ri2rGW4TunBMMFRiewKt
         B62jR+qmgLAMAJnlrtxg+lcJoTK66xcEqeq4eih6YSw2GccaFTQnhGO10Vgf/wdlErHw
         hsxNFnjLeRfJDpR1j5D5cxEPqPZYCYJLNgGpzB78o7/iNijh2WP50cNeEJiXnoIga93P
         JBTZUOJ+5K9nxOjQ7UhRo8nzLlmUJQdvK1mzELbwJiM7tBPO8bs9FqTPRyjICZmxLcLd
         IsEYRu6jmXprUp45+MAlf7+yfQPArPkUzZk8voVV5cjRq6bH6rmYIsQm223qn5tozmZw
         m6cQ==
X-Gm-Message-State: AOAM532wALp8MPDUwYdkwk8bt4DhWf8PDHHdiV1DMcek0/7w35EPGn1n
        yDJ/nWk6afXuCPGuQd4LGmc=
X-Google-Smtp-Source: ABdhPJwzn66svOLyNGQGEbOAdfoKR9YJ7xdiEqL1XcdL/npcQ4v7+/GgeAtAcT/yB9onTW1wmXM39Q==
X-Received: by 2002:a37:a7d5:: with SMTP id q204mr9405qke.236.1632835891560;
        Tue, 28 Sep 2021 06:31:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b9f6:9a69:7554:f4bc? ([2600:1700:e72:80a0:b9f6:9a69:7554:f4bc])
        by smtp.gmail.com with ESMTPSA id q184sm15115768qkd.35.2021.09.28.06.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 06:31:31 -0700 (PDT)
Message-ID: <97eb5075-2ef3-8891-138a-44a035437404@gmail.com>
Date:   Tue, 28 Sep 2021 09:31:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/28/2021 2:46 AM, Elijah Newren wrote:
> [Did some slight re-ordering of topics]
> 
> On Mon, Sep 27, 2021 at 5:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
>> * ds/add-rm-with-sparse-index (2021-09-24) 13 commits
>>  - advice: update message to suggest '--sparse'
>>  - mv: refuse to move sparse paths
>>  - rm: skip sparse paths with missing SKIP_WORKTREE
>>  - rm: add --sparse option
>>  - add: update --renormalize to skip sparse paths
>>  - add: update --chmod to skip sparse paths
>>  - add: implement the --sparse option
>>  - add: skip tracked paths outside sparse-checkout cone
>>  - add: fail when adding an untracked sparse file
>>  - dir: fix pattern matching on dirs
>>  - dir: select directories correctly
>>  - t1092: behavior for adding sparse files
>>  - t3705: test that 'sparse_entry' is unstaged
>>
>>  "git add", "git mv", and "git rm" have been adjusted to avoid
>>  updating paths outside of the sparse-checkout definition unless
>>  the user specifies a "--sparse" option.
>>
>>  Will merge to 'next'?
> 
> It would be nice to see the --diff-filter=u change, which you also
> seemed to like[1]; but after that, yeah this is ready to merge down.
> 
> [1] https://lore.kernel.org/git/xmqq35pppwsm.fsf@gitster.g/

Yes, I agree. I was waiting to see if more comments trickled in, but
it seems stable now. Do you want me to re-roll the whole series, or
do you want to apply the fixup below?

Thanks,
-Stolee


---- >8 ----

From d279bd580ad3b66187f9a8c0370acc5bca7cc5b6 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 28 Sep 2021 09:30:10 -0400
Subject: [PATCH] fixup! t1092: behavior for adding sparse files

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a00e42fa233..ca91c6a67f8 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -192,7 +192,7 @@ test_sparse_unstaged () {
 	for repo in sparse-checkout sparse-index
 	do
 		# Skip "unmerged" paths
-		git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&
+		git -C $repo diff --staged --diff-filter=u -- "$file" >diff &&
 		test_must_be_empty diff || return 1
 	done
 }
-- 
2.33.0.vfs.0.0


