Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D933123D
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597782; cv=none; b=Lt7Fc7dXQBjPEkBftc+hu5vmfFhECs7p2wmJncsH/ht2krq8Ra9RuXB2lE1dpW3f4GzWyY8t+psHwMilFeuDOztHsBcookZjw6FqaDPQ5zYLMOM32r0mpHX1glmjBTZQ/QZxjmeAqgKBfc1y568VqCx3wfeztHZ9YSjPBLTUkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597782; c=relaxed/simple;
	bh=eXFfo49A2MigYumlhEfO8QMuikQ+BIcFPgv4BLUbJLo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OijI+v1vTW9D0uU32QWhoBHl7jJNgcn2q3mw5nPWyPKI+NBqz7deJObtbZpdUrrp6OuZgCEoV5M9RvnaepLtLpT1bEiy/sYsCqnBQJtp79RrS6KZG2TGmBxcYdbcbZT6NNFpDHhzI1jI7aqeMbZFcOuZdVKYuP7+U63bJ/VTfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG4ekiQn; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG4ekiQn"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso35484325e9.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769597778; x=1770202578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCAG9f85WYpPegDIQA6PEuMzjcic89T55ZUFLb9eYJE=;
        b=OG4ekiQnuzAccEN19alG6qySSCERuNJkOW9ypQHdIJmcRuPvziiPo1FJiW9uzCEE3y
         TXiiUX/2z60790sn8p2OCqgNQzHZS6MhnqU2jImx2qhUGRy0sRSFf/2FDpy1opLtmPRS
         onlhh9Hr192UU1fZ+xYGZRaIPCGbqRGfKlbgwiKvJSXqk2x71Of3euuDusxeZ9+rJwYZ
         IotIKVjzBHdH41+dCZvjFaOCgWWBQ7H3mx3q6OoMwOtr7XjyeCmM8H1sWy7rKFonC7nj
         hZrdW4Vzo1aKpSoWLIUJaMA/sG1uo1lAlNat2BN0joN4RphnoYXomoC5clDD/Ze2ineG
         dOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597778; x=1770202578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCAG9f85WYpPegDIQA6PEuMzjcic89T55ZUFLb9eYJE=;
        b=vG+XXwJLoBzBb8qX6J6zAkDBBlaYmsvcasa6B3412RIuCU/X85wUvATA/p72zpA4uL
         m0bgdAJ+gji3Gu0iPUKdci0m+Wp5htEL8hOVbTorVqEofd08SCraVI0wZJBzlVJV/e3+
         kyR4ptIa41whYNrX2+JNantLSQKMdarFz5NEzzPR36mjylPKhBYNBAfMgHK1iajhIXL1
         9fGHxjNHk8B1WmcCD6ylxuxhRbCbJ6TM4bQ4yyp9MksigvSoyTM9G8cxZKH+oZEPISy5
         6+cGrTDe/Uy0xsz8l+1QndDET8OHS73A/+NzBw1O0Kg+MbhvnIQgFC6Kg6wAXi42Be4Z
         bWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCULXLFAWpm5XMz96G87bUQ07kpy+haoNiRUr/QzRfx/9ctm0O0FdN1XFLniY6z7kh1YDOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEAupd4KZMaQm/tFuVEmiq1723V6pTuXg67xNXuV919MlTuqdf
	zsORqCFCqf57+mpPCBty+FGvRL/hiPBUNCseo/ZzQknNw3asab2kWkkq
X-Gm-Gg: AZuq6aJkbfkeDonCTVW5khqbB1S58JWuqC7lwSaoOknNXU2RWwNTooU7k5tc/zrGWdT
	Ceci3Dsjhyq1BdxSUJhJ4w8xBczAzYF085AINDugU9lfL6Bc/YXmMCnm8MQ5vAYaJ7vnoNEFWxU
	poYoUJ/JYMfWaqTIYpNvHJMoETe9FQE2eqKR86G6Or5ALDRePQQEUpJ7UWDrOKvtMXNSt+ypW2V
	IiwWY+53EPdIOJNOTeDFb5RMUP0xiqsBiEOjyenztOOWzQrFFUuh4TM9kI0s0vKZxXLgAyLqS6R
	foJPffbk9RWFWhbgI7MEaznPjnRKbdh4nBxz/WoHV7+9sGAI47o1eYmDUIln6pIllZITilI/aml
	qTpwjCT7TIFKqBFSINqBSWNxnxXnC98f7vlHrxvxUmJYy66g4njejOEsxOJ0z+mJ7JGWLwSR4+q
	GzgdA4+hcaghhZZyCyQrwp79A02pbTOacterwR8+Nt+V3JzhAlR3kIwTUC3XEbdK8gUA==
