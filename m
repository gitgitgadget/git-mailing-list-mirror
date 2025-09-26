Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE6287512
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872522; cv=none; b=KGqlp8wUgrxbMKEpAho5FnUVuHjP69vSbx9bghtAdMo+Afm8Bl+miPIWpzXdeU4bDi/x7CrUCzzFFoG/w8lIgudmTKG2qBUt91uwAoseNK8vXvEcC3uPOoT1URlcN9ek8rpVPTAJPZVRZ/ozHI/I20A4WjA9iX8256Vwfv2kU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872522; c=relaxed/simple;
	bh=J5PmOXWpusn3zZtIOC2pwZaywMi2AyD1t+zcUcWwubQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apD4hWKVbuRR+5ufWTlzlI04OljFPrmqNEudobh8y6GocNITezot8BO0s4etaruYyI1uF+xWE8dMrBAb9kuzK0bsRlUUp0yRP1e3Ak5+sSHQdNrSYMhIK43gSVqOqGAwQ4I09PE/a72+0LTVov8Qe2bI8O49T2UDd3IMm61xwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0DDXn6j; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0DDXn6j"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5b658b006e2so88174137.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758872520; x=1759477320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZEgMTt/SsaOCL7kLTIALuNe7d9P5V4ji4Spk1oXV/s=;
        b=a0DDXn6jHRcLFq7cKQiqrmgEC3/INUTAOMU/vnrQOmcEQrk/Z+JSPKwbj2uVWtVN8H
         CakMTM6WBsjUAaXj++aJt6eZVv0eHoyYaG9FVv7QPh7vO1wG2LIhhlQPL0fTUgVi05B1
         tR2sAPV5ZO9oEYGvNf8iGJBu7HoMIVl81LM6AQeCQvnMYWLa4gPK3OZaqADnS2h5Fe/R
         i9hGiCsi9PTMDVpfsMnip3nbUhql5Jt80Nu2JHBCouZcgeiwA7EpVCVyk74DE2G01Spv
         5vr2+BdBBwPw99aViUoKeKxg41knbJO5Wfz6crArYoHKEH0235mIBf/nMjlaweMRVYq3
         famQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758872520; x=1759477320;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZEgMTt/SsaOCL7kLTIALuNe7d9P5V4ji4Spk1oXV/s=;
        b=hGjvv+H0ZRymHTASIid7ZLACqz0sSrCC9LszQbJzJCZyY2GOSj/Gd0BYi9EIln1EsD
         tk82GUyY/1vOBbNx7Ggf+KoKyM0WiubdrMndgdafhGE2S1LYreFOm7dDThwXJB33/t7T
         g+0T8JCls4pMaEsu4mZR11SA3C0eOdaRN3KVC4kxB7asth7yCOiwUbpINGSwo/UbbXNX
         0wqQdcmGtjT+mwyKoKqFsnul3kqFoJ/YTGDAa2xzbFJpur40QjI3D+KqRvs6xA93P2Bo
         e0SKovuWdJWT9+qmCdG5oOEF/uBtzKn6kkZs9imAQbc6mNi4QXAI8qwiYyxfPpY0bnVn
         GSdA==
X-Gm-Message-State: AOJu0Yyi/FEAvr04BYkMONwj/dbvy/ma0gRbQfcRcQ6DaLKC85cF5mHG
	3Bip854onvRmc+RG5i3tFwMMY5yec64zAQwl8z8fnhyVYVvBwE0hwKUD2tDd+DU4llbz7I+JJN6
	ZCWjVCa7HTW7sckonhfdPcfjA1ya0Yc8=
X-Gm-Gg: ASbGncsK0b+VsMrKlvPmU6YdJKZBzAB3mKHxOVS40mDvkx2FmoRHyPzwsM0VY2C4V1B
	CZQDGqhbjaX5a++MOYYxYPTeCUGA/YYJ4iL1BWf9Ye0A9AZe6LGB7k9flMsAn+EDVjuryV+wDo5
	0qK+su0VdqmWVUYwjCNVo1WpSLfbSAKPSKHw5q1X4SugbpkNUaClqhgut1Ec3QmERak4T05c+Pj
	H96shkp6HPX57O6YHrVn69HuSW9DzdGT2684m0Qzg==
X-Google-Smtp-Source: AGHT+IFpqnH/Yf8es/4tS23Tgn/+6OY6n6GpPi9xtGFwN+QNGjZWtjPI4qmSNOOrEZ7el1RUeRFIE6mzSysmKoTJyQ0=
X-Received: by 2002:a05:6102:3591:b0:520:4054:6b9 with SMTP id
 ada2fe7eead31-5acc604a9fbmr2833274137.9.1758872519997; Fri, 26 Sep 2025
 00:41:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Sep 2025 03:41:58 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Sep 2025 03:41:58 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjmyh353.fsf@gitster.g>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
 <20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com> <xmqqbjmyh353.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Sep 2025 03:41:58 -0400
