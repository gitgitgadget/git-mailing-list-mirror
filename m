From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Sat, 26 Jan 2008 14:37:50 +0200
Message-ID: <e51f66da0801260437t7c6d4c6ck2d37d36a452de5f0@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
	 <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
	 <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
	 <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
	 <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 13:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIkIk-0002Zm-8Q
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 13:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbYAZMhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 07:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYAZMhz
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 07:37:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:23020 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbYAZMhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 07:37:54 -0500
Received: by fg-out-1718.google.com with SMTP id e21so992005fga.17
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NP3B44oGqfKKS4YfafbtA7IL/ivwbFf0DNurUAI6HlE=;
        b=V470wjXzFYiKwJtT3BZ09uOsp7SchaIwr2hj+j80Fu4G3fGtp3pwL6MmnuPqvFNYMtvIFCrRO/xt+4luI3zF+aWLnfCJixIpEjHUgeaoMdjtIc17f5bNTTL7Hu6cBQDp1tHjw5z7i+AYOazkNqtwROIOaN+qlSIcp71dXxVJeps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hykM/mqc3D3Us0202oLiARFGw3upou6R1wc+KG/qlX2iWwMf0nYxLCPag9xjZyPkZG0RvK+LsEdkUpJZBXHui2md24v2bUaG7jCRol3CmolefkXPTa5WiIOWPmZCd35Tr4FtmF7npXuzvhB9luHr06HkG1x0FpKSIuExiACMu38=
Received: by 10.78.81.20 with SMTP id e20mr4411209hub.60.1201351070326;
        Sat, 26 Jan 2008 04:37:50 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Sat, 26 Jan 2008 04:37:50 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71780>

On 1/26/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> It's also a mindset issue. Quite frankly, people who do this by "convert
> to some folded/normalized form, then do the operation" will generally make
> much more fundamental mistakes. Once you get into the mindset of "let's
> pass a corrupted strign around", you are in trouble. You start thinking
> that the corrupted string isn't really "corrupt", it's in an "optimized
> format".

Ok, you seem to focus on case folding and general performance,
I focus on hash quality and code complexity.  Considering you
may want several folding methods, it seemed to me that it would
be good to separate the two aspects.

But I'll try to follow your path for a moment.

Hashing 32 or 64 bits at a time is not trivial, eg. you cannot
use same algorithm for both cases, 64 bits requires twice the
work to mix well.

Per Jenkins notes, hash inner loop should be reversible - that
means that details from beginning of data should shift out of horizon.
But final mixing should achieve avalanche - that means each bit in
input should affect 50% bits in output.

