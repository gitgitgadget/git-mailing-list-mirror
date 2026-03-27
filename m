Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0A32FA18
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774652862; cv=none; b=UKZLZlETY/9v+Bu8D5zqieujzoNbjnUZAosDPcQTDyiw1bE282V86KcRZo94FAr8bIECf+uTgLZccsGPacMdccy1PIqzuXOqRTQCzeDzcNTIW8jcCK1V7fcmvIfdfd8gMRxqJC2O9u7arS7mmp4D0AzCaK64fXk702IMYvTWfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774652862; c=relaxed/simple;
	bh=WBRWR1nBRQQUi296HzIgTUicicwv4ADrMANUNNJyVFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGBpAV/FfyQH4B6+gl3kXD+UY8qpchDcGxLutNaO4MgF1jDVePd0bin5H5cilOLpmvuGFtsUt+iPtUY5wdwUhhWBtlrpSCQixYIsRqeGj//pSGiA4CV3u1EjP8v8UCHAMOAbHMDovFuDx+tl2G8pZ7U0+c42sSo18NzEtWaWqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=C8N9HGKO; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="C8N9HGKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774652858; x=1775257658; i=l.s.r@web.de;
	bh=Rk/5IfXb2SkKboV0Flv2gdZeiTnC+nhWSkGZyrqqgXM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C8N9HGKOUvQ76NnNAJCpfE6V4BsIcleRq9N3CvoNMG+RL+HxezWeGkSN+rAVPlAU
	 K/xzU4Re9BZqK8ygg4CpVN6PQIr6NscYqG5063RrPjLlfMC4l+nlaYoNTFzyJayJm
	 xrWLHD6+GfNIUb31hd+I61iTztBF7SFK+X/y+q2h0PVYDIF9VWAlUR+eFmaf2KPmB
	 didnVgsxfh8Pt6Jzz5Z1mZbRyFP2SKiFji242TzOIHoSNROQYv+fOdbRtDffkDlGO
	 GgcgCjj0pYvDzt2Dn0ZNJwIDG+zPVWlnc3JbFtKEw/cpGxhCNyI3bkQJnPm1BrdAz
	 vqKHFPVvUgIdudzBdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1vju4e2JQg-00aJfi; Sat, 28
 Mar 2026 00:07:38 +0100
Message-ID: <b1a9ce9e-fe3f-4f1d-a603-7f484f1ba834@web.de>
Date: Sat, 28 Mar 2026 00:07:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] use strvec_pushv() to add another strvec
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
 <084f3b43-91ac-4553-8305-03944e97eaa6@web.de> <xmqqeclb91v6.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqeclb91v6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ELIHA0iFp4DagjCX7m+8R0RG74AEzFjsBiEYvQsozGWq4zngTx7
 /9PCmMn4lu0HgGgP9rYOxbr0Hnf+gCXKuJc5F+zZNhrUcEvbgFdXsWbOxvBEDCYOjOlTb7f
 JBSB/szoPHxqXr1GYX+1rraeFXa3xK/AgW+AIeOXUrQ7YeBpM2Yw9PHJhuCOlXhHlJdzTxt
 e/EwRk+z0j4FRq6fggVhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sHtHMx8MSEk=;52r3TDM3bNqJv0qpDq2BOJd7F1w
 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

