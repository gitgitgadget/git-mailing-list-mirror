Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D11F76CA
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659627; cv=none; b=DFuF01Wr6FOlIa9mhe0nRBBBgU7UO2tCyWyxaiRe8G2GbN+2+Rt++gF4vn89xtzIMEhHaMOoTM8BJdfrSkfAXjPLfItw3BdphUKbFOgqEfYfZrvQkk2QEomdqp05mfnVLK1GfSksEltvMHuauKTFNgMlwWy5oFlQrddNeEY4ALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659627; c=relaxed/simple;
	bh=uYtbLAAFGEVAYdAXV1T87icV4WzYH8Se7plk+K3sl2o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ef6uWJjjT0y0Ej+CGx3VAxlGUp+UCp7Bb956gfzg5qYqJFtKBbIe3GbVMvk8j/7949KqGMBjkSMaXQ4cNTbSlVdOKR54D77TBGwDKLXtIrKfZQgLeQdZYX8EOTi0j5KT1JrOwjTiB2H98Ux2IZQSVL/LrChdDXgMm6qxtDAtG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn0AHzOv; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn0AHzOv"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5188c6f260cso1645090e0c.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738659624; x=1739264424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZspDjSiAlXfACVO+cpHUQ5cFcfGXgTjDGrH5xaQDNs=;
        b=dn0AHzOvfjs2u6MOF3eU8HMyOPA9Sa4rCMndYCb8ioEP2QwVlxnBo9dZgcWK2VX0hL
         WUiTn0OVzd7qb+YQozOiTVWgRib4LD09yyxoxh6jA05ZsMpsMw8AMWJ/b2OcCYUFIX3v
         CGavkeFg2mnhfEt4JbxeOFjz6KBLzmOtE3yvYsSikTWY5v98l57cxnbmJ7ONdNvlLDuE
         Xx1oJpSoenZEA7o43jOxyUYt7f1gNjAKzPVzH6VcuvaNYrH/X/QAI7v2UCZJxGCgYReF
         KUQCd/vyYMpyK36dgT2parmRB5YCG5kllAU/vrVOOPZSqAFj/RLZ3no8aANcT+YBKUDK
         3ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738659624; x=1739264424;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZspDjSiAlXfACVO+cpHUQ5cFcfGXgTjDGrH5xaQDNs=;
        b=cUY2CP6kE+O6pU+3stK0ZEZiuoxgka+iEaS9K/cc+OL6ere9pn9rAnOiIvVc3JfJQQ
         T53SyVUWgDo24CFCz9AhfaexG82DN2lfLdxCTGn1+E538x9rgILvP3ZtypUyGAG5Ilba
         CPH5TIWWeTiacW6EzxBNWwabywSaCBQd++F3ic4rgbYS3eozvOqwiIpWZLdBEerJjy01
         UrhWxnJHxRXN9yW/pyo5rHxynq0LCYfcqiRyINhsOt2m0pwAVD5MHk0GmOOLiYkVcPW/
         fr052zqLUsUtdiJVaXXHAttmWYNB8rizJ3+OQ3XXSVDTVVDX/NGPFUn7wcMTaomQQzrQ
         O6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBBZn4Rfe0I5Z+hthYicJWYUCAG5gJcY0DRDyeAOgni1ZsxrX3hS7N4Alasza5hidN7Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzVbweN/YRDfst/KYc1aeqIUkIwxcLeVJa+nsLxzL2GxPc18A
	4wRP0xxfdCbx1dWVEjXVpOZeawpFsVesf4mdAyOF1aFGjmT0eTtmylS9fznRvH/0SJZ6pO/dUSD
	5My6KYp1go+yBu0ywO8w87f7eYFc=
X-Gm-Gg: ASbGncudv6iNkib90INsU9RwNRRxfUY2CEtT4BU3D8jdVAPKZ/DEqmf6fMoSmboxZS6
	JWJ6b6MjaUO47DKroz1Gba7HwpsTl4Ov+7JNCtqf73lzzLt1cLOhiKCC/H+HPeLvh7EhcnxFFir
	hVEIai7/8xW4gMs55p7ACv5LSMl0hYDQ==
