Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95263148838
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935419; cv=none; b=J29AZ5RxP2ufiTCvQS0GlCEZhQdhq5eLcg3oC20jCyBUAop42fQ23uk60dC+r4i9DZplu1Oj6wKnxWaUu3ylrIWXh16vGUt2aw7L+bmQxVZQ6HOnhiqjtDWxxzdZonuUcPctNCgXiyZ5oXRHTo2+WECjxdNsrdfZPwza+ADfTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935419; c=relaxed/simple;
	bh=gbQrecuZmGpattVtDIiHW6yJH9aPqVFyPxy+eLpnXl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utILeM03pMYNR3gTf5CjDx0ryitH/0B2+EZ2TfL2hn4/zIZlXyJA5eWC+C6LzjFHqdPmeLy1c/ZKiR/XLFR8t5Pw8BC1Yus7aAS0gFVh9IREUx+ToOKBlZj8f1InxISrqeu+421UNlxJwzkw5dAwunkfkxWWi0xXHtoiHlUBNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYMv2Jzc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYMv2Jzc"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78d6903b7c6so19493285a.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712935416; x=1713540216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAJwGkU7iMVBv2ZeeitEEE4Lu8Z3PGPRGXZ6pZyTSCQ=;
        b=BYMv2JzcFkL8UoouWm8rN9U+aEyBDNkRpXY4yJWswugusjGIuLCPyVHfH1t1sQQoYj
         MJD6MvqGcNdwTj6BPDC2d0zdF/7+F1LWbjn+l7T4dNAlYp2T+Y/g8qLy/AWVyaTD8Q84
         spxu1MdrfDS+5D6pZC0QukozV1kRRjMMdMB5KUV9CTySC2gOXPYN49e5Ofz9Th9MSMfk
         FkEPaVWxxIBAr8EcHkrFnDuHoNP11e58N4wuysvct/BYgOmJS19u1EWXyaLS9bnywyGO
         +ggw8sTMc1TyQNSmz7fViVUOzxY4rb1S7mVJhs1B5/+AlaXyYoRmLyLCkiKUkG7tyfhN
         V49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935416; x=1713540216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAJwGkU7iMVBv2ZeeitEEE4Lu8Z3PGPRGXZ6pZyTSCQ=;
        b=TutPdaI94C66Og3F5FTJRTP1hcOLu5S/Iz6qQdHIXlAkU3wtBW5hyWve0VVynq5YHv
         7bM3kteYhXH4ZriHxghTtZ0hDe3HdYSR8go2evQTN73ktbfxYMNy4bTc7gLvVMzsquVe
         1LG/i/52zG0HGQdxXcJOH9Qd2+jpsXf6VYvVSvx/QrP0/2qqBo4xZnKTHJiJzPat2qZ/
         SIJoyFB6/mnanBO7Vhzw3pLASo9Yn87zpAVL8hHpMrcy7SWl1OC/tKQrWhLNvlefvcg8
         a+At+dQi4TdrSCgrrI/3U/nFe9WdZ/a3rgcrNicO3hITku470sd6aM3aZRAs2atE4ffj
         vNMA==
X-Forwarded-Encrypted: i=1; AJvYcCUMPBG0bAFd6KY6nlNOIEPR0JsWJGU9q6BhrkhKzOEJ5LJpJFMVXxz1MUQYUBoXgAsvyOvKdSEkXhQ1mWPLPXZeI3UI
X-Gm-Message-State: AOJu0YwqbEMfVnNej4wXLwIo+ocFt+6cGWn6Yauk1TEgDKLuEBNO+now
	9OafGbY3smu2HIOTLK6Pd/wgtqpfEkNsBMSfgH7Y/HIR0VrHwj18
X-Google-Smtp-Source: AGHT+IGR8ZqJ7ODphHPaahagTVCmTfWZbXIUH7M3usp099bByu+UCBby26d0xkMiiZzNJTQbbnzF0w==
X-Received: by 2002:a05:620a:19a6:b0:78e:d3c5:f8be with SMTP id bm38-20020a05620a19a600b0078ed3c5f8bemr436010qkb.7.1712935416194;
        Fri, 12 Apr 2024 08:23:36 -0700 (PDT)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id j9-20020ae9c209000000b0078d73685803sm2250987qkg.99.2024.04.12.08.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2024 08:23:35 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: add --symbolic-name option
