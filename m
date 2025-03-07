Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F46187346
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381672; cv=none; b=Tl69wBgJ2KKOTc2gp6UXckG0dXHbdmwEnKqw5sTPQPyQq7AkZwA/HHiKGD8Gjw86WMRCbmsuoaOChKxfq/p/S9sh9Hun4MGWHUNolqQEgjdYRrs1vHRZ6T2VCPeddz+hZZHJyO15H7k6uVVqfO3eHD6C3uRT9d6q3KoZImdmlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381672; c=relaxed/simple;
	bh=2XjAa5r2wzvTr1b52Qg7o7t9XgwXpj6dr7fI1por45I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBGN3v+OtF7LPvOb6GnXPcpRcgVIm4f45DH7bmJSE+6fnwJh2Ow+FqVbgPv1AGCLHX2mPuXdpJAqd6Ek/yUSPRLnP+rS9lrEc/nPL/gN/lCWcf5dW7fYwhAjfxgP8vS0dup3UbxPMRY0VFfEFyqhyIhN7h4mfQy6cAYX7JJAiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7Wb70mU; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Wb70mU"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb18130f9so1149162e0c.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741381670; x=1741986470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqwrA+JdUenQSy1Y6QKUO30QSX4n1UbR4hwYqEItq+s=;
        b=O7Wb70mULozXhZFdBtp2TOYkmjNmu+UUcrxIwAo7g/EWZFwVGG/VZbP4FZq7h4kwc0
         X9zRpgVieVicfs0UvbHq5Hrfg+7I3uAnEw49ZLihV0LarpTBuk0beJ4mh/IC6eeBmO6O
         mytX+dwl1vLKZi0YTba3X5yUPNGRywCboknMrUBzYUHIHrp0mOgwt7Aqzv1rrDLRCEoz
         lBUgFtRSXIJwIseFgObmutpgo5XBrgBPFqFI0oDo0r02xzX6r/xDDLyPHOEERV7ojqO+
         5u+7i38NjbRVkiTpQggKlwWStgs8P3c+7/WEiziknPlm7hif5gRWPTMF00ecVaweINcA
         F+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381670; x=1741986470;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqwrA+JdUenQSy1Y6QKUO30QSX4n1UbR4hwYqEItq+s=;
        b=JCt2noP9JCX1szPYlGWmB0AhyHRtHgBcSbo9anv8xpynIHntA/U9ISsVB+kvNky7cX
         2Epknflu26RtaaoDJCPmu30pEmVmZt0X61kWHXKH6LgLkkq2ZxqyeeGu5+rhvyZw1j0D
         My9jDVkPd/7lYOKpAt+Is9vNrGQADAjRuUP+/WwTNTFw+SQylkeIQae+94RjhfpnPBzJ
         tO/d0GEg1Addo1PJjcIiKAU8h03SaRf+7HI79EVqcW48H1L4T2WR+qR6yZ2HIoUvZgut
         22aiba6CV7gHYFy0ZiogCBttuTng+Si7OICmyIq1esF5Vpp0RZ5KzGkuWhKl/YLmzPqy
         vqTA==
X-Gm-Message-State: AOJu0YwkiZppX1mnBDeylzP4UoBo6mvgg4uE9V0jLJu0NkfAROYhFlUB
	JhUVsedSpaOfCuSvt6Syu5v40B3W5qv9396wvnxoMBVBaHqsG74KLm98RSbjyVDDJps3FW+29Iu
	FAlPYORmK+e7nux4bSeJ/jeAhW6nkR5YC
X-Gm-Gg: ASbGncsproLdgXiXvTqyi2C8mfAiNbFc0CG/hlvAVGFCr0XKJ5RrfL0+QApqKuiFeV6
	6A03Uv9yKsEydvrW5sXZcjiY13LkLcVv6APgx4rmgelCYv3KyVxTVo2Hi01ksIHfY8F5VuIY8jy
	7V+I6DlxbA3jkqVroCHnxzpntYaggL3QyHWRX6tnX8KkfXgR/fYtcAZ64b84Ec