On 3/22/26 7:05 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> diff --git a/contrib/coccinelle/strvec.cocci b/contrib/coccinelle/strve=
c.cocci
>> new file mode 100644
>> index 0000000000..64edb09f1c
>> --- /dev/null
>> +++ b/contrib/coccinelle/strvec.cocci
>> @@ -0,0 +1,46 @@
>> +@@
>> +type T;
>> +identifier i;
>> +expression dst;
>> +struct strvec *src_ptr;
>> +struct strvec src_arr;
>> +@@
>> +(
>> +- for (T i =3D 0; i < src_ptr->nr; i++) { strvec_push(dst, src_ptr->v[=
i]); }
>> ++ strvec_pushv(dst, src_ptr->v);
>> +|
>> +- for (T i =3D 0; i < src_arr.nr; i++) { strvec_push(dst, src_arr.v[i]=
); }
>> ++ strvec_pushv(dst, src_arr.v);
>> +)
>> +
>> +@ separate_loop_index @
>> +type T;
>> +identifier i;
>> +expression dst;
>> +struct strvec *src_ptr;
>> +struct strvec src_arr;
>> +@@
>> +  T i;
>> +  ...
>> +(
>> +- for (i =3D 0; i < src_ptr->nr; i++) { strvec_push(dst, src_ptr->v[i]=
); }
>> ++ strvec_pushv(dst, src_ptr->v);
>> +|
>> +- for (i =3D 0; i < src_arr.nr; i++) { strvec_push(dst, src_arr.v[i]);=
 }
>> ++ strvec_pushv(dst, src_arr.v);
>> +)
>=20
> It is a bit unfortunate that we need to write these four cases separatel=
y.

An abstraction that matches both struct and struct pointer as well as
the appropriate member access operator would be nice.

"_arr" is a misnomer.  struct strvec is not an array, even though it
contains one and its purpose is to store multiple items.

>> +@ unused_loop_index extends separate_loop_index @
>> +@@
>> +  {
>> +  ...
>> +- T i;
>> +  ... when !=3D i
>> +  }
>=20
> I do not grok this one (not an objection, but a statement of fact
> that I have to look up what "when !=3D" is doing there and I haven't).

This line matches code that doesn't contain i, which is loop counter
from the rule above.

>> +@ depends on unused_loop_index @
>> +@@
>> +  if (...)
>> +- {
>> +  strvec_pushv(...);
>> +- }
>=20
> This is a bit questionable, in that we would probably want to remove
> excess {} around any simple single-statement block, and not limited
> to a call to strvec_pushv().

Perhaps, but this rule only exists to mop up after the one it depends
on, which can create such a thing.

Even if we had a general rule for that (and I'm not sure if that would
be a good idea), it would probably live in a different file.  And
without this one here we'd need to run coccicheck and apply its results
twice -- first for strvec_pushv(), then again for brace removal.
Unnecessarily annoying.

> I think it leads to a philosophical question: should Coccinelle
> rules used in the context of this project aim to produce the ideal
> result that does not require any human clean-up, or is it OK to make
> humans notice there is a questionable construction without updating
> it to the final ideal form?  I've been assuming the latter somehow
> but I do not recall we had a discussion or decision on this point

The README doesn't say, but mentions "cost-benefit ratio" twice.

Without brace-removal I get (with "make clean" between runs):=20

Benchmark 1: make tools/coccinelle/strvec.cocci.patch
  Time (mean =C2=B1 =CF=83):     18.864 s =C2=B1  0.084 s    [User: 51.865=
 s, System: 17.521 s]
  Range (min =E2=80=A6 max):   18.677 s =E2=80=A6 18.974 s    10 runs

... and with it:

Benchmark 1: make tools/coccinelle/strvec.cocci.patch
  Time (mean =C2=B1 =CF=83):     19.066 s =C2=B1  0.132 s    [User: 52.462=
 s, System: 17.665 s]
  Range (min =E2=80=A6 max):   18.956 s =E2=80=A6 19.300 s    10 runs

I think a more interesting question is whether we want to keep the
overall rule.  If we do then automatic brace-removal doesn't add
too much a cost on top.

>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 6ecd468ef7..a32224ed02 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -1024,12 +1024,8 @@ static int get_pack(struct fetch_pack_args *args=
,
>>  				     fsck_msg_types.buf);
>>  	}
>> =20
>> -	if (index_pack_args) {
>> -		int i;
>> -
>> -		for (i =3D 0; i < cmd.args.nr; i++)
>> -			strvec_push(index_pack_args, cmd.args.v[i]);
>> -	}
>> +	if (index_pack_args)
>> +		strvec_pushv(index_pack_args, cmd.args.v);
>=20
> This does lead to a great result, and I presume that this is the
> doing of the last two rules?

Right, and the one above them, of course.

Ren=C3=A9

