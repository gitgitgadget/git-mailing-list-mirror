Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961919414B
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767831; cv=none; b=r3HurbOVxJIf+wmRYVZ24Evp3h6IUKTClMHJ+Ezwn6dJSbHadi6xQrD+hxUybEByVjEAtIRkBddypllDvIkey85mV+m/847e4zIwgPc5uRizuMadvsxrR2J00hreMPO0+1zC21/tCltgQ22vIY1GTsDuyyscy4QluZYp0YqXVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767831; c=relaxed/simple;
	bh=oOHukOEgWaCGB89WiBylywSxKSZscSWoZKgFvhb/8Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKMoc+RhsuVWfinwNZwGD3+tRw7jLs4jdZaH414mSMf4aT08tqMh7+vc+NVdpc4ba9Z9PZJat7JW67Q86JZ7k1P5izfeKdLnaYjGUukisuFA3f+OWw0nRtDF4qLdLvRk5vigcOXMSKpRs+y9EuWbAftJcgNvwBacyR2X1CKJ1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB1zNxJX; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB1zNxJX"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d1ffa161c0so89098b6e.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767828; x=1718372628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf+02UmWM8R1QX+zS7qc0pioBIroF9PGRrNIffFHl48=;
        b=PB1zNxJXan08w4CmfjMDo5IMzLTJc/5rH1i5tpHeK81qr69KWLxHytL9Z3PceYXAhm
         d949A1/E2TGw+/BtVLTHPfbS9Sd62kbmWufmC0mXvLsuPztQSiAVJcWKdiSu6GWtD24q
         UAMaENJzgAkRp9Iuj75/b5bcvp71dFQMdfPpvZmWg7W7SXOkp+0fDLlyGMrMPMzmCE25
         roL0GLcKcTvsWnEFJLYKtrYa3mOLIH7fjnYRVtp1ZO0GYMK+C1563pI4mZisuqm1Jkeo
         DptbA35Tu/KXoJqmiAZSlZ5bwIUe/YAR6zKnZzBLiBn66l6rvN/AHtzibWl3NUtPnSJB
         eepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767828; x=1718372628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xf+02UmWM8R1QX+zS7qc0pioBIroF9PGRrNIffFHl48=;
        b=eTAJ19ka31mDJgKfyVVRpG61MnKPXeOpea65cEAKqx/Deom3JXFWz0zTIfkJh+ztPK
         3YHYae46XT0SKAQgkcBiaw+bqekGWLARP/iZD6JWiFaG/SCQ8IMIERT1+GjvYygEL5cL
         vzM/QDS2QegEfyZA0PATIwZC3htKVVzuezIZEDY9UleB9Mt1fW25Z0AuUT/IhbqrkO6G
         WkJqLQeRevf4h5QDotZGLAdSpQc51x10PywqKp9DyF+xpPIN7owAqpzsPyEDSBM7LBKR
         UIrac7ceqEz/VulkI8ORZDPCR2/EZfnKKun10ze6OmhyQq2EX470CsaydumaIhgMjTVw
         GXAw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5XnKSI3GFwYQ+dpAn8tR/ZGkVH5fPOUyDXjgGD4oj/fnCDzvy2AqdxPvku2bqdHLwUb9xcsAaYhxrhajFl7DOUgT
X-Gm-Message-State: AOJu0YxIJaJJ4tenxVQrdmqVM0xmjxBtYQH8RVCKN/U7/niybGMTEGjF
	isgJgqd1yg0J9wbPsuWKEcQO53vL8PA5dKZ4JLBIAwdN2qn8kThD
X-Google-Smtp-Source: AGHT+IHn7CPE+JTOURa7bzNFkiUr3+jYg7+pM/KDTWe5tKOBy5XsMJ6XD0p75fTERqPY2XZsRtaoyQ==
X-Received: by 2002:a54:448b:0:b0:3d2:199b:63dc with SMTP id 5614622812f47-3d2199b95b8mr367309b6e.5.1717767826852;
        Fri, 07 Jun 2024 06:43:46 -0700 (PDT)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6a369esm17296326d6.45.2024.06.07.06.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2024 06:43:46 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
Date: Fri, 07 Jun 2024 09:43:46 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <7FC6AD35-0DF4-4228-8708-790470D4B0EA@gmail.com>
In-Reply-To: <xmqqv82mkk15.fsf@gitster.g>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
 <xmqq34pqlyou.fsf@gitster.g> <xmqqv82mkk15.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On 6 Jun 2024, at 14:23, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>  29 files changed, 64 insertions(+), 52 deletions(-)