X-Google-Smtp-Source: AGHT+IFeOAv3qTieHEd802vKWeK7S97s5qyct/5nw91B1XTe+TMHvpt3dCPx3PnrSN61QMPmky0VdC1eXBE00mMByqg=
X-Received: by 2002:a05:6122:54b:b0:520:3e1c:500f with SMTP id
 71dfb90a1353d-523e424c958mr3866606e0c.8.1741381670145; Fri, 07 Mar 2025
 13:07:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 15:07:48 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250307195740.GA3675378@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com> <20250307195740.GA3675378@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 15:07:48 -0600
X-Gm-Features: AQ5f1JonbvFNaw2WVdIqbrIPpmR_Ku4M1rmnrhl1w9ATkOfESRhs38D_QBWp3Ac
Message-ID: <CAOLa=ZTqqEYX4UBweEfZiHM4Fb=gQr1oe5PA66j8n+nS_fymRw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction support
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000de3d75062fc7036c"

--000000000000de3d75062fc7036c
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 0132b8b06a..dd9912d637 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1371,8 +1371,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>  					    transaction->updates[i],
>>  					    &refnames_to_check, head_type,
>>  					    &head_referent, &referent, err);
>> -		if (ret)
>> +		if (ret) {
>> +			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>> +				strbuf_setlen(err, 0);
>> +				ret = 0;
>> +
>> +				continue;
>> +			}
>>  			goto done;
>> +		}
>>  	}
>>
>>  	string_list_sort(&refnames_to_check);
>
> Coverity complains that this "ret = 0" is a dead store. I think it's
> right, because either:
>
>   1. Our continue loops again, and we overwrite "ret" with the next call
>      to prepare_single_update().
>
>   2. We leave the loop (because this is the final entry in the
>      transaction update array), and then we overwrite "ret" with the
>      result of refs_verify_refnames_available().
>
> But it may be better to leave it in place as a defensive measure against
> the rest of the function changing.
>

Yes agreed with your analysis, and also your inference. So I'll let this stay.
Thanks for reporting!

> -Peff

--000000000000de3d75062fc7036c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4344b79c8178232_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mTFlDTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTBSQy9vRHVkcFJibURsR0RDSVM0VUplaWdaTW5OWApvcXN0cG54eVJl
UEdLWHo5S3lFb3oxcW1UdUxBT1gzb3NSc3UzbjR0WmNwWmV0U05qVWtHQVVFTU5HQXEzdXB2Cm43
SGJYbTdkQmpZaFpLMzk5OE9vT2hBUDVQSG8zYnpIZWVMNEgrRFBrZkhtQjV2cGlodzN3QmhQTFk2
MG1sVS8KTU5ZRVdDaUozNEtrdnBlRVpkU00vMlEyZHdNWEVXdkF6WlI0aEc4eEFIRTFhTTVobDJh
OU5QSGFrNHdwQmtWbgpHSUE4ekFVaWplSm9ZL2grNEYxeC9OK0MyU0VGY3R6RVV4cU5PSHBhSmE1
T3pLV0cvNlpUc3hzU2hvd3BVeWtYClJuZGdFV1lTaU96M3duQjA1MTVVU3IzU2I3SndvSG9xazRs
UjBLdisrSzU3dW1jR2YzVWRKMnJlOTQ2OGN3ek0KaHhjaVM4eEM2d082eEVneFprRXdlektMd1dO
STl6VGJjWFJPcEU1dTVhTDRadGdFTy8wdytvNFFNTHNCVnVaMgowZjU1VnRFQWlvK29FK1dvZTd3
cGZqc09Lb2gvdEVPeUVaY1g4Zno1d2l0VG9yemJ1SlRlbXY5Slc3QXhjTXRBCnZNREFHNk8zR2gr
ZU0vRE14ZEhaOGdaZU1MOEZsY2JTcUFtU0tPND0KPVZQU2kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000de3d75062fc7036c--
