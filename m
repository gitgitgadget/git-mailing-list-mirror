Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2D1F91E1
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104295; cv=none; b=UT6avnbLozbLHUKcP56y75tB+FJS2n65FjygiJ7pZ3rpwrpnODLqcnBCzd+uR2CqrIUcAAg7AqhsapI4hXWHF8ZF0JrBnYkRgXN9FeQM2b3wZM8x3iZvXnx6GCYuG8+EXNPzEXg6Ct6Iegn2mTb2SROAH61DN99Ye+tpkcS+kIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104295; c=relaxed/simple;
	bh=hlSG/3wDzNVd2CswcrIdPlJkFhHCrpZh1Ey8Xau32/E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzXgCuL6+MJEAIYc6CTBjjVrxsBCp+i+WqyPn++871GIHP/Zxxj2IK5c8TITPVEiSMqsYSpuPrhfm2CMVF8sq34tHtUP0iL8A6zK1Ag7Mzh9aYXnmytPf+sUqfUySmHvDFzV7bwmRQjyJ+5SEn8fJUBnfdfpolIKw9N55Q0+gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwxy8vhN; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwxy8vhN"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51cd9115009so479004e0c.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737104293; x=1737709093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSKocukLhE79f8oOXOfrI6PF9IGSR+W+X/ZLqJ+CFAA=;
        b=Qwxy8vhN6WhXhUYD79WDOVZPAKt5a5T0ULyPNEH0zPJIlBVXi46uUrEBrXZ5BTx0/h
         BHH69e7fIGzobtTzbPI0IarPvqw4W8Q+IKF6NQZ5OK/8OpqyQpmLwsGW96pUnhTBFGNO
         4s2QFt48Y6h2V/TrdgdAhevgMz4/K/SpOzrHLsnLIJQ6QYLY/DGXLCfZ61PTNhdIGdS1
         AnjfOGjbCTjQhcfnMlsF59DNHgEB98sdtD4zrZ/y9HAl87Iyo8ch6BWH6c5tVIBrfsIn
         IzYh9gJqb4nslI/J0KQ61PTRoRAT5bvRHqeakxZxFwTjQ6pHAYE1etVQN6Gg1ya2Xm12
         MZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737104293; x=1737709093;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSKocukLhE79f8oOXOfrI6PF9IGSR+W+X/ZLqJ+CFAA=;
        b=YjW/P36M6nZxHk+WJ5dRzIbF39rviiCk9yEjOlNb7YhMJIlMCLxGurnc9hMt7AwChq
         8WoKpWGpKl4tKLleedFuoWxGhox7iBg/F/oEdAl3RCSj8Rtj/XQO7saAbcTj9jH4zen3
         hQWr16oHdAmgqJBGl/cNRlFdopr7E9tORIeegkewgQ8VCsQGOy7VgcwMsVPD+4YdUlrl
         0wzi/fvye0/1XZlyORSaOrD3HDFcNiTVzKOZX9sdAjikou3cyA6DYvpyeR+Ma/elpeSK
         wQHQlPM8ZxGRoBl+8PMwz+O/lp+PRVATbdN02z/awnFttS+QSgkrNlq8dS7GfHCrddzt
         ExMw==
X-Gm-Message-State: AOJu0Yx7O6592F71fZIcUrMqFDRNtvyHEa6vYbr2vSXJejPinvA92m1q
	HEp/SgCrBBsPy11fdvnt1Z48x+oxD3KBZTZJzFGTNpje10IyUSMBgLMlYWvcbC7TcfwlLOxBNQl
	ugK3g9lEVUlM1+VECtxp+Z6NaaRJGobaL
X-Gm-Gg: ASbGncuTwSDOi57pU8X3j7HSV25oD1XY6SXtTQ4ALuX8diQabJL/a7xjHSateCCB5Qk
	gibt6jKZUe3ngvoN84LBJNWOBdGPsLrAb9RaZIkI=
X-Google-Smtp-Source: AGHT+IEEqosvLvekRXk218qSid7KXQWxarivS44L0Hv7T94QeSNDApHEX6NKDx0W1FI5kiMpqc93NEJ/1Xs7mf2XPwY=
X-Received: by 2002:a05:6122:3d46:b0:50f:f21c:4fd0 with SMTP id
 71dfb90a1353d-51d5b30169cmr1129705e0c.8.1737104292774; Fri, 17 Jan 2025
 00:58:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jan 2025 08:58:11 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjzaur2ry.fsf@gitster.g>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
 <20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com> <xmqqjzaur2ry.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 08:58:11 +0000
