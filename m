Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A87C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiIXWms (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 18:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIXWmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 18:42:46 -0400
X-Greylist: delayed 275 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Sep 2022 15:42:45 PDT
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C981A4505E
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:42:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7530215BBD4;
        Sat, 24 Sep 2022 18:38:07 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=okETolQUp9GzLJ0xP4ciTSAusuesldsb1zg5CEu
        IFl0=; b=RFCZEYXSg1COmfn7AuSizQY4e3VpWqdZY1sh5pwS+UjsThoQE5MmwLr
        pKrhxMpIX8SEXZVK4LqggPABwyxDVnmVo9N+xHMI6bVIIJntOm17yRdSwcemf5x8
        KOM9TqerSS2rQyoF6ecUvJ37H7GK363iZi8lccPKIxO9O4OAPEZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6890A15BBD3;
        Sat, 24 Sep 2022 18:38:07 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B723815BBD1;
        Sat, 24 Sep 2022 18:38:06 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sat, 24 Sep 2022 18:38:04 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [filter-repo PATCH] fix links to git-fast-import
Message-ID: <Yy+GzB0gTBHaJJw1@pobox.com>
References: <20220924033708.2409170-1-tmz@pobox.com>
 <CABPp-BHPYa4Lzj0Kt-q+qyA+qpo3BLkoMoQOo7sPNoo-0RTxKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHPYa4Lzj0Kt-q+qyA+qpo3BLkoMoQOo7sPNoo-0RTxKA@mail.gmail.com>
X-Pobox-Relay-ID: 8F0EB92E-3C59-11ED-89D0-2AEEC5D8090B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:
> On Fri, Sep 23, 2022 at 8:37 PM Todd Zullinger <tmz@pobox.com> wrote:
>> I noticed the link to git-fast-import.html in git-filter-repo.html was
>> missing the `git-` prefix.  The man page similarly lacked it when
>> referencing it.
>>
>>  html/git-filter-repo.html | 2 +-
>>  man1/git-filter-repo.1    | 2 +-
> 
> Neither of these files are tracked; both are auto-generated.  I do
> stuff them into the "docs" branch so people can grab them...but
> they'll just be wiped out and overwritten the next time I build the
> docs.  So, either the documentation source file is wrong, or the build
> process is.

D'oh! I should have looked closer at the build process.
Somehow I saw the docs branch and just _assumed_ it was the
source.  And that required looking right past the asciidoc
version in Documentation/ on the main branch. ;)

I was clearly a few too many tangents deep.

> Is the real problem that in this text from Documentation/git-filter-repo.txt:
> 
>     There are four callbacks that allow you to operate directly on raw
>     objects that contain data that's easy to write in
>     linkgit:fast-import[1] format:
> 
> that there should be a "git-" on the last line?

Indeed, thanks.

This should work (I tested by symlinking git-filter-repo.txt
to git's Documentation, as the Makefile does):

-- 8< --
Subject: [PATCH] git-filter-repo.txt: add missing `git-` prefix to fast-import
 link

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-filter-repo.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-repo.txt b/Documentation/git-filter-repo.txt
index 9c00a78..09374a4 100644
--- a/Documentation/git-filter-repo.txt
+++ b/Documentation/git-filter-repo.txt
@@ -1047,7 +1047,7 @@ instead of strings.
 
 There are four callbacks that allow you to operate directly on raw
 objects that contain data that's easy to write in
-linkgit:fast-import[1] format:
+linkgit:git-fast-import[1] format:
 
 --------------------------------------------------
 --blob-callback
-- 8< --

-- 
Todd
