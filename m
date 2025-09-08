Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38D5661
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316428; cv=none; b=IllS7ELUffcwOCOJU5xLxEXQ9oaLLjj/8JjvvnJmC8UA6mK81TwMlgT0YCQDFy+HOpoIMy03cSNoPEGDMLULec/RN7yuWYTee62vEAwUkfUPpnH+XGNFv81y1ZdcxWkWaom+FnxKVynxwkD9gVthcYBPFSDRoCMSwaG+5L0cKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316428; c=relaxed/simple;
	bh=8NtY1vr0HHTGMrbfBz6faguIku2UtORAsO9xqUVgx98=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1PWKeHsg7sF83YfNkV0BpVe8q+KfQw0NOhzyi/+JRXdaMimigYvRMMtXBtXlU/xht2u6iOKmv0EurHBWNB1URme2PdC0Vu/PaWMF8d0cBJw28dixpLiIVT+Em1DHgVN4/MT34pRJmbGy/qJzT7e8OWHYWgrvvGJPEgokOal+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ81AmDI; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ81AmDI"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-529858dc690so1147473137.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757316425; x=1757921225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwB+hhktbryV9GcQhAlRRrGRqAWUdvIqaB9ymu1O5rM=;
        b=UZ81AmDISBHJJ7/HPxuwx0GUc4FPj+vpVFkqolDEVxRsn3QXEhiD9ddyu1wFE+Btqm
         gsgBforRWSUApSTv5RvUgaqZaCJjRIYREnbOW+spzqif1f0IKRuGXuklINU2fkyAqSaa
         o7IYdhEQDybDTOFgUj4gLGlFGq7h12ZGDuGHsx3KyK0hupqIA2iQjcDnDtI3qphkq4fz
         Eue/RhJDjqgeTkarqmRey2veVokRgUGbm/8Aaj7y2LpA2jUaSeZn+crf9cMClzsHa1fu
         HhiQlCASRml+7TR6wyG2/7rOofYnq0uPRwYBTByGLEGwc6PIu8RbqOz9oycf4c+s6Z1k
         9+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316425; x=1757921225;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwB+hhktbryV9GcQhAlRRrGRqAWUdvIqaB9ymu1O5rM=;
        b=qftWp6MeWM+yE7qJmAaGcM5hZG4BFeaM+Fm6QpIC5dtZXhhN20pnGK6dp2A+jAo06U
         AfDUGkoBeoCbwIZcF4z1J+stN7dUgnDtc4brgoO5eVTiCzJXwYzDsTAcbOTjigE2Fa1/
         J5cuQdXz12zr4Ro6GWdCA3/wqLVqNPwLRvZUrWOzZyexu07ZwxaEMumHcqQ9rUu7Ip1U
         tavtAlSfj9gyDjvlHuJxX6Wy5cfz6zTd3N4PAtIcA2tmh3tNeSNmEReuXW/C88OVMPvj
         4WAq5/exRVBfINbpyacxvbV24KgBeOcn/WdBA7Ta96Z57L0f720qEbxZj66T3d/nkVXZ
         IM/Q==
X-Gm-Message-State: AOJu0Yz97kLMO4Xk/9b3BVZv6dI3914M2xAcepQZskdu5hNyZSKwDt9F
	IVkN2f47g/nPb5ifAjwfg/JiYFNZAlczpCH1yvszajzzXCXqVOkatvHooLmz8hutuzJihP2get7
	7Tw//NSF45YYa1Dt5R6DylGVBfbT044diWgws
X-Gm-Gg: ASbGncvgn0XKJ0LVc87u2HVqUwWDcDTXEoXAqtuYVRn+I3ZVrFHdLtwKar1Ps6/07QP
	U2PVMowc8ghiRVrPAlB/JgNttF8uyqb/ItNfXY5jj6MBG+uvaE508vexryY3wksNrrPyOjRg2wb
	1o4Bk+Aw3p+yPfkB3ldjRZ6QEHsMut34kHtAYbA2b7baVLc9giAJ3xVhjpHmnsYF/a7xq5rCFaH
	R4z/bBcoQgt0CxXM+BuFOW6sPTjqQ+2Ag4nuAO0Tw==
X-Google-Smtp-Source: AGHT+IEt5Wn2b+4JsBI3NRQloEYDK/HNiyaDLDrTFWbGnj4QB0IPujar9BeW6TH+g4py2DUBH3c/i72DW0RidWHPNlY=
X-Received: by 2002:a05:6102:160e:b0:4e2:a235:2483 with SMTP id
 ada2fe7eead31-53d13a4fb07mr1322779137.19.1757316425439; Mon, 08 Sep 2025
 00:27:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 02:27:03 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 02:27:03 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aLfw-peLY8NEKSZd@pks.im>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
 <aLfw-peLY8NEKSZd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Sep 2025 02:27:03 -0500
X-Gm-Features: AS18NWA7ypXeZQalut-9E30kb6nE3tbezc3y8ryDD5V9LSpISW4cR3m2yqGJZZA
Message-ID: <CAOLa=ZTC1=KRB6pANUcwpoiVKSbbCGJQPG=WW_TLEjHziyO6ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs/files: handle F/D conflicts in case-insensitive FS
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000004bf5ff063e451dbb"

