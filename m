Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A8C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 08:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbiEZIro (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEZIrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 04:47:43 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F7E5EBE7
        for <git@vger.kernel.org>; Thu, 26 May 2022 01:47:41 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nu99e-000Cc9-Fx;
        Thu, 26 May 2022 09:47:39 +0100
Message-ID: <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
Date:   Thu, 26 May 2022 09:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: About GIT Internals
Content-Language: en-GB
To:     git-vger@eldondev.com, Aman <amanmatreja@gmail.com>
Cc:     git@vger.kernel.org
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Yo68+kjAeP6tnduW@invalid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2022 00:34, git-vger@eldondev.com wrote:
> Hi Aman, responses inline below.
>
> On Wed, May 25, 2022 at 09:40:42PM +0530, Aman wrote:
>> Could someone please assist - in sharing some resources - which I
>> could go through, to better understand GIT software internals.
> There is an excellent free book at https://git-scm.com/book/en/v2 .
>
> Chapter 10 is about git internals. It is important to realize that,
> unlike many other version control systems, git works effectively on
> files locally on your computer, without any server or other shared
> resources to manage. Also, one good way to learn may be to form a
> question that you want to answer first. "How do I ...." or "what happens
> when I ....". Since git works locally, it is possible to create a git
> repo, look at the files contained in the .git directory, take action
> with git, and then look at the files again.
>
>
Another Git feature, compared to older version control systems, is that
it flips the 'control' aspect on its head. (who controls what you can
store?)

It does this by using the hash (sha1, or sha256) values as a way of
users _checking_ that they have the right copy of a file or commit,
rather than needing special permissions to access (write/read) some
alleged 'master' copy (in the sense of a unique artefact) of the
particular version. Maintainers now check and authorise particular
versions much more easily.

Hence Git _Distributes Control_ - you no longer need permission to keep
versioned copies of your work. This was, in my mind, a core element of
its success.

There is other stuff about how Git splits the (file) content from it's
meta-data, so if say 10 files contain the same licence text, then it
only hold one copy of that text, with its own unique hash. Then has a
hierarchy (pyramid) of hashes of the meta-data to build up a whole
project's hash (the top level 'tree'), and the same hierarchy technique
is repeated for the project's history of commits.

If you have a copy of the repository with the latest (same) hash then
you have a perfect copy, indistinguishable to the 'original'! Older
versioning systems did not have those guarantees, many were derived from
systems for versioning engineering and architectural drawings such as
those that were used for the RMS Titanic or Empire State Building.

Philip

PS it's worth checking out the distinction between having hash (a magic
id) of some text, and encrypting (a magic translation of) some text.


