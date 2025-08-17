Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC871DE89A
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755422844; cv=none; b=a0i3L6j2ToMyByWMiVk0ExSS1DkoVTICcGNnVHyeS6jLX7pmmG0odxDyHpUxGpaN7EawDvpApebVUJzW+fO96FjnMFEsKDu3RfJgk2Q2uS4KFg8/GndvUWk4EKYPvqUil5PNoQ+wl7KD1BwAsZ5cd1HpeWyLLIo6h6+qNazBJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755422844; c=relaxed/simple;
	bh=gnMTvv9VrjNWEuS+o4Nw0GJLTaMh/PBCoEVasFBVWBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHmy8W0v7ZYgLkSmW/WMgKyfkCQv6dFTMC5BOwaNgoThY5F0JEF4Teh2csfRB9I6A3R2ZVEJEfuRasRN80oSfWZXNsvVgtFrq9gE9tY3HlroejMnEiYCsE/AlM6GHYwPSNsl+to+4aiWRX+GvHkwlTOBEg83832Sp1RzymDPsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=olLb+pUS; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="olLb+pUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755422833; x=1756027633; i=l.s.r@web.de;
	bh=lEU4LepQdnUjN2FjNpkswCTd+NjrD6GkpMVLxnXnV3I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=olLb+pUS+e+el+B0aULeDpV0kdrND0Ze5JB85YSNggDVHGOZXWgjxmUcqR0Ov61m
	 WfB1YVmIEBBe1DDybkkKU9q8VexSBzGqAOEyXqWcA589alXnpY9u5PwqnPIt3/Ta/
	 NIPwsrgVeoncN/MvNLSNp68xGj25gg28/cQpD9lFaYb5BRekqJEQMSg78BtDNLKVh
	 RacE0i+BZne9pFarZXilNqo2gIG3TDlfah5W1npRiSqLZl27TufyjfLzQ2Eq058Ok
	 gueJenj0U8fz/RLVU7Eb0pu7uRDEHGjU8+ydBHRZAfjFz4aXkq2g2rqKhQzMuhs9q
	 OatOmB1+exsB8kFlkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YN9-1utvSK2Ue1-00Alf1; Sun, 17
 Aug 2025 11:27:13 +0200
Message-ID: <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
Date: Sun, 17 Aug 2025 11:27:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250814232644.GC2937@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uW/p8WpdxeUSFQltn+zb16nh9SXPOkeueSEKbsFfEdjC1ACZaMN
 VQpuv70L84HA07Hr2UYjFo/71PHaupbKR3F5R52zad0Ow8GT2DRB0T9pPQlhLcNfS6wCsPx
 SpTuJGd5HOzr+75612wT1mKEJON1LS+kKJkpSzG2TwwODMO4pS0Yl0ELHlpdeHjoI6btNvG
 deJjdb1A4F3qfx1aq5zBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j0nNhzCbEfs=;hKgiZrURmuCLztWyfrnLNjKdqH0
 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

On 8/15/25 1:26 AM, Jeff King wrote:
> On Wed, Aug 13, 2025 at 02:19:14PM +0100, Phillip Wood wrote:
>=20
>> I had a quick look at the callers of describe_commit() and they all see=
m to
>> use an oid that they get from looking up a commit so I'm not sure under=
 what
>> circumstances this call to lookup_commit_reference() can fail.
>=20
> I wonder if it would make sense for describe_commit() to just take a
> "struct commit" pointer.

Yes, a lot.

> Then it could skip the call to turn the oid
> into a commit entirely, and the compiler would make sure we always have
> a commit. :)
>=20
> Something like this (totally untested, and not something I'm planning to
> follow up on, but maybe inspirational):
>=20
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 32f5bf513f..3e8691a4c4 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -352,26 +352,24 @@ static void append_suffix(int depth, const struct =
object_id *oid, struct strbuf
>  		    repo_find_unique_abbrev(the_repository, oid, abbrev));
>  }
> =20
> -static void describe_commit(struct object_id *oid, struct strbuf *dst)
> +static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  {
> -	struct commit *cmit, *gave_up_on =3D NULL;
> +	struct commit *gave_up_on =3D NULL;
>  	struct lazy_queue queue =3D LAZY_QUEUE_INIT;
>  	struct commit_name *n;
>  	struct possible_tag all_matches[MAX_TAGS];
>  	unsigned int match_cnt =3D 0, annotated_cnt =3D 0, cur_match;
>  	unsigned long seen_commits =3D 0;
>  	unsigned int unannotated_cnt =3D 0;
> =20
> -	cmit =3D lookup_commit_reference(the_repository, oid);
> -
>  	n =3D find_commit_name(&cmit->object.oid);
>  	if (n && (tags || all || n->prio =3D=3D 2)) {
>  		/*
>  		 * Exact match to an existing ref.
>  		 */
>  		append_name(n, dst);
>  		if (n->misnamed || longformat)
> -			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
> +			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : &cmit->object.oid=
, dst);
>  		if (suffix)
>  			strbuf_addstr(dst, suffix);
>  		return;
> @@ -528,7 +526,7 @@ static void describe_commit(struct object_id *oid, s=
truct strbuf *dst)
>  }
> =20
>  struct process_commit_data {
> -	struct object_id current_commit;
> +	struct commit *current_commit;
>  	struct object_id looking_for;
>  	struct strbuf *dst;
>  	struct rev_info *revs;
> @@ -537,7 +535,7 @@ struct process_commit_data {
>  static void process_commit(struct commit *commit, void *data)
>  {
>  	struct process_commit_data *pcd =3D data;
> -	pcd->current_commit =3D commit->object.oid;
> +	pcd->current_commit =3D commit;
>  }
> =20
>  static void process_object(struct object *obj, const char *path, void *=
data)
> @@ -546,7 +544,7 @@ static void process_object(struct object *obj, const=
 char *path, void *data)
> =20
>  	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
>  		reset_revision_walk();
> -		describe_commit(&pcd->current_commit, pcd->dst);
> +		describe_commit(pcd->current_commit, pcd->dst);

pcd->current_commit is initialized to NULL below, but
traverse_commit_list() without a filter must have set it via our
process_commit() callback before we get to the describe_commit() call.

Or are there weird repositories (e.g., just a blob, just a tag) that can
cause traverse_commit_list() to call its show_object() callback without
ever calling its show_commit() callback?  I don't see how, but may be
missing some way.

>  		strbuf_addf(pcd->dst, ":%s", path);
>  		clear_prio_queue(&pcd->revs->commits);
>  	}
> @@ -556,7 +554,7 @@ static void describe_blob(struct object_id oid, stru=
ct strbuf *dst)
>  {
>  	struct rev_info revs;
>  	struct strvec args =3D STRVEC_INIT;
> -	struct process_commit_data pcd =3D { *null_oid(the_hash_algo), oid, ds=
t, &revs};
> +	struct process_commit_data pcd =3D { NULL, oid, dst, &revs};
> =20
>  	strvec_pushl(&args, "internal: The first arg is not parsed",
>  		     "--objects", "--in-commit-order", "--reverse", "HEAD",
> @@ -589,7 +587,7 @@ static void describe(const char *arg, int last_one)
>  	cmit =3D lookup_commit_reference_gently(the_repository, &oid, 1);
> =20
>  	if (cmit)
> -		describe_commit(&oid, &sb);
> +		describe_commit(cmit, &sb);
>  	else if (odb_read_object_info(the_repository->objects,
>  				      &oid, NULL) =3D=3D OBJ_BLOB)
>  		describe_blob(oid, &sb);

