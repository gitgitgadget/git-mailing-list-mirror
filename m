Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1E4C4363A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4442222A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bastelstu.be header.i=@bastelstu.be header.b="DM+O7vgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgJNSfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389127AbgJNSfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 14:35:38 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Oct 2020 11:35:38 PDT
Received: from chrono.xqk7.com (mail.chrono.xqk7.com [IPv6:2a01:4f8:150:6153:beef::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9DEC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bastelstu.be;
        s=mail20171119; t=1602699945;
        bh=14LsyXaUEhcaU++k0fLlKkSI7zcS74FrOAHtSemvUZg=;
        h=To:References:Cc:From:Subject:Date:In-Reply-To:From;
        b=DM+O7vgRvXGjWReANco8tJXu1PPCOEPeTsmYVKvs/g/EB/PA6vgZNJhlCFoyryF2k
         BpEN7PY9MRG/W/aXxOVjMXPFyluZqzbtKM8UrWJUaOj5h9QQ7Ohmf+sOR2W9LFmAL6
         oQUC0i4zLTsOOoCmCZ8/hJ34sW5Yp/bVuE95IB5TGOQALGJNbW2RvxjpyZq6IHD+dA
         3kpkbMnm8aBElQ2rq/F7yCG6lG7GWF+laczQee91WBYzeOdwas3yvrYgyURTovrVl3
         Le/pNHKbcqP3l1EhrgZPGFBXGaP1yVrKAlxdlfIip1XVrl/5klav4DplU4QpttzvDV
         mDz39Wr56NvRw==
To:     git@vger.kernel.org
References: <CAGP6POKvZHHWDcV4-4P6Y4yy6gCujm7vpEqKxWW0whT2FyqYEw@mail.gmail.com>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>, Willy Tarreau <w@1wt.eu>
From:   =?UTF-8?Q?Tim_D=c3=bcsterhus?= <tim@bastelstu.be>
Autocrypt: addr=timwolla@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 +Bgib+6sdwCfW+JcQNcwH+1TmKlFaXiqXZXMElQ=
Subject: Unable to get pack file - HTTP 416 [was: error: Unable to get pack
 file]
Message-ID: <419fd4ad-f9c2-927c-7ae0-c6083f70dcba@bastelstu.be>
Date:   Wed, 14 Oct 2020 20:25:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAGP6POKvZHHWDcV4-4P6Y4yy6gCujm7vpEqKxWW0whT2FyqYEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi List,
Hongyi,
Willy,

[please leave me in Cc, I am not subscribed]

Am 20.06.20 um 16:58 schrieb Hongyi Zhao:
> I have a local repo mirror for https://source.winehq.org/git/wine.git
> which was updated some time ago. When I try to update the local repo
> to its latest version, I meet the following error message:
> 
> $ git pull
> error: Unable to get pack file
> https://source.winehq.org/git/wine.git/objects/pack/pack-3776ee1d93e316ed56507e9062d8fc8e5c07feed.pack
> The requested URL returned error: 416 Requested Range Not Satisfiable
> error: Unable to find 6ed1d04b1325d4c2480907b76b8b1d5529caebab under
> https://source.winehq.org/git/wine.git
> Cannot obtain needed object 6ed1d04b1325d4c2480907b76b8b1d5529caebab
> while processing commit bf454cc39428fc5299e5c26d9c0ddc6a9277c7ae.
> error: fetch failed.
> 
> Any suggestions for this problem?
> 

I experienced the same issue yesterday with the canonical git repository
of HAProxy [0]. The git repository uses the dumb HTTP transport.

I am using git 2.28.0 from the `git-core` PPA for Ubuntu:
https://launchpad.net/~git-core/+archive/ubuntu/ppa



I attempted to update the repository using `git fetch` as usual, but
interrupted the fetch with Ctrl+C, because it appeared stuck. It did not
return in tens of seconds, while it usually updates in single-digit seconds.

Afterwards I retried the operation, but it failed with the same error
message Hongyi experienced in June.

I could track the issue down to the following:

1. git already downloaded all the bytes of the pack file in question.
2. When retrying the `git fetch` git attempted to resume the download by
sending a `Range` request.
3. Because the file was complete git was sending an invalid `Range`.
4. The nginx at haproxy.org returned the HTTP 416 in response, causing
git to fail.

I could fix the issue by truncating the temporary pack file to be 1 Byte
smaller than before. I suspect deleting the temporary file would also
have worked. Even after truncation the operation took quite a while. I
am not sure what git was doing under the hood. The network connection
was not the limiting factor there.

Neither running `git fsck` nor `git gc` was able to fix the issue. I had
to edit around in the `.git/objects/` folder.

I would claim that this behavior is a bug in git, because I was unable
to fix my repository with regular git commands. The next repack on the
server might or might not have fixed the issue.

I believe one of the following suggestions should prevent this issue
from happening:

1. Retry without the `Range` header when receiving a 416 in response.
2. Checking the returned `Content-Range` to check whether the full pack
is already downloaded and then ignoring the error status.
3. Deleting the temporary packfile in progress when resuming the
download fails. Then the next retry would have worked from my understanding.

Please see the following link to mail-archive.com for my initial thread
on the HAProxy mailing list. It might contain additional details:

https://www.mail-archive.com/haproxy@formilux.org/msg38650.html

Best regards
Tim Düsterhus

[0] https://git.haproxy.org/git/haproxy.git/
