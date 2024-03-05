Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750DD268
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672166; cv=none; b=kLu0Z16Cm+FpYwhJeuf4QQszwCyarw0DOQvHwYuqo34jIMqmjRNVmpi77OhxYYCdR+cI9UoJ+bTsUU4pQocTG1ZUKM+ym2AaEXoenlN5RoQA1KPAQZeZyYl0e8WdhYMFBoCTDXR3MfM1ahtJbhs4QdSMjyaMijSla5DnPx+5zlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672166; c=relaxed/simple;
	bh=omhVxgQIcqPjCmldBMUiqht+mj4O7/XsuX4iMvOJe9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2pKSXCwBT6ciBTB21B1UFvhvIMB2lNG1CWkljUjpPVkq3pP5btctV9f1ikuM+r58ia3/gKVuUIR6gCMI/V47gkpuuS7zBo8s5Dxd3PdmDY1PzP4uxFAXALwUhtP6nTxyq2rgXjjQCweBrgk+V3v0vh3eVccihKUd93BuBi/jqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts+hfzaY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts+hfzaY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ef2251565so5114841cf.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709672164; x=1710276964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sscj4Y+oqtL8ZE0Qrc43H+5zuPlhJiBvpX/pTZ94JbI=;
        b=Ts+hfzaYqIXI1nyUYHrrGTg8WpHy5Z9F4RKE9JzjP75p3eUYYkivMurQoXKFEP2DBx
         Svg9K7Vr7gxiXxg/06cHM6Pk8J6FoxoHm/qfIoeHtEnZ9CMBWwgk4fblXaM9dH02TXug
         U12z9VJjI45JWtgA5vLtQe+wOOTO1x/jVYxrpXyU5psPs71JexfZjNOWlMXlBK/wunND
         obifq426I61uuKM9qpyulfU1Z1/pNavsX1FLX3hsauMBdZ/VsWZKAOIQFWPqVJhcEYSS
         Sh0GkxPYkLpPmy7eyiimXx2hUsufcYjUl3EhxRqUw0wOzJzNw0U2ddv1+81QI4/MlVcP
         EDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672164; x=1710276964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sscj4Y+oqtL8ZE0Qrc43H+5zuPlhJiBvpX/pTZ94JbI=;
        b=rABxsDYYik4n4dr7CFLYbiEDV1/pKJ8kkbBQ/LMyL3UL8ufV4i7gBKd+scuJPTcpZW
         5T1PNbXf8pXlgqpKdAXlNaFcZDSAWlXmKj6276JzRJr2CEdMktxj+MIdrQMGCk9DBND7
         LBH20H8//fPFCzZmmmmHyCxfB7EI9H7/bbgR1XKC3zDLdMrY2QRQq19WWYGrlXgfanvQ
         9T4ELHoUL1ca+pofRepTggmHgRabWCCC4hbtPgUKHpd+Bfxxlg7macrfP4GzNvGAJJKw
         UuqPCRpMD87X0Xg3bCKvh46lW9Alonc/vtdYl07PbpVzYIJi3tX5k+XDXeEawj4bwIxu
         wBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrf2ZVmFK03kXIf6a6wh+OPZHsUXFzxGuuY6rSNQQkJ5U4CyiurP+i5qBBicy8jy5EF11AxEOLBEOlWJwwLEbzWJNb
X-Gm-Message-State: AOJu0YyThhrAbm2zj7caLLi0k9cXaS6UlOBHQayHVG5J96rGs7FNWVGk
	Obym1aTVpMJBGXnDvQ7hn3irUg3Mug1LjWgDCK3D6lu38WaPsF8a
X-Google-Smtp-Source: AGHT+IGwzQLHftl1kjfyTl+rssngLeGUp7JYZMUJH7rILDv66z3MSMGcJSOEUTTTRaAQX+fA5jm+9A==
X-Received: by 2002:a05:622a:494:b0:42e:f4ab:fe07 with SMTP id p20-20020a05622a049400b0042ef4abfe07mr1616496qtx.1.1709672164208;
        Tue, 05 Mar 2024 12:56:04 -0800 (PST)
Received: from [172.16.0.225] (static-96-242-234-213.nwrknj.fios.verizon.net. [96.242.234.213])
        by smtp.gmail.com with ESMTPSA id dq10-20020a05622a520a00b0042e703a8d74sm1084419qtb.56.2024.03.05.12.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:56:03 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] show-ref: add --unresolved option
Date: Tue, 05 Mar 2024 15:56:03 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <44609CA3-1215-4EAD-8456-DDD66A3B93A8@gmail.com>
In-Reply-To: <xmqqplw9mviu.fsf@gitster.g>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <xmqqplw9mviu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On 4 Mar 2024, at 18:23, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> For reftable development, it would be handy to have a tool to provide
>> the direct value of any ref whether it be a symbolic ref or not.
>> Currently there is git-symbolic-ref, which only works for symbolic ref=
s,
>> and git-rev-parse, which will resolve the ref. Let's add a --unresolve=
d
>> option that will only take one ref and return whatever it points to
>> without dereferencing it.
>
> The approach may be reasonble, but the above description can use
> some improvements.
>
>  * Even though the title of the patch says show-ref, the last
>    sentence is a bit too far from there and it was unclear to what
>    you are adding a new feature at least to me during my first read.
>
>       Let's teach show-ref a `--unresolved` optionthat will ...
>
>    may make it easier to follow.
>
>  * "Whatever it points to without dereferencing it" implied that it
>    assumes what it is asked to show can be dereferenced, which
>    invites a natural question: what happens to a thing that is not
>    dereferenceable in the first place?  The implementation seems to
>    show either symbolic-ref target (for symbolic refs) or the object
>    name (for others), but let's make it easier for readers.

