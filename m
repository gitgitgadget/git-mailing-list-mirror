Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6A155333
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556561; cv=none; b=d4RZKAsSUGmaGm01XDBDzITmcxfirVRvcYLqeNuLSSy6/xoJnUZsBDVGzjmDDAzSX/IIwOnzj1NelFLOT79fsf2E1jpNKPNssGcy11ibTPC+WJb+Pd0wXyuSpvqIrnvGRigwnEde4KI6B3+oo69tBG9bgfMR5Uox7N8yUh7olqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556561; c=relaxed/simple;
	bh=HJyCkisvJptU0yn8KU4/X2N17skPZI0mcWzWrJVCSBM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmuUh6T2iCIkq8JE25OChCeW3iR4aAf1pEaxVIWRzoowd9+yv7xyCctFtgyJSuVamz9QQD5rSUVs+dtSqopvRAwJixWpccAoH0XVcQoiq5jvbcwiW46nVXg6mMPv0HLUUBNtZGencaYlDTejeyxmgGlnJghjti3mOGIANnDxra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzeE68q4; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzeE68q4"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4fc15e2c451so597397137.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556558; x=1755161358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfM6gBXU6emPdMu7mS23nThxZ5iag3UxHyTdWakzEMk=;
        b=BzeE68q4DWxl6MP8N+zlnHjUeS4aV/CgW6s/pK5KrNWk99OwlSPkyDx/Qmb0PxH3GA
         gItHZfs+kB+OT1wxxPgjQPaOngObtjAVMKgMUgx6O81ivTZlK+cK9fL9eGhVpcaMB5oo
         A9ctK/+D9g9Sge45Pw9EJszmI5yG3nuMnepcoksOso+SMhXsGc8WuXN7+i3iZ6aDzxup
         7p3kUFQweM4ZBy/fAQp/7vqxPLlFoOKwocFlSg9bflerKcL9LqxPMSObui2gUCPbv+mq
         oGvpWCAST5/8eNB5rHXzKkb+Eut4jmwIQWAj0uyzsMbIOg6L3+soMQIaDchTcqIy3WU+
         AhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556558; x=1755161358;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfM6gBXU6emPdMu7mS23nThxZ5iag3UxHyTdWakzEMk=;
        b=EkxkdzvWwNLWjEWDl/fU8FUiCKmtWbEwoVxBbjCWY0ZrGhhckGUuMukHr5JjCgbcPu
         Jmy+jGa0Ni+lM2eO9OLlE4Fy0d9d0p9VvDUbgg6eD6lESYQtlcPIwN8Y3wmP0WdguwfQ
         0vhNnS8aL2+Ztaaq3EPb9id5fRR2lcGMw+rhxTnxIsAgmQwMMSoi3kjRcY/I1L+VjbZN
         OFiXoSzBoep0hKp+3x7aLwZ4jbIP6MKdLGkPFUV2UBFBrtYG82AQmXrdLY9GzLrF1ElU
         Y+jNvXXZ125iGw6FAMJwXezcRi9zIfAUgK+aRHs+WlUM+8Jq19aV1Sq7kWrgmQlqJbvg
         y+gw==
X-Forwarded-Encrypted: i=1; AJvYcCUPFo7WVzhJDq2D6/L69nAUcN3m3AB+tTQlDb87S4LlD5oSbOAmB46Ge8UCiLT/V5u2Uy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlHCfEJwIp5i/n+zKZQv8Av2UPQ+RmCtEC9FXjomD9Do7dCLq
	/B3VZsRTgdoqcp+pJxD4PVsLCOylzKKIsdZRLC+BmpcP3EdX2GKuzSH0evb2kVq51l+8eR7MwUt
	xYtuDWT5h+Z/lmjenAMvUKx38bj7Gnwiuwvlm
X-Gm-Gg: ASbGnctHtshRgOlpYTIQq0XVev4nionjVTgJ6aeiyZHcpIuIA/LRzMWPZVkRqAkHHhY
	AdDIVeeDG0NDIsXxsf9k/6fnWYiZkXyh5jJzHOtrXncGHEgMcoyrP6WxnS/patuu2OHGJziLSDB
	FJRIJPHuCqo8Kg9rwkd6TIhIQIK6yDOq35tOKFExY2VUk88zyaDj4VF8azVUODF/djDoH2vnBXW
	GQVAQ==
