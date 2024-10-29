Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740F206052
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202399; cv=none; b=GgvN/yFnw6tQLMycbae3dhdFzqgjEUAnl+3eV8irjlL8bkZwU4pOxR6dX7w1H7zUcPW+PSe3JO6wV99By+3oZ6BPr1HhcduGHcmgInKLnuFlyXou368Ahyt3PvScP+3dLmLX6EeCtdFF4leOYp4rY4Dc/eRIqwIZR9x/NlUNRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202399; c=relaxed/simple;
	bh=1IBn1ZsFQt+T9BDs9QJpUeLoNwXXzl0gH9zNkAClHQs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT3ENLfaQ2BGynAcpHhnMEKsHOJuuiap2S0DT9TJed5snJcAXHSaE7RYSRCW0yPOa5a35tSq8+Q518rDqTfzWWkjC/9Pd5uLYq6XYorWCeza2mw/khEmpe1+6vYdkFngms103fzv5pTpc4Cnpojg2JhWgjKD8wiNLNYC7C4IouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtARDlgn; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtARDlgn"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fdf96b31aso1489906241.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730202396; x=1730807196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ooLroujx0qD3QIs1An3CWnlXcOUM8zWW35JmBQkq00c=;
        b=YtARDlgnqnqZiJu4g60znbbAZxAMVisitoOSvjzO2wliNnrkBjOOxe6m/du05oGGRy
         h2seJW0TsX/CJp6he2SR9Fo8cDR6mgt/Y6ISHM7cIW0ZWViO4GqtVx1NYr+ibu74uxNm
         ZA5dZh0TFz130vl9aFmH7nMxzyUA3VpqlIk0oWXWS1vop7b6Y+NHXY3Hi42Apzi9ilgf
         Xp6HyDR3Trt2xxOJ29dir5NxnxuWDf6mtb6V6oaPzDS3UtvfGfsXudjV0Mu/xwFzoOTY
         CjbzGINGAGAFDXv9yTrZbGhuY3oH53oZX+r5SzYSfMWjVi0OzIM+zSFbxqhtSLPksC2N
         HQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202396; x=1730807196;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooLroujx0qD3QIs1An3CWnlXcOUM8zWW35JmBQkq00c=;
        b=CrQD4dvtenhr+9rDzEDxN8haDMA7HH8VD7Sm1s4kt9FNyjVO+I2RGWmloSLVH+ojyq
         N/3DTtyawId2zgbnGEt93EIOqEfjDWNbArHY/cy82ePAhaGuYlGCizWZjONf/PjzfePg
         yM+ZcPdbjFd1qF69SeNuuSCcWO/oUjsmGZ6GzjtQcSgfkoxAchwepFZh90EQu8kytvog
         qse7FRQEBLmi4kaZEQIc6qVYxZKfNiPY49ops13zpMoCGPdpWhMVDXmlZ1yQJG9Sailq
         iAmYb1KAp++3BK3bUbutZnn25LJzniGEu1Q7lxud2RUrIucsTqFXQp8smfujGhhkpEHE
         Xrwg==
X-Gm-Message-State: AOJu0YyYVJhKOppLNclOrFq9bf+QIMEw5Oi0bPhkTYJZcbhN1FzgR2RZ
	T4/7yOWbKsCyXAwEDe1iwQ52zCMsklZg/S/ME8CmNLLX6SZsUyc11SIbzHMtct++QKQBX9l6boc
	EgrX9u33pnYDWzPuE+ZBrywuAeMXTW993
X-Google-Smtp-Source: AGHT+IH4W22G/pB9l6/UIPuTp5PZ1YlRo5pDB3QWNA5sjOvWUGmXOJrvCN45MVVKwexExj28lH9VoFrRhxP6+vBpDHg=
X-Received: by 2002:a05:6122:d85:b0:50d:4cb8:5afd with SMTP id
 71dfb90a1353d-5101502de1emr8384197e0c.4.1730202396083; Tue, 29 Oct 2024
 04:46:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 07:46:35 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zx+2YRqoIOwE0ysU@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com> <26d2461cc349c14b05d2713ee411bb058251f45f.1730122499.git.karthik.188@gmail.com>
 <Zx+2YRqoIOwE0ysU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 07:46:35 -0400
Message-ID: <CAOLa=ZRbQPbuUk+CMk12Sj5VQCqrbDRR9E4S8OA_cCuiZZiWXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] packfile: add repository to struct `packed_git`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000035776e06259c23be"

