Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A129341671
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425846; cv=none; b=rKUuqGrW6VFgszvIiMxXenzYZRkFNylOC4Gl7KRHvP/VFuz0ZMi8dgITDF8dN1L/zLr5z0uELMTSodhtFIGj4qU1jZdHhTrgOJzSUDCaxV6lS9M0Fy182oA7hR/tumukvMXjgyF4E3MNnLkjVNp4L+pLfMY5+aEQ+36+4oEC1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425846; c=relaxed/simple;
	bh=styxTXd5rbIjXO+FbN2FFam+aMCBftEPEJtTnPI2wPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtcUKK6fAUhksAQuK1SPromr9P3KxZ8XrPXyl4TkZlREpk0yEF3Rds0aRe1ffHYcK7hTVVqYMay7n8df8vMIdFxkYLejnpEAz4IDzWW8yLWt5S6RmdehDxrA+diJ7VmXw8CDjExijHGCCJOQt996yBmcnAL/1YFGUpK21/QyGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPs6W989; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPs6W989"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso4677485e9.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757425842; x=1758030642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TwQUcwDi7+D0zWIigsT50Kgfszgqou69HCeGwQiusKc=;
        b=fPs6W989TUv8eysntSM4ruquigp9+tLqW5GDzBpmCaiOjeNOvVvPS1YmSuPrQd6Bk2
         M9YnOlexF5Q+E/t5ToJ4/CD2v3u3zgixKwnI7fZoHhPWmnEIGRrrXayjFsWlx8w+Zm9V
         nAZjVrG53tuIP2vUKQHzoMRpgwGlD7iT/v43RS8Idfn9Ka5UJJsoU/g+BbNB3Tf4at4e
         H/u0SgO2dg/wi7gfsVyfv3MGCudU8rq2l2yKgDmL5PROtyr+RdsAYl3U92FNFDOl3pdI
         4tA7J4Yi9B0a7h8YtIgcpHTxeEP03Gzg6zyGnf8IenTtdBjaZq9gUp6hrw40CHnI3ztb
         W3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425842; x=1758030642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwQUcwDi7+D0zWIigsT50Kgfszgqou69HCeGwQiusKc=;
        b=dnCrgxpi1uxQPI4FmOMwWHt+uw7WZFJMcJ2Yd1shQt6WT+9QfzqzuzVXuaUQmfNOIJ
         R6myr73MrFjayd5Lo15N3H/1HdK5sF6aIa1lUuxgzsch6WhbcuFMoNqUHT5NKwJQYioB
         /C6yirpv7ddthx0EEL8tZuKV2KfYeri7O3E6eTy7bKf+51n9Z2h2uyW0MP0jzup8Umtx
         Jp1SRO7hg7BTbEN9auMlFfc1GGQ6sXhr0T3D66ZxrhROjRPB4b9BjJSCENGtnD1byzD/
         zNHUljtFDHI9eH1Q5YMZH89OccEEFkT5DvnOm48sQuR0vj5EloCdFqk4ew0E1Nb5mwCC
         d68g==
X-Gm-Message-State: AOJu0Yx2VOxji7rjp6rbGWqgt8edXrksh/7H4X/XSRhR7cOLXCkrDI+t
	LUyo3tBfHvcAQLVANwwgjeduCZYrl4IZzz0wqS8DVfrZ/FP/QARd+BOq63hxUg==
X-Gm-Gg: ASbGncssp4S10S5at14YapPr8d5caWhqbmuJFxwSteHZ08hxY9ITiVc1kwyAv6pPig1
	14hxJb5guoAF48EX8t36P1cwt0A6TSGv8BupLIqluA8Gqz5ijhE4uWip7z5yoqK35nQ3/TnPQ2/
	Hj+ttcvFLZqCKb8JxWhmsytaAi9y4SltJTRJS13OxhaN7oPsGHBU3aNNGEitQPikGVvCDLsShLY
	TQ4qpOlol+wnXVl7ctd8peO5lbzoAcp3Q7mvVL9f2MJYC5JfyawyTv/HdifUJAyFRTJdsKeDc90
	FmRezfYyrX/CJmYdMtmr3jf4e37coBb/VLCdIiGNUXSoWpEd+3zwbQWu6TlFFNfVL0kE/+JTJCh
	QgFbfQ20ih2bGwN3+HIby0lNmql5JHBcF+ktMlR8rujLex6qpFG5xZVNwefcO/po6CtnYWDoOSx
	2EjczH
