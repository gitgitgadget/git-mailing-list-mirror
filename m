Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7F1BEF77
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402592; cv=none; b=cTm4W7uOf236SQlqHENrQ00AkocIYyY0AEGEKRb/6XVzebczhzZMf11FdhkfCaxggSiCWo2Blr/iTOPbyoqktc+PIlenmZqzaHO7ec9DMZ6zo4uFBJb+XMoaLCHvZziz+SsQSmlfHoTOYcb2k+/0J9lC1OU69xLlvkDatb/Dqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402592; c=relaxed/simple;
	bh=Q+kPmgUbU6EwGZjVj3LZO6FNZzN70uarhMvx9CIeB8g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=a+4V0BChK4Ka6yRIhE2lDIiEPzOmKpj3pdo6ZnfRqPoMOwArEHkOXCTHUCphyZdTt9qqi10wMygev2OtFpXm2fTqHGMc3J+oqzzSd/zhP8Ri+BRNSPLb2ni3+oa4wuwPgpKd/y8kJh5DNvzJTZ8qnus8HPMsUShZsTcb7l4LbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI7IxQOG; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI7IxQOG"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so5212497241.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402590; x=1746007390; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+kPmgUbU6EwGZjVj3LZO6FNZzN70uarhMvx9CIeB8g=;
        b=YI7IxQOG6j40nfNxflTP6rrYSBbtHpoYWp9ulKy68QY0ppuwfa7pE6eOnRMPXzWlrk
         ivUA6+DPaXTzrZhsVsspXtbYzs8Ma1g6OLprf/qhsvnUwG8vHV59NbasWzj9wQhP+gen
         FYDzsHob0ED7Lo0vefmsru9gbyiTRvnBgaUeifNK1jKjwS7QVy9STTpkhtav4L9aleJt
         I9vQ607yU6qVcW2TlMd7w66nW7Bqy8rhMXoVFAZOiaSGKH+hsQ371D+YOA7Rt0wpbVzm
         kC8+m7QlBwY/snXw5yRo8NIRaIsQtmhwGTcD8zy5ga/NVfW6fDOHytB0Y3HPqXGBBpDS
         a30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402590; x=1746007390;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+kPmgUbU6EwGZjVj3LZO6FNZzN70uarhMvx9CIeB8g=;
        b=hLfCJ/mSPo2++Tawg0xzISbeU2JVs3uTFsp8mTvpSQ1AsSQQy0IbfSOFlJHDk8fKvZ
         58HCiC648ycqCW6NOLQCm178yNE+AJzGBYRwidOaE4ZozN1gPpS9eeJnwgYym6uQe+8x
         kMNHTH+tiPtZ1N6rq+iCdfk8zMjd8SSyDW3vT/vv13s5Rn3HwrEMULAouIloL2/yYRt+
         0G6FQOaIPbcEcTG46xpFK45wrMoyARDSX+cbTa0v2CadzXyAyTvEJW3pSJgKJZO16Rw0
         m7ClpdeGilr0Ni17zzhzRvbMxTcp5RNqgpVDgg25Uy54rzD8KOSLvpBtDoszW5HVgqkU
         tzWA==
X-Forwarded-Encrypted: i=1; AJvYcCVVxz63UaZrHMppkahtmJx7ExloBSBHuMm4OiIDaW0k/b26/9NK1UkFOuKAtgsSExyKtiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygs0wFi+X4glZssNLoj7iMDAelP2diHn9AmN1GbmDzc7oJoanR
	SRMKbgBqyANOFVDlbWpuYQVrZexlzDTUCUkorpDYWutTmhr6t/lE9dpZQ+GR0qMqpFjAZSyRbYL
	wbXGDlwPp1gnmViwykFseruTtCXslX++F
