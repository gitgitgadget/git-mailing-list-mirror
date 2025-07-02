Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E52D0C63
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471381; cv=none; b=e+WMySgoVTefSU2qKmQThTacad0u+iquIFmAFNvCsohc+i2Phe+pXk8SEsa6Ai4GOwEM/iJXYQuYKXnKivporXBD9t2NPTcrI8K2MfXwN713lnc1jN3yD1fIYhX5WHiiO/9NymLbT5MOEsfDOhFWRp5B9XE8NGFg3tVYPZJ8zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471381; c=relaxed/simple;
	bh=gxViCfkKcEPJ3QYB8L5FkeR4RFES/uF5J6OLxmz2SYs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OA/KKljb6QU8IimeuTmEHuwPB8SjnEd8sAGAqvoh+7MO2yeeLAsUjAEqBmEGC06g57OYCTrcN51NjP/Yr+AajZ2nWeD6jwWw0/5AhFKvGcdpTAzvig+ptHZtW493+UqEHgqGbyygHJNU31wj1daa5Yp/Nqy59dFlWe4l9qJO6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz2t1751471350t2547300c
X-QQ-Originating-IP: DUPvaZSub1YvauVah850vg9874v0wYcc/aVMVJ607G8=
Received: from smtpclient.apple ( [202.119.44.124])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 02 Jul 2025 23:49:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6087463232843015337
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 1/2] bloom: replace struct bloom_key * with struct
 bloom_keyvec
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aGVLZ9VUf2M1sWhL@pks.im>
Date: Wed, 2 Jul 2025 23:49:04 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B2AC9DD-1462-4B6D-B2D5-B2FEEA70B4C3@smail.nju.edu.cn>
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
 <20250628042140.1097910-2-502024330056@smail.nju.edu.cn>
 <aGVLZ9VUf2M1sWhL@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M0/UNHhZ6hMGdhWjCxxBhOuffIjUw8KqnbObKOsExpwkT04IMTuxxfwu
	3+il2tViyw9pIR3xcTE06FHFLWJSh3woMeVLj6ghJh+OUTJxWSatWQ53G6eb2ONA6ie/DS1
	3AvDS5Jcyoj9PnJClwDaIfO5zNfZmvwXtf6RBgSqExFZZkKNheLyxyNhQ2f9kxkJS8WKlSx
	91esWEavqE/oB4/AwqvF/jOH8x97Jn84IaIfXB7HARtlrTfKHNACM9AyHFOYa76WqMijR4R
	+S2zeRuuvnpIOFVJLJ165+dQ9hgJvNlHQPZONG2rwvp8lN8E8BlX4uTXau0BkXsNUFcNxaE
	DzejESGi35fbT1nJAAN3DcrGbsDAqDr+Cb0L3Fb0MxQGVSczlXYSIId48rmEl7K8OvrrSlJ
	OeWDITHgsC55VIbevhskz3NnCRG2tm5VARvQjsoCF4Zg5dGWT85XWY21eQQHup4w8snx5Dw
	sPt77paTqKy9urBRH3ZWS3/NZYCgj9pIZnV9tvsLKihxPrFb7Ji4pth+hSQO6iaS7pfYZ4r
	1Qc8SVTkGQEsferRSRZC/dkaooOnnTG8khGLBzxeqfmou6ohUTPnj2sUfTQ7+3AYWBC+vur
	RyZpHsDsox1T8WiVTSckRj16sxgvjJX0d9qpJ80jnGX4abCaq5b8jJHjZaEfsgpXmEId7hq
	05OkMD+tGFbS/z0r9D6QElBDLzH3+0stkOLjjxtR74FvC4bFZ1q6OkyUrTX8RCyzUIRrzF8
	jgkH2wtwMysWuIzv7QVKUQq/qyrChMbG85eavPvNlVlUzIcsiiPmSADUa3/ChTB60uXmghx
	fe/UPtxqXoEbn4Zf8GssRGxi2isuApbvoCxNbpha03qc5kR0d5LDKWcYJHRDokNo1JjQVoO
	6ZGEtd9p1a+54K0nMazhaj9A59OvQmv+XlVVp1Z83dCbEh5L0RPhEDL4joEaoEnbgDs9UHQ
	vfGw2gtJAW3jUCSx+R/THDUiiplISWdvUYU7zJyhAWov40FaabmvRSztE
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Patrick Steinhardt <ps@pks.im> writes:
>=20
> On Sat, Jun 28, 2025 at 12:21:39PM +0800, Lidong Yan wrote:
>> diff --git a/bloom.h b/bloom.h
>> index 6e46489a20..9e4e832c8c 100644
>> --- a/bloom.h
>> +++ b/bloom.h
>> @@ -74,6 +74,11 @@ struct bloom_key {
>> uint32_t *hashes;
>> };
>>=20
>> +struct bloom_keyvec {
>> + size_t count;
>> + struct bloom_key key[FLEX_ARRAY];
>> +};
>> +
>=20
> A short comment would help readers understand what the intent of this
> data structure is.