Yeah good point. The language could be made more precise.

>
>>  Documentation/git-show-ref.txt |  8 ++++++
>>  builtin/show-ref.c             | 33 ++++++++++++++++--------
>>  t/t1403-show-ref.sh            | 47 +++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 77 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-r=
ef.txt
>> index ba757470059..2f9b4de1346 100644
>> --- a/Documentation/git-show-ref.txt
>> +++ b/Documentation/git-show-ref.txt
>> @@ -16,6 +16,7 @@ SYNOPSIS
>>  	     [--] [<ref>...]
>>  'git show-ref' --exclude-existing[=3D<pattern>]
>>  'git show-ref' --exists <ref>
>> +'git show-ref' --unresolved <ref>
>>
>>  DESCRIPTION
>>  -----------
>> @@ -76,6 +77,13 @@ OPTIONS
>>  	it does, 2 if it is missing, and 1 in case looking up the reference
>>  	failed with an error other than the reference being missing.
>>
>> +--unresolved::
>> +
>> +	Prints out what the reference points to without resolving it. Return=
s
>> +	an exit code of 0 if it does, 2 if it is missing, and 1 in case look=
ing
>> +	up the reference failed with an error other than the reference being=

>> +	missing.
>
> Exactly the same issue as in the proposed log message, i.e. what is
> printed for what kind of ref is not really clear.
>
>> -static int cmd_show_ref__exists(const char **refs)
>> +static int cmd_show_ref__raw(const char **refs, int show)
>>  {
>> -	struct strbuf unused_referent =3D STRBUF_INIT;
>> -	struct object_id unused_oid;
>> -	unsigned int unused_type;
>> +	struct strbuf referent =3D STRBUF_INIT;
>> +	struct object_id oid;
>> +	unsigned int type;
>>  	int failure_errno =3D 0;
>>  	const char *ref;
>>  	int ret =3D 0;
>> @@ -236,7 +237,7 @@ static int cmd_show_ref__exists(const char **refs)=

>>  		die("--exists requires exactly one reference");
>>
>>  	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
>> -			      &unused_oid, &unused_referent, &unused_type,
>> +			      &oid, &referent, &type,
>>  			      &failure_errno)) {
>>  		if (failure_errno =3D=3D ENOENT || failure_errno =3D=3D EISDIR) {
>>  			error(_("reference does not exist"));
>> @@ -250,8 +251,16 @@ static int cmd_show_ref__exists(const char **refs=
)
>>  		goto out;
>>  	}
>>
>> +		if (!show)
>> +			goto out;
>> +
>> +		if (type & REF_ISSYMREF)
>> +			printf("ref: %s\n", referent.buf);
>> +		else
>> +			printf("ref: %s\n", oid_to_hex(&oid));
>
> If I create a symbolic ref whose value is deadbeef....deadbeef 40-hex,
> I cannot tell from this output if it is a symbolic ref of a ref that
> stores an object whose name is that hash.  Reserve the use of "ref: %s"=

> to the symbolic refs (so that it will also match how the files backend
> stores them in modern Git), and use some other prefix (or no
> perfix).
>
> Actually, I am not sure if what is proposed is even a good
> interface.  Given a repository with these few refs:
>
>     $ git show-ref refs/heads/master
>     b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/heads/master
>     $ git show-ref refs/remotes/repo/HEAD
>     b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/remotes/repo/HEAD
>     $ git symbolic-ref refs/remotes/repo/HEAD
>     refs/remotes/repo/master
>
> I would think that the second command above shows the gap in feature
> set our current "show-ref" has.  If we could do
>
>     $ git show-ref --<option> refs/heads/master refs/remotes/repo/HEAD
>     b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/heads/master
>     ref:refs/remotes/repo/master refs/remotes/repo/HEAD

I like this option. It makes it clear that it's a symbolic ref without ad=
ding
additional output to the command.

cc'ing Patrick here for his thoughts as well since he has interest in thi=
s topic.

>
> or alternatively
>
>     $ git show-ref --<option> refs/heads/master refs/remotes/repo/HEAD
>     b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/heads/master
>     ref:refs/remotes/repo/master b387623c12f3f4a376e4d35a610fd3e55d7ea9=
07 refs/remotes/repo/HEAD
>
> wouldn't it match the existing feature set better?  You also do not
> have to limit yourself to single ref query per process invocation.
>
> I am not sure if you need to worry about quoting of the values of
> symbolic-ref, though.  You _might_ need to move the (optional)
> symref information to the end, i.e. something like this you might
> prefer.  I dunno.
>
>     $ git show-ref --<option> refs/remotes/repo/HEAD
>     b387623c12f3f4a376e4d35a610fd3e55d7ea907 refs/remotes/repo/HEAD ref=
s/remotes/repo/master
>
> I do not know what the <option> should be called, either.  From an
> end-user's point of view, the option tells the command to also
> report which ref the ref points at, if it were a symbolic one.
> "unresolved" may be technically acceptable name to those who know
> the underlying implementation (i.e. we tell read_raw_ref not to
> resolve when it does its thing), but I am afraid that is a bit too
> opaque implementation detail for end-users who are expected to learn
> this option.

I think something like --no-dereference that was suggested in [1] could w=
ork
since the concept of dereferencing should be familiar to the user. Howeve=
r, this
maybe confusing because of the existing --dereference flag that is specif=
ic to
tags...

1. https://lore.kernel.org/git/a3de2b7b-4603-4604-a4d2-938a598e312e@gmail=
=2Ecom/

thanks
John

