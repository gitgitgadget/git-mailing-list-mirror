Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6259A1FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 17:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbcJWR5v (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 13:57:51 -0400
Received: from mout.web.de ([212.227.15.14]:51623 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755229AbcJWR5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 13:57:50 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MNc1S-1c15mg3c6c-007DVA; Sun, 23 Oct 2016 19:57:32
 +0200
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
To:     Jeff King <peff@peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
 <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
Date:   Sun, 23 Oct 2016 19:57:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zOshnQqZs/lN4FdvSv2sCa27g1G5sVHrj+a0aVLWovQmrimUXbJ
 MOYt2MVi/2EqkcWGZfl0ulQbrJRxzvjoZyEeSOrFf4642SPguLbUY4uq3AMgBhNuBjVeho8
 qWtwbCeiM9bMR34Y7L8o8BVt7uQpAwuGVu0K5K70a7z7c/yA+tx4/L6pZaC8NkdKntuqvOt
 gutDPD7UiJdkBugj1jnUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CrUXG8ZV/uo=:C4Fv8xir5MpxKvAbJzWGRu
 3+/GB1Wzo4lh6jYeIsxO63EkwC5jqUCbJqmrYNrxbHUU81n6yEr/iGkkdrCh7pS8qKspA6FFV
 k5DQx7teGkAZ7rhidvN8ED2S76XdqqdPbiVp1eBMsdg65M5DkaKi4KDhamAx04ofvZkXqagQ7
 y3Shu7VfrRPnnai2q4z2MtznQxtDGvDP+AXzOgUfoMuKkm3vTjXUz513dYbGHARZtSi3vC0oY
 YOUhJ/iCfKPZnPHmBI+ZV/71B59t0mMvqY0aVwFncvx/hhDW04cC6u+K6EznHObUEiFzB7GSN
 O6E2KhDzsDaZyedAbrcFIP/9rlPaA31pH7sT0VersVBQ/Cqag7+/Z02o13gWdJKogbjKdcLDN
 QTW874RAH+BL2s/FoC77ANdavVUws+LUc2POhMSKZ6bLbQpeKU99wT82G2RbUUSL94ndjpPT5
 xqXIRC/sRdIxZPqYNyQ4Bb6lIfNKPYUqEDFIcOlUlNt/Rr+838F787iE+mJIM2Vzv5agJlikY
 X32IsisC4vK14j6/XSzhSaUQjAyU8JjRbZ1Iv+WOkThG4hT7+k3d8O7kqZCMvcCTrB4SDJhYu
 IaAkR7Buotm9qd/HsCp+U3jnU9UFuKSFMF7YdT4gb7devXMWoaIfLSLvrrSEvlsHR0V4TSC8B
 uJTiZwSj+VdqAX2B44CRIl0855uESePWoPWsAjdPJnhZp3Mqkhpuil9Slp9czSAW9Eioj+IaW
 QpaN+0sGzvKp6AG9E/W4A6m1lATijcm7x+4Be73+Dc1KyLtROscjyvomtEi8sjeyUxVJxePpZ
 SScZ1WH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.2016 um 11:11 schrieb Jeff King:
> On Sun, Oct 23, 2016 at 11:00:48AM +0200, René Scharfe wrote:
>
>> Overflow is defined for unsigned integers, but not for signed ones.
>> Make the ring buffer index in sha1_to_hex() unsigned to be on the
>> safe side.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> Hard to trigger, but probably even harder to diagnose once someone
>> somehow manages to do it on some uncommon architecture.
>
> Indeed. If we are worried about overflow, we would also want to assume
> that it wraps at a multiple of 4, but that is probably a sane
> assumption.

Hmm, I can't think of a way to violate this assumption except with 
unsigned integers that are only a single bit wide.  That would be a 
weird machine.  Are there other possibilities?

>> diff --git a/hex.c b/hex.c
>> index ab2610e..8c6c189 100644
>> --- a/hex.c
>> +++ b/hex.c
>> @@ -76,7 +76,7 @@ char *oid_to_hex_r(char *buffer, const struct object_id *oid)
>>
>>  char *sha1_to_hex(const unsigned char *sha1)
>>  {
>> -	static int bufno;
>> +	static unsigned int bufno;
>>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>>  	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
>>  }
>
> I wonder if just truncating bufno would be conceptually simpler (albeit
> longer):
>
>   bufno++;
>   bufno &= 3;
>   return sha1_to_hex_r(hexbuffer[bufno], sha1);
>
> You could also write the second line like:
>
>   bufno %= ARRAY_SIZE(hexbuffer);
>
> which is less magical (right now the set of buffers must be a power of
> 2). I expect the compiler could turn that into a bitmask itself.

Expelling magic is a good idea.  And indeed, at least gcc, clang and icc 
on x86-64 are smart enough to use an AND instead of dividing 
(https://godbolt.org/g/rFPpzF).

But gcc also adds a sign extension (cltq/cdqe) if we store the truncated 
value, unlike the other two compilers.  I don't see why -- the bit mask 
operation enforces a value between 0 and 3 (inclusive) and the upper 
bits of eax are zeroed automatically, so the cltq is effectively a noop.

Using size_t gets us rid of the extra instruction and is the right type 
anyway.  It would suffice on its own, hmm..

> I'm fine with any of the options. I guess you'd want a similar patch for
> find_unique_abbrev on top of jk/no-looking-at-dotgit-outside-repo.

Actually I'd want you to want to amend your series yourself. ;)  Maybe I 
can convince Coccinelle to handle that issue for us.

And there's also path.c::get_pathname().  That's enough cases to justify 
adding a macro, I'd say:

---
  cache.h | 3 +++
  hex.c   | 4 ++--
  path.c  | 4 ++--
  3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 05ecb88..8bb4918 100644
--- a/cache.h
+++ b/cache.h
@@ -555,6 +555,9 @@ extern int daemonize(void);
  		} \
  	} while (0)

+#define NEXT_RING_ITEM(array, index) \
+	(array)[(index) = ((index) + 1) % ARRAY_SIZE(array)]
+
  /* Initialize and use the cache information */
  struct lock_file;
  extern int read_index(struct index_state *);
diff --git a/hex.c b/hex.c
index ab2610e..5e711b9 100644
--- a/hex.c
+++ b/hex.c
@@ -76,9 +76,9 @@ char *oid_to_hex_r(char *buffer, const struct 
object_id *oid)

  char *sha1_to_hex(const unsigned char *sha1)
  {
-	static int bufno;
+	static size_t bufno;
  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
-	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
+	return sha1_to_hex_r(NEXT_RING_ITEM(hexbuffer, bufno), sha1);
  }

  char *oid_to_hex(const struct object_id *oid)
diff --git a/path.c b/path.c
index a8e7295..60dba6a 100644
--- a/path.c
+++ b/path.c
@@ -24,8 +24,8 @@ static struct strbuf *get_pathname(void)
  	static struct strbuf pathname_array[4] = {
  		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
  	};
-	static int index;
-	struct strbuf *sb = &pathname_array[3 & ++index];
+	static size_t index;
+	struct strbuf *sb = &NEXT_RING_ITEM(pathname_array, index);
  	strbuf_reset(sb);
  	return sb;
  }
-- 
2.10.1


