Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E1C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 03:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiBFDFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 22:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBFDFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 22:05:51 -0500
X-Greylist: delayed 9776 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 19:05:48 PST
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B503C043186
        for <git@vger.kernel.org>; Sat,  5 Feb 2022 19:05:48 -0800 (PST)
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nGVKL-0001Vo-6z; Sun, 06 Feb 2022 00:22:49 +0000
Message-ID: <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
Date:   Sun, 6 Feb 2022 00:22:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Commit SHA1 == SHA1 checksum?
Content-Language: en-GB
To:     "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/02/2022 01:19, Gamblin, Todd wrote:
> Apologies if this has been asked before, but the closest thing I could find was this thread:
>
> 	http://public-inbox.org/git/Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz/
>
> That thread devolved into a discussion of the security of different hashes and didn’t answer my question.
>
> I want to know when and where git *guarantees* that the snapshot I have checked out has the checksum that git says it does, or if it does at all.
>
> The use case for this is for package managers. I work on Spack (http://github.com/spack/spack if you’re curious) and we download sources from tarballs and git repos (like many similar tools).  For tarballs we require a sha256, and we use it to verify the tarball after download.
>
> For git repos, we would like to require a commit sha1, provided that it’s basically as secure as downloading a tarball and checking it against a known sha1.  So, if I `git clone` something, is the commit sha1 actually verified?
For the Git releases, the maintainer, Junio, will PGP sign the release
tag with his key e.g.
https://git.kernel.org/pub/scm/git/git.git/tag/?h=v2.35.1

The tag contains the sha1 hash of the release commit, which in turn
contains the sha1 hashes of the tree that is being released, and the 
previous commit in the git history, and onward the hashes roll...

https://lore.kernel.org/git/xmqqh7n5zv2b.fsf@gitster.c.googlers.com/ is
a recent discussion on the refreshing of the PGP key. the post
https://lore.kernel.org

/git/YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net/ in the thread notes
"The signature is .. over the uncompressed .tar ... You therefore need
to uncompress it first with gunzip."
>
> Thanks,
> -Todd
>
>
> PS: I know that sha1 has been declared “risky” by NIST and that folks should move away from it, and please be assured that we’re using sha256’s everywhere else.  Here I really just want to know whether cloning a git repo at a particular commit is as secure as downloading a tarball and checking it against a sha1, not whether or not sha1 is secure.
>
>
I don't think there is an obvious cross-check for the tarball sha1
comparison with the release tag's sha1, if that's the question.

The repeatability of tarballs has been discussed but I didn't find a
mail reference immediately.

Philip
