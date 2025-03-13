Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3C42052
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870382; cv=none; b=mJOU7sk92RC5e1BCFPBZEcWnBmUVEZNWBm2TMS5LWHX937o1Ji5kEx33JucYEkwkNgtesCsSnpymE5T/bZ7R+PvhmqC+liT5H2uLqZ5I4aL+nfRx24OGwRp60/d0Jmp3zYyTSO+nI7+lYyRY8Dx/KG8O0oNmwd0atCY5F1VwwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870382; c=relaxed/simple;
	bh=SSsaGsenZgOgfBZPFmBk5A7DavKBdAMUDuos+WOhunE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=QHoDLGXDW61N+tav9berpeYbIAFgEwuUD2uLRD4uqaDyCZbEnRtx8ggcM3wlo9FqxIqd4O0fymfWhgPG51OiXvdSPxB6Q5WkWOzvZ+SmRXvtpWM2vIaaMosqWrBE4I1GSPbNUjiVp0HRzPSlzRdKErGufpUNmZFXF/6xsWb/MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSHmz9mv; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSHmz9mv"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d377306ddso420106241.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741870380; x=1742475180; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwPYGQRO9IW9tnvLBNpPOfHIAIF8/g6FRgz23XkzKms=;
        b=iSHmz9mvlRDsEshBgL04JbVC37QWPAdgOZkm4U74p28XlzFrzD9NHai5oziyKydR37
         A8sqd7ZpCE10EfdfWz8rqrPvIXCymqBm1FJvQOzVQylHp9gtsEudDkXW9go0l+UMzdEN
         v5HsQLRgJ9ClCLx/xqrtZ9Do/W1Q58krztDfNAL7gwdsWj8bpcowI9x8eTEeXP01/hAl
         61KabC4SHD0XmXkU2Bq3s48RmN8SfuBnpEMyzaYyMttx59NeI2yRVTefRyvgrTeozgnp
         4f4i0DCHf405/h5QZXdgqvz+dtH2bE7w0UiDSKPVa3FjxgxhPHWIKPtp/cEceGwjmIU9
         YmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870380; x=1742475180;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwPYGQRO9IW9tnvLBNpPOfHIAIF8/g6FRgz23XkzKms=;
        b=PnuA0QtXThnivzQVTfhjGssNgj6cf7xbApsHNPIbC1VlGzgDQnjjrJPz2IiFxr4NwP
         RkTUb+eIju14B7kIg9oT7vhItWG5ZQftxZ9bKPYvCKB/4A0PqrEKzANTOC79bz/qDsHq
         D3j/r/DZwEcQtbNtUTg/HEBm5FHyB19nZ+ZK3/954nUQECud07pP6gh+hlJiG1+/6m0P
         7qAY+OEbmAg3Xxc17fhmkWNna7XR0Hen4u5jmqA6qAYAOn7g1w2A2G7jCWjpFq+ThLAl
         P9QbqhPO1E1VsHOffV9o2+MGyLeFF03Em6p6qP+v37j25U34Zg/t0NXNcCS7thro2O4v
         wRcw==
X-Forwarded-Encrypted: i=1; AJvYcCX1khw9A9R51Q/c2sOKaFWMvF7aFnWGzCk4VLgMhHY8FrKEZ0DoHJVwV/8aRDteLSWgcIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxww6hRJ4VI/6RS4gDD3KrmybJdcpL17JPBXz5Don/i9HdUbkF/
	VL9bvDU3Mgo4mYcRnjK6U+uUOaY7JgSJGZyOunkRSIy15ilt/WkamCpHChpq6GWGnk4w79jMIx9
	g7pGUiL50PwCgtqU5u+DUiGV68zM=
X-Gm-Gg: ASbGncsAiZCOrqhatRcr1zbFPM67KvvHqD8IhjjmJnsQ+3a/i8T7/BAVbZXLsP6ii45
	gWfDZw+AmP5kaEKkBYchgsLG0DuBjCWgRk6/Si4t+uedq1dUIXVkWtXVyzS69li5ptZKyiJNAxe
	meiwN1WWAPMxZ1zXX3b3o7yXn+pWMoIi0L62ButA==
X-Google-Smtp-Source: AGHT+IFBqECsk9h7tTyOx2Pgd3aRRRGkm5z/5RSizG2/PaQNaz4pCKGcTTFHFScWifAgDxd1ARmwmvd9yQxmS8CSp8c=
X-Received: by 2002:a05:6122:8297:b0:51b:a11f:cbdb with SMTP id
 71dfb90a1353d-523e4172c0amr20429071e0c.4.1741870379641; Thu, 13 Mar 2025
 05:52:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 08:52:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 08:52:58 -0400