X-Google-Smtp-Source: AGHT+IGQ09X0a7UQBuhyqf2irpVwQ9kVrAz4Ra/Dhlt1PCMNdtZX1ctnypqe4X12B8+oikyzsNzFbT2SCzn+iGtBczw=
X-Received: by 2002:a05:6102:d94:b0:4ec:285:72e1 with SMTP id
 ada2fe7eead31-5037873c802mr2545639137.6.1754556558121; Thu, 07 Aug 2025
 01:49:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:49:17 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:49:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-5-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-5-748db2eda3b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 04:49:17 -0400
X-Gm-Features: Ac12FXyObTYSfWOmO6UlF2grwf8UQtpW_q3jhAPhtNxQbzEBW_rUZG3omKJDIMA
Message-ID: <CAOLa=ZTA_3po038J7DGxk=gEM3JkkH5afBeRqTJLcKNM87hmxQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] midx: load multi-pack indices via their source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="00000000000062c07c063bc288dc"

--00000000000062c07c063bc288dc
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> To load a multi-pack index the caller is expected to pass both the
> repository and the object directory where the multi-pack index is
> located. While this works, this layout has a couple of downsides:
>
>   - We need to pass in information reduntant with the owning source,
>     namely its object directory and whether the source is local or not.
>
>   - We don't have access to the source when loading the multi-pack
>     index. If we had that access, we could store a pointer to the owning
>     source in the MIDX and thus deduplicate some information.
>
>   - Multi-pack indices are inherently specific to the object source and
>     its format. With the goal of pluggable object backends in mind we
>     will eventually want the backends to own the logic of reading and
>     writing multi-pack indices. Making the logic work on top of object
>     sources is a step into that direction.
>
> Refactor loading of multi-pack indices accordingly.
>
> This surfaces one small problem though: git-multi-pack-index(1) and our
> MIDX test helper both know to read and write multi-pack-indices located
> in a different object directory. This issue is addressed by adding the
> user-provided object directory as an in-memory alternate.
>

Doesn't this commit only fix the 'read' side of things i.e.
'cmd_multi_pack_index_verify'.

Shouldn't we squash the next commit into this? Otherwise, writing midx
present in a different object directory is broken as of this commit no?
For e.g. in 'cmd_multi_pack_index_expire' we call
'handle_object_dir_option' which would add it as an alternate obd, but
we don't use the return value at all.

[snip]

--00000000000062c07c063bc288dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4b71c4c754e1672_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVWFJc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melpVQy85QlZ0N3ZRcS95YTMrTzJBQnR1c3A3eU5LTAoyUmMvWUkybUt2
NFhRWDNzd2RpNHVRU2VRTnBzRzN2UGxTSDBWV1VhWWZGTWFxWEdxSHhmWlAyTkwzTnc4ZmJSCnR3
QUF5TEMvNmxyQkpLTWRGMmorSVRYUEIvVTZHc1dPeDlSQTgvMER3TzlvNkNZZmNSRFh1U0xDaUkv
R0xydGEKbGF1WkN2ZjJ4MG1oSWI3UFowR2txT1pwc3V3dm5XOUtaVWYyOGdHZnpxeGhFc2NuaFcz
TVBneTdJbG5jNThVeQp0TlVJb3daRXdsaTlzVmJCaUN5Qk9nK29ObmQvUnhXMG10VkQxOExqWjhu
cUNVcWNkSlJpaWlMWHJ5U29pOUdRCmxwZUl5cjJCbXpIQnJGT1VucTBLaml2NHJ6WVdNem9Lanph
MmxKdE5xMmFuVzd5MVRNaUlZYmVLOXlKYjE4WGwKOWxVY0Qycmt6Y2VqV0xHcnN0NThrd2hGeitM
cm05YlFEekR5Y3JDVXVrTnZ1d1ZuNW9JbUZWRXJPdGRrVTNCawpHdWNHdGJPcTd6elV4amhPTnM1
SkVDYm9ob3ZEbzVxbVY1ZEtLaGJkdW1KTmFMQjFyZFZkWUxhVUM2b3NzbjZSCjBJb3RPbjN2ZnN5
TlVCaEFBcjM4emZKZ2VZNjFWTFBLVEYwZWxZaz0KPWRRdC8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000062c07c063bc288dc--