Date: Fri, 12 Apr 2024 11:23:35 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <2E94E03A-CBDE-406D-AB65-DEAC4BB26761@gmail.com>
In-Reply-To: <ZhY3UCwJeMcG4fH1@tanuki>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
 <ZhY3UCwJeMcG4fH1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 10 Apr 2024, at 2:53, Patrick Steinhardt wrote:

> On Mon, Apr 08, 2024 at 05:38:13PM +0000, John Cai via GitGitGadget wro=
te:
>> From: John Cai <johncai86@gmail.com>
>>
>> For reftable development, it would be handy to have a tool to provide
>> the direct value of any ref whether it be a symbolic ref or not.
>> Currently there is git-symbolic-ref, which only works for symbolic ref=
s,
>> and git-rev-parse, which will resolve the ref. Let's teach show-ref a
>> --symbolic-name option that will cause git-show-ref(1) to print out th=
e
>> value symbolic references points to.
>
> I think it was Peff who shared a way to achieve this without actually
> introducing a new option via `git for-each-ref --format=3D`. Can we may=
be
> provide some benchmarks to demonstrate that this variant is preferable
> over what's already possible?

Yes, it would be better to not introduce a new option. I've done a quick
benchmark including my changes to add the unresolved symref to the iterat=
or, and
some changes to integrate this into ref-filter.c. Here are the results:

$ hyperfine --warmup 5 "git for-each-ref \
--format=3D'%(refname) %(objectname) %(symref)'" "./git for-each-ref \
--format=3D'%(refname) %(objectname) %(symref)'"

Benchmark 1: git for-each-ref --format=3D'%(refname) %(objectname) %(symr=
ef)'
  Time (mean =C2=B1 =CF=83):     213.5 ms =C2=B1   9.9 ms    [User: 7.5 m=
s, System: 14.3 ms]
  Range (min =E2=80=A6 max):   202.7 ms =E2=80=A6 236.3 ms    14 runs

Benchmark 2: ./git for-each-ref --format=3D'%(refname) %(objectname) %(sy=
mref)'
  Time (mean =C2=B1 =CF=83):      10.8 ms =C2=B1   1.3 ms    [User: 4.4 m=
s, System: 6.2 ms]
  Range (min =E2=80=A6 max):     9.5 ms =E2=80=A6  17.5 ms    189 runs

Summary
  ./git for-each-ref --format=3D'%(refname) %(objectname) %(symref)' ran
   19.72 =C2=B1 2.62 times faster than git for-each-ref --format=3D'%(ref=
name) %(objectname) %(symref)'

It looks like this gives us a nice speedup. I will send up a new version =
that improves git-for-each-ref
instead.

thanks
John

