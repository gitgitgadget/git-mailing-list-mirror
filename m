Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4527D207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 22:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032204AbdDZWvh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 18:51:37 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36595 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031904AbdDZWvf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 18:51:35 -0400
Received: by mail-pf0-f170.google.com with SMTP id 194so7511412pfv.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E2He40rWXJmxkS7VVdq6PYIb8b6KVtwukVrln7S0CUQ=;
        b=SwW5mL0VLEcyqU1xa5SB/2sMzzfA7/JVjgbSpbJwdRd46u2WWBGGBg2B3JkDJT+qxX
         5e0MR8wlRtElEdt430lnP41MYX3yFfSqrrA10cUevnsbh9qiHEyKFIuds/gxFEuwmKF7
         onz1vzd0MmG18G12pjevGMhIsL2ssLuATftwZzsF/FXZlBCqVBmvx2IihtATQLejz9kz
         gPJ5liF+s+gYRF653O9LvoAAvOmQKE6IvTQV/yjs4qMTL29KkvDq89b7jx6YXEwkBmd+
         xEpiUIlk7fagru1VSfOgA+lsUmtmtcatLYKHwk4rCWrL6nonCt7Iokz6s4UW+2LOj9sx
         0YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E2He40rWXJmxkS7VVdq6PYIb8b6KVtwukVrln7S0CUQ=;
        b=gEzrUvXiBzkdLolQMWXB4pLfeFuJ//NtJPGn9nFQxwWTuYl/RQHxokajQiyFPpvzpA
         W3srVMiW/DIIEGH6GPi3ZPG3Ez8hC/Zvu4GNm3Db6COwuqXXhf7SfPeFj8D8ihiF2ykp
         /R/ZMHpsMrR7Je2i1WG6feGkV9Cj5maNGtLL+1jawwOY2UauMyu4nrtysxl+QOYW7qEO
         AomtEfgaUGF2iCSg40/p/Oa0bGb+lqzBNZSKB9BQsCa2hZF/g04R9zbFp+mrJC0mkzZF
         hzRBO1dy0ewsXQlhlOIcWPhcfsutYr5+H/g5IxLhDhAk51Jgn/gu/TcLuqxSwJngQGzz
         fxdA==
X-Gm-Message-State: AN3rC/5OGX7O5MUt4qtmtGQPNTteV4UOyVbt7kivVyqdbcbytdhJ41J3
        Tqyq32N5PzXFI02z
X-Received: by 10.84.168.131 with SMTP id f3mr2938664plb.160.1493247094156;
        Wed, 26 Apr 2017 15:51:34 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:41b4:1b86:df1e:5e66])
        by smtp.gmail.com with ESMTPSA id v63sm510775pfb.104.2017.04.26.15.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 15:51:32 -0700 (PDT)
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
To:     Kevin David <Kevin.David@microsoft.com>,
        Ben Peart <peartben@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
 <CAGZ79ka-YaF5dBXJmhXsfwwrwSBy0tkun0yDysG581E0mpqDVw@mail.gmail.com>
 <00bf01d2aed7$b13492a0$139db7e0$@gmail.com>
 <BY2PR21MB0052067C2CDC6F727CCB6969EE030@BY2PR21MB0052.namprd21.prod.outlook.com>
 <18ebcd04-4765-bdc7-3880-b0e8cb90d35c@google.com>
 <CY4PR21MB05047397A12B8692C923FC67EE1A0@CY4PR21MB0504.namprd21.prod.outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <e9f18a53-c4cc-9927-7579-03d88a9169cd@google.com>
Date:   Wed, 26 Apr 2017 15:51:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB05047397A12B8692C923FC67EE1A0@CY4PR21MB0504.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/21/2017 09:41 AM, Kevin David wrote:
> Hi Jonathan,
>
> Sorry for the delayed response - other work got in the way, unfortunately!

No worries!

