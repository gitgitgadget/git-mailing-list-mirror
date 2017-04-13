Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B153620960
	for <e@80x24.org>; Thu, 13 Apr 2017 20:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755733AbdDMUM7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 16:12:59 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35706 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755416AbdDMUM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 16:12:58 -0400
Received: by mail-pf0-f181.google.com with SMTP id i5so32970614pfc.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=a5eDKkhwuXTWUaklr8FEpWRzRf9P+zaGX63sEDetJpc=;
        b=hWVxTv+TA7uKXPpsE0DoIy0V3wzcYzTLLuYYHGfKVczOxuMuAL+zeOQGXF4Q6pgwao
         hwcT0qVr+G9XtkUM81YPHPse9fe5J9U+yKeNn9vpAIBkCpA9i9IpUfOwCbaxuGTndLs2
         6hqd16JIcgSlygU/df5+uCabmVJkKSmVVHxiVzvw7VLQPQGrWtbcjUa1w3HryRbwtUq1
         i/wvTGgJ62yoRZXpKG9hV7fCSlHi3CR7hSwchJ+sMznh6unG1Dc4o9kNBteEKiMzIfI+
         wPrkylc0sCYtxNkd364fpTGcWlefbAufkzrtal53c0pv1gSklsybaSdUivabqPQstxrK
         SxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=a5eDKkhwuXTWUaklr8FEpWRzRf9P+zaGX63sEDetJpc=;
        b=UyQty9YYGiGVGuwCIhEWsrQK2UXts+2mFLxK5vNE5c7whgF7V59D/14AvJlUwfJIiq
         8Ib9jNPGaUujoTDy9z9eL0Iqb7RXEM3n+9L+aE1PkgGsRatC9VSAv6X5AoelP/Pfxvrj
         YZ4/k2J7iy82S/gx126U4QC3eoEGhQcTXO/FhlillqR2uiQbs2Q0PK+pkVJ7DDToCAUM
         FfD49ZFFGmT2DkFvrPnHxdtyYrSCguQKCgmJ11wj7YdQSbWZTcivrdmXTGSsGE8RhnXU
         kBjshsu1srmDVjZqbRHL0jhw3jkv9E5UMNLnGb14y+Yve/uKOkzdfXaoZOernl0Fidtu
         Iz9Q==
X-Gm-Message-State: AN3rC/7b1L4d8jjDjyM1EBXxtMhl7Ia6xqVLP+EAJbHqATuR4tGM9y0m
        HkKqWhhPw7Jk1nAq
X-Received: by 10.99.44.140 with SMTP id s134mr4306599pgs.178.1492114377245;
        Thu, 13 Apr 2017 13:12:57 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:ccfa:7153:b6a9:3bd0])
        by smtp.gmail.com with ESMTPSA id v8sm28356180pfd.108.2017.04.13.13.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2017 13:12:55 -0700 (PDT)
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
To:     Kevin David <Kevin.David@microsoft.com>,
        Ben Peart <peartben@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
 <CAGZ79ka-YaF5dBXJmhXsfwwrwSBy0tkun0yDysG581E0mpqDVw@mail.gmail.com>
 <00bf01d2aed7$b13492a0$139db7e0$@gmail.com>
 <BY2PR21MB0052067C2CDC6F727CCB6969EE030@BY2PR21MB0052.namprd21.prod.outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <18ebcd04-4765-bdc7-3880-b0e8cb90d35c@google.com>
Date:   Thu, 13 Apr 2017 13:12:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <BY2PR21MB0052067C2CDC6F727CCB6969EE030@BY2PR21MB0052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/12/2017 03:02 PM, Kevin David wrote:
> Hi Jonathan,
>
> I work on the network protocols for the GVFS project at Microsoft.
> I shared a couple thoughts and questions below.

Thanks for your reply!

> I know we're considering server behavior here, but how large do you generally
> expect these blob-want requests to be? I ask because we took an initial approach
> very similar to this, however, we had a hard time being clever about figuring out
> what set of blobs to request for those clients that didn't want the entire set, and
> ended up falling back to single-blob requests.
>
> Obviously, this could be due to thenature of our filesystem-virtualization-based client,
> but I also suspect that the teams attacking this problem are more often than not dealing
> with very large blob objects, so the cost of a round-trip becomes lower relative to sending
> the object content itself.