Understood, will add comment for struct bloom_keyvec in v4.

>=20
>> int load_bloom_filter_from_graph(struct commit_graph *g,
>> struct bloom_filter *filter,
>> uint32_t graph_pos);
>> @@ -100,6 +105,17 @@ void add_key_to_filter(const struct bloom_key =
*key,
>> void init_bloom_filters(void);
>> void deinit_bloom_filters(void);
>>=20
>> +struct bloom_keyvec *create_bloom_keyvec(size_t count);
>> +void destroy_bloom_keyvec(struct bloom_keyvec *vec);
>=20
> These functions are named very unusually for us -- the first version =
of
> this patch series was following our coding guidelines, but this =
version
> here isn't anymore.
>=20
> - The primary data structure that a subsystem 'S' deals with is called
>   `struct S`. Functions that operate on `struct S` are named
>   `S_<verb>()` and should generally receive a pointer to `struct S` as
>   first parameter. E.g.
>=20
> Second, the functions should probably be called `*_new()` and =
`*_free()`
> instead of `create_*()` and `destroy_*()`.

Though I think create and destroy doesn=E2=80=99t match the 'operate on =
struct S=E2=80=99
definition, I will rename these function to *_verb in v4.

>=20
>> +static inline void fill_bloom_keyvec_key(const char *data, size_t =
len,
>> + struct bloom_keyvec *vec, size_t nr,
>> + const struct bloom_filter_settings *settings)
>> +{
>> + assert(nr < vec->count);
>> + fill_bloom_key(data, len, &vec->key[nr], settings);
>> +}
>> +
>=20
> Similarly, this should probably be called `bloom_keyvec_fill_key()`.

I initially wanted the new function to have a name similar to =
fill_bloom_key,
but perhaps I should consider renaming it.

>=20
>> enum bloom_filter_computed {
>> BLOOM_NOT_COMPUTED =3D (1 << 0),
>> BLOOM_COMPUTED     =3D (1 << 1),
>> @@ -137,4 +153,8 @@ int bloom_filter_contains(const struct =
bloom_filter *filter,
>>  const struct bloom_key *key,
>>  const struct bloom_filter_settings *settings);
>>=20
>> +int bloom_filter_contains_vec(const struct bloom_filter *filter,
>> +      const struct bloom_keyvec *v,
>> +      const struct bloom_filter_settings *settings);
>> +
>> #endif
>=20
> This one looks alright though.
>=20
>> diff --git a/revision.c b/revision.c
>> index afee111196..3aa544c137 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -779,11 +782,8 @@ static int =
check_maybe_different_in_bloom_filter(struct rev_info *revs,
>> return -1;
>> }
>>=20
>> - for (j =3D 0; result && j < revs->bloom_keys_nr; j++) {
>> - result =3D bloom_filter_contains(filter,
>> -       &revs->bloom_keys[j],
>> -       revs->bloom_filter_settings);
>> - }
>> + result =3D bloom_filter_contains_vec(filter, =
revs->bloom_keyvecs[0],
>> +   revs->bloom_filter_settings);
>>=20
>> if (result)
>> count_bloom_filter_maybe++;
>=20
> This conversion feels wrong to me. Why don't we end up iterating =
through
> `revs->bloom_keyvecs_nr` here?  We do indeed change it back in the =
next
> patch to use a for loop.

My original intention was to include all the loop-related logic in =
[PATCH 2/2].
However, the lack of a loop here does make the code look error-prone. I =
will
add the loop in v4.

>=20
>> @@ -3230,10 +3230,10 @@ void release_revisions(struct rev_info *revs)
>> line_log_free(revs);
>> oidset_clear(&revs->missing_commits);
>>=20
>> - for (int i =3D 0; i < revs->bloom_keys_nr; i++)
>> - clear_bloom_key(&revs->bloom_keys[i]);
>> - FREE_AND_NULL(revs->bloom_keys);
>> - revs->bloom_keys_nr =3D 0;
>> + for (int i =3D 0; i < revs->bloom_keyvecs_nr; i++)
>=20
> It's puzzling that the number of keys is declared as `int`. It's not =
an
> issue introduced by you, but can we maybe fix it while at it?

Yes, of course.

Thanks for your review,
Lidong

