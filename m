Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731E220357
	for <e@80x24.org>; Mon, 17 Jul 2017 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdGQSx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 14:53:26 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34648 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdGQSxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 14:53:24 -0400
Received: by mail-pf0-f180.google.com with SMTP id q85so80594743pfq.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KE7DktBCnUx7XjolxwEnJyiC+rkS/XnoCyWr78CLwqE=;
        b=mJax4JZtxfPy46vE/TgU6L6BRjAGtSlgOzYjO2eTmGkE7HBk4f1MaxaMNykIDCnPz8
         xbI7Dyc2BnIua2ho7WE111Rk8TEG4bYaPrQncGQe73JbqCvKOer8UiAEmECMfqIeAhiv
         cTMDn6qZ0ZI4b4pxaZOqMgm+v8zqxKq6OhyDq8k+OY/KGf37bq7jC+q27v3ZYYted+ZK
         txEk6txWbJfwYOo/PQtT972rbiiYtZn3mpo2+rNJ6+PN89G0LpZOxdfv9yxKLycO7L20
         D43Vicn6+tMdMD/DmAIXeNGrD+pj7IIj4MX+C9q2a4kivkzw62AZBsk1jz2vBe1g58Rx
         PJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KE7DktBCnUx7XjolxwEnJyiC+rkS/XnoCyWr78CLwqE=;
        b=GqUbkM9luutyj4k389bUr1AlFOO3sDh6wZImr63pVZG42gQiQaoZt3l8ae1YtgxdBz
         SvamsuuO44myh4SGXxTVqJU+uvadDTF6a/aNLJHx5xvyrWlXVi8vjtHZUsUYytl2aRpK
         dNDb9WzGROCm4ysMWfs3zi0kwKFEnQkprqEBf3TNzU5VNvbvhK/oKVpASMAOvbz/g+hh
         hGcE/LzzJINKGmAQ9nqX/Umt7/1Xq7CWgepC89UQsVI84WVoYhiXeuRAMw5Q1gzlzogA
         FC2vmN4bSdl/zTMSBtdzWttab1R3PUFlFT3KUY47AGfRnVFPGC4c8TDuRlkXHcO6lBWq
         mOxg==
X-Gm-Message-State: AIVw111X+fhQdovircoiUdboCFzY5mHgg2cIUTGgEuiAKYcfhmteXkye
        1++QnHpkY48WDPpO8boevIdGsK68H4KE84/RlQ==
X-Received: by 10.99.54.9 with SMTP id d9mr18826611pga.195.1500317604208; Mon,
 17 Jul 2017 11:53:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Mon, 17 Jul 2017 11:53:23 -0700 (PDT)
In-Reply-To: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Jul 2017 11:53:23 -0700
Message-ID: <CAGZ79kaFmxRSp1YBXc=6YEeDGUO-VLBF0yk+Bb0np7x80z_Vog@mail.gmail.com>
Subject: Re: reftable [v2]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 8:01 AM, Shawn Pearce <spearce@spearce.org> wrote:

> A ref block is written as:
>
>     'r'
>     uint24 ( block_len )
>     ref_record*
>     uint32( restart_offset )*
>     uint16( number_of_restarts )
>     padding?
>
...
>
> The 2-byte `number_of_restarts + 1` stores the number of entries in
> the `restart_offset` list.

This means uint16( number_of_restarts ) cannot be 0, but has to be 1
to indicate no restarts?

Why do we need to be non-NUL here, but the padding is all NUL?

When starting to write a block, we need to know exactly how large
the ref_records* and restart offsets need to be to put the
number_of_restarts at the position as promised via block_len.
This sounds complicated unless I missed the obvious.

Going by this, would it rather make sense to omit the block_len
and then scan backwards from *block_size-1 to find the first non-NUL
and that will be the number_of_restarts?

Or we could allow additional padding between ref_record and
restart_offsets, such that the writer implementation has wiggle room
for the restarting logic.

>
> #### log record
>
> Log record keys are structured as:
>
>     ref_name '\0' reverse_int32( time_sec )
>
> where `time_sec` is the update time in seconds since the epoch.

The epoch ends 2038, which is in 21 years. (Did you just volunteer
to fixup the time issues in 20 years?)
If possible I'd prefer a date to be encoded with more range available.

>  The
> `reverse_int32` function inverses the value so lexographical ordering
> the network byte order time sorts more recent records first:
>
>     reverse_int(int32 t) {
>       return 0xffffffff - t;
>     }
>
> Log records have a similar starting structure to ref and index
> records, utilizing the same prefix compression scheme applied to the
> key described above.

The ref names itself are compressed, would we also want to compress
the timing information? The time_sec could be a varint indicating a delta
to the previous change of a ref, or fixed to the epoch if it is the first change
of that ref.

Just to be clear, the ordering here would be

  refs/heads/maint <number>
  refs/heads/maint <smaller number>
  ...
  refs/heads/master <number>
  refs/heads/master <smaller number>

such that refs that have more than one entry in its reflog in a given
refstable file, would have perfect prefix compression for the ref?

> ### Update transactions
>
> Although reftables are immutable, mutations are supported by writing a
> new reftable and atomically appending it to the stack:
>
> 1. Atomically create `stack.lock`
> 2. Copy current stack to `stack.lock`.
> 3. Prepare new reftable in temp file `.refXXXXXXX`.
>    Include log entries.
> 4. Rename (3) to `${sha1}.ref`.
> 5. Append `${sha1}.ref` to `stack.lock`
> 6. Atomically rename `stack.lock` to `stack`.

In case 3.+4. becomes time consuming, it can be prepared outside
the lock, such that inside the lock we'd only need to check
for contention of refs? For example if I'd want to update one ref and
another write wants to update another refs, we'd both be preparing
the a new refstable containing one ref and log, then one of us obtains
the lock and writes. The second writer would then need to inspect
the delta of the stack and see if any ref that they want to change
was touched.

> ### Compaction
>
> A partial stack of reftables can be compacted by merging references
> using a straightforward merge join across reftables, selecting the
> most recent value for output, and omitting deleted references that do
> not appear in remaining, lower reftables.
>
> For sake of illustration, assume the stack currently consists of
> reftable files (from oldest to newest): A, B, C, and D. The compactor
> is going to compact B and C, leaving A and D alone.
>
> 1.  Obtain lock `stack.lock` and read the `stack` file.
> 2.  Obtain locks `B.lock` and `C.lock`.
>     Ownership of these locks prevents other processes from trying
> to compact these files.
> 3.  Release `stack.lock`.
> 4.  Compact `B` and `C` in temp file `.refXXXXXXX`.
> 5.  Reacquire lock `stack.lock`.
> 6.  Verify that `B` and `C` are still in the stack, in that order. This
>     should always be the case, assuming that other processes are adhering
>     to the locking protocol.
> 7.  Rename `.refXXXXXXX` to `X`.
> 8.  Write the new stack to `stack.lock`, replacing `B` and `C` with `X`.
> 9.  Atomically rename `stack.lock` to `stack`.
> 10. Delete `B` and `C`, perhaps after a short sleep to avoid forcing
>     readers to backtrack.
>
> This strategy permits compactions to proceed independently of updates.

10. could be deferred to gc as well. auto gc would need to learn about
the number
of loose refstables in that case.

Thanks,
Stefan