--00000000000035776e06259c23be
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 28, 2024 at 02:43:39PM +0100, Karthik Nayak wrote:
>> The struct `packed_git` holds information regarding a packed object
>> file. Let's add the repository variable to this object, to represent the
>> repository that this packfile belongs to. This helps remove dependency
>> on the global `the_repository` object in `packfile.c` by simply using
>> repository information now readily available in the struct.
>
> Makes sense, good. I think it would be useful here to capture some of
> the discussion from just before you sent this series to indicate why
> it's OK to use the_repository even when we have alternates.
>
> I think it is now quite obvious in retrospect, but let's do our future
> selves a service by capturing it here, too ;-).
>

Agree, will add it in the next version.

>> ---
>>  10 files changed, 30 insertions(+), 16 deletions(-)
>
> Oh, good. I am glad to see that this new approach is already yielding
> far less disruptive of a change.
>
>> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> index 76d5c20f14..ffee7d3abd 100644
>> --- a/builtin/fast-import.c
>> +++ b/builtin/fast-import.c
>> @@ -765,6 +765,7 @@ static void start_packfile(void)
>>
>>  	p->pack_fd = pack_fd;
>>  	p->do_not_close = 1;
>> +	p->repo = the_repository;
>
> Makes sense. Here we are crafting the packfile by hand, so initializing
> ->repo directly makes sense here.
>
> It would be nice if we could rewrite this in terms of
> packfile.c:alloc_packed_git(), but that is a static function. Exposing
> it as non-static is probably showing too much of the internals, so I
> think leaving this as-is makes sense.
>

Yes, I did consider that too, but dropped it for the same reasons you
stated.