X-Received: by 2002:a05:600c:34d5:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-48069c25bb0mr53488975e9.12.1769597777838;
        Wed, 28 Jan 2026 02:56:17 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3d1sm55656785e9.9.2026.01.28.02.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 02:56:17 -0800 (PST)
Message-ID: <7513600a-24bb-4ea2-847f-8e9a1dbe7ef3@gmail.com>
Date: Wed, 28 Jan 2026 10:56:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/10] xdiff: move xdl_cleanup_records() from xprepare.c
 to xdiffi.c
From: Phillip Wood <phillip.wood123@gmail.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <1dba6b34aa5c3eec06ae50a74d133c37b1d2404e.1767379944.git.gitgitgadget@gmail.com>
 <2a31e36a-8e36-4544-a54b-d877a85af8a3@gmail.com>
Content-Language: en-US
In-Reply-To: <2a31e36a-8e36-4544-a54b-d877a85af8a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/01/2026 15:01, Phillip Wood wrote:
> Hi Ezekiel
> 
> On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> Only the classic diff uses xdl_cleanup_records(). Move it,
>> xdl_clean_mmatch(), and the macros to xdiffi.c and call
>> xdl_cleanup_records() inside of xdl_do_classic_diff(). This better
>> organizes the code related to the classic diff.
> 
> I think calling xdl_cleanup_records() from inside xdl_do_classic_diff() 
> makes sense. I don't have a strong opinion either way on the code 
> movement.

Having thought about it I'm not so sure the code movement here makes 
sense. Having utility functions in a separate file is perfectly 
reasonable (afterall xprepare.c existed before the histogram and 
patientce algorithms were added). It's not like the code xdiffi.c is 
only about the myers diff there is generic code for diff sliders in 
there as well.

Thanks

Phillip

  You should remove '#include "compat/ivec.h"' from xprepare.c