X-Google-Smtp-Source: AGHT+IHYMxRBIJm0sJHQ7GL9uCKRJ0ibfyqthmNXcQCIQj1kE6llXyA5gkQvbr7C0Qy/0es2Fn5PEJrJPKgH4DMhxrY=
X-Received: by 2002:a05:6122:488f:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-51e9e556b10mr18654839e0c.10.1738659624290; Tue, 04 Feb 2025
 01:00:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Feb 2025 04:00:22 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250204040558.34766-2-meetsoni3017@gmail.com>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com> <20250204040558.34766-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Feb 2025 04:00:22 -0500
X-Gm-Features: AWEUYZmgcQW9Mg_8MqVA98yhTrsCUh6zCFEO706Ozt5-LuZe8Mr-bTIusgcZytc
Message-ID: <CAOLa=ZShqCkyabVK2PU-XXpx9QS3_W=9QMH6ioJB=t8Ec2NYqg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 1/5] remote: rename function omit_name_by_refspec
To: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com, Jacob Keller <jacob.e.keller@intel.com>, 
	Junio C Hamano <gitster@pobox.com>, Pavel Rappo <pavel.rappo@gmail.com>, 
	Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Matthew Rogers <mattr94@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004ab615062d4d3d2d"

--0000000000004ab615062d4d3d2d
Content-Type: text/plain; charset="UTF-8"

Meet Soni <meetsoni3017@gmail.com> writes:

> diff --git a/remote.h b/remote.h
> index bda10dd5c8..66ee53411d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -261,11 +261,7 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
>   */
>  struct ref *ref_remove_duplicates(struct ref *ref_map);
>
> -/*
> - * Check whether a name matches any negative refspec in rs. Returns 1 if the
> - * name matches at least one negative refspec, and 0 otherwise.
> - */
> -int omit_name_by_refspec(const char *name, struct refspec *rs);
> +int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
>

Nit: The first sentence is now duplicated by the function name as
mentioned in the commit message. But aren't we loosing information by
removing the second sentence?

>  /*
>   * Remove all entries in the input list which match any negative refspec in
> --
> 2.34.1

--0000000000004ab615062d4d3d2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d4d33ab76d29db82_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1laDF4OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekFzQy85L1NHWCtwMzUyNTIycHY5TTRpT2l2TEwvYgppcXBGaWd4Y2Fx
dmYxdkpyc2Z1QzUxamg0Z1VCSmVueVRMNnlFTkgwQ0ZyaGVkcURWOFBMUGs0UDBRcVY0YThpCmo4
dmFTVm1meGRFWEhKNG9OMU1RaEk2SndXMWVyd05BazE0RStlTDJVV3RrQ2VDeHpSMGJQMUhudjA5
K0xHTEIKWnIyano1UlN6aWZFcWhZNzUxeTBMQWNzQ0gxQ1drTjlkZ2h1U1BKL3V4ZzdNY1FsLyto
aVBkaldnNkUrTEUrWgo0TG9jVXBOajcyS3lmUGdKeTZJM254ZjZPM2lDNFBLRzUvYVUxcUl2cmJT
NjBnREhEQ1hKZWtRd0s5eER2SENxClpTN3hhK0UwSUFNeWxHRHc5d28xSWt3M0p2MWdibStQUWox
L0NqMnIzTW1LL0haeGlBTkZUK2h4c0NNUHByWE0KbS9VOWxmYkdaQXJoY1NjSlo3N3pqNmtXZ1M5
MG5ZcWxGUkhsaVF1dVlrYU83bHcxbGtCa1lqajFSSWhzR2FCQgo0WXlQVTJoM3ZlaWdXTGRCVjN5
Nmk4SGdnRmplVFdrcmRpczUwTDBnRHhoblM3R0l1dE9GZWYwRTl1WGdzZEdhCmZpTFpVVVcxem1U
aXFwRHE0M0VocEN2RTI4L1N3QlFuTWtlVU92VT0KPVRxbVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004ab615062d4d3d2d--
