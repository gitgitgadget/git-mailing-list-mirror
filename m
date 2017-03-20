Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CFC20958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbdCTWUs (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:20:48 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63479 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755257AbdCTWUq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 18:20:46 -0400
X-AuditID: 12074414-807ff70000002bfd-ab-58d055bcbf82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.65.11261.CB550D85; Mon, 20 Mar 2017 18:20:44 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KMKfmf030910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 18:20:42 -0400
Subject: Re: [PATCH 04/20] refs_verify_refname_available(): implement once for
 all backends
To:     Jeff King <peff@peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <22abd274bfdada94b3654a811ee209822640765f.1490026594.git.mhagger@alum.mit.edu>
 <20170320174240.gykldqzbqyva6kbs@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <6ff4a9f9-23a5-89c9-f478-00449132d410@alum.mit.edu>
Date:   Mon, 20 Mar 2017 23:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170320174240.gykldqzbqyva6kbs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqLsn9EKEwZJ+LYuuK91MFg29V5gt
        ljx8zWzRPeUto8WPlh5mB1aPnbPusnt0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mr6v2sVWcEqy4taXvWwNjKtFuhg5OSQETCTO3zrF2MXIxSEksINJ4sar9WwQzgUmiWX3
        F7GAVAkLxEosOjOZFcQWEZCV+H54I1THIUaJ3ZOaWUAcZoHtjBIvby5gB6liE9CVWNTTzARi
        8wrYSyz885IZxGYRUJVYcPsx2CRRgRCJOQsfMELUCEqcnPkEbBungIvEioY2NhCbWUBd4s+8
        S8wQtrzE9rdzmCcw8s9C0jILSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVm
        luilppRuYoSEs8gOxiMn5Q4xCnAwKvHwrrhyPkKINbGsuDL3EKMkB5OSKG+V74UIIb6k/JTK
        jMTijPii0pzUYqDfOZiVRHhrPYByvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotg
        sjIcHEoSvAtCgBoFi1LTUyvSMnNKENJMHJwgw3mAhv8IBhleXJCYW5yZDpE/xagoJc5rCdIs
        AJLIKM2D64Wlm1eM4kCvCPOeBKniAaYquO5XQIOZgAYvu3EGZHBJIkJKqoFxbZKOcNiiF7vr
        M8/c//X1153vwl+j+UpmzjVfIx9raZSzn7mat8xAcqupxpHqAwrvdqf57Cv+/M4iYfEyKVnT
        fR8P1LXJbGl4KnZSYrH4z2MPmUUPP2cKFHyxd3uX3lPDeycL74mHvf71oHVHz9Tv5778ThLd
        dbIlYDF/e9o1nvlMZWbbmLRvKLEUZyQaajEXFScCABKeFGISAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20/2017 06:42 PM, Jeff King wrote:
> On Mon, Mar 20, 2017 at 05:33:09PM +0100, Michael Haggerty wrote:
> 
>> It turns out that we can now implement
>> `refs_verify_refname_available()` based on the other virtual
>> functions, so there is no need for it to be defined at the backend
>> level. Instead, define it once in `refs.c` and remove the
>> `files_backend` definition.
> 
> Does this mean that backends can no longer provide storage for
> D/F-conflicted refnames (i.e., "refs/foo" and "refs/foo/bar")? It looks
> like the global verify_refname_available() has that logic baked in.

The `verify_refname_available()` function implements the "no D/F
conflict" policy. But it's called from the backends, not from the common
code, and nobody says that a backend needs to call the function.

> [...]
>>  int refs_verify_refname_available(struct ref_store *refs,
>>  				  const char *refname,
>> -				  const struct string_list *extra,
>> +				  const struct string_list *extras,
>>  				  const struct string_list *skip,
>>  				  struct strbuf *err)
>>  {
>> [...]
>> +		/*
>> +		 * We are still at a leading dir of the refname (e.g.,
>> +		 * "refs/foo"; if there is a reference with that name,
>> +		 * it is a conflict, *unless* it is in skip.
>> +		 */
>> +		if (skip && string_list_has_string(skip, dirname.buf))
>> +			continue;
>> +
>> +		if (!refs_read_raw_ref(refs, dirname.buf, oid.hash, &referent, &type)) {
>> +			strbuf_addf(err, "'%s' exists; cannot create '%s'",
>> +				    dirname.buf, refname);
>> +			goto cleanup;
>> +		}
> 
> We don't really care about reading the ref value here; we just care if
> it exists. Does that matter for efficiency (e.g., for the files backend
> it's a stat() versus an open/read/close)? I guess the difference only
> matters when it _does_ exist, which is the uncommon error case.

Yes, I assume that the conflict cases are unusual so I wasn't worrying
too much about their performance.

Not quite so obvious is that the new code sometimes checks for conflicts
against both loose and packed references in situations where the old
code only checked against packed references. Specifically, this happens
when the code has just read, or locked, or failed to find a loose
reference, so it could infer that there are no loose references that
could conflict. I don't think that will be noticeable, because it is the
reading of the whole `packed-refs` file that is a big expensive
operation that it is important to avoid. Anyway, later patches (i.e.,
after there is a `packed_ref_store`) can switch back to checking only
packed references and get back the old optimization.

> (Also, I suspect the loose ref cache always just reads everything in the
> current code, though with the iterator approach in theory we could stop
> doing that).

The loose ref cache reads directories into the cache lazily,
breadth-first. So it reads all of the entries in the directories leading
to the reference being looked up, but no others. When iterating, it
reads the parent directories of the prefix that is being iterated over
plus the whole subtree under the prefix, and that's it (though this
optimization is not yet wired through to `git for-each-ref`).

Michael