I am envisioning (1a) as described in Jeff Hostetler's e-mail [1] ("a 
pre-command or hook to identify needed blobs and pre-fetch them before 
allowing the actual command to start"), so a Git command would typically 
make a single request that contains all the blobs required, but my 
proposal can also handle (1c) ('"fault" them in as necessary in 
read_object() while the command is running and without any pre-fetch 
(either synchronously or asynchronously and with/without a helper 
process)').

Even if we decided to go with single-blob requests and responses, it is 
still important to send them as packfiles, so that the server can serve 
them directly from its compressed storage without first having to 
uncompress them.

[1] 
https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/

> Along the same lines as above, this is where we started and it worked well for
> low-volume requests. However, when we started ramping up the load,
> `pack-objects` operating on a very large packed repository (~150 GiB) became
> very computationally expensive, even with `--compression=1 --depth=0 --window=0`.
>
> Being a bit more clever about packing objects (e.g. splitting blobs out from commits
> and trees) improved this a bit, but we still hit a bottlenecks from what appeared to
> be a large number of memory-mapping operations on a ~140GiB packfile of blobs.
>
> Each `pack-objects` process would consume approximately one CPU core for the
> duration of the request. It's possible that further splitting of these large blob packs
> would have improved performance in some scenarios, but that would increase the
> amount of pack-index lookups necessary to find a single object.

I'm not very experienced with mmap, but I thought that memory-mapping a 
large file in itself does not incur much of a performance penalty (if 
any) - it is the accesses that count. I experimented with 15,000 and 
150,000 MiB files and mmap and they seem to be handled quite well. Also, 
how many objects are "pack-objects" packing here?

>> === Endpoint support for forward compatibility
>>
>> This "server" endpoint requires that the first line be understood, but
>> will ignore any other lines starting with words that it does not
>> understand. This allows new "commands" to be added (distinguished by
>> their first lines) and existing commands to be "upgraded" with backwards compatibility.
>
> This seems like a clever way to avoid the canonical `/info/refs?service=git-upload-pack`
> capability negotiation on every call. However, using error handling to fallback seems
> slightly wonky to me. Hopefully users are incentivized to upgrade their clients.

By "error handling to fallback", do you mean in my proposal or in a 
possible future one (assuming my proposal is implemented)? I don't think 
my proposal requires any error handling to fallback (since only new 
clients can clone partially - old clients will just clone totally and 
obliviously), but I acknowledge that this proposal does not mean that 
any future proposal can be done without requiring error handling to 
fallback.

>> === Indication to use the proposed endpoint
>>
>> The client will probably already record that at least one of its
>> remotes (the one that it successfully performed a "partial clone"
>> from) supports this new endpoint (if not, it can’t determine whether a
>> missing blob was caused by repo corruption or by the "partial clone").
>> This knowledge can be used both to know that the server supports
>> "fetch-blob-pack" and "fetch-commit-pack" (for the latter, the client
>> can fall back to "fetch-pack"/"upload-pack" when fetching from other servers).
>
> This makes a lot of sense to me. When we built our caching proxy, we had to be careful
> when designing how we'd handle clients requesting objects missing from the proxy.
>
> For example, a client requests a single blob and the proxy doesn't have it - we can't simply
> download that object from the "authoritative" remote and stick it in the `.git\objects\xx\yyy...`
> directory, because the repository would be made corrupt.

By proxy, do you mean a Git repository? Sorry, I don't really understand 
this part.

> Having a way to specify that the repo is a "partial clone" and allowing "holes" would help a lot,
> I believe. I know there have been varying opinions on how these missing objects should be
> "marked" and I'm not ready to propose anything there - just agreeing the problem is important.

Agreed.

> Not do derail us too far off blobs, but I wonder if we need a `fetch-commit-pack` endpoint,
> or could get away with introducing a new capability (e.g. `no-blobs`) to `upload-pack` instead.
> As a casual observer, this seems like it would be a much smaller change since the rest of the
> negotiation/reachability calculation would look the same, right? Or would this `fetch-commit-pack`
> not return trees either?
>
> I only ask because, in our observations, when git wants to read commits it's
> usually followed by a lot of "related" trees - again caveated with the fact that
> we're intercepting many things at the filesystem layer.

The main reason for this extra command is not to exclude blobs (which, 
as you said, can be done with a new capability - I suspect that we will 
need a capability or parameter of some sort anyway to indicate which 
size of blobs to filter out) but to eliminate the mandatory ref 
advertisement that is done whenever the client fetches. One of our use 
cases (internal Android) has large blobs and many (more than 700k) refs, 
so it would benefit greatly from blob filtering and elimination of the 
mandatory ref advertisement (tens of megabytes per fetch).

As for the size of the change, I have a work in progress that implements 
this [2].

[2] 
https://public-inbox.org/git/cover.1491851452.git.jonathantanmy@google.com/

> Just to keep the discussion interesting, I'll throw an alternative out there that's
> worked well for us. As I understand it, the HTTP-based dumb transfer protocol
> supports returning objects in loose object format, but only if they already exist
> in loose format.
>
> Extending this to have the remote provide these objects via a "dumb" protocol
> when they are packed as well - i.e. the server would "loosens" them upon request -
> is basically what we do and it works quite well for low-latency clients. To further improve
> performance at the cost of complexity, we've added caching at the memory and disk layer
> for these loose objects in the same format we send to the client.
>
> There's a clear tradeoff here - the servers must have adequate disk and/or memory to store
> these loose objects in optimal format. In addition, the higher the latency is to the remote,
> the worse this solution will perform. Fortunately, in our case, network topology allows us to
> put these caching proxies close enough to clients for it not to matter.

This does make sense in the situation you describe, but (as you said) I 
don't think we can guarantee this in the majority of situations. I think 
some sort of batching (like the (1a) solution I talked about near the 
start of this e-mail) and serving packed data from packed storage should 
form the baseline, and any situation-specific optimizations (e.g. 
serving unpacked data from topologically-close servers) can be 
additional steps.
