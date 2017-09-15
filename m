Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A44920A25
	for <e@80x24.org>; Fri, 15 Sep 2017 04:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdIOEVK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 00:21:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61417 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750708AbdIOEVJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Sep 2017 00:21:09 -0400
X-AuditID: 12074413-38bff70000007929-88-59bb5534d410
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 13.62.31017.4355BB95; Fri, 15 Sep 2017 00:21:08 -0400 (EDT)
Received: from [192.168.69.190] (p54AAE5E5.dip0.t-ipconnect.de [84.170.229.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8F4L5cb016257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 15 Sep 2017 00:21:06 -0400
Subject: Re: [PATCH 00/20] Read `packed-refs` using mmap()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1505319366.git.mhagger@alum.mit.edu>
 <alpine.DEB.2.21.1.1709142101560.4132@virtualbox>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d0fe1daf-4b44-fa4f-dab6-2590e6c09163@alum.mit.edu>
Date:   Fri, 15 Sep 2017 06:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709142101560.4132@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqGsSujvS4PU9I4u1z+4wWTxff4Ld
        outKN5NFQ+8VZov+5V1sFt1T3jJa/GjpYbbYvLmdxYHDY+esu+weHz7GeSzYVOrxrHcPo8fF
        S8oenzfJBbBFcdmkpOZklqUW6dslcGX0TWxnKjhtUrH9+2rWBsbDWl2MnBwSAiYSl9YtZe1i
        5OIQEtjBJPHu0gIo5wKTxLzvP5lBqoQFrCSeH1jADmKLAHU07mxgAyliFjjPJHG1YSUTSEJI
        IFtiwf5vbCA2m4CuxKKeZrA4r4C9xJuZf8HiLAKqEl9/nQaLiwpESPS9vcwOUSMocXLmExYQ
        m1PATuLvpo1gNrOAusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDALSfssJC2zkLTMQtKygJFl
        FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIhAjvYNx1Uu4QowAHoxIP747e
        XZFCrIllxZW5hxglOZiURHn36u6MFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCm+C3O1KINyWx
        siq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBaxsC1ChYlJqeWpGWmVOCkGbi
        4AQZzgM0PAqkhre4IDG3ODMdIn+KUVFKnNcRJCEAksgozYPrhSWwV4ziQK8I89qBVPEAkx9c
        9yugwUxAg8+c3gEyuCQRISXVwCg2W8lC11n67LvqUu4vkco+ptqK+W3nz9twbdy6bq9YyrGb
        Ig7+ESJhC+Ls+hyX5CdMKtpocO3NbvbEuPcMZ6et09h2P5htp+Ss4C/iZkYHfAXME7WmZvZV
        X3l/mvtdxj0p79JLrhtMD3f8/rP+zqTUZZsctA5yec6YxTS1TU9D5e9xsa3LE5RYijMSDbWY
        i4oTAcACDm07AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/14/2017 10:23 PM, Johannes Schindelin wrote:
> On Wed, 13 Sep 2017, Michael Haggerty wrote:
> 
>> * `mmap()` the whole file rather than `read()`ing it.
> 
> On Windows, a memory-mapped file cannot be renamed. As a consequence, the
> following tests fail on `pu`:
> 
> [...]

Thanks for your quick investigation.

> This diff:
> 
> -- snip --
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index f9c5e771bdd..ee8b3603624 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1306,13 +1308,13 @@ static int packed_transaction_finish(struct
> ref_store *ref_store,
>  	char *packed_refs_path;
>  
>  	packed_refs_path = get_locked_file_path(&refs->lock);
> +	clear_snapshot(refs);
>  	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
>  		strbuf_addf(err, "error replacing %s: %s",
>  			    refs->path, strerror(errno));
>  		goto cleanup;
>  	}
>  
> -	clear_snapshot(refs);
>  	ret = 0;
>  
>  cleanup:
> -- snap --
> 
> reduces the failed tests to
> 
> t1410-reflog.counts.sh
> t3210-pack-refs.counts.sh
> t3211-peel-ref.counts.sh
> t5505-remote.counts.sh
> t5510-fetch.counts.sh
> t5600-clone-fail-cleanup.counts.sh

That change is a strict improvement on all systems; I'll integrate it
into the series.

> However, much as I tried to wrap my head around it, I could not even start
> to come up with a solution for e.g. the t1410 regression. The failure
> happens in `git branch -d one/two`.
> 
> The culprit: there is yet another unreleased snapshot while we try to
> finish the transaction.
> 
> It is the snapshot of the main_worktree_ref_store as acquired by
> add_head_info() (which is called from get_main_worktree(), which in turn
> was called from get_worktrees(), in turn having been called from
> find_shared_symref() that was called from delete_branches()), and it seems
> to me that there was never any plan to have that released, including its
> snapshot.

Yeah the idea was that the default situation would be that whenever a
`packed-refs` file needs to be read, it would be kept mmapped for the
life of the program (or until the file was detected to have been
changed). This was meant to be a replacement for the explicit
`ref_cache`. So any long-lived git process could be expected to have the
`packed-refs` file (or even multiple `packed-refs` files in the case of
submodules) mmapped.

That's obviously not going to work on Windows.

> [...]
> Do you have any idea how to ensure that all mmap()ed packed refs are
> released before attempting to finish a transaction?

[And from your other email:]
> This is only one example, as I figure that multiple worktrees could cause
> even more ref_stores to have unreleased snapshots of the packed-refs file.
> 
> I imagine that something like close_all_packs() is needed
> ("clear_all_snapshots()"?).

Yes, I wasn't really familiar with `close_all_packs()`, but it sounds
like it solves a similar problem.

Within a single process, we could make this work via an arduous process
of figuring out what functions might want to overwrite the `packed-refs`
file, and making sure that nobody up the call stack is iterating over
references during those function calls. If that condition is met, then
calling `clear_snapshot()` earlier, as you propose above, would decrease
the reference count to zero, causing the old snapshot to be freed, and
allowing the rename to succeed. We could even do

    if (!clear_snapshot(refs))
            BUG("packed-refs snapshot is still in use");

, analogously to `close_all_packs()`, to help find code that violates
the condition.

Similarly, it wouldn't be allowed to invoke a subprocess or hook
function while iterating over references, and one would have to clear
any current snapshots before doing so. It might even make sense to do
that at the same time as `close_all_packs()`, for example in a new
function `close_all_unnecessary_files()`.

But what about unrelated processes? Anybody reading `packed-refs` would
block anybody who wants to modify it, for example to delete a reference
or pack the references. I think this is worse than the packfile
situation. Packfiles all have unique names, so they never need to be
overwritten; at worst they are deleted. And the deletion is never
critical to correctness. If you can't delete a packfile, the only
consequence is that it hangs around until the next GC.

However, the `packed-refs` file always has the same name, and
overwriting it is sometimes critical for correctness. So it sounds to me
like even *readers* mustn't keep the file open or mmapped longer than
necessary!

(This makes me wonder, doesn't `rename_tempfile()` for the `packed-refs`
file *already* fail sometimes on Windows due to a concurrent reader?
Shouldn't it retry if it gets whatever error indicates that the failure
was due to the file being open?)

Anyway, if all of my reasoning is correct, it seems that the inescapable
conclusion is that having the `packed-refs` file open or mmapped is
tantamount to holding a reader lock on the file, because it causes
writers to fail or at least have to retry. Therefore, even if you are
only reading the `packed-refs` file, you should read then close/munmap
it as quickly as possible.

And if *that* is true, then ISTM that this mmap idea is unworkable on
Windows. We would either need to keep the old `ref_cache`-based code
around for use there, or we would need to make a copy the file contents
in memory immediately and use *that* as our cache. The latter would be
pretty easy to implement, actually, because something similar is done in
`sort_snapshot()` to handle the case that the `packed-refs` file on disk
is not correctly ordered by refname. I think that approach would be
competitive with the `ref_cache`-based code, which also reads (and
parses!) the whole file whenever any packed reference needs to be read.
It is possible that memory usage might go up a bit due to the fact that
the SHA-1s would be stored in memory in hex rather than binary form; on
the other hand, this would spare some memory overhead associated with
allocating lots of little objects and the pointers that string the
objects together, so it's probably a wash.

Please let me know if you agree with my reasoning. If so, I'll implement
"always copy `packed-refs` file contents to RAM" for Windows.

A possible future optimization might be that when iterating over a
subset of the references (e.g., `refs/replace/`), only that part of the
file is copied to RAM. But that would be a bigger change, and it's not
obvious whether it might make some read access patterns slower.

Michael
