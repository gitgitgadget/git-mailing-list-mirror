Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2790A20401
	for <e@80x24.org>; Sun, 18 Jun 2017 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdFRM7V (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 08:59:21 -0400
Received: from mout.web.de ([212.227.15.3]:51782 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbdFRM7U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 08:59:20 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hsk-1denCO25BW-00urO8; Sun, 18
 Jun 2017 14:59:06 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
 <20170618114923.bffmbr5dqe4oivyw@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <96c26ba2-8548-1693-e803-3a3434ae3a62@web.de>
Date:   Sun, 18 Jun 2017 14:59:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170618114923.bffmbr5dqe4oivyw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:he/lnN9y7sAT5w1g5meORcyNMiQAUGVWcSxuhbglhjQqXAcGxph
 dVfx7xBLfmb9liYD1a8Fhq22jadsjpTchp7m9cKO8BFOThAwZ5FqKiGxkqI7JTw7Vck9MUB
 BVchkmJ14XzNewTcsL1hVVaf/qboFKXD2vvPqfnwPCDcA7Dge8ifLQJWXEULxP/elJBDwAD
 PQEC+A8pZtRnzk4gNzuxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hdBCkG84gSM=:RXLCigt3ULSGsnYJkfGCKQ
 oNoq1Pas8XYIrIjid1qrsbh9Qz8PLkU9v/+lPed33IRsDWvbSmYSeE5YUM9rCHFcObt5x1Rl7
 ot6h50Bh+l2xyLrVyutXM7bmOJpJ586PuE0XoG3EC46wT1k81M+dBexTy3RO8lE9xxkkxKJgT
 pl4zrwrm02Wk8EQ+zW6XL7yHDWWcbvET7glA7BIKHwXVPdLPtwQbudZk5+vQcz/uhv+t00g+b
 Z1TlaSSWMfJYKSvK3kBv/QrbDaiNi2ErBkNjo1JXSdoI6MVhG5FUskQ0iDqZTvLXefJ3V9kKM
 zAIGCN/PTBkvIrZUUCr7BZ88VN047ikKOxj6SIGxWBXrh+Da0E63tD6Dqn6tEptl3tQR4V/l3
 jaf5dFYEfVkct/ODXUB9mHo801n+kIw7BUykvSdgneSNd9CLxexrNDQGfBxMZBbzTwj1Hl9S/
 D63QX4ZA/6Lcs5aQDL1POzGwjs6bBmx9KtHsLk2LF5VgOrawZtF0T8kk7wZ2/7XpUX3hum31i
 XwhPwTqqKehcmxyy+eaL4MzNqfOq58jcUi9yWEtMJNUuuAkcre+yOUt13Z/tN+HxCKrOloYGn
 gBSTwD4Vsy6JSYIsk1lGFijzsMuMbp7TyWv9aOCrhmCj7P6nMWS057CvPTQC6506k/dT5Y7ib
 Se5ePj6NKkesiJGFzhNcZPAt5/EN2cWTFwaS8ou+rXShQISnFMoZ4gpyhZ8bIIX1TLiKUTkVb
 582F7wtAS7tyfrQrtO0LSDEZT1mlSojhWXMlZK2azOIzWqsqsXYOWWiw9w2kAxC+8bWzcS6dC
 ZTegQKl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.06.2017 um 13:49 schrieb Jeff King:
> On Sun, Jun 18, 2017 at 12:58:37PM +0200, René Scharfe wrote:
> 
>> An oid_array spends ca. 30 bytes per entry (20 bytes for a hash times
>> a factor of 1.5 from alloc_nr).  How many loose objects do we have to
>> expect?  30 MB for a million of them sounds not too bad, but can there
>> realistically be orders of magnitude more?
> 
> Good point. We gc by default at 6000 loose objects, and lots of thing
> will suffer poor performance by the time you hit a million. So a little
> extra space is probably not worth worrying about.
> 
>> So here's a patch for caching loose object hashes in an oid_array
>> without a way to invalidate or release the cache.  It uses a single
>> oid_array for simplicity, but reads each subdirectory individually and
>> remembers that fact using a bitmap.
> 
> I like the direction of this very much.
> 
>> @@ -1586,6 +1587,9 @@ extern struct alternate_object_database {
>>   	struct strbuf scratch;
>>   	size_t base_len;
>>   
>> +	uint32_t loose_objects_subdir_bitmap[8];
> 
> Is it worth the complexity of having an actual bitmap and not just an
> array of char? I guess it's not _that_ complex to access the bits, but
> there are a lot of magic numbers involved.

That would be 224 bytes more per alternate_object_database, and we'd
gain simpler code.  Hmm.  We could add some bitmap helper macros, but
you're probably right that the first version should use the simplest
form for representing small bitmaps that we currently have.

>> +	struct oid_array loose_objects_cache;
> 
> We should probably insert a comment here warning that the cache may go
> out of date during the process run, and should only be used when that's
> an acceptable tradeoff.

Then we need to offer a way for opting out.  Through a global variable?
(I'd rather reduce their number, but don't see how allow programs to
nicely toggle this cache otherwise.)

>> +static void read_loose_object_subdir(struct alternate_object_database *alt,
>> +				     int subdir_nr)
> 
> I think it's nice to pull this out into a helper function. I do wonder
> if it should just be reusing for_each_loose_file_in_objdir(). You'd just
> need to expose the in_obj_subdir() variant publicly.
> 
> It does do slightly more than we need (for the callbacks it actually
> builds the filename), but I doubt memcpy()ing a few bytes would be
> measurable.

Good point.  The function also copies the common first two hex digits
for each entry.  But all that extra work is certainly dwarfed by the
readdir calls.

René
