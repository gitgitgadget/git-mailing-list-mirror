Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4336C9D1
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566017; cv=pass; b=SsG7U6mOP6FkAfoeIgWL6IxxRaEQ1zyCG1obU5DnrOAF5shPga26rn9FQe2kVU6TTTGafJgrRAUuUI6vFmX189CBuIyUXmKYSefn18wkVEoPbUKLOcmXnDoAbEmF8URK8hRRYw9/+b9EUW+0Eq6EJZM3ZZzoKlPryu5sVmEB78A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566017; c=relaxed/simple;
	bh=j38lSW44rDfhM7CXLYa5qJOjJik+fWOp7mfYggyveNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4w6xoVjMge6yhIt3bpGdEXc8r5cez0wfnluHxHWL8bzGgRDwDKZ1SNhNbHq0TPT7bSUsB8Ru/45cyPshsgsGvM0C4dOWkmcEMAAFb0GoF1CEjsVW2zomaZfD5fxUmnOn5IoIM7iOrCCZOW/NzgX5+Nos+U7E4gxD2eYVPOMyik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QCXK8md/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hajHKHxa; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCXK8md/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hajHKHxa"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0LlT3238347
	for <git@vger.kernel.org>; Tue, 3 Mar 2026 19:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j38lSW44rDfhM7CXLYa5qJOjJik+fWOp7mfYggyveNs=; b=QCXK8md/BXBy+3Jy
	zGIvZ34rKhGXwM3Gm1jsPRO8x0mnyl/KcX0UKWLKRJUmH01jVyszTte3viR4wgGj
	ahwr1IqJDQ3RIlrm1+MPs2FMUB+Buo3CLN2b2m0otBsAD3nZ9AnPGw046dmA3I7j
	Mqtde0GPyV6CHTOkxdKG0AvLbYvm/cxEIobWOAeEo6x/KhBtC/DidlBImQtuFwtl
	+irg+4RTOvYK+1aPH1B2/w0v9npi3qtmfFQSum41DJMqIXjvQ5mMgLSAc76NvvHN
	xGw4Y9Dte0DCAsUYzlhsWlIwSfs/N11o4JmmHBQpKLg2UwUqZfv484Fc26+a3Mmi
	VkkliA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtu9yrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 03 Mar 2026 19:26:51 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64ad2a28349so7075897d50.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 11:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772566011; cv=none;
        d=google.com; s=arc-20240605;
        b=ZwEmxlm10kRMvXMT/cxRQ09/VLOHG1c0wiph2XqpxpBD5NeQo22U68zGFkdyYo3q61
         X0nuTSOhzN+/4mGRgl0zBzVMFXMXknZN7LZB/e/aLXwfsuTuUBaginMfdzNSi2WiuFR+
         kE77YzfZSQ27dZJauBlLublT6vI+UigGFX5jKa+eCUy00Fd95LajWed2o/ob/asXmDwv
         G6OGr0DQbDyl2JYBEYl5QtcErlnQr6DSgCwH2QwM+4gDaH6Py2AUULUy6rUf2UWQjlzi
         NRpFfsx2fpmFxhNXTbZ0wyQNZQjvCqdcd+sFoforS1GxSBxafNyi1lwMl7wpQMJHNkGr
         ngTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j38lSW44rDfhM7CXLYa5qJOjJik+fWOp7mfYggyveNs=;
        fh=DW7/E6WjsU7x309xCHuRB1/ZdJJbGvw5PKToTZNYdGo=;
        b=F39MN7xZhfFB40zJpOAYOCakDLm1MSwKkwFeJEqXBp3mInigBJgBDn12TsEZBslMlH
         niNaYB1LHQQhO+Z/HpVGasCC7LVbybZBOHsYSBGRTXe3ybvmAORp5k3S/9lEJnWIVxfZ
         Z/mVdp2m5cpCbUp2FS1A0OHi/kg2fEgshVGJVW7lXE5O1Cr+/Iu+wkFGmoxOCkN+5K1u
         gssbk9U6g+C7pI59Jrnvaag2U5pbDDhZDFFdqQJP38CvRm9HBqzsjr7TqS08X0rqPSJv
         5CM+SnRgh5FdsJyZgEb22+JfDlT4O1uktWSwqNMZJ3oUArsMTZZ4NTlRYjuTjOwjQa+K
         lenw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772566011; x=1773170811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j38lSW44rDfhM7CXLYa5qJOjJik+fWOp7mfYggyveNs=;
        b=hajHKHxaSpb0yvn0gSZdrdBK/8NQLcpYO6eK2vMO1YJi5CaIsF8A011TNpJROFSYxq
         68Pl2EU70LnpNVxL3kA41ZJUT7iRA/gvuPTHuk/EmufVBuyGCD+D2Z+NSqhklZzxIx9x
         Cj105ELLb9s2jIUmy6/bK4z/Ye4to0/aNvCCQTDpqadYwr+/dTaDX/BqQxhgGXoAstoD
         9uE35RmyW0pvLyfwoePdlGLuNswCfcv7hsIudyhnyeehRPCCkQagITPNdEUuj8hPN3EQ
         PK8b8s6/7rvlFTJI5WWG4RSl8KvmnIWuhJcmQjCIKvkeu8WywLbwUSn5YSolVnHJVQrO
         N14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566011; x=1773170811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j38lSW44rDfhM7CXLYa5qJOjJik+fWOp7mfYggyveNs=;
        b=Aucf6uGlrAqOTUO6wSV6mrCiZqR9hBC1NoX1QynueOkX2Eriai2VzbZvkAysrc+KeK
         po4STiEl1LV5CaUt9c5lnJqJGJtsuiEZC6YQ4aSiucdikcMyfoSBFHiZkZ/DBVRTNkIr
         sfTv/Jo0zx/PGQu2i8/20HML/N1YMbqkg7Tw1mNYl5wvjO8S+sT9uyvHEJ2bmwi04Qz9
         OFxQqYt+3GLAS1UjKj5U1AOTzQxjc025yGhJMmG5dEQEDdOqe/+k6jt0BFTibuUw4nBX
         wsgmbZo9nASYBWuv7qZaF4hZQQkWb93T1UejaAV1fR8xmnXsg9VFUW4Ei+FAxe4tGBVm
         dABQ==