X-Gm-Features: AQ5f1JogDrvm4JWbtFUBZTtt1jDk-NooNREJJ5k9Wv9aX3aeDhTzhhkM0iad3MQ
Message-ID: <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com>
Subject: Re: [GSoC PATCH] pathspec: fix sign comparison warnings
To: Arnav Bhate <bhatearnav@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000394dfb063038cd9c"

--000000000000394dfb063038cd9c
Content-Type: text/plain; charset="UTF-8"

Arnav Bhate <bhatearnav@gmail.com> writes:

> There are multiple places, especially in loops, where a signed and an
> unsigned data type are compared. Git uses a mix of signed and unsigned
> types to store lengths of arrays. This sometimes leads to using a signed
> index for an array whose length is stored in an unsigned variable or
> vice versa.
>
> Replace signed data types with unsigned data types and vice versa
> wherever necessary. In some cases, introduce a new variable, where both
> signed and unsigned data types have been used to store lengths of arrays
> in the same function, where previously only one variable was used to
> iterate over both types. In cases where this is not possible, add
> appropriate cast. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.
>
> Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
> ---
>  pathspec.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 89663645e1..fd7dfdfd84 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -1,5 +1,4 @@
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>
>  #include "git-compat-util.h"
>  #include "abspath.h"
> @@ -36,6 +35,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>  					enum ps_skip_worktree_action sw_action)
>  {
>  	int num_unmatched = 0, i;
> +	unsigned int j;
>
>  	/*
>  	 * Since we are walking the index as if we were walking the directory,
> @@ -48,8 +48,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>  			num_unmatched++;
>  	if (!num_unmatched)
>  		return;
> -	for (i = 0; i < istate->cache_nr; i++) {
> -		const struct cache_entry *ce = istate->cache[i];
> +	for (j = 0; j < istate->cache_nr; j++) {
> +		const struct cache_entry *ce = istate->cache[j];
>  		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>  		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
>  			continue;

While this is correct, now we have 'i' & 'j' as iteration variables,
generally this is used in O(n^2) loops to define the outer and inner
loops. Here, however, we use it to simply define two different types. I
find this deviation from convention a little confusing.

Perhaps, we could simply utilize the option of intializing loop
variables in the loop itself?

  diff --git a/pathspec.c b/pathspec.c
  index 89663645e1..ff8854afb8 100644
  --- a/pathspec.c
  +++ b/pathspec.c
  @@ -35,7 +35,7 @@ void add_pathspec_matches_against_index(const
struct pathspec *pathspec,
   					char *seen,
   					enum ps_skip_worktree_action sw_action)
   {
  -	int num_unmatched = 0, i;
  +	int num_unmatched = 0;

   	/*
   	 * Since we are walking the index as if we were walking the directory,
  @@ -43,12 +43,12 @@ void add_pathspec_matches_against_index(const
struct pathspec *pathspec,
   	 * mistakenly think that the user gave a pathspec that did not match
   	 * anything.
   	 */
  -	for (i = 0; i < pathspec->nr; i++)
  +	for (int i = 0; i < pathspec->nr; i++)
   		if (!seen[i])
   			num_unmatched++;
   	if (!num_unmatched)
   		return;
  -	for (i = 0; i < istate->cache_nr; i++) {
  +	for (unsigned int i = 0; i < istate->cache_nr; i++) {
   		const struct cache_entry *ce = istate->cache[i];
   		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
   		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))

This would read much cleaner and also avoid two different loop
variables. WDYT?

Also a bigger question is, shouldn't the type of `pathspec.nr` and
'istate.cache_nr' be the actual change required? Shouldn't they be set
to 'size_t'?

> @@ -78,7 +78,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
>  {
>  	struct index_state *istate = the_repository->index;
>  	char *seen = xcalloc(pathspec->nr, 1);
> -	int i;
> +	unsigned int i;
>

Nit: We could also drop this and move the initialization to the line
below.

>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
> @@ -130,7 +130,7 @@ static void prefix_magic(struct strbuf *sb, int prefixlen,
>  	if (element[1] != '(') {
>  		/* Process an element in shorthand form (e.g. ":!/<match>") */
>  		strbuf_addstr(sb, ":(");
> -		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +		for (unsigned int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>  			if ((magic & pathspec_magic[i].bit) &&
>  			    pathspec_magic[i].mnemonic) {
>  				if (sb->buf[sb->len - 1] != '(')

Shouldn't we use 'size_t' for this, since we're iterating over the
elements of an array?

> @@ -341,7 +341,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
>
>  	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
>  		size_t len = strcspn_escaped(pos, ",)");
> -		int i;
> +		unsigned int i;
>

This too should be 'size_t'.

>  		if (pos[len] == ',')
>  			nextat = pos + len + 1; /* handle ',' */
> @@ -354,7 +354,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
>  		if (starts_with(pos, "prefix:")) {
>  			char *endptr;
>  			*prefix_len = strtol(pos + 7, &endptr, 10);
> -			if (endptr - pos != len)
> +			if ((size_t)(endptr - pos) != len)
>  				die(_("invalid parameter for pathspec magic 'prefix'"));
>  			continue;
>  		}

This makes sense. But is it guaranteed that `endptr - pos` is greater
than 0?

> @@ -400,7 +400,7 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>
>  	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
>  		char ch = *pos;
> -		int i;
> +		unsigned int i;
>

This too, should be 'size_t'

>  		/* Special case alias for '!' */
>  		if (ch == '^') {
> @@ -564,7 +564,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
>
>  void pathspec_magic_names(unsigned magic, struct strbuf *out)
>  {
> -	int i;
> +	unsigned int i;

This can be inlined and made 'size_t'.

>  	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>  		const struct pathspec_magic *m = pathspec_magic + i;
>  		if (!(magic & m->bit))
> @@ -803,8 +803,8 @@ int match_pathspec_attrs(struct index_state *istate,
>  int pathspec_needs_expanded_index(struct index_state *istate,
>  				  const struct pathspec *pathspec)
>  {
> -	unsigned int i, pos;
> -	int res = 0;
> +	unsigned int pos;
> +	int i, res = 0;
>  	char *skip_worktree_seen = NULL;
>

This can be inlined, but this change is done to match 'pathspec.nr''s
type. This goes to my earlier question, I would say we first need to
modify 'pathspec.nr' itself to be 'size_t'.

>  	/*
> @@ -845,7 +845,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>  			 * - not-in-cone/bar*: may need expanded index
>  			 * - **.c: may need expanded index
>  			 */
> -			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
> +			if (strspn(item.original + item.nowildcard_len, "*") == (unsigned int)(item.len - item.nowildcard_len) &&
>  			    path_in_cone_mode_sparse_checkout(item.original, istate))
>  				continue;
>

Similar here, I see the types of 'item.len' and 'item.nowwildcard_len'
are 'int'. Do they need to be 'size_t'?

> @@ -860,7 +860,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>  				 * directory name and the sparse directory is the first
>  				 * component of the pathspec, need to expand the index.
>  				 */
> -				if (item.nowildcard_len > ce_namelen(ce) &&
> +				if ((unsigned int)item.nowildcard_len > ce_namelen(ce) &&
>  				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
>  					res = 1;
>  					break;
> --
> 2.48.1

Same question as above!

--000000000000394dfb063038cd9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9aedac7d7dc7650d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUzFTVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1VyQy80d0tLa2FBV0ZCbkFQRDlzQURNS3pGWXJaVApYUVlsbDl6Mm4v
T21rNG9nSUNab0ZuZXMrN05XK3pmSGNTY0VBbTlCc3Zhd2VpTDFFSkpxOTd6L2JadzRYRjE1Cm9P
c2FzcTVLeFF6cklMc09PcmhSZDZBaHI0MGhKbEJkV0Q2Y3V0RE8zNUxVTFh2RmtoQk52eENIN1Mz
RzdCeWsKZHZYVSthSDV2OWRUTmFaREUrL3lSRTQveG1KUnhURTVuSVF0amNLWlMzRGF1K08rMXkw
MEpncHphczA5Q1cwcgpVNEROb09ocVpYcEJ1Z28zdVM0amp0SnUra2gvQThYV0VXS3pGMlJtSDdS
azVTN1J5c0phdWs5dlkyQ1RQYksrCmkzYXZ4NFRCaW1QTm5Zc0NKSTZwRHY5Qm9WRUxoY1c4Tys2
R21BbmV2RlB1OCtnY1EwbnJCRytMMFdWUU96bVMKTlQ2NkVOc0k5YlN1S3dQRHRFV1ltbGRyeU5Y
MTc0MFRSakFnSE4vSC9nNm1hKzlVZFNpMUkwbUcvUy8xUEZaVApleTg3VUZjemhaYVZSTTJ3elZ2
aGNwTHRtN3Eva2VkcXgwUUM5RkpubjBDQmlJK1N2V0RRaUVxbkVSeHlOOCt2CjVGdElHUmxlVC9G
VldEMmNVZCtTbkgxSW9vcXVuMUx1ZUNNR1lYRT0KPVZqOTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000394dfb063038cd9c--