> if you're moving the only code that uses it out of that file.
> 
> Thanks
> 
> Phillip
> 
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>> ---
>>   xdiff/xdiffi.c   | 180 ++++++++++++++++++++++++++++++++++++++++++++
>>   xdiff/xprepare.c | 191 +----------------------------------------------
>>   2 files changed, 181 insertions(+), 190 deletions(-)
>>
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index e3196c7245..0f1fd7cf80 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -21,6 +21,7 @@
>>    */
>>   #include "xinclude.h"
>> +#include "compat/ivec.h"
>>   static size_t get_hash(xdfile_t *xdf, long index)
>>   {
>> @@ -33,6 +34,14 @@ static size_t get_hash(xdfile_t *xdf, long index)
>>   #define XDL_SNAKE_CNT 20
>>   #define XDL_K_HEUR 4
>> +#define XDL_KPDIS_RUN 4
>> +#define XDL_MAX_EQLIMIT 1024
>> +#define XDL_SIMSCAN_WINDOW 100
>> +
>> +#define DISCARD 0
>> +#define KEEP 1
>> +#define INVESTIGATE 2
>> +
>>   typedef struct s_xdpsplit {
>>       long i1, i2;
>>       int min_lo, min_hi;
>> @@ -311,6 +320,175 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long 
>> lim1,
>>   }
>> +static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, 
>> long e) {
>> +    long r, rdis0, rpdis0, rdis1, rpdis1;
>> +
>> +    /*
>> +     * Limits the window that is examined during the similar-lines
>> +     * scan. The loops below stops when action[i - r] == KEEP
>> +     * (line that has no match), but there are corner cases where
>> +     * the loop proceed all the way to the extremities by causing
>> +     * huge performance penalties in case of big files.
>> +     */
>> +    if (i - s > XDL_SIMSCAN_WINDOW)
>> +        s = i - XDL_SIMSCAN_WINDOW;
>> +    if (e - i > XDL_SIMSCAN_WINDOW)
>> +        e = i + XDL_SIMSCAN_WINDOW;
>> +
>> +    /*
>> +     * Scans the lines before 'i' to find a run of lines that either
>> +     * have no match (action[j] == DISCARD) or have multiple matches
>> +     * (action[j] == INVESTIGATE). Note that we always call this
>> +     * function with action[i] == INVESTIGATE, so the current line
>> +     * (i) is already a multimatch line.
>> +     */
>> +    for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
>> +        if (action[i - r] == DISCARD)
>> +            rdis0++;
>> +        else if (action[i - r] == INVESTIGATE)
>> +            rpdis0++;
>> +        else if (action[i - r] == KEEP)
>> +            break;
>> +        else
>> +            BUG("Illegal value for action[i - r]");
>> +    }
>> +    /*
>> +     * If the run before the line 'i' found only multimatch lines,
>> +     * we return false and hence we don't make the current line (i)
>> +     * discarded. We want to discard multimatch lines only when
>> +     * they appear in the middle of runs with nomatch lines
>> +     * (action[j] == DISCARD).
>> +     */
>> +    if (rdis0 == 0)
>> +        return 0;
>> +    for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
>> +        if (action[i + r] == DISCARD)
>> +            rdis1++;
>> +        else if (action[i + r] == INVESTIGATE)
>> +            rpdis1++;
>> +        else if (action[i + r] == KEEP)
>> +            break;
>> +        else
>> +            BUG("Illegal value for action[i + r]");
>> +    }
>> +    /*
>> +     * If the run after the line 'i' found only multimatch lines,
>> +     * we return false and hence we don't make the current line (i)
>> +     * discarded.
>> +     */
>> +    if (rdis1 == 0)
>> +        return false;
>> +    rdis1 += rdis0;
>> +    rpdis1 += rpdis0;
>> +
>> +    return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
>> +}
>> +
>> +struct xoccurrence
>> +{
>> +    size_t file1, file2;
>> +};
>> +
>> +
>> +DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
>> +
>> +
>> +/*
>> + * Try to reduce the problem complexity, discard records that have no
>> + * matches on the other file. Also, lines that have multiple matches
>> + * might be potentially discarded if they appear in a run of 
>> discardable.
>> + */
>> +static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
>> +    long i;
>> +    size_t nm, mlim;
>> +    xrecord_t *recs;
>> +    uint8_t *action1 = NULL, *action2 = NULL;
>> +    struct IVec_xoccurrence occ;
>> +    bool need_min = !!(flags & XDF_NEED_MINIMAL);
>> +    int ret = 0;
>> +    ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
>> +    ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
>> +
>> +    IVEC_INIT(occ);
>> +    ivec_zero(&occ, xe->mph_size);
>> +
>> +    for (size_t j = 0; j < xe->xdf1.nrec; j++) {
>> +        size_t mph1 = xe->xdf1.recs[j].minimal_perfect_hash;
>> +        occ.ptr[mph1].file1 += 1;
>> +    }
>> +
>> +    for (size_t j = 0; j < xe->xdf2.nrec; j++) {
>> +        size_t mph2 = xe->xdf2.recs[j].minimal_perfect_hash;
>> +        occ.ptr[mph2].file2 += 1;
>> +    }
>> +
>> +    /*
>> +     * Create temporary arrays that will help us decide if
>> +     * changed[i] should remain false, or become true.
>> +     */
>> +    if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
>> +        ret = -1;
>> +        goto cleanup;
>> +    }
>> +    if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
>> +        ret = -1;
>> +        goto cleanup;
>> +    }
>> +
>> +    /*
>> +     * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>> +     */
>> +    if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>> +        mlim = XDL_MAX_EQLIMIT;
>> +    for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; 
>> i <= dend1; i++, recs++) {
>> +        nm = occ.ptr[recs->minimal_perfect_hash].file2;
>> +        action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? 
>> INVESTIGATE: KEEP;
>> +    }
>> +
>> +    if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>> +        mlim = XDL_MAX_EQLIMIT;
>> +    for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; 
>> i <= dend2; i++, recs++) {
>> +        nm = occ.ptr[recs->minimal_perfect_hash].file1;
>> +        action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? 
>> INVESTIGATE: KEEP;
>> +    }
>> +
>> +    /*
>> +     * Use temporary arrays to decide if changed[i] should remain
>> +     * false, or become true.
>> +     */
>> +    xe->xdf1.nreff = 0;
>> +    for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
>> +         i <= dend1; i++, recs++) {
>> +        if (action1[i] == KEEP ||
>> +            (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, 
>> i, xe->delta_start, dend1))) {
>> +            xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
>> +            /* changed[i] remains false, i.e. keep */
>> +        } else
>> +            xe->xdf1.changed[i] = true;
>> +            /* i.e. discard */
>> +    }
>> +
>> +    xe->xdf2.nreff = 0;
>> +    for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
>> +         i <= dend2; i++, recs++) {
>> +        if (action2[i] == KEEP ||
>> +            (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, 
>> i, xe->delta_start, dend2))) {
>> +            xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
>> +            /* changed[i] remains false, i.e. keep */
>> +        } else
>> +            xe->xdf2.changed[i] = true;
>> +            /* i.e. discard */
>> +    }
>> +
>> +cleanup:
>> +    xdl_free(action1);
>> +    xdl_free(action2);
>> +    ivec_free(&occ);
>> +
>> +    return ret;
>> +}
>> +
>> +
>>   int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags)
>>   {
>>       long ndiags;
>> @@ -318,6 +496,8 @@ int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags)
>>       xdalgoenv_t xenv;
>>       int res;
>> +    xdl_cleanup_records(xe, flags);
>> +
>>       /*
>>        * Allocate and setup K vectors to be used by the differential
>>        * algorithm.
>> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
>> index b53a3b80c4..3f555e29f4 100644
>> --- a/xdiff/xprepare.c
>> +++ b/xdiff/xprepare.c
>> @@ -24,14 +24,6 @@
>>   #include "compat/ivec.h"
>> -#define XDL_KPDIS_RUN 4
>> -#define XDL_MAX_EQLIMIT 1024
>> -#define XDL_SIMSCAN_WINDOW 100
>> -
>> -#define DISCARD 0
>> -#define KEEP 1
>> -#define INVESTIGATE 2
>> -
>>   typedef struct s_xdlclass {
>>       struct s_xdlclass *next;
>>       xrecord_t rec;
>> @@ -50,8 +42,6 @@ typedef struct s_xdlclassifier {
>>   } xdlclassifier_t;
>> -
>> -
>>   static int xdl_init_classifier(xdlclassifier_t *cf, long size, long 
>> flags) {
>>       memset(cf, 0, sizeof(xdlclassifier_t));
>> @@ -186,175 +176,6 @@ void xdl_free_env(xdfenv_t *xe) {
>>   }
>> -static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, 
>> long e) {
>> -    long r, rdis0, rpdis0, rdis1, rpdis1;
>> -
>> -    /*
>> -     * Limits the window that is examined during the similar-lines
>> -     * scan. The loops below stops when action[i - r] == KEEP
>> -     * (line that has no match), but there are corner cases where
>> -     * the loop proceed all the way to the extremities by causing
>> -     * huge performance penalties in case of big files.
>> -     */
>> -    if (i - s > XDL_SIMSCAN_WINDOW)
>> -        s = i - XDL_SIMSCAN_WINDOW;
>> -    if (e - i > XDL_SIMSCAN_WINDOW)
>> -        e = i + XDL_SIMSCAN_WINDOW;
>> -
>> -    /*
>> -     * Scans the lines before 'i' to find a run of lines that either
>> -     * have no match (action[j] == DISCARD) or have multiple matches
>> -     * (action[j] == INVESTIGATE). Note that we always call this
>> -     * function with action[i] == INVESTIGATE, so the current line
>> -     * (i) is already a multimatch line.
>> -     */
>> -    for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
>> -        if (action[i - r] == DISCARD)
>> -            rdis0++;
>> -        else if (action[i - r] == INVESTIGATE)
>> -            rpdis0++;
>> -        else if (action[i - r] == KEEP)
>> -            break;
>> -        else
>> -            BUG("Illegal value for action[i - r]");
>> -    }
>> -    /*
>> -     * If the run before the line 'i' found only multimatch lines,
>> -     * we return false and hence we don't make the current line (i)
>> -     * discarded. We want to discard multimatch lines only when
>> -     * they appear in the middle of runs with nomatch lines
>> -     * (action[j] == DISCARD).
>> -     */
>> -    if (rdis0 == 0)
>> -        return 0;
>> -    for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
>> -        if (action[i + r] == DISCARD)
>> -            rdis1++;
>> -        else if (action[i + r] == INVESTIGATE)
>> -            rpdis1++;
>> -        else if (action[i + r] == KEEP)
>> -            break;
>> -        else
>> -            BUG("Illegal value for action[i + r]");
>> -    }
>> -    /*
>> -     * If the run after the line 'i' found only multimatch lines,
>> -     * we return false and hence we don't make the current line (i)
>> -     * discarded.
>> -     */
>> -    if (rdis1 == 0)
>> -        return false;
>> -    rdis1 += rdis0;
>> -    rpdis1 += rpdis0;
>> -
>> -    return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
>> -}
>> -
>> -struct xoccurrence
>> -{
>> -    size_t file1, file2;
>> -};
>> -
>> -
>> -DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
>> -
>> -
>> -/*
>> - * Try to reduce the problem complexity, discard records that have no
>> - * matches on the other file. Also, lines that have multiple matches
>> - * might be potentially discarded if they appear in a run of 
>> discardable.
>> - */
>> -static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
>> -    long i;
>> -    size_t nm, mlim;
>> -    xrecord_t *recs;
>> -    uint8_t *action1 = NULL, *action2 = NULL;
>> -    struct IVec_xoccurrence occ;
>> -    bool need_min = !!(flags & XDF_NEED_MINIMAL);
>> -    int ret = 0;
>> -    ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
>> -    ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
>> -
>> -    IVEC_INIT(occ);
>> -    ivec_zero(&occ, xe->mph_size);
>> -
>> -    for (size_t j = 0; j < xe->xdf1.nrec; j++) {
>> -        size_t mph1 = xe->xdf1.recs[j].minimal_perfect_hash;
>> -        occ.ptr[mph1].file1 += 1;
>> -    }
>> -
>> -    for (size_t j = 0; j < xe->xdf2.nrec; j++) {
>> -        size_t mph2 = xe->xdf2.recs[j].minimal_perfect_hash;
>> -        occ.ptr[mph2].file2 += 1;
>> -    }
>> -
>> -    /*
>> -     * Create temporary arrays that will help us decide if
>> -     * changed[i] should remain false, or become true.
>> -     */
>> -    if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
>> -        ret = -1;
>> -        goto cleanup;
>> -    }
>> -    if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
>> -        ret = -1;
>> -        goto cleanup;
>> -    }
>> -
>> -    /*
>> -     * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>> -     */
>> -    if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>> -        mlim = XDL_MAX_EQLIMIT;
>> -    for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; 
>> i <= dend1; i++, recs++) {
>> -        nm = occ.ptr[recs->minimal_perfect_hash].file2;
>> -        action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? 
>> INVESTIGATE: KEEP;
>> -    }
>> -
>> -    if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>> -        mlim = XDL_MAX_EQLIMIT;
>> -    for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; 
>> i <= dend2; i++, recs++) {
>> -        nm = occ.ptr[recs->minimal_perfect_hash].file1;
>> -        action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? 
>> INVESTIGATE: KEEP;
>> -    }
>> -
>> -    /*
>> -     * Use temporary arrays to decide if changed[i] should remain
>> -     * false, or become true.
>> -     */
>> -    xe->xdf1.nreff = 0;
>> -    for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
>> -         i <= dend1; i++, recs++) {
>> -        if (action1[i] == KEEP ||
>> -            (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, 
>> i, xe->delta_start, dend1))) {
>> -            xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
>> -            /* changed[i] remains false, i.e. keep */
>> -        } else
>> -            xe->xdf1.changed[i] = true;
>> -            /* i.e. discard */
>> -    }
>> -
>> -    xe->xdf2.nreff = 0;
>> -    for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
>> -         i <= dend2; i++, recs++) {
>> -        if (action2[i] == KEEP ||
>> -            (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, 
>> i, xe->delta_start, dend2))) {
>> -            xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
>> -            /* changed[i] remains false, i.e. keep */
>> -        } else
>> -            xe->xdf2.changed[i] = true;
>> -            /* i.e. discard */
>> -    }
>> -
>> -cleanup:
>> -    xdl_free(action1);
>> -    xdl_free(action2);
>> -    ivec_free(&occ);
>> -
>> -    return ret;
>> -}
>> -
>> -
>>   /*
>>    * Early trim initial and terminal matching records.
>>    */
>> @@ -414,19 +235,9 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, 
>> xpparam_t const *xpp,
>>       }
>>       xe->mph_size = cf.count;
>> +    xdl_free_classifier(&cf);
>>       xdl_trim_ends(xe);
>> -    if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>> -        (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
>> -        xdl_cleanup_records(xe, xpp->flags) < 0) {
>> -
>> -        xdl_free_ctx(&xe->xdf2);
>> -        xdl_free_ctx(&xe->xdf1);
>> -        xdl_free_classifier(&cf);
>> -        return -1;
>> -    }
>> -
>> -    xdl_free_classifier(&cf);
>>       return 0;
>>   }
> 
> 

