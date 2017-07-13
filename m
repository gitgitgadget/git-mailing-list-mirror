Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A181FA4D
	for <e@80x24.org>; Thu, 13 Jul 2017 19:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbdGMT45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:56:57 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33243 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbdGMT44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:56:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id e7so34355623pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jVBUYmys8Y9h7xIEQSBBQ9vWWYvepVJ2LQGjh1x024U=;
        b=XQ42twClgrDO9ljz+uA9H4iR/HxDyu5NntnR0Zf8l95jq2dx6FFXe5NieiXq/UEQOf
         48fQCqRaJFj04DppSQIO38o0a2Oe6IeyF3Nvm5c3SVEjmHqqKU76aEo9BeHkKHn9IfgY
         MQCl3t9NtgKDyfikyKqRkMrFSFsFxTN2265hpuzuuySTCmHE7yWfi8Pjv74QQY1KDDBC
         YAf8SOSMTm3sPTp3MneL+dsMV6QVPsraFerMaUAtIAQYV5sFCGqa08pOM8DHSZjNrzkx
         nXqELgVWFR1DqSsluUiAb8YI2LUJgu9mze2j3AuZ+g1KoNrWWZejw9x+MGA/Yi7Ct1JO
         gNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jVBUYmys8Y9h7xIEQSBBQ9vWWYvepVJ2LQGjh1x024U=;
        b=R4NhfFD1ojajfoDMB3ABFWdn98ghSPf6RUn6eoVYe86BUQrl7Fniisn3XLvsdRRwmO
         jQnY68pR5qSkjoJiwyqYZj8d/LQwsB4obKesAGpMAMcRrIHR3EYt/QI09ISMYrFPITfz
         HegluiPjAle3Hx0cURj0iwEU/u0d7/65BKbFc/rAsK2vEbRfYRZINX27nJGnXa1G+kcN
         zhnGmzQjA13rNLTJP2fXLQ9GMo49C6cPIdQUZ4iOuyaIXaExS846sxz8SnjJg1WV6bDC
         es3G1ZH+nmTxZwnhcRHexNcxBurcb706aJF+CdjQ021MJ/uOeaASU96RYdOVgmIjWClL
         Mxcw==
X-Gm-Message-State: AIVw112CMrjDqWCFBnW8PqMW2U0Wfk4EA/zibZHBpQZbU79Q9qMdbgb/
        Q4CQfS4eS3AXzuG5JPqgVWdpkeLblBA6
X-Received: by 10.99.149.83 with SMTP id t19mr10904285pgn.247.1499975815255;
 Thu, 13 Jul 2017 12:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 12:56:54 -0700 (PDT)
In-Reply-To: <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 12:56:54 -0700
Message-ID: <CAGZ79kbY_t=Xtpb7fy0sZ9TWOy-UOUx8X5+_qLx60Dtg48Ok-g@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:32 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 12, 2017 at 05:17:58PM -0700, Shawn Pearce wrote:
>
>> We've been having scaling problems with insane number of references
>> (>866k), so I started thinking a lot about improving ref storage.
>>
>> I've written a simple approach, and implemented it in JGit.
>> Performance is promising:
>>
>>   - 62M packed-refs compresses to 27M
>>   - 42.3 usec lookup
>
> Exciting. I'd love for us to have a simple-ish on-disk structure that
> scales well and doesn't involve a dependency on a third-party database
> structure.
>
> Let me see what holes I can poke in your proposal, though. :)
>
>> ### Problem statement
>>
>> Some repositories contain a lot of references (e.g.  android at 866k,
>> rails at 31k).  The existing packed-refs format takes up a lot of
>> space (e.g.  62M), and does not scale with additional references.
>> Lookup of a single reference requires linearly scanning the file.
>
> I think the linear scan is actually an implementation short-coming. Even
> though the records aren't fixed-length, the fact that newlines can only
> appear as end-of-record is sufficient to mmap and binary search a
> packed-refs file (you just have to backtrack a little when you land in
> the middle of a record).

Except that a record is a "delta" to the previous record, so it's not
just finding a record, but reconstructing it. Example for records:

    varint( prefix_length )
    varint( (suffix_length << 2) | type )
    suffix
    value?

First record:

 0,
 16 << 2 | 0x01,
  "refs/heads/maint"
  08f9c32463bf9e578acb7ac5f77afd36e803c6bc

next record (refs/heads/master):

  13
  4 << 2 | 0x01
  "ster",
  80145b1e412719c960036c8c62a9e35dd23a5b2d

Now if you found the second one, you cannot reconstruct its
real name (refs/heads/master) without knowing the name
of the first. The name of the first is easy because the prefix_length
is 0. If it also had a prefix length != 0 you'd have to go back more.


>> - Occupy less disk space for large repositories.
>
> Good goal.  Just to play devil's advocate, the simplest way to do that
> with the current code would be to gzip packed-refs (and/or store sha1s
> as binary). That works against the "mmap and binary search" plan,
> though. :)

Given the compression by delta-ing the name to the previous change and
the fact that Gerrit has

  refs/heads/changes/1
  refs/heads/changes/2
  refs/heads/changes/3
  ...

I think this format would trump a "dumb" zip.
(Github having sequentially numbered pull requests would also
benefit here)

>> ## File format
>
> OK, let me try to summarize to see if I understand.

When Shawn presented the proposal, a couple of colleagues here
were as excited as I was, but the daring question is, why Shawn
did not give the whole thing in BNF format from top down:

  initial-block
  content-blocks*
  (index-block)
  footer

> The reftable file is a sequence of blocks, each of which contains a
> finite set of heavily-compressed refs. You have to read each block
> sequentially,

Each block may have restarting points, that allow for intra-block
binary search.

> but since they're a fixed size, that's still a
> constant-time operation (I'm ignoring the "restarts" thing for now). You
> find the right block by reading the index.

or by reading the footer at the end. If the footer and the index differ
in block size (one bit flipped), we can ask the CRC of the footer
for more guidance.

>  So lookup really is more
> like O(block_size * log(n/block_size)), but block_size being a constant,
> it drops out to O(log n).

There is also an index block such that you can binary search across
blocks, so

O( log(block_count) + log(intra_block_restarting_points) + small linear scan)

There are 2 binary searches, and the block size is an interesting
thing to look at when making up trade offs.