X-Gm-Gg: ASbGncvfQYRKKNMloK8DaDfVYwVveKFnmmPuXeKFP+1bLlngYc4G652f+j1q7KkZ3o0
	2xLHSKrcMGZ61AOGNSIPNIdziSasja7KLov3Fhx3TOPmDWxNxhGozIAU/Irb+vkEkRmqlHW/PmT
	KSLWGoXUgo/AX43VJwNXbR7RRHXx9VH3v2RPZmucJbPi4hvSs7k/ON6oh8
X-Google-Smtp-Source: AGHT+IH+4DCaLHd41p5GkasGg5w1+CM/0oSz8XzKtyEwgxfNxFJrATRL+VgIlLr83qbV+6s8xLjWGesUpsiCTHttZGk=
X-Received: by 2002:a05:6122:2a0b:b0:520:61ee:c821 with SMTP id
 71dfb90a1353d-529253f804bmr15967914e0c.3.1745402590361; Wed, 23 Apr 2025
 03:03:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 06:03:09 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 06:03:09 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-3-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im> <20250423-pks-object-store-cleanups-v1-3-81f8411a5d08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 06:03:09 -0400
X-Gm-Features: ATxdqUF8Soq3buHDG9e7FzYvKfMtI9VOYYvaylwM8y2b3XpLxVGsKwyHMOpTK1g
Message-ID: <CAOLa=ZS8n+MTG1e=zViEL944yuO_UuqnmT9cTqmTkktHoUiirA@mail.gmail.com>
Subject: Re: [PATCH 03/13] object-store: move and rename `odb_pack_keep()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000639c5706336f35fe"

--000000000000639c5706336f35fe
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `odb_pack_keep()` creates a file at the passed-in path. If
> this fails, then the function re-tries by first creating any potentially
> missing leading directoriesk and then trying to create the file once

s/directoriesk/directories

> again. As such, this function doesn't host any kind of logic that is
> specific to the object store, but is rather a generic helper function.
>
> Rename the function to `safe_create_file_with_leading_directories()` and
> move it into "path.c". While at it, refactor it so that it loses its
> dependency on `the_repository`.
>

Rest of the patch looks good.

--000000000000639c5706336f35fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 408d1d0aeac03d75_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSXV0d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDFlQy85bjR6bDF4c3hNZHZURzFKRVJhRG5ocFlrLwpNNm91NmJLQ0tK
cEJxQ05FTm1RWXdRNEtmMGhGajgvcTZZRWozS0ZRZmdMUVMvT29LVlZxdWFFMG5neGVEZkErCm9J
THlWdjRtUUxLWjdMNjZzTHVVd1pIbXV0M0hWRnhyWGJOb2d6amtOWHorY2NHbVFBTTNsZ3BVeVgx
OXU2YkUKZ2VuNzdHTXZKVzBLUWQzUElnaFQvNEh2UTUwOXE2QkNyZWo0Z0t3RFdQeFp6aHJFdC8z
TTh2d1NYMU1tLzdLNwp3R2FIcXkxYWRHc0kySTVWOCsrVTlWRGZUOFQ1aDFza1B0SGVBVmVOK2J6
TzdRZ1VlemNIQUlhUEhGTG9PYThJCkVFT0xhUFZCOW45RVZIcXU0ME9haUFYTDRqdCtvTGFQK1NE
THVwbXFhQnE2em9lU2NKVHBTUFJ2UGJuVUtFV3oKbmg1Tk5UMkFJa0J0djJZOHkxRXJ5SXZMaHdm
VFdEdDNwVHVHMkRBakV0SnVmbjR3TUc0RkY1TDRab2hqWFVSNgp6VU1YSVFhaW92VU9mQXQzei90
Y0IwcENpMmV1M0RMK1h5K0MyTDlCTWtIWmFKeHV5NnFKNk9XL2JmS05keXg5Cld2dFRzU2RySEsy
MmpOTmdMaEdsdDBOa2hJb2VYNkM1d3RNZDVWcz0KPUs0bGUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000639c5706336f35fe--