>> diff --git a/commit-graph.c b/commit-graph.c
>> index 5bd89c0acd..83dd69bfeb 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -1914,7 +1914,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
>>  		struct packed_git *p;
>>  		strbuf_setlen(&packname, dirlen);
>>  		strbuf_addstr(&packname, pack_indexes->items[i].string);
>> -		p = add_packed_git(packname.buf, packname.len, 1);
>> +		p = add_packed_git(ctx->r, packname.buf, packname.len, 1);
>
> I wondered if ctx->r was the right choice here or not, but it is, and it
> is (currently) always equal to the value of the_repository, so it's a
> moot point. Let's keep going...
>
>> diff --git a/midx-write.c b/midx-write.c
>> index b3a5f6c516..c57726ef94 100644
>> --- a/midx-write.c
>> +++ b/midx-write.c
>> @@ -154,7 +154,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
>>  			return;
>>
>>  		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
>> -		p = add_packed_git(full_path, full_path_len, 0);
>> +		p = add_packed_git(the_repository, full_path, full_path_len, 0);
>
> Ugh. I thought we had already added a repository field to our auxiliary
> write_midx_context struct, but we have not, so this change looks right
> to me.  Doing so (adding that new field) seems like it would be a good
> piece of #leftoverbits.
>
>> diff --git a/midx.c b/midx.c
>> index e82d4f2e65..8edb75f51d 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -464,7 +464,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>>  					strhash(key.buf), key.buf,
>>  					struct packed_git, packmap_ent);
>>  	if (!p) {
>> -		p = add_packed_git(pack_name.buf, pack_name.len, m->local);
>> +		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
>
> OK, so here we're trusting the value of 'r' from the caller. That comes
> from 64404a24cf (midx: pass a repository pointer, 2019-04-29), which is
> doing the right thing. (As an aside, I thought that that change was from
> when we added the --object-dir flag to 'git multi-pack-index', but the
> change is in fact unrelated and has to do with adding installed packs to
> the repository's MRU list).
>
>>  		if (p) {
>>  			install_packed_git(r, p);
>>  			list_add_tail(&p->mru, &r->objects->packed_git_mru);
>> diff --git a/object-store-ll.h b/object-store-ll.h
>> index 53b8e693b1..8b31072b09 100644
>> --- a/object-store-ll.h
>> +++ b/object-store-ll.h
>> @@ -4,6 +4,7 @@
>>  #include "hashmap.h"
>>  #include "object.h"
>>  #include "list.h"
>> +#include "repository.h"
>
> Hmm. Do we need to include all of repository.h here? I don't think we
> do, because we never peek into any of the fields of that structure from
> within this header. So I think you could do something like:
>
> --- 8< ---
> diff --git a/object-store-ll.h b/object-store-ll.h
> index 6f9f4276e6..bcfae2e1bf 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -4,13 +4,13 @@
>  #include "hashmap.h"
>  #include "object.h"
>  #include "list.h"
> -#include "repository.h"
>  #include "thread-utils.h"
>  #include "oidset.h"
>
>  struct oidmap;
>  struct oidtree;
>  struct strbuf;
> +struct repository;
>
>  struct object_directory {
>  	struct object_directory *next;
> --- >8 ---
>
> instead of #include-ing the whole thing, which would be preferable.
>

This is much better, I will patch it in.

>>  #include "thread-utils.h"
>>  #include "oidset.h"
>>
>> @@ -135,6 +136,10 @@ struct packed_git {
>>  	 */
>>  	const uint32_t *mtimes_map;
>>  	size_t mtimes_size;
>> +
>> +	/* repo dentoes the repository this packed file belongs to */
>> +	struct repository *repo;
>
> Calling this 'repo' makes sense, but...
>
>> diff --git a/packfile.c b/packfile.c
>> index 9560f0a33c..45f300e5e1 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -217,11 +217,12 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
>>  	return ntohl(level1_ofs[value]);
>>  }
>>
>> -static struct packed_git *alloc_packed_git(int extra)
>> +static struct packed_git *alloc_packed_git(struct repository *repo, int extra)
>
> Here and elsewhere, I think our usual convention is to call a 'struct
> repository *' (when it is a formal parameter of some function) just "r"
> instead of "repo".
>
> At least that's what my intuition told me, and a very rough grep says
> that '*r' appears as a parameter 815 times, while '*repo' appears only
> 577 times. It's close, but I think that '*r' is preferred here since
> it's fewer characters.
>

I agree, by now you know I prefer readability over fewer characters, so
it more of an intentional choice. But here, I think it can be '*r'
though, since it is sort of obvious what 'r' refers to in most cases.

I will change this in all commits in the next version.

>>  {
>>  	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
>>  	memset(p, 0, sizeof(*p));
>
> Not at all the fault of this patch, but it feels like a bit of a
> foot-gun to allocate a bounds-checked version of 'sizeof(*p)+extra',
> while only zero'ing the first 'sizeof(*p)' bytes. I think in all cases
> where it actually matters via add_packed_git() we fill out that extra
> space anyway, but it might be nice cleanup to do something like:
>
>     struct packed_git *p;
>     size_t sz = sizeof(*p) + extra;
>
>     p = xcalloc(1, sz);
>
> , or something. But that can be dealt with later and/or as #leftoverbits.
>

Like you stated, there is bunch of refactoring we could do here, I mostly
don't want to digress and create too much noise, so I will turn a blind
eye in some cases and leave it for later.

> The rest is looking good, nicely done. Let's keep reading...
>
> Thanks,
> Taylor

Thanks for the review.

--00000000000035776e06259c23be
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7fd60d620f712517_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jZ3l4Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMll5Qy9zRzU5NEhaZEpkbk1sckJoZHhsV1lHVzFyVQpEcjZTWGpkWElh
Wm9meFZCYkJqV21ma1ppbThWRzVUdXl6bHFBOVM3cVpUQndScExTSnk4S1d5dktDTm8weWVkCkZo
OHdYSWpZd2V1MkVlN3Vuek1LR3lsNnNZRVhKZG4zMDhoNEdBODJWcGlLclRwZGNMTzRmUUxLMDZW
QVZIbUgKUG12UitseWt4ZXJPdVhYRnRnc2cwSGxYT3h5Vyt3akRhN0NVOHg0N2psNVlYMW5uV21P
VWl3dFJubXcwSFpMZgpscC9zOUlLeVM3K1poN25QaDRtUTdIRXlnRUp0dkZGVmRPakU1MDY1VHNV
RE5OSkZHOWRKQm9FRFk5b0xaSm1oClhtcWhUaWhZM3dSTno3bnpwSjdnTXF4eTUxZXRoeFp5NExs
a0t1S2doMGVOY0U1V2ZBV2NBYXJwZmZXWDlRYXIKRU12Tkc0aTd0R0tIbm02cU9XWU1mTDQ1TFdS
VE9wLzFFQ3UyQ3BGZEpSNER2MGZlbzRSMWh0dXFLS0VrUjFBTwprYkIzNWp0YlNZeUcxVnNyeGNl
cVFjbmQ3bXozQkdHbUlzQjFTQlRIQ1hjb1pNNmVIOFZTVnpoZk1FN1VQWm01CndXQ3lXR0lBL0c5
T0c2M1Z1cm0rcExick9JdU5lWHk1SytDTW1zMD0KPVc2ZjQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000035776e06259c23be--