>> I am envisioning (1a) as described in Jeff Hostetler's e-mail [1] ("a
>> pre-command or hook to identify needed blobs and pre-fetch them before
>> allowing the actual command to start"), so a Git command would typically
>> make a single request that contains all the blobs required, but my
>> proposal can also handle (1c) ('"fault" them in as necessary in
>> read_object() while the command is running and without any pre-fetch
>> (either synchronously or asynchronously and with/without a helper
>> process)').
>>
>> Even if we decided to go with single-blob requests and responses, it is
>> still important to send them as packfiles, so that the server can serve
>> them directly from its compressed storage without first having to
>> uncompress them.
>>
>> [1] https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/
>
> Ah, I missed this. If we think we can build meaningfully-sized requests via (1a) and (1b),
> then I agree - packs are optimal.
>
> However, if single-blob requests/responses dominate, I have a few concerns, mostly from
> experience playing with something similar:
> * Regardless of the size of the object or number returned, the client will need to
>   `index-pack` the result and create a corresponding `.idx` file, which requires
>   decompression to construct (right?)

Yes, although I think that loose objects would need to be decompressed 
too to verify the SHA-1.

> * Unless the client's repository is repacked aggressively, we'll pollute the
>   `.git\objects\pack` directory with little indexes (somewhere around 4KiB minimum)
>   and packfiles rapidly, which would degrade performance. One rudimentary workaround
>   would be to loosen these packs on the client if they were under a certain
>   size/object count. I think fetch does this already?
>
> In either case, shifting the pack decompression/loose object recompression problem
> to the client instead of the server is probably a good principle, but in our case it
> simply wasn't fast enough to serve single blobs interactively (e.g. opening a source
> file you don't have locally). I'm hopeful that the proposed partial clone solutions you
> referenced would reduce the frequency of this being required.

I wrote up a proposal for how Git should handle missing blobs, including 
a hook that, when invoked, is allowed to write packed or loose objects 
[1]. I was thinking along similar lines too about the many-packfile 
issue, and that was part of the reason why [1] was written the way it is.

I think that, by default, the wire protocol should transmit packs 
because it causes less load on the server (as you describe) and it 
supports batch requests. Also, this protocol with single-blob fetching 
might be usable as-is for projects that only exclude large blobs (so 
there are relatively few of them), and will be more and more usable as 
we migrate the more commonly used Git commands to provide batch 
requests. However, the ability to customize the hook allows users to use 
another download scheme more suited to their use cases (for example, in 
yours, where you can provision servers that are topologically close to 
your clients).

[1] <20170426221346.25337-1-jonathantanmy@google.com>

>>> Being a bit more clever about packing objects (e.g. splitting blobs out from commits
>>> and trees) improved this a bit, but we still hit a bottlenecks from what appeared to
>>> be a large number of memory-mapping operations on a ~140GiB packfile of blobs.
>>>
>>> Each `pack-objects` process would consume approximately one CPU core for the
>>> duration of the request. It's possible that further splitting of these large blob packs
>>> would have improved performance in some scenarios, but that would increase the
>>> amount of pack-index lookups necessary to find a single object.
>>
>> I'm not very experienced with mmap, but I thought that memory-mapping a
>> large file in itself does not incur much of a performance penalty (if
>> any) - it is the accesses that count. I experimented with 15,000 and
>> 150,000 MiB files and mmap and they seem to be handled quite well. Also,
>> how many objects are "pack-objects" packing here?
>
> Back when we took this approach, it was ~4000 blob objects at a time.
> Perhaps we were being bitten by the Windows implementation of git_mmap[3]?.
> When I profiled the 4k blob scenario, the majority of CPU and wall time was
> spent in MapViewOfFileEx, which looks like it could mean accesses as well.
>
> [3] https://github.com/git/git/blob/master/compat/win32mmap.c

Hmm...I don't have much experience with this, but this may be something 
to keep in mind.

>>> This seems like a clever way to avoid the canonical `/info/refs?service=git-upload-pack`
>>> capability negotiation on every call. However, using error handling to fallback seems
>>> slightly wonky to me. Hopefully users are incentivized to upgrade their clients.
>>
>> By "error handling to fallback", do you mean in my proposal or in a
>> possible future one (assuming my proposal is implemented)? I don't think
>> my proposal requires any error handling to fallback (since only new
>> clients can clone partially - old clients will just clone totally and
>> obliviously), but I acknowledge that this proposal does not mean that
>> any future proposal can be done without requiring error handling to
>> fallback.
>
> Right, I was talking about the possible future one - more around the
> concept of back-compat in the event of any protocol changes. I don't want
> to spend too much time focusing on what we might want in the future, but a
> thought I just had: what about versioning as a part of the URL? For example,
> `/server-endpoint?version=1.0`. This could also enable breaking changes for
> existing commands.

That could work, although we could put a version number in the command 
name (e.g. "fetch-any-blob-2") too.

> Ah, interesting. We solved the many-refs problem using a different approach -
> basically, limiting what the server returns based on who the user is and preferences
> they set via our web interface or an API. I've been promised by a few colleagues that
> we'll have more to share here soon... With your proposal, how does the client choose
> which refs they want to fetch?

The "want" lines can now take names (including glob characters). A list 
of refs (names and hashes) that correspond to those "want"s will be 
returned by the server right before the packfile.

(So the client doesn't "choose" in the sense that it has a list of 
options and it picks a subset of them - it chooses by sending one or 
more strings that the server will match.)

> I took a look at look at your patch series. I'm nowhere near qualified to give feedback
> given my lack of experience with the core git implementation and C in general, but it
> looks reasonable. Hoping we can come up with a better name than "server-endpoint" though :)

Thanks, and I'm open to suggestions for the name. :-)

>>> Just to keep the discussion interesting, I'll throw an alternative out there that's
>>> worked well for us. As I understand it, the HTTP-based dumb transfer protocol
>>> supports returning objects in loose object format, but only if they already exist
>>> in loose format.
>>>
>>> Extending this to have the remote provide these objects via a "dumb" protocol
>>> when they are packed as well - i.e. the server would "loosens" them upon request -
>>> is basically what we do and it works quite well for low-latency clients. To further improve
>>> performance at the cost of complexity, we've added caching at the memory and disk layer
>>> for these loose objects in the same format we send to the client.
>>>
>>> There's a clear tradeoff here - the servers must have adequate disk and/or memory to store
>>> these loose objects in optimal format. In addition, the higher the latency is to the remote,
>>> the worse this solution will perform. Fortunately, in our case, network topology allows us to
>>> put these caching proxies close enough to clients for it not to matter.
>>
>> This does make sense in the situation you describe, but (as you said) I
>> don't think we can guarantee this in the majority of situations. I think
>> some sort of batching (like the (1a) solution I talked about near the
>> start of this e-mail) and serving packed data from packed storage should
>> form the baseline, and any situation-specific optimizations (e.g.
>> serving unpacked data from topologically-close servers) can be
>> additional steps.
>
> Agreed - our choice of solution was largely driven by our lack of ability to batch,
> performance issues with `pack-objects` at scale, and ability to deploy the
> previously-mentioned proxies very close to clients. If we can solve the first
> problem (batching), optimizing for the hopefully-less-common single blob at a time
> scenario becomes less important. If we assume that happens, I think your proposal
> looks sound overall.

Thanks.