X-Google-Smtp-Source: AGHT+IHokCyJjBQ5MXdGSX+KmHHD6LLuZF9MuzgcvJlXfEzcuQji5qEgoOCC4r8ikY16CO/NWXyKXQ==
X-Received: by 2002:a05:600c:4587:b0:45d:d94b:a8fc with SMTP id 5b1f17b1804b1-45ddde8c757mr131221115e9.16.1757425841304;
        Tue, 09 Sep 2025 06:50:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm238494065e9.3.2025.09.09.06.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:50:40 -0700 (PDT)
Message-ID: <aae1ad41-8604-45bc-8ec3-03180e6152ff@gmail.com>
Date: Tue, 9 Sep 2025 14:50:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/17] xdiff: delete chastore from xdfile_t, view with
 --color-words
To: Elijah Newren <newren@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
 <e7d1933d1c470528de94118fe9c58b47bcc67aca.1757274320.git.gitgitgadget@gmail.com>
 <CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/09/2025 09:58, Elijah Newren wrote:
> On Sun, Sep 7, 2025 at 12:46 PM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>> The chastore_t type is very unfriendly to Rust FFI. It's also redundant
>> since 'recs' is a vector type that grows every time an xrecord_t is
>> added.
> 
> The second sentence seems to presume the reader knows what chastore_t
> type is for, and about the confusing dual layering between it and
> recs.its confusing dual layering.  I liked your more extended
> explanation in https://lore.kernel.org/git/7ea2dccd71fc502f20614ce217fc9885d1b17413.1756496539.git.gitgitgadget@gmail.com/;
> could some of that be used here?

I agree that's a better explaination. I also think it would be helpful 
to spell out the implications of this change. If I understand the change 
correctly we now store all the records in a contiguous array, rather 
than having the records in a arena and storing a separate array of 
pointers to those records. As sizeof(xrecord_t) is pretty small the 
change to contiguous storage hopefully wont cause any allocation issues, 
though I guess it does mean we end up copying more data as we grow the 
array compared to using an arena.

Overall these first few patches look like a really nice cleanup.

Thanks

Phillip