>
> Patrick
>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  Documentation/git-show-ref.txt | 21 ++++++++++++++++++-
>>  builtin/show-ref.c             | 38 ++++++++++++++++++++++++---------=
-
>>  refs.c                         |  6 ++++++
>>  refs.h                         |  2 +-
>>  t/t1403-show-ref.sh            | 20 ++++++++++++++++++
>>  5 files changed, 74 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-r=
ef.txt
>> index ba757470059..9627b34b37f 100644
>> --- a/Documentation/git-show-ref.txt
>> +++ b/Documentation/git-show-ref.txt
>> @@ -10,7 +10,7 @@ SYNOPSIS
>>  [verse]
>>  'git show-ref' [--head] [-d | --dereference]
>>  	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
>> -	     [--heads] [--] [<pattern>...]
>> +	     [--heads] [--symbolic-name] [--] [<pattern>...]
>>  'git show-ref' --verify [-q | --quiet] [-d | --dereference]
>>  	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
>>  	     [--] [<ref>...]
>> @@ -58,6 +58,11 @@ OPTIONS
>>  	Dereference tags into object IDs as well. They will be shown with `^=
{}`
>>  	appended.
>>
>> +--symbolic-name::
>> +
>> +	Print out the value the reference points to without dereferencing. T=
his
>> +	is useful to know the reference that a symbolic ref is pointing to.
>> +
>>  -s::
>>  --hash[=3D<n>]::
>>
>> @@ -146,6 +151,20 @@ $ git show-ref --heads --hash
>>  ...
>>  ---------------------------------------------------------------------=
--------
>>
>> +When using `--symbolic-name`, the output is in the format:
>> +
>> +-----------
>> +<oid> SP <ref> SP <symbolic-name>
>> +-----------
>> +
>> +For example,
>> +
>> +---------------------------------------------------------------------=
--------
>> +$ git show-ref --symbolic-name
>> +b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF ref:=
refs/heads/main
>> +...
>> +---------------------------------------------------------------------=
--------
>> +
>>  EXAMPLES
>>  --------
>>
>> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
>> index 1c15421e600..1d681505eac 100644
>> --- a/builtin/show-ref.c
>> +++ b/builtin/show-ref.c
>> @@ -12,7 +12,7 @@
>>  static const char * const show_ref_usage[] =3D {
>>  	N_("git show-ref [--head] [-d | --dereference]\n"
>>  	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n=
"
>> -	   "             [--heads] [--] [<pattern>...]"),
>> +	   "             [--heads] [--symbolic-name] [--] [<pattern>...]"),
>>  	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
>>  	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
>>  	   "             [--] [<ref>...]"),
>> @@ -26,10 +26,13 @@ struct show_one_options {
>>  	int hash_only;
>>  	int abbrev;
>>  	int deref_tags;
>> +	int symbolic_name;
>>  };
>>
>>  static void show_one(const struct show_one_options *opts,
>> -		     const char *refname, const struct object_id *oid)
>> +		     const char *refname,
>> +		     const char *referent,
>> +		     const struct object_id *oid, const int is_symref)
>>  {
>>  	const char *hex;
>>  	struct object_id peeled;
>> @@ -44,7 +47,9 @@ static void show_one(const struct show_one_options *=
opts,
>>  	hex =3D repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
>>  	if (opts->hash_only)
>>  		printf("%s\n", hex);
>> -	else
>> +	else if (opts->symbolic_name & is_symref) {
>> +		printf("%s %s ref:%s\n", hex, refname, referent);
>> +	} else
>>  		printf("%s %s\n", hex, refname);
>>
>>  	if (!opts->deref_tags)
>> @@ -63,8 +68,11 @@ struct show_ref_data {
>>  	int show_head;
>>  };
>>
>> -static int show_ref(const char *refname, const struct object_id *oid,=

>> -		    int flag UNUSED, void *cbdata)
>> +static int show_ref_referent(struct repository *repo UNUSED,
>> +			     const char *refname,
>> +			     const char *referent,
>> +			     const struct object_id *oid,
>> +			     int flag, void *cbdata)
>>  {
>>  	struct show_ref_data *data =3D cbdata;
>>
>> @@ -91,11 +99,17 @@ static int show_ref(const char *refname, const str=
uct object_id *oid,
>>  match:
>>  	data->found_match++;
>>
>> -	show_one(data->show_one_opts, refname, oid);
>> +	show_one(data->show_one_opts, refname, referent, oid, flag & REF_ISS=
YMREF);
>>
>>  	return 0;
>>  }
>>
>> +static int show_ref(const char *refname, const struct object_id *oid,=

>> +		    int flag, void *cbdata)
>> +{
>> +	return show_ref_referent(NULL, refname, NULL, oid, flag, cbdata);
>> +}
>> +
>>  static int add_existing(const char *refname,
>>  			const struct object_id *oid UNUSED,
>>  			int flag UNUSED, void *cbdata)
>> @@ -171,10 +185,11 @@ static int cmd_show_ref__verify(const struct sho=
w_one_options *show_one_opts,
>>
>>  	while (*refs) {
>>  		struct object_id oid;
>> +		int flags =3D 0;
>>
>>  		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
>> -		    !read_ref(*refs, &oid)) {
>> -			show_one(show_one_opts, *refs, &oid);
>> +		    !read_ref_full(*refs, 0, &oid, &flags)) {
>> +			show_one(show_one_opts, *refs, NULL, &oid, flags & REF_ISSYMREF);
>>  		}
>>  		else if (!show_one_opts->quiet)
>>  			die("'%s' - not a valid ref", *refs);
>> @@ -208,11 +223,11 @@ static int cmd_show_ref__patterns(const struct p=
atterns_options *opts,
>>  		head_ref(show_ref, &show_ref_data);
>>  	if (opts->heads_only || opts->tags_only) {
>>  		if (opts->heads_only)
>> -			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
>> +			for_each_ref_all("refs/heads/", show_ref_referent, &show_ref_data)=
;
>>  		if (opts->tags_only)
>> -			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
>> +			for_each_ref_all("refs/tags/", show_ref_referent, &show_ref_data);=

>>  	} else {
>> -		for_each_ref(show_ref, &show_ref_data);
>> +		for_each_ref_all("", show_ref_referent, &show_ref_data);
>>  	}
>>  	if (!show_ref_data.found_match)
>>  		return 1;
>> @@ -289,6 +304,7 @@ int cmd_show_ref(int argc, const char **argv, cons=
t char *prefix)
>>  		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (c=
an be combined with heads)")),
>>  		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads=
 (can be combined with tags)")),
>>  		OPT_BOOL(0, "exists", &exists, N_("check for reference existence wi=
thout resolving")),
>> +		OPT_BOOL(0, "symbolic-name", &show_one_opts.symbolic_name, N_("prin=
t out symbolic reference values")),
>>  		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
>>  			    "requires exact ref path")),
>>  		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
>> diff --git a/refs.c b/refs.c
>> index 77ae38ea214..9488ad9594d 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1734,6 +1734,12 @@ int for_each_replace_ref(struct repository *r, =
each_repo_ref_fn fn, void *cb_dat
>>  				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>>  }
>>
>> +int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *c=
b_data)
>> +{
>> +	return do_for_each_repo_ref(the_repository, prefix, fn, 0,
>> +				    0, cb_data);
>> +}
>> +
>>  int for_each_namespaced_ref(const char **exclude_patterns,
>>  			    each_ref_fn fn, void *cb_data)
>>  {
>> diff --git a/refs.h b/refs.h
>> index 23e5aaba2e9..54b459375be 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -337,7 +337,6 @@ int refs_for_each_branch_ref(struct ref_store *ref=
s,
>>  			     each_ref_fn fn, void *cb_data);
>>  int refs_for_each_remote_ref(struct ref_store *refs,
>>  			     each_ref_fn fn, void *cb_data);
>> -
>>  /* just iterates the head ref. */
>>  int head_ref(each_ref_fn fn, void *cb_data);
>>
>> @@ -381,6 +380,7 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data=
);
>>  int for_each_branch_ref(each_ref_fn fn, void *cb_data);
>>  int for_each_remote_ref(each_ref_fn fn, void *cb_data);
>>  int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, v=
oid *cb_data);
>> +int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *c=
b_data);
>>
>>  /* iterates all refs that match the specified glob pattern. */
>>  int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_d=
ata);
>> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
>> index 33fb7a38fff..0aebe709dca 100755
>> --- a/t/t1403-show-ref.sh
>> +++ b/t/t1403-show-ref.sh
>> @@ -286,4 +286,24 @@ test_expect_success '--exists with existing speci=
al ref' '
>>  	git show-ref --exists FETCH_HEAD
>>  '
>>
>> +test_expect_success '--symbolic-name with a non symbolic ref' '
>> +	commit_oid=3D$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BR=
ANCH_NAME) &&
>> +	cat >expect <<-EOF &&
>> +	$commit_oid refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +	EOF
>> +	git show-ref --symbolic-name refs/heads/$GIT_TEST_DEFAULT_INITIAL_BR=
ANCH_NAME >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success '--symbolic-name with symbolic ref' '
>> +	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &=
&
>> +	commit_oid=3D$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BR=
ANCH_NAME) &&
>> +	cat >expect <<-EOF &&
>> +	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAU=
LT_INITIAL_BRANCH_NAME
>> +	EOF
>> +	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFA=
ULT_INITIAL_BRANCH_NAME &&
>> +	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>  test_done
>> -- =

>> gitgitgadget