X-Gm-Message-State: AOJu0YznGXXGB+z9oN/Z0edFXG501KybYnsXiUPf237ElF/8Z3rrYOZR
	8022A2IN6FT5RL6fhPXqG60fske3X51Ur/hipmmiq8fP6Lqr+McDJ6fYwmVFB06zfKX3Bjd1kfT
	ie0709IDqvlG/H4sVyo8d/h/W07D2qXFODNcrqjic7pKKjBwnKSBfMDeb+bqoKXG84WhyhTi1XO
	3Fpcm1iW2cs1/W4tlL4RvBGgLE3oct4w==
X-Gm-Gg: ATEYQzwHehRZUcnjF08UIoTD/eYxI5axWVHb+cQK5/QIOdjXnFJrC37zEoJXjAVr0H6
	9+8RgwuDqp8CH3J9vdN21cCJOs1+AE6Jpo0JOwtx9YpE6rlMErC8p7oR0YZAimPQ/bf+ezq9HIR
	HxcLSuprCNINndixNPUvg1B6DYbm+UHY13O22Yp6GMT7EF3zZSehwT7kGCgbgkfnM9drQz5+5X8
	Th0Xt0=
X-Received: by 2002:a05:690e:15c4:b0:649:e1e8:2f09 with SMTP id 956f58d0204a3-64cc222b058mr10663828d50.51.1772566011399;
        Tue, 03 Mar 2026 11:26:51 -0800 (PST)
X-Received: by 2002:a05:690e:15c4:b0:649:e1e8:2f09 with SMTP id
 956f58d0204a3-64cc222b058mr10663820d50.51.1772566011069; Tue, 03 Mar 2026
 11:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
 <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
 <xmqqfr6hfyqq.fsf@gitster.g> <CAFcKa=-ei+93P_Rp+2eKWW+43aSyg_hxHb9K6X5KmXEcS1VGvg@mail.gmail.com>
In-Reply-To: <CAFcKa=-ei+93P_Rp+2eKWW+43aSyg_hxHb9K6X5KmXEcS1VGvg@mail.gmail.com>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 12:26:39 -0700
X-Gm-Features: AaiRm5194voQDKMWtb4RjFLDM2Op6EYDu7RM6rFUmLUueG90eN_IYNfSUjijumQ
Message-ID: <CAFcKa=-EH7YD0bjeUyC6EVijTStuFZYOzQHbAnoXRUtY694Khw@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: YjAnQGVqefWaKw428klu8PfN-0bObXzb
X-Proofpoint-ORIG-GUID: YjAnQGVqefWaKw428klu8PfN-0bObXzb
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a735fb cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=N85yrnZVSuQvAVkIEGgA:9
 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1NyBTYWx0ZWRfXw4dICDzFOfuT
 3IAgGyU6IKZnDwkoLdZXfRMEsLDHG4qVhHkkdeV4B0UHLYZ9tsFftfYRNapZ3waje1xC4GfZ6ym
 nS0SYwU0AHWfX/FGo6vnwfK0Zx2FYRe+hzN9jIZs5zWWoHaDh0QklfVI6eWe9JaDAk/DCqWhDEA
 YyTJiLgrLVc2QrHDN0gDQrW1WXs7ixHbqQ8PHZ94gmpt9NNWG7NNMj3iutDzgWHFiTHOlxiiCRz
 J7XFNEKyl6Uu5zCEyI5a/td0jTCT8Aio/qd425DglY0X01R89d/mkaZEGRrMJsq/Gtii4eswuM+
 DUmsssevNgvcjk9WoRhsq1tUWYwYdZYbD6j2Fm4T5lhGJgIyywU7hDYdpiDojcoly/Utqz1TIXe
 pzhslIKtvJapzTG3ytRkMjcaLFy26q43mHwCtgjwQPL9+IMcspxK85ny08NvoQGiQ594JbQIs0l
 A1JkzOrs96csmQFChsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030157

On Tue, Mar 3, 2026 at 12:00=E2=80=AFPM Nasser Grainawi
<nasser.grainawi@oss.qualcomm.com> wrote:
>
> Also, I just noticed I have $pwd in a couple places and need that to be
> $(pwd), so I will send both those fixes.

Sorry, ignore this. L11 in this script has `pwd=3D$(pwd)`, so the $pwd
usage was intentional and not problematic.