--0000000000004bf5ff063e451dbb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 02, 2025 at 10:34:26AM +0200, Karthik Nayak wrote:
>> Similar to the previous commit, when using the files-backend on
>> case-insensitive filesystems, there is possibility of hitting F/D
>> conflicts when creating references within a single transaction, such as:
>>
>>   - 'refs/heads/foo'
>>   - 'refs/heads/Foo/bar'
>
> Great, I wanted to ask about this scenario.
>
>> Ideally such conflicts are caught in `refs_verify_refnames_available()`
>> which is responsible for checking F/D conflicts within a given
>> transaction. This utility function is shared across the reference
>> backends. As such, it doesn't consider the issues of using a
>> case-insensitive, which only affects the files-backend.
>>
>> While one solution would be to make the function aware of such issues.
>> This feels like leaking implementation details of file-backend specific
>> issues into the utility function. So opt for the more simpler option, of
>> lowercasing all references sent to this function when on a
>> case-insensitive filesystem and operating on the files-backend.
>>
>> To do this, simply use a `struct strbuf` to convert the refname to a
>> lower case and append it to the list of refnames to be checked. Since we
>> use a `struct strbuf` and the memory is cleared right after, make sure
>> that the string list duplicates all provided string.
>>
>> Without this change, the user would simply be left with a repository
>> with '.lock' files which were created in the 'prepare' phase of the
>> transaction, as the 'commit' phase would simply abort and not do the
>> necessary cleanup.
>
> Oh, that's a clever hack. Does this also work for the case where we have
> preexisting refs already that differ only in casing? I guess it should
> given that the lookups we perform should yield those refs regardless of
> their casing.
>
> In any case, if we don't already have such a test it would be great to
> also verify that this works as expected.
>

There is a case which I missed and Junio also highlighted, I will fix
that in the consequent version.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 9f58ea4858..466cdfe121 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -869,8 +869,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  		 * If the ref did not exist and we are creating it, we have to
>>  		 * make sure there is no existing packed ref that conflicts
>>  		 * with refname. This check is deferred so that we can batch it.
>> +		 *
>> +		 * For case-insensitive filesystems, we should also check for F/D
>> +		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
>> +		 * the refname.
>>  		 */
>> -		item = string_list_append(refnames_to_check, refname);
>> +		if (ignore_case) {
>> +			struct strbuf lower = STRBUF_INIT;
>> +
>> +			strbuf_addstr(&lower, refname);
>> +			strbuf_tolower(&lower);
>> +
>> +			item = string_list_append(refnames_to_check, lower.buf);
>> +			strbuf_release(&lower);
>
> Can we use `string_list_append_nodup()` together with `strbuf_detach()`
> here to avoid one memory allocation?
>

That's clever, I'll add that in, thanks!

>> +		} else {
>> +			item = string_list_append(refnames_to_check, refname);
>> +		}
>> +
>>  		item->util = xmalloc(sizeof(update_idx));
>>  		memcpy(item->util, &update_idx, sizeof(update_idx));
>>  	}
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 57f60da81b..84dc68e5f3 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -53,6 +53,12 @@ test_expect_success "clone and setup child repos" '
>>  		cd case_sensitive &&
>>  		git branch branch1 &&
>>  		git branch bRanch1
>> +	) &&
>> +	git clone --ref-format=reftable . case_sensitive_fd &&
>> +	(
>> +		cd case_sensitive_fd &&
>> +		git branch foo/bar &&
>> +		git branch Foo
>>  	)
>>  '
>>
>
> Nice idea to use the reftable format here.
>

Yeah, that was the only way.

>> @@ -1546,6 +1552,20 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
>>  	)
>>  '
>>
>> +test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensitive filesystem' '
>> +	test_when_finished rm -rf case_insensitive &&
>> +	(
>> +		git init --bare case_insensitive &&
>> +		cd case_insensitive &&
>> +		git remote add origin -- ../case_sensitive_fd &&
>> +		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
>> +		test_grep "failed: refname conflict" err &&
>> +		git rev-parse refs/heads/main >expect &&
>> +		git rev-parse refs/heads/foo/bar >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>
> Okay, so we again only end up with one of these references, which is the
> best we can do.
>

Exactly.

> atrick

--0000000000004bf5ff063e451dbb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cc18945a3c5bcb73_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pK2hVVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0loREFDQWFLanE2VzBLaEZWakRDaDNjT2xhUEFrUQozMVoyZUNwNFNL
c24rQndKK1BwRzZUSWhZU1g3cktMY1RabmdBWi9KblBvNElUOW56bVVidTVxT1g1YXpRWjFUCnpC
Y09Ib3puR3VpOGdxekI5NnBTUWFEdGs1R2N2YWgyakxUd2t6R3hmVzBHNE1GcW0welZ1MHMyTXVT
SG94OXMKWkdFc0NVd2cxOHJUVjdKM3VXUVdyV0F3RkJZWlV5dEdzOWNLSzdwTnF2bnJiNUozd3lj
R0RUc2I0RkNabW94dwpDZ0gxOG95enNzUCsyNFZkbjJUT1hmYTFpRFFyRERnb093M2tlTVh3N3Qw
Y3NOanB0V283bm5Na2trQzREMlZ6Cis2WWNRUktMTndYeFowdWpCSkhDQnc5a0xoQ2ZoWVNNUkJO
RnlXTUc0Tk5LWjRxZ0VnTWJuYmlkeTlOSEZLa3QKVFdKaFpnMGxvNVZ4aEVvN0p1b0Jwc25tWlgw
OWswNXB2K2ZVM1NFQXQ5dTYvVjdVMDRiUnBPcXBMV0FKNW9aNgpDU1ZjTUppckFhc21EeUR5RHMw
U3Nsb1BzVmNjMDBONkErMVhVRWtUN21wcGVLQ3ROaHVQbEtnZURDQWlRaDBLCmpaSXEwUDdqMGtO
MERHd3VNd0VJTStmMHd6MCtweEUycFlTbGVBaz0KPW9XdlgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004bf5ff063e451dbb--