>>
>> Wow, the blast radius of this thing is rather big.  Among these
>> existing callers of refs_resolve_ref_unsafe(), how many of them
>> will benefit from being able to pass a non NULL parameter at the end
>> of the series, and more importantly, in the future to take advantage
>> of the new feature possibly with a separate series?
>> ...
>> That way, you do not have to touch those existing callers that will
>> never benefit from the new capability in the future.  You won't risk
>> conflicting with in flight topics semantically, either.
>
> The same comment applies to [3/4], but I do not want to fix the Cc: hea=
der
> again, so I am replying to this message.

Yes, so for 3/4 I was exploring doing the same thing. However, each_repo_=
fn goes
pretty deep in the callstack and to provide an alternate set of functions=
 that
use something like each_repo_referent_fn would still lead to a relatively=
 large
blast radius, eg, something like:


diff --git a/ref-filter.c b/ref-filter.c
index f7fb0c7e0e..770d3715c2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2631,12 +2631,12 @@ static int filter_exclude_match(struct ref_filter=
 *filter, const char *refname)
  * pattern match, so the callback still has to match each ref individual=
ly.
  */
 static int for_each_fullref_in_pattern(struct ref_filter *filter,
-				       each_ref_fn cb,
+				       each_ref_with_referent_fn cb,
 				       void *cb_data)
 {
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
-		return refs_for_each_include_root_refs(get_main_ref_store(the_reposito=
ry),
+		return refs_for_each_include_root_refs_with_referent(get_main_ref_stor=
e(the_repository),
 						       cb, cb_data);
 	}

@@ -2646,7 +2646,7 @@ static int for_each_fullref_in_pattern(struct ref_f=
ilter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+		return refs_for_each_fullref_in_with_referent(get_main_ref_store(the_r=
epository),
 						"", NULL, cb, cb_data);
 	}

@@ -2656,17 +2656,17 @@ static int for_each_fullref_in_pattern(struct ref=
_filter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+		return refs_for_each_fullref_in_with_referent(get_main_ref_store(the_r=
epository),
 						"", NULL, cb, cb_data);
 	}

 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+		return refs_for_each_fullref_in_with_referent(get_main_ref_store(the_r=
epository),
 						 "", filter->exclude.v, cb, cb_data);
 	}

-	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_reposit=
ory),
+	return refs_for_each_fullref_in_prefixes_with_referent(get_main_ref_sto=
re(the_repository),
 						 NULL, filter->name_patterns,
 						 filter->exclude.v,
 						 cb, cb_data);
@@ -2781,7 +2781,7 @@ static int filter_ref_kind(struct ref_filter *filte=
r, const char *refname)
 	return ref_kind_from_refname(refname);
 }