Also must be noted that we are mixing 32->32 and 64->64 instead
of the usual 8->32.  So it seems that the best bet would be to use
integer hash functions as core.  Jenkins himself points to Thomas
Wang (http://www.cris.com/~Ttwang/tech/inthash.htm) who has good
integer mix functions for both 32 and 64 bits.

Integer hash function must have both reversibility and avalance,
so they may be slightly overkill for this purpose, but fixing that
means lot of work.

So here is what I propose for hashing, if you really want to have
combined folding + hashing:

/* Thomas Wang integer hash functions */

static inline uint32_t hash32(uint32_t key)
{
        key = ~key + (key << 15);
        key = key ^ (key >> 12);
        key = key + (key << 2);
        key = key ^ (key >> 4);
        key = key * 2057;
        key = key ^ (key >> 16);
        return key;
}

static inline uint64_t hash64(uint64_t key)
{
        key = (~key) + (key << 21); // key = (key << 21) - key - 1;
        key = key ^ (key >> 24);
        key = (key + (key << 3)) + (key << 8); // key * 265
        key = key ^ (key >> 14);
        key = (key + (key << 2)) + (key << 4); // key * 21
        key = key ^ (key >> 28);
        key = key + (key << 31);
        return key;
}

/*
 * Simple addition should be enough for new values,
 * considering the mix functions does work well.
 */

/* this is functon to use in git */
static inline unsigned long hash_long(unsigned long hash, unsigned long val)
{
        if (sizeof(long) == 8)
                return hash64(hash + val);
        else
                return hash32(hash + val);
}

/* below is regular hash for testing */

static uint32_t inline hash_int32(uint32_t hash, uint32_t val)
{
        return hash32(hash + val);
}

static uint64_t inline hash_int64(uint64_t hash, uint64_t val)
{
        return hash64(hash + val);
}

/* hack to avoid call to libc memcpy() */
static inline void simple_memcpy(void *_dst, const void *_src, unsigned len)
{
        const uint8_t *src = _src;
        uint8_t *dst = _dst;
        while (len--)
                *dst++ = *src++;
}

uint32_t int32_hash(const void *_data, unsigned int size)
{
        const uint8_t *src = _data;
        /* inital value.  +size avoids \0 and \0\0 hashing same */
        uint32_t hash = 1234567890 + size;
        uint32_t val;
        while (size >= 4) {
                memcpy(&val, src, 4); /* direct load on x86/64 */
                src += 4;
                size -= 4;
                hash = hash_int32(hash, val);
        }
        if (size > 0) {
                val = 0;
                simple_memcpy(&val, src, size);
                hash = hash_int32(hash, val);
        }
        return hash;
}

uint32_t int64_hash(const void *_data, unsigned int size)
{
        const uint8_t *src = _data;
        uint64_t hash = 12345678901234567890ULL + size;
        uint64_t val;
        while (size >= 8) {
                memcpy(&val, src, 8); /* direct load on x86/64 */
                hash = hash_int64(hash, val);
                src += 8;
                size -= 8;
        }
        if (size > 0) {
                val = 0;
                simple_memcpy(&val, src, size);
                hash = hash_int64(hash, val);
        }
        /* here we go to 32 bits, simple masking is enough */
        return hash;
}


In the "regular" hash functions I again use the memcpy() trick, because
I don't want to bother with access optimizations.  Especially considering
that part is unnecessary for git.


Intel Core Duo (32bit).  String length 0 .. 40, random alignment:
-------------------------------------------------------------------


Testing: seed=34 align=0 minlen=0 maxlen=40 trycnt=3 duration=10

lookup3             :  #0 .. 165.489  #1 .. 165.494  #2 .. 165.490 MB/s
int32_hash          :  #0 .. 148.359  #1 .. 148.350  #2 .. 148.435 MB/s
int64_hash          :  #0 .. 123.105  #1 .. 123.040  #2 .. 123.039 MB/s
lookup3_memcpy_hack :  #0 .. 169.791  #1 .. 169.795  #2 .. 169.749 MB/s
oat                 :  #0 .. 134.737  #1 .. 134.702  #2 .. 134.735 MB/s
fnv                 :  #0 .. 131.457  #1 .. 131.470  #2 .. 131.474 MB/s
hsieh               :  #0 .. 166.619  #1 .. 166.622  #2 .. 166.588 MB/s

Results compared to reference:

lookup3             : 100.000 %
int32_hash          :  89.661 %
int64_hash          :  74.361 %
lookup3_memcpy_hack : 102.591 %
oat                 :  81.409 %
fnv                 :  79.441 %
hsieh               : 100.676 %


AMD Opteron(tm) Processor 252 (64bit) 2.6GHz
-------------------------------------------------

Testing: seed=34 align=0 minlen=0 maxlen=40 trycnt=3 duration=10

lookup3             :  #0 .. 208.819  #1 .. 208.877  #2 .. 208.897 MB/s
int32_hash          :  #0 .. 181.096  #1 .. 181.100  #2 .. 181.097 MB/s
int64_hash          :  #0 .. 196.823  #1 .. 196.761  #2 .. 196.825 MB/s
lookup3_memcpy_hack :  #0 .. 201.593  #1 .. 201.597  #2 .. 201.594 MB/s
oat                 :  #0 .. 160.769  #1 .. 160.774  #2 .. 160.772 MB/s
fnv                 :  #0 .. 200.046  #1 .. 200.044  #2 .. 200.046 MB/s
hsieh               :  #0 .. 205.515  #1 .. 205.520  #2 .. 205.517 MB/s

Results compared to reference:

lookup3             : 100.000 %
int32_hash          :  86.706 %
int64_hash          :  94.225 %
lookup3_memcpy_hack :  96.519 %
oat                 :  76.974 %
fnv                 :  95.778 %
hsieh               :  98.398 %


So speedwise the result is not bad.  Especially considering unoptimized
data fetching.  On larger data (~1k) is tends to lose to lookup3 more,
I guess lookup3 parallelizes better (3x 32bit int vs. 1x 32/64 int).

The functions pass Jenkins lookup3 selftest that eg. FNV does not.

The code is also available at:

 http://pgbouncer.projects.postgresql.org/hashtest/hashtest-2008-01-26.tgz


-- 
marko