X-Gm-Features: AS18NWDzGJXefjqaSybXlzmo3v8smCUOr8_f_TA9ZBR-ZxZfHbFe9xzc7JoOD2M
Message-ID: <CAOLa=ZSfL1CVCNjD0Vi3kpQqLM6t7YVa=G2ChGpaza6WOjZTCw@mail.gmail.com>
Subject: Re: [PATCH v2] refs/ref-cache: fix SEGFAULT when seeking in empty directories
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c2f543063faf6bbb"

--000000000000c2f543063faf6bbb
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
>> index c180e0aad7..e5e5df16d8 100644
>> --- a/refs/ref-cache.c
>> +++ b/refs/ref-cache.c
>> @@ -539,7 +539,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>>  				 */
>>  				break;
>>  			}
>> -		} while (slash);
>> +		} while (slash && dir->nr);
>>  	}
>
> This is at the tail of a "do { ... } while (...);" loop, but inside
> the loop I see this construct:
>
> 			for (idx = 0; idx < dir->nr; idx++) {
> 				cmp = strncmp(refname, dir->entries[idx]->name, len);
> 				if (cmp <= 0)
> 					break;
> 			}
> 			/* don't overflow the index */
> 			idx = idx >= dir->nr ? dir->nr - 1 : idx;
>
> i.e., if we scan all the dir->entries[] elements in the innter loop
> and did not find any hit, idx would become dir->nr and this inner
> loop runs to the end.  If (dir->nr == 0), then ?: operator [*] would
> become the idx = (dir->nr - 1);  And that idx is used for a while
> before we get to this "while (slash && dir->nr)".
>

This wouldn't happen because before the loop starts, we set:

   dir = get_ref_dir(iter->cache->root);

So, `dir` will always have an entry (i.e. 'refs') in the first
iteration, after that, the checks in the while section  of the 'do {}
while (...)' loop will kick in.

> And then tha tis used like this.
>
> 			if (slash)
> 				slash = slash + 1;
>
> 			level->index = idx;
> 			if (dir->entries[idx]->flag & REF_DIR) {
> 				...
>
> IOW, isn't this check a bit too late?  I wonder if we can leave at
> the beginning of the outer loop, even before sort_ref_dir(dir), when
> dir->nr is zero, or something?
>
>

We could add it there too. I can't see the merit of one over the other.
But if you see it being more readable. I'll happily make that change.

As the author of this code, I do find it complex already.

>
> [Side note]
>
>  * I found the problematic ?: extremely hard to read, given its
>    contrast with the terminating condnition of for loop.  If you
>    apply the discipline to keep the textual order match the actual
>    order, i.e.
>
> 	for (idx = 0; idx < dir->nr; idx++)
> 		...;
>
> 	idx = dir->nr <= idx ? dir->nr - 1 : idx;
>
>    people would have spotted this more easily.
>
>    But perhaps that may be just me.  Anyway...

I'm not really sold on this being easier to read. But that could be me,
So I'll make a second commit to make this change, we can drop it if
unwanted.

--000000000000c2f543063faf6bbb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a3d6838ed992d2c3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qV1E4VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1hDQy93S1RQc0ZmZEtvaE9LVElqaVJRTm5PQlg1RQphS3BkaGRIV2pW
KzNvMDFZdjJQSGJvOVpEb2RKTHlIT2NnV0xuWC9wcWtTeElTcFcxMkRDcVpnNkdHMk1scVRRCis2
cG1CRWFZYjRaUGxJUklIT1JmbXBaL3pUNG9lM1FaamMwWUUrdWtKSExPaFlWalYybkloMi9vdWNM
Mk9jSkoKVWxBeTBNR1h4dXkzUmcvYkZzeFZJS3FHZllpN1BBMkxMUTltNXM2a0tQRHFCQjBYMkpX
Smp2bFN2WXpsd0tHcQo3SGVXaG9yZGVDNEFsSExpYWQyZGcvMjFQRmJtbTdrWGVNSnNvWHRWR3h3
Ty9zTVdjZFBjeTJJVjBXSGlVcE9JCmFiWC9seklNWmlwWCttSUQvaUR1YkRPSVpRendOaElYQWJq
VjM3R1krUXBvQk84bDFMWFdrU0VSc1NDd2ljbTgKWWJQa1ZNQ2NQM21lUGJDN3ZYelh5Q3hQU1RF
K2VrMEpCbWVudFI0b2xOWExKckFSNU1qMDl6cFpaMkdIMm55MgpqU0FxNXRWZGVlQkRMRXNKQjZk
N2NERW5MNHpycEdIWXFCd2F2Rk5jVW1QaHhxZWIydlVUV3NrMEtaMFJmbFBQClZreHRTUzZHN3JH
OFR3eHQyTTNMRzFsK0R0My9tYjk1QkNiYW5ibz0KPTdiekEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c2f543063faf6bbb--