-static struct ref_array_item *apply_ref_filter(const char *refname, cons=
t struct object_id *oid,
+static struct ref_array_item *apply_ref_filter(const char *refname, cons=
t char *referent, const struct object_id *oid,
 			    int flag, struct ref_filter *filter)
 {
 	struct ref_array_item *ref;
@@ -2850,6 +2850,7 @@ static struct ref_array_item *apply_ref_filter(cons=
t char *refname, const struct
 	ref->commit =3D commit;
 	ref->flag =3D flag;
 	ref->kind =3D kind;
+	ref->symref =3D referent;

 	return ref;
 }
@@ -2863,12 +2864,12 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int filter_one(const char *refname, const struct object_id *oid, =
int flag, void *cb_data)
+static int filter_one(const char *refname, const char *referent, const s=
truct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata =3D cb_data;
 	struct ref_array_item *ref;

-	ref =3D apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	ref =3D apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filt=
er);
 	if (ref)
 		ref_array_append(ref_cbdata->array, ref);

@@ -2898,13 +2899,13 @@ struct ref_filter_and_format_cbdata {
 	} internal;
 };

-static int filter_and_format_one(const char *refname, const struct objec=
t_id *oid, int flag, void *cb_data)
+static int filter_and_format_one(const char *refname, const char *refere=
nt, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_and_format_cbdata *ref_cbdata =3D cb_data;
 	struct ref_array_item *ref;
 	struct strbuf output =3D STRBUF_INIT, err =3D STRBUF_INIT;

-	ref =3D apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	ref =3D apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filt=
er);
 	if (!ref)
 		return 0;

@@ -3050,7 +3051,7 @@ void filter_ahead_behind(struct repository *r,
 	free(commits);
 }

-static int do_filter_refs(struct ref_filter *filter, unsigned int type, =
each_ref_fn fn, void *cb_data)
+static int do_filter_refs(struct ref_filter *filter, unsigned int type, =
each_ref_with_referent_fn fn, void *cb_data)
 {
 	int ret =3D 0;

@@ -3070,15 +3071,15 @@ static int do_filter_refs(struct ref_filter *filt=
er, unsigned int type, each_ref
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind =3D=3D FILTER_REFS_BRANCHES)
-			ret =3D refs_for_each_fullref_in(get_main_ref_store(the_repository),
+			ret =3D refs_for_each_fullref_in_with_referent(get_main_ref_store(the=
_repository),
 						       "refs/heads/", NULL,
 						       fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_REMOTES)
-			ret =3D refs_for_each_fullref_in(get_main_ref_store(the_repository),
+			ret =3D refs_for_each_fullref_in_with_referent(get_main_ref_store(the=
_repository),
 						       "refs/remotes/", NULL,
 						       fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_TAGS)
-			ret =3D refs_for_each_fullref_in(get_main_ref_store(the_repository),
+			ret =3D refs_for_each_fullref_in_with_referent(get_main_ref_store(the=
_repository),
 						       "refs/tags/", NULL, fn,
 						       cb_data);
 		else if (filter->kind & FILTER_REFS_REGULAR)
@@ -3090,7 +3091,7 @@ static int do_filter_refs(struct ref_filter *filter=
, unsigned int type, each_ref
 		 */
 		if (!ret && !(filter->kind & FILTER_REFS_ROOT_REFS) &&
 		    (filter->kind & FILTER_REFS_DETACHED_HEAD))
-			refs_head_ref(get_main_ref_store(the_repository), fn,
+			refs_head_ref_referent(get_main_ref_store(the_repository), fn,
 				      cb_data);
 	}

diff --git a/refs.c b/refs.c
index 6dcb0288cb..4366f35586 100644
--- a/refs.c
+++ b/refs.c
@@ -1529,6 +1529,19 @@ int refs_head_ref(struct ref_store *refs, each_ref=
_fn fn, void *cb_data)
 	return 0;
 }

+int refs_head_ref_referent(struct ref_store *refs, each_ref_with_referen=
t_fn fn, void *cb_data)
+{
+	struct object_id oid;
+	int flag;
+	const char *referent;
+
+	if (refs_resolve_ref_unsafe_with_referent(refs, "HEAD", referent, RESOL=
VE_REF_READING,
+				    &oid, &flag))
+		return fn("HEAD", referent, &oid, flag, cb_data);
+
+	return 0;
+}
+
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix,
@@ -1560,6 +1573,22 @@ struct ref_iterator *refs_ref_iterator_begin(
 	return iter;
 }

+static int do_for_each_ref_with_referent(struct ref_store *refs, const c=
har *prefix,
+			   const char **exclude_patterns,
+			   each_ref_with_referent_fn fn, int trim,
+			   enum do_for_each_ref_flags flags, void *cb_data)
+{
+	struct ref_iterator *iter;
+
+	if (!refs)
+		return 0;
+
+	iter =3D refs_ref_iterator_begin(refs, prefix, exclude_patterns, trim,
+				       flags);
+
+	return do_for_each_ref_iterator_with_referent(iter, fn, cb_data);
+}
+
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   const char **exclude_patterns,
 			   each_ref_fn fn, int trim,
@@ -1594,6 +1623,13 @@ int refs_for_each_fullref_in(struct ref_store *ref=
s, const char *prefix,
 	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_dat=
a);
 }

+int refs_for_each_fullref_in_with_referent(struct ref_store *refs, const=
 char *prefix,
+			     const char **exclude_patterns,
+			     each_ref_with_referent_fn fn, void *cb_data)
+{
+	return do_for_each_ref_with_referent(refs, prefix, exclude_patterns, fn=
, 0, 0, cb_data);
+}
+
 int refs_for_each_replace_ref(struct ref_store *refs, each_ref_fn fn, vo=
id *cb_data)
 {
 	const char *git_replace_ref_base =3D ref_namespace[NAMESPACE_REPLACE].r=
ef;
@@ -1627,6 +1663,13 @@ int refs_for_each_include_root_refs(struct ref_sto=
re *refs, each_ref_fn fn,
 			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
 }

+int refs_for_each_include_root_refs_with_referent(struct ref_store *refs=
, each_ref_with_referent_fn fn,
+				    void *cb_data)
+{
+	return do_for_each_ref_with_referent(refs, "", NULL, fn, 0,
+			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
+}
+
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a =3D *(const char **)va;
@@ -1716,6 +1759,37 @@ int refs_for_each_fullref_in_prefixes(struct ref_s=
tore *ref_store,
 	return ret;
 }

+int refs_for_each_fullref_in_prefixes_with_referent(struct ref_store *re=
f_store,
+				      const char *namespace,
+				      const char **patterns,
+				      const char **exclude_patterns,
+				      each_ref_with_referent_fn fn, void *cb_data)
+{
+	struct string_list prefixes =3D STRING_LIST_INIT_DUP;
+	struct string_list_item *prefix;
+	struct strbuf buf =3D STRBUF_INIT;
+	int ret =3D 0, namespace_len;
+
+	find_longest_prefixes(&prefixes, patterns);
+
+	if (namespace)
+		strbuf_addstr(&buf, namespace);
+	namespace_len =3D buf.len;
+
+	for_each_string_list_item(prefix, &prefixes) {
+		strbuf_addstr(&buf, prefix->string);
+		ret =3D refs_for_each_fullref_in_with_referent(ref_store, buf.buf,
+					       exclude_patterns, fn, cb_data);
+		if (ret)
+			break;
+		strbuf_setlen(&buf, namespace_len);
+	}
+
+	string_list_clear(&prefixes, 0);
+	strbuf_release(&buf);
+	return ret;
+}
+
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
 				  struct strbuf *referent, unsigned int *type,
diff --git a/refs.h b/refs.h
index ba6d0e0753..d8387c6296 100644
--- a/refs.h
+++ b/refs.h
@@ -304,6 +304,9 @@ struct ref_transaction;
 typedef int each_ref_fn(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);

+typedef int each_ref_with_referent_fn(const char *refname, const char *r=
eferent,
+			const struct object_id *oid, int flags, void *cb_data);
+
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
@@ -315,6 +318,8 @@ typedef int each_ref_fn(const char *refname,
  */
 int refs_head_ref(struct ref_store *refs,
 		  each_ref_fn fn, void *cb_data);
+int refs_head_ref_referent(struct ref_store *refs,
+		  each_ref_with_referent_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -351,6 +356,17 @@ int refs_for_each_fullref_in_prefixes(struct ref_sto=
re *refs,
 				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data);

+int refs_for_each_fullref_in_prefixes_with_referent(struct ref_store *re=
fs,
+				      const char *namespace,
+				      const char **patterns,
+				      const char **exclude_patterns,
+				      each_ref_with_referent_fn fn, void *cb_data);
+
+int refs_for_each_fullref_in_with_referent(struct ref_store *refs, const=
 char *prefix,
+			     const char **exclude_patterns,
+			     each_ref_with_referent_fn fn, void *cb_data);
+
+
 /* iterates all refs that match the specified glob pattern. */
 int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
 			   const char *pattern, void *cb_data);
@@ -377,6 +393,10 @@ int refs_for_each_rawref(struct ref_store *refs, eac=
h_ref_fn fn, void *cb_data);
 int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn =
fn,
 				    void *cb_data);

+int refs_for_each_include_root_refs_with_referent(struct ref_store *refs=
, each_ref_with_referent_fn fn,
+				    void *cb_data);
+
+
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs=
/'.
diff --git a/refs/iterator.c b/refs/iterator.c
index 26acb6bd64..26c38ec6de 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -469,3 +469,30 @@ int do_for_each_ref_iterator(struct ref_iterator *it=
er,
 		return -1;
 	return retval;
 }
+
+int do_for_each_ref_iterator_with_referent(struct ref_iterator *iter,
+			     each_ref_with_referent_fn fn, void *cb_data)
+{
+	int retval =3D 0, ok;
+	struct ref_iterator *old_ref_iter =3D current_ref_iter;
+
+	current_ref_iter =3D iter;
+	while ((ok =3D ref_iterator_advance(iter)) =3D=3D ITER_OK) {
+		retval =3D fn(iter->refname, iter->referent, iter->oid, iter->flags, c=
b_data);
+		if (retval) {
+			/*
+			 * If ref_iterator_abort() returns ITER_ERROR,
+			 * we ignore that error in deference to the
+			 * callback function's return value.
+			 */
+			ref_iterator_abort(iter);
+			goto out;
+		}
+	}
+
+out:
+	current_ref_iter =3D old_ref_iter;
+	if (ok =3D=3D ITER_ERROR)
+		return -1;
+	return retval;
+}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0775451435..ebec407468 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -486,6 +486,9 @@ extern struct ref_iterator *current_ref_iter;
  */
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
+int do_for_each_ref_iterator_with_referent(struct ref_iterator *iter,
+			     each_ref_with_referent_fn fn, void *cb_data);
+

 struct ref_store;


Which is a little bit unseemly in my view...so between the two options I =
would be
inclined to go with modifying each_repo_fn than create a whole subset set=
 of
helpers. wdyt?

thanks
John

>
> Thanks.

