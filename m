Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7416D9BF
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184827; cv=none; b=E3f6wy3/OgGG84RlNiOsFpRsy7AZb3PXJYFfVWqpMvD9sz0s37Wo5hwHBap1mUzfZd11ZaaaT669lwZCT+PDICTC0pi5nwFUbK76AFoUv1hwI5t8ngHOV1lV89AxmsSSUzib50c2H5V/mrfoPoOKaxk+L7TnmKzwJEal2/u4Z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184827; c=relaxed/simple;
	bh=S2i1U5EqOcrEQTD8nFKfho2s5/lxvzerPG8MzVovxvY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=OrJkaudfR7STJMZsArZhYb8fqownJLYdz2NncCcBEfcqa7RtqASgF0fKbFsd6ZI1fDgtNbOef8ejYLGda/ovBdiRgJIRqcbIaMf7BgSzPCv23X6BQnWWq3mUmAOFFG1Adqhj6dJ7Fah5B8gApTYFkoA7zsJcu+cHJTGVdwpSh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1ylXUu9; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1ylXUu9"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bb041514c1so1060014eaf.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718184825; x=1718789625; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2i1U5EqOcrEQTD8nFKfho2s5/lxvzerPG8MzVovxvY=;
        b=a1ylXUu9NLhsIeoWwBi72/Y90pWzVMC1jlQf8zkD3XZ//e7Bf/wUqThh7j5qdEeMU9
         YAPi72YKgXYJPqCdjWBJf01oPsA1IKKagzeD6QWJZ+LHBtR0dk7FsK7tkcZ5YZJNF8x3
         ETmLvUrUX2QEjnDNjwl/zh20TYNQWpWEnENOXhXK69K3xxL3Jq4lp0+i3d1OzLY4eTa3
         mM0mlfrMGe3Fib1OGcRqln+aAKanG9OuXSD7AkUY3v6OB/QoSo8gq6gKbBPSqTedmqGB
         5gPFhBdEhgc+OFQWGww6SEAepFH8cC4LmsmNVRWBYkZW/YcEg3wOtdoM03726Vr6KoZF
         1iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184825; x=1718789625;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2i1U5EqOcrEQTD8nFKfho2s5/lxvzerPG8MzVovxvY=;
        b=h3NMHnS+Mb1+zt4RmScGvfQXdldok/iVXEpIjGPFvDES6Acb5ljDFTP66cDNqHrSUT
         cvGUzL0F88t2a+j6sbOZn7vQqOvLIGXSWzP/Vk7GfGx5U3GrhJX6qOTMzxiDEzLGbwhF
         rKurbYg60csvJ69zuzmrEeMlPTyki0H/LBCdHwxmsxfRBEDbiYr/zl61U4TdXjckGhcG
         rMNortMRupUn+KA0LKaEgpEFP2A0+ZxuwphXLFAmP/TaFKdYMbqExadUYSV92DKAJd2z
         wvhWXZ5kxwW9W1I3giKRygwhw+RKKiIDS+Z8iVfTneqJYCcJTsRaSAerP+mgKNW54oj3
         67aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6+t/eHjPKttDux1kM1mGsVfpijUCuz8Fxe9UjNUwM2A5Lk6ZEiuZWlDGuESI58+DQbG32XeVBTWT1Kux2B6p+g+C
X-Gm-Message-State: AOJu0YwHLREOtMWef8q0/Mpzzosih1tQREFLg1gDNPEcS6Gsz0pMHxyX
	UcKHVG/khIXprzovHZQlD4Vtchuj+JO5JusZbFc5Dn1KAdL39lRkUp6AM7BRqwMLRPIF2x7YkwP
	0PiGwzEL/yMB6vSLsegEP975FStNxGO5V
X-Google-Smtp-Source: AGHT+IEAVSDhkfFHIMWYtUa3bDVX6NpVYajgaRK91EIHGAd+75mv7XQSRCWMajuvE+Zb84RzyKODCBazEJAPqDGkCpw=
X-Received: by 2002:a05:6871:b1e:b0:254:c3c9:7002 with SMTP id
 586e51a60fabf-25514b96658mr1439113fac.13.1718184824419; Wed, 12 Jun 2024
 02:33:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jun 2024 11:33:43 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <4ba1343d-1467-46a0-85b0-b249e1ddedf7@gmail.com>
References: <cover.1717402439.git.ps@pks.im> <930de119116355f0b6df9e7e1d5d0fe38d93755a.1717402439.git.ps@pks.im>
 <CAOLa=ZQ5qN9+GGp2Cmks+J2dCbZpNvd0ZEGTWejedUCtzXF9Ew@mail.gmail.com> <4ba1343d-1467-46a0-85b0-b249e1ddedf7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 11:33:43 +0200
Message-ID: <CAOLa=ZQDCwE2KZVBV16vtA9-=iqLW7c1TAFv4Cj0SQPwEC=8FQ@mail.gmail.com>
Subject: Re: [PATCH 13/29] merge-recursive: fix memory leak when finalizing merge
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001e6c28061aae1476"

--0000000000001e6c28061aae1476
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 06/06/2024 11:50, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> We do not free some members of `struct merge_options`' private data.
>>
>> Nit: s/`struct merge_options`'/`struct merge_options`'s/
>
> Either is correct, it is a matter of style whether one adds the trailing
> "s".
>
> Best Wishes
>
> Phillip

TIL, thanks Phillip.

--0000000000001e6c28061aae1476
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 83a76b6480e48a4e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1acGEzWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlk4Qy85MTFQMFpZTm1CQ1BLUzU5OXhoOFZnL3ZSagpTSG1iTmdmdWpW
MFZDVTJyTVZybXRjem5IZklmdEUwUDJOMTM0LzdGalpKUEVjd21oekJUYjNUbFJQYlV3MzNwClNP
V3dhYTBQdW10U0IxOUNwNFFCcG9IK0VudDVlUzVia0JuVUdRYjVmYndITGVYRUxQUTNQUDhoTkdQ
cENES04KVTJjb00xTXZWNk9xa1RrNkszVlpIak5nWFZ3anBmckhmMUV4cmZ3Z0VOWUxlZ3NsaWpa
MGVhQ0FxR3BrSjZ2YQpUeDI1T0JYL2UrZGhpZUxHMTQybTVwOElidkl2Y2RQWXNSSlFjUzRmRFlY
TW5GZ0VtbkZNN3ZFRE1oaGVkTGp3CkQ0aDZIZDVWS3dScGZXR2dOV0FycHF1WERPdlBSUENhbDc3
bTZiWXhZaEJFbXgzMGZFbWZEUk0xTkl5Qm9sK1cKZkJMMnpTSkVNQk5hTFQ0UlErNVc3aGM2TUdn
NkJXRDVGRGFucW1YQ2ovZy9VRmE4VEdrdlVHQ0ZneTlSdGRzOQo2OTZLWjJCK09qUDdyb1Exd2tv
UU1xdnNNSXdHYjJyU1M0S1ZUL3BJeEVtejkrRktzYjlPQW83aE0yTG03RDVTCjJPTzVRVEVrVWpL
MC8xYXdKbEc3YWVKbjlqcW5TaFNMdFQ0ZTVYMD0KPTVtNnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001e6c28061aae1476--