X-Gm-Features: AbW1kvaYxztrPfPcV-5RfwLWkyWFyibpZrbwx6vwR4NoELwkIri-YE0Ur1yts38
Message-ID: <CAOLa=ZS8EeC_G56CYq9CT8cwvb5QL3nEgY1Fo1_zz4uCn8jB_A@mail.gmail.com>
Subject: Re: [PATCH 3/5] pack-write: pass hash_algo to `write_idx_file()`
To: Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004f55a0062be31c82"

--0000000000004f55a0062be31c82
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak via B4 Relay
> <devnull+karthik.188.gmail.com@kernel.org> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `write_idx_file()` function uses the global `the_hash_algo` variable
>> to access the repository's hash function. To avoid global variable
>> usage, pass the hash function from the layers above.
>>
>> Altough the layers above could have access to the hash function
>> internally, simply pass in `the_hash_algo`. This avoids any
>> compatibility issues and bubbles up global variable usage to upper
>> layers which can be eventually resolved.
>> ...
>> -void stage_tmp_packfiles(struct strbuf *name_buffer,
>> +void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
>> +			 struct strbuf *name_buffer,
>>  			 const char *pack_tmp_name,
>>  			 struct pack_idx_entry **written_list,
>>  			 uint32_t nr_written,
>> @@ -561,8 +563,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
>>  	if (adjust_shared_perm(pack_tmp_name))
>>  		die_errno("unable to make temporary pack file readable");
>>
>> -	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
>> -					       pack_idx_opts, hash);
>> +	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
>> +					       nr_written, pack_idx_opts, hash);
>
> The proposed log message should mention the reason why this
> stage_tmp_packfiles() function needs to be singled out among many
> other direct callers of write_idx_file() function.
>

Agreed, Patrick also pointed out the same.

> In other words, ...
>
>> @@ -798,8 +798,8 @@ static const char *create_index(void)
>>  	if (c != last)
>>  		die("internal consistency error creating the index");
>>
>> -	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
>> -				 pack_data->hash);
>> +	tmpfile = write_idx_file(the_hash_algo, NULL, idx, object_count,
>> +				 &pack_idx_opts, pack_data->hash);
>>  	free(idx);
>>  	return tmpfile;
>>  }
>
> ... this hunk could have made create_index() to take a git_hash_algo
> object and pass it down to write_idx_file(), while changing all the
> callers of create_index() pass the_hash_algo, but we did not do so.
>
> But stage_tmp_packfiles() got that treatment.  Please tell your
> readers in the proposed log message what makes it special.
>
> Thanks.
>

Will fix it in the next version, but in short, it was because the
function is also part of 'pack-write.c' and we're focusing only on
cleanup of 'pack-write.c'.

--0000000000004f55a0062be31c82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 469ee0f129fa7b56_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lS0c2RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXFiQy85a3l5cExqQlJNWW1DWVhRRWNjaE5NaG9IYgptUmhINExQdk91
b1c5dC9maUN2RS8zdTg5ZTdwbWhHWEtEdFkxbU1rdE1DOURZbjBhVUhmK0gxbnhNZkk4MmV2CjVH
N0xhTGdLVU9FRXcxbzZaeTVheVFNN0d5UDV1Y05hdkkxRkVWSm9jUENQVlU4d0cxTEh3Y3EyMkth
VUo1QmMKOEhKZ1pReTA5MFpYb203bVlOd2g2Y0pidk1iQWVNY3BiUXdzd2hJVE1hZE96Vzdjb2sz
Y2FyeGRITTlUUVo2RApiSmkreXZ1OWczVlhRS3o1d3UwcE9RTnEzOTlOcFoyNWx3VnFzMGxVRjNR
YUlDWHRMTjdqSXNTSkkrNUdQNzRMCmVUdHZvWmloZTdZbkwxMENiTDhiMnRBVVlXQlhpRkVlaFlr
LzZZUUpTNytqNytkNyt1a1hUOEdzZjYyM0l6bFIKaURFcTRSK3VDeGNxdEh5bHJIczI2dGczdlk0
a0pPMUxMc0Zhblg3MStnVm1wc2JvQUl3cCtFK29VTStXQUpXMApNRVpHcXZlU1ZhbDd0UTNLSm9q
bDZ0eitHR0l0WGJzM21YNGR5LzNxeWZlald6UHVzTUZnMjhMczZWYk9MOWRkCk5vS0toNHNUdVgw
Z1ZtMGtsZXNKOHlmMHBaY1lPZTk3bHY2QVpEST0KPVZFZmgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004f55a0062be31c82--