>>
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>> ---
>>   xdiff/xdiffi.c     | 24 ++++++++++----------
>>   xdiff/xemit.c      |  6 ++---
>>   xdiff/xhistogram.c |  2 +-
>>   xdiff/xmerge.c     | 56 +++++++++++++++++++++++-----------------------
>>   xdiff/xpatience.c  | 10 ++++-----
>>   xdiff/xprepare.c   | 19 ++++++----------
>>   xdiff/xtypes.h     |  3 +--
>>   xdiff/xutils.c     | 12 +++++-----
>>   8 files changed, 63 insertions(+), 69 deletions(-)
>>
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index 11cd090b53..a66125d44a 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -24,7 +24,7 @@
>>
>>   static unsigned long get_hash(xdfile_t *xdf, long index)
>>   {
>> -       return xdf->recs[xdf->rindex[index]]->ha;
>> +       return xdf->recs[xdf->rindex[index]].ha;
>>   }
>>
>>   #define XDL_MAX_COST_MIN 256
>> @@ -489,13 +489,13 @@ static void measure_split(const xdfile_t *xdf, long split,
>>                  m->indent = -1;
>>          } else {
>>                  m->end_of_file = 0;
>> -               m->indent = get_indent(xdf->recs[split]);
>> +               m->indent = get_indent(&xdf->recs[split]);
>>          }
>>
>>          m->pre_blank = 0;
>>          m->pre_indent = -1;
>>          for (i = split - 1; i >= 0; i--) {
>> -               m->pre_indent = get_indent(xdf->recs[i]);
>> +               m->pre_indent = get_indent(&xdf->recs[i]);
>>                  if (m->pre_indent != -1)
>>                          break;
>>                  m->pre_blank += 1;
>> @@ -508,7 +508,7 @@ static void measure_split(const xdfile_t *xdf, long split,
>>          m->post_blank = 0;
>>          m->post_indent = -1;
>>          for (i = split + 1; i < xdf->nrec; i++) {
>> -               m->post_indent = get_indent(xdf->recs[i]);
>> +               m->post_indent = get_indent(&xdf->recs[i]);
>>                  if (m->post_indent != -1)
>>                          break;
>>                  m->post_blank += 1;
>> @@ -752,7 +752,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
>>   static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
>>   {
>>          if (g->end < xdf->nrec &&
>> -           recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
>> +           recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
>>                  xdf->rchg[g->start++] = 0;
>>                  xdf->rchg[g->end++] = 1;
>>
>> @@ -773,7 +773,7 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
>>   static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
>>   {
>>          if (g->start > 0 &&
>> -           recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1])) {
>> +           recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
>>                  xdf->rchg[--g->start] = 1;
>>                  xdf->rchg[--g->end] = 0;
>>
>> @@ -988,16 +988,16 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>>
>>          for (xch = xscr; xch; xch = xch->next) {
>>                  int ignore = 1;
>> -               xrecord_t **rec;
>> +               xrecord_t *rec;
>>                  long i;
>>
>>                  rec = &xe->xdf1.recs[xch->i1];
>>                  for (i = 0; i < xch->chg1 && ignore; i++)
>> -                       ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
>> +                       ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
>>
>>                  rec = &xe->xdf2.recs[xch->i2];
>>                  for (i = 0; i < xch->chg2 && ignore; i++)
>> -                       ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
>> +                       ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
>>
>>                  xch->ignore = ignore;
>>          }
>> @@ -1021,7 +1021,7 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
>>          xdchange_t *xch;
>>
>>          for (xch = xscr; xch; xch = xch->next) {
>> -               xrecord_t **rec;
>> +               xrecord_t *rec;
>>                  int ignore = 1;
>>                  long i;
>>
>> @@ -1033,11 +1033,11 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
>>
>>                  rec = &xe->xdf1.recs[xch->i1];
>>                  for (i = 0; i < xch->chg1 && ignore; i++)
>> -                       ignore = record_matches_regex(rec[i], xpp);
>> +                       ignore = record_matches_regex(&rec[i], xpp);
>>
>>                  rec = &xe->xdf2.recs[xch->i2];
>>                  for (i = 0; i < xch->chg2 && ignore; i++)
>> -                       ignore = record_matches_regex(rec[i], xpp);
>> +                       ignore = record_matches_regex(&rec[i], xpp);
>>
>>                  xch->ignore = ignore;
>>          }
>> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
>> index 2161ac3cd0..b2f1f30cd3 100644
>> --- a/xdiff/xemit.c
>> +++ b/xdiff/xemit.c
>> @@ -25,7 +25,7 @@
>>
>>   static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
>>   {
>> -       xrecord_t *rec = xdf->recs[ri];
>> +       xrecord_t *rec = &xdf->recs[ri];
>>
>>          if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
>>                  return -1;
>> @@ -110,7 +110,7 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
>>   static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
>>                             char *buf, long sz)
>>   {
>> -       xrecord_t *rec = xdf->recs[ri];
>> +       xrecord_t *rec = &xdf->recs[ri];
>>
>>          if (!xecfg->find_func)
>>                  return def_ff(rec->ptr, rec->size, buf, sz);
>> @@ -150,7 +150,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
>>
>>   static int is_empty_rec(xdfile_t *xdf, long ri)
>>   {
>> -       xrecord_t *rec = xdf->recs[ri];
>> +       xrecord_t *rec = &xdf->recs[ri];
>>          long i = 0;
>>
>>          for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
>> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
>> index 040d81e0bc..4d857e8ae2 100644
>> --- a/xdiff/xhistogram.c
>> +++ b/xdiff/xhistogram.c
>> @@ -86,7 +86,7 @@ struct region {
>>          ((LINE_MAP(index, ptr))->cnt)
>>
>>   #define REC(env, s, l) \
>> -       (env->xdf##s.recs[l - 1])
>> +       (&env->xdf##s.recs[l - 1])
>>
>>   static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
>>   {
>> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
>> index af40c88a5b..fd600cbb5d 100644
>> --- a/xdiff/xmerge.c
>> +++ b/xdiff/xmerge.c
>> @@ -97,12 +97,12 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>>                  int line_count, long flags)
>>   {
>>          int i;
>> -       xrecord_t **rec1 = xe1->xdf2.recs + i1;
>> -       xrecord_t **rec2 = xe2->xdf2.recs + i2;
>> +       xrecord_t *rec1 = xe1->xdf2.recs + i1;
>> +       xrecord_t *rec2 = xe2->xdf2.recs + i2;
>>
>>          for (i = 0; i < line_count; i++) {
>> -               int result = xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
>> -                       rec2[i]->ptr, rec2[i]->size, flags);
>> +               int result = xdl_recmatch(rec1[i].ptr, rec1[i].size,
>> +                       rec2[i].ptr, rec2[i].size, flags);
>>                  if (!result)
>>                          return -1;
>>          }
>> @@ -111,7 +111,7 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>>
>>   static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
>>   {
>> -       xrecord_t **recs;
>> +       xrecord_t *recs;
>>          int size = 0;
>>
>>          recs = (use_orig ? xe->xdf1.recs : xe->xdf2.recs) + i;
>> @@ -119,12 +119,12 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int nee
>>          if (count < 1)
>>                  return 0;
>>
>> -       for (i = 0; i < count; size += recs[i++]->size)
>> +       for (i = 0; i < count; size += recs[i++].size)
>>                  if (dest)
>> -                       memcpy(dest + size, recs[i]->ptr, recs[i]->size);
>> +                       memcpy(dest + size, recs[i].ptr, recs[i].size);
>>          if (add_nl) {
>> -               i = recs[count - 1]->size;
>> -               if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
>> +               i = recs[count - 1].size;
>> +               if (i == 0 || recs[count - 1].ptr[i - 1] != '\n') {
>>                          if (needs_cr) {
>>                                  if (dest)
>>                                          dest[size] = '\r';
>> @@ -160,22 +160,22 @@ static int is_eol_crlf(xdfile_t *file, int i)
>>
>>          if (i < file->nrec - 1)
>>                  /* All lines before the last *must* end in LF */
>> -               return (size = file->recs[i]->size) > 1 &&
>> -                       file->recs[i]->ptr[size - 2] == '\r';
>> +               return (size = file->recs[i].size) > 1 &&
>> +                       file->recs[i].ptr[size - 2] == '\r';
>>          if (!file->nrec)
>>                  /* Cannot determine eol style from empty file */
>>                  return -1;
>> -       if ((size = file->recs[i]->size) &&
>> -                       file->recs[i]->ptr[size - 1] == '\n')
>> +       if ((size = file->recs[i].size) &&
>> +                       file->recs[i].ptr[size - 1] == '\n')
>>                  /* Last line; ends in LF; Is it CR/LF? */
>>                  return size > 1 &&
>> -                       file->recs[i]->ptr[size - 2] == '\r';
>> +                       file->recs[i].ptr[size - 2] == '\r';
>>          if (!i)
>>                  /* The only line has no eol */
>>                  return -1;
>>          /* Determine eol from second-to-last line */
>> -       return (size = file->recs[i - 1]->size) > 1 &&
>> -               file->recs[i - 1]->ptr[size - 2] == '\r';
>> +       return (size = file->recs[i - 1].size) > 1 &&
>> +               file->recs[i - 1].ptr[size - 2] == '\r';
>>   }
>>
>>   static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
>> @@ -334,22 +334,22 @@ static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
>>   static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>>                  xpparam_t const *xpp)
>>   {
>> -       xrecord_t **rec1 = xe1->xdf2.recs, **rec2 = xe2->xdf2.recs;
>> +       xrecord_t *rec1 = xe1->xdf2.recs, *rec2 = xe2->xdf2.recs;
>>          for (; m; m = m->next) {
>>                  /* let's handle just the conflicts */
>>                  if (m->mode)
>>                          continue;
>>
>>                  while(m->chg1 && m->chg2 &&
>> -                     recmatch(rec1[m->i1], rec2[m->i2], xpp->flags)) {
>> +                     recmatch(&rec1[m->i1], &rec2[m->i2], xpp->flags)) {
>>                          m->chg1--;
>>                          m->chg2--;
>>                          m->i1++;
>>                          m->i2++;
>>                  }
>>                  while (m->chg1 && m->chg2 &&
>> -                      recmatch(rec1[m->i1 + m->chg1 - 1],
>> -                               rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
>> +                      recmatch(&rec1[m->i1 + m->chg1 - 1],
>> +                               &rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
>>                          m->chg1--;
>>                          m->chg2--;
>>                  }
>> @@ -381,12 +381,12 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>>                   * This probably does not work outside git, since
>>                   * we have a very simple mmfile structure.
>>                   */
>> -               t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;
>> -               t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1]->ptr
>> -                       + xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - t1.ptr;
>> -               t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
>> -               t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
>> -                       + xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.ptr;
>> +               t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
>> +               t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
>> +                       + xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;
>> +               t2.ptr = (char *)xe2->xdf2.recs[m->i2].ptr;
>> +               t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
>> +                       + xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.ptr;
>>                  if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
>>                          return -1;
>>                  if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
>> @@ -440,8 +440,8 @@ static int line_contains_alnum(const char *ptr, long size)
>>   static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>>   {
>>          for (; chg; chg--, i++)
>> -               if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
>> -                               xe->xdf2.recs[i]->size))
>> +               if (line_contains_alnum(xe->xdf2.recs[i].ptr,
>> +                               xe->xdf2.recs[i].size))
>>                          return 1;
>>          return 0;
>>   }
>> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
>> index 77dc411d19..bf69a58527 100644
>> --- a/xdiff/xpatience.c
>> +++ b/xdiff/xpatience.c
>> @@ -88,9 +88,9 @@ static int is_anchor(xpparam_t const *xpp, const char *line)
>>   static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>>                            int pass)
>>   {
>> -       xrecord_t **records = pass == 1 ?
>> +       xrecord_t *records = pass == 1 ?
>>                  map->env->xdf1.recs : map->env->xdf2.recs;
>> -       xrecord_t *record = records[line - 1];
>> +       xrecord_t *record = &records[line - 1];
>>          /*
>>           * After xdl_prepare_env() (or more precisely, due to
>>           * xdl_classify_record()), the "ha" member of the records (AKA lines)
>> @@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>>                  return;
>>          map->entries[index].line1 = line;
>>          map->entries[index].hash = record->ha;
>> -       map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1]->ptr);
>> +       map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1].ptr);
>>          if (!map->first)
>>                  map->first = map->entries + index;
>>          if (map->last) {
>> @@ -246,8 +246,8 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
>>
>>   static int match(struct hashmap *map, int line1, int line2)
>>   {
>> -       xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
>> -       xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
>> +       xrecord_t *record1 = &map->env->xdf1.recs[line1 - 1];
>> +       xrecord_t *record2 = &map->env->xdf2.recs[line2 - 1];
>>          return record1->ha == record2->ha;
>>   }
>>
>> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
>> index 6f1d4b4725..92f9845003 100644
>> --- a/xdiff/xprepare.c
>> +++ b/xdiff/xprepare.c
>> @@ -131,7 +131,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
>>          xdl_free(xdf->rindex);
>>          xdl_free(xdf->rchg - 1);
>>          xdl_free(xdf->recs);
>> -       xdl_cha_free(&xdf->rcha);
>>   }
>>
>>
>> @@ -146,8 +145,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>>          xdf->rchg = NULL;
>>          xdf->recs = NULL;
>>
>> -       if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
>> -               goto abort;
>>          if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
>>                  goto abort;
>>
>> @@ -158,12 +155,10 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>>                          hav = xdl_hash_record(&cur, top, xpp->flags);
>>                          if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
>>                                  goto abort;
>> -                       if (!(crec = xdl_cha_alloc(&xdf->rcha)))
>> -                               goto abort;
>> +                       crec = &xdf->recs[xdf->nrec++];
>>                          crec->ptr = prev;
>>                          crec->size = (long) (cur - prev);
>>                          crec->ha = hav;
>> -                       xdf->recs[xdf->nrec++] = crec;
>>                          if (xdl_classify_record(pass, cf, crec) < 0)
>>                                  goto abort;
>>                  }
>> @@ -263,7 +258,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
>>    */
>>   static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
>>          long i, nm, nreff, mlim;
>> -       xrecord_t **recs;
>> +       xrecord_t *recs;
>>          xdlclass_t *rcrec;
>>          char *dis, *dis1, *dis2;
>>          int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>> @@ -276,7 +271,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>>          if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
>>                  mlim = XDL_MAX_EQLIMIT;
>>          for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
>> -               rcrec = cf->rcrecs[(*recs)->ha];
>> +               rcrec = cf->rcrecs[recs->ha];
>>                  nm = rcrec ? rcrec->len2 : 0;
>>                  dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>>          }
>> @@ -284,7 +279,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>>          if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
>>                  mlim = XDL_MAX_EQLIMIT;
>>          for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
>> -               rcrec = cf->rcrecs[(*recs)->ha];
>> +               rcrec = cf->rcrecs[recs->ha];
>>                  nm = rcrec ? rcrec->len1 : 0;
>>                  dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>>          }
>> @@ -320,13 +315,13 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>>    */
>>   static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
>>          long i, lim;
>> -       xrecord_t **recs1, **recs2;
>> +       xrecord_t *recs1, *recs2;
>>
>>          recs1 = xdf1->recs;
>>          recs2 = xdf2->recs;
>>          for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
>>               i++, recs1++, recs2++)
>> -               if ((*recs1)->ha != (*recs2)->ha)
>> +               if (recs1->ha != recs2->ha)
>>                          break;
>>
>>          xdf1->dstart = xdf2->dstart = i;
>> @@ -334,7 +329,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
>>          recs1 = xdf1->recs + xdf1->nrec - 1;
>>          recs2 = xdf2->recs + xdf2->nrec - 1;
>>          for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
>> -               if ((*recs1)->ha != (*recs2)->ha)
>> +               if (recs1->ha != recs2->ha)
>>                          break;
>>
>>          xdf1->dend = xdf1->nrec - i - 1;
>> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
>> index 85848f1685..3d26cbf1ec 100644
>> --- a/xdiff/xtypes.h
>> +++ b/xdiff/xtypes.h
>> @@ -45,10 +45,9 @@ typedef struct s_xrecord {
>>   } xrecord_t;
>>
>>   typedef struct s_xdfile {
>> -       chastore_t rcha;
>> +       xrecord_t *recs;
>>          long nrec;
>>          long dstart, dend;
>> -       xrecord_t **recs;
>>          char *rchg;
>>          long *rindex;
>>          long nreff;
>> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
>> index 444a108f87..332982b509 100644
>> --- a/xdiff/xutils.c
>> +++ b/xdiff/xutils.c
>> @@ -416,12 +416,12 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>>          mmfile_t subfile1, subfile2;
>>          xdfenv_t env;
>>
>> -       subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
>> -       subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
>> -               diff_env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
>> -       subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
>> -       subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
>> -               diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
>> +       subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1].ptr;
>> +       subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2].ptr +
>> +               diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.ptr;
>> +       subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1].ptr;
>> +       subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2].ptr +
>> +               diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.ptr;
>>          if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>>                  return -1;
>>
>> --
>> gitgitgadget
> 
> You weren't kidding with the --color-words callout; there's an awful
> lot of places where you only change one or two characters (e.g. '->'
> becoming '.'); that's much easier to see when viewing the diff with
> that flag.
> 
> Anyway, looks good.
> 

