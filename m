Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660E01F453
	for <e@80x24.org>; Thu,  4 Oct 2018 05:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJDMsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 08:48:41 -0400
Received: from mout.web.de ([212.227.15.4]:40457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJDMsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 08:48:41 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljxc1-1faWYS2mr3-00brVr; Thu, 04
 Oct 2018 07:56:49 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljxc1-1faWYS2mr3-00brVr; Thu, 04
 Oct 2018 07:56:49 +0200
Subject: Re: [PATCH v2 2/2] oidset: use khash
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <5efe6695-2e82-786c-1170-7874978cb534@web.de>
 <20181003194051.GB20709@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d17f104e-7cc2-5e73-78c9-6c268f9ec5b2@web.de>
Date:   Thu, 4 Oct 2018 07:56:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003194051.GB20709@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K/Ww29/TX47HLoA3YXgQDWydUCSAJ/v+slB1rebyA6NYdeiiffI
 RBPe5P5/3By8HZCIwBNb3TumRFkqNQm0hS+lQpYjYZ3JiqMGq06ezm2atl+H5zoS67djEgD
 7Jy+YIMbV29xvMYNB9Iv6HouxOEdNgJmgxnFCpjOG0PMq7BmfifPY3p5qi4qzm02ZrD8NLN
 4UHDEG44vef3uw/kPknsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z+b4gOdsi04=:dAPQLdH3mg91R49btlrjCR
 v6FFidZJhmb6KSCn2374KylBTZoshoUOFVdMqLCYlQCX2pRyGMCOCHOXo8EXgIAW9a7iB0P32
 CP71zKa3oGXgNBUswXVtvejbXJivHW/Rz1OzarQAxe+If/eSrvTUb5UX7TEVACG84I49PQBdr
 RrZzxBnp7IK3h3b8A07ggmIhRNsVdb5iOY8tDpRMXVtDisytPIKrvlPVI6KEiMi9Zqa1mE5iN
 F9gYJV4ciI31K9zeVGMxZTB9TiPB+827Sfi5upv2ISMO1ULeHM+qiQ1ZPqjE7H1Us8nXTk4If
 ZQDkF6n7Pw29xzndgKjEEtCuMKgZUnY/CI9A7poj58hgA2L44JwVoWds11BTiNLvY5SV8RI3c
 NPIO6aupCsLPsiq/UF9GucwcUMwif/RCajXeF2wiARvKEV2MUQscjdP4hpZDyFV7XDuA6aBKQ
 P4plaaLiXnzHztjfIFXWZsjVlgZcKRo/GHrsJHL7IyoTfk0CTNvhz7K/fgdU+efCkoqKtthRL
 QqqRj/2SNXCrDsAFxzASBMrjfFjAq4cdkJpyZd481sIBfTwePbdRQq2XkRbN8ecuPwZ2YrMQ1
 iUG4Jl9sBAcIjzMqyIqD9uYjwh8j4AFf9o1GjWGGwe0EHF11DJ0yLTtFR/BiPGkCsXCpQiuNl
 9L4QAFlqHHEXWcWSxg2KQebwvgyezTMPjbVPbcSodwDjR5VZDaK2YvWiHXKteqKRfZySPp2nU
 WB+CdHvRk/kX7ycIOxp8ZlhYiv/oTwHYsVBrvfGMH6lUtNRl20hdnE4nPNKmgYybBDy/PiMi5
 hcUbI9Sf4hyVGQRCjrFPtgSDcFyjuYVwNFnstr1RKzDWQa5lRU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2018 um 21:40 schrieb Jeff King:
> On Wed, Oct 03, 2018 at 03:16:39PM +0200, René Scharfe wrote:
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 75047a4b2a..a839315726 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -536,7 +536,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
>>  	 * add to "newlist" between calls, the additions will always be for
>>  	 * oids that are already in the set.
>>  	 */
>> -	if (!tip_oids->map.map.tablesize) {
>> +	if (!tip_oids->set.n_buckets) {
>>  		add_refs_to_oidset(tip_oids, unmatched);
>>  		add_refs_to_oidset(tip_oids, newlist);
>>  	}
> 
> This is a little intimate with the implementation of khash, but I think
> it's probably OK (and really no worse than what was there before).
> 
> As the comment above notes, I think we're really looking at the case
> where this gets populated on the first call, but not subsequent ones. It
> might be less hacky to use a "static int initialized" here. Or if we
> want to avoid hidden globals, put the logic into filter_refs() to decide
> when to populate.

Right.  I'd prefer the latter, but was unable to find a nice way that
still populates the oidset lazily.  It's certainly worth another look,
and a separate series.

>> diff --git a/oidset.h b/oidset.h
>> index 40ec5f87fe..4b90540cd4 100644
>> --- a/oidset.h
>> +++ b/oidset.h
>> [...]
>> +KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
> 
> This will declare these "static inline". Our other major "macros become
> inline functions" code is commit-slab.h, and there we found it necessary
> to add MAYBE_UNUSED. I wonder if we ought to be doing the same here (I
> don't get any warnings, but I suspect sparse might complain).

I doubt it (but didn't check) because khash.h defines kh_clear_##name(),
which we don't use it anywhere and there have been no complaints so far.
And if we wanted to add MAYBE_UNUSED then the right place for that would
be in KHASH_INIT, no?

> It might be nice if these functions could hide inside oidset.c (and just
> declare the struct here). It looks like we might be able to do that with
> __KHASH_TYPE(), but the double-underscore implies that we're not
> supposed to. ;)
> 
> I guess we also use a few of them in our inlines here. I'm not 100% sure
> that oidset_* needs to be inlined either, but this is at least a pretty
> faithful conversion of the original.

We could inline all of the oidset functions, following the spirit of
klib/khash.h.

Or we could uninline all of them and then may be able to clean up
oidset.h by using KHASH_DECLARE.  Perhaps we'd need to guard with an
"#ifndef THIS_IS_OIDSET_C" or similar to avoid a clash with KHASH_INIT.

Not sure if any of that would be a worthwhile improvement..

René
