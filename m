Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B87D202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 10:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbdIHKCu (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 06:02:50 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55688 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751654AbdIHKCs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 06:02:48 -0400
X-AuditID: 12074411-f7dff70000007f0a-a0-59b26ac7f816
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 24.50.32522.7CA62B95; Fri,  8 Sep 2017 06:02:47 -0400 (EDT)
Received: from [192.168.69.190] (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88A2iT9024468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 06:02:45 -0400
Subject: Re: [PATCH 01/10] packed-backend: don't adjust the reference count on
 lock/unlock
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <c5d66cadb70efdb5b5ce91fbcc5673621f5d4792.1503993268.git.mhagger@alum.mit.edu>
 <20170908065223.f7f52hjcx5qsjbch@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d49a7b75-66d4-7c63-d260-71c7413b3571@alum.mit.edu>
Date:   Fri, 8 Sep 2017 12:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170908065223.f7f52hjcx5qsjbch@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqHs8a1Okwcdb0hZrn91hsni+/gS7
        RdeVbiaLht4rzBbdU94yWvxo6WG22Ly5ncWB3WPnrLvsHgs2lXo8693D6HHxkrLH501yAaxR
        XDYpqTmZZalF+nYJXBlrbnaxFKxUrFh//Ah7A+NxqS5GTg4JAROJz9uvMXUxcnEICexgkpix
        ZB0bhHOeSeLl7D9MIFXCAjES1x89YAaxRQRkJb4f3sgIUsQssIVJ4t3cDnaIjkOMEouf7WYF
        qWIT0JVY1NMM1s0rYC8xffVpoLEcHCwCKhKbzzmAhEUFIiT63l5mhygRlDg58wkLiM0p4CJx
        ce4ZNhCbWUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUmIWkfRaSlllIWmYhaVnAyLKKUS4x
        pzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyQeBHcwzjgpd4hRgINRiYfXInhjpBBr
        YllxZe4hRkkOJiVR3oYZQCG+pPyUyozE4oz4otKc1GJgKHAwK4nwXvTbFCnEm5JYWZValA+T
        kuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLgDQXGvZBgUWp6akVaZk4JQpqJgxNkOA/Q
        cAWQGt7igsTc4sx0iPwpRkUpcV7/TKCEAEgiozQPrheWrl4xigO9IsybAFLFA0x1cN2vgAYz
        AQ0ueb4BZHBJIkJKqoFRMtpd6KNjtOu8cDbOb3vVDugX/J0uLDZz7o7PM+YueK57WSDNc6Eu
        z/qJs+Zt6lt85ntDzZd3sso7S6+ua1+o+m+28f5P832OrzdxuPbZbfNklz1bZnRvMzhz3Hji
        w34jNc22ugn725+mnxIptgoR3jc1detH3guqEbau/d8aam9FM9nPv5qzTomlOCPRUIu5qDgR
        AGop12cyAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2017 08:52 AM, Jeff King wrote:
> On Tue, Aug 29, 2017 at 10:20:25AM +0200, Michael Haggerty wrote:
> 
>> The old code incremented the packed ref cache reference count when
>> acquiring the packed-refs lock, and decremented the count when
>> releasing the lock. This is unnecessary because a locked packed-refs
>> file cannot be changed, so there is no reason for the cache to become
>> stale.
> 
> Hmm, I thought that after your last series, we might hold the lock but
> update the packed-refs from a separate tempfile. I.e., 42dfa7ecef
> (commit_packed_refs(): use a staging file separate from the lockfile,
> 2017-06-23).
> 
>> Moreover, the extra reference count causes a problem if we
>> intentionally clear the packed refs cache, as we sometimes need to do
>> if we change the cache in anticipation of writing a change to disk,
>> but then the write to disk fails. In that case, `packed_refs_unlock()`
>> would have no easy way to find the cache whose reference count it
>> needs to decrement.
>>
>> This whole issue will soon become moot due to upcoming changes that
>> avoid changing the in-memory cache as part of updating the packed-refs
>> on disk, but this change makes that transition easier.
> 
> All of this makes sense, and I'm happy this complexity is going away in
> the long run. But I guess what I'm wondering is in the meantime if we
> can have a sequence like:
> 
>   1. We hold packed-refs.lock
> 
>   2. We update the file without releasing the lock, via 42dfa7ecef.
> 
>   3. Still holding the lock, we try to look at packed-refs. The
>      stat_validity code says no, we're not up to date.
> 
>   4. We discard the old packed_ref_cache and reload it. Because its
>      reference count was not incremented during step 1, we actually
>      free() it.
> 
>   5. We try to look at at the old freed pointer.
> 
> There are several steps in there that might be implausible. So I'm
> mostly playing devil's advocate here.
> 
> I'm wondering if the "don't validate while we hold the lock" logic in
> get_packed_refs_cache() means that step 3 is impossible.

That's one of the reasons your scenario can't happen, but that just begs
the question of whether the "don't validate while we hold the lock" code
is wrongheaded.

In fact it's OK. The method by which the packed-refs file on disk is
modified at this point in the patch series is by modifying the packed
ref-cache and then writing the data from the ref-cache to disk. So the
packed ref-cache remains fresh because any changes that we plan to make
to the file are made in the cache first anyway.

I'll explain that a bit better in the log message.

The next question is whether this change interacts badly with changes
later in the patch series, when we cease to modify the ref-cache before
writing the new packed-refs file. Here we're OK, too, because
immediately after `rename_tempfile()` is used to rename the new
packed-refs file into place, we clear the packed ref-cache, so no
subsequent callers of `get_packed_refs_cache()` should see the stale cache.

Which in turn is partly because your step 5 is also implausible: code
shouldn't be holding a pointer to the packed ref-cache across operations
that might change the file. (Code that calls `get_packed_refs_cache()`
is OK because that function would see that `refs->cache` is NULL and
reload it regardless of whether we hold the lock.)

So I think everything is OK, but thanks for making me think through and
explain it better :-)

>> @@ -560,9 +559,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>>  	 */
>>  	validate_packed_ref_cache(refs);
>>  
>> -	packed_ref_cache = get_packed_ref_cache(refs);
>> -	/* Increment the reference count to prevent it from being freed: */
>> -	acquire_packed_ref_cache(packed_ref_cache);
>> +	get_packed_ref_cache(refs);
> 
> It seems a bit funny to call a "get" function and throw away the return
> value. Presumably we care about its side effect of updating refs->cache.
> That might be worth a comment (though if this is all going away soon, I
> care a lot less about niceties like that).

I'm rerolling anyway, so I'll add a comment. Thanks.

Michael
