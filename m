Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C330229B2E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580262; cv=none; b=ndQrjvMfNZwiYA8M+VYGf6RJbQn6yFP/WSOR/Xr24JZZd4CP4ykOVLm4xKAIKFGpK3AhDenWJBBk8f8LKWnaWNRuoj0iJ9aiZcmcSy1fB+hIV+yQQVSNpu8nddH2SZR1chznySIUP30eMusTii7gxpdi2Z0tkeCisM/wyj5Sj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580262; c=relaxed/simple;
	bh=bqmXcAScso3k4hCBPZD9l99haBo02Fy/U0g3ei1KQs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRDw4X3XT6TL22wjA1lmaZvWP81M51tAVTWKS/wpttV/fphiSsYQhtJ4hulehrLntWTM0PRdq9tr/fqOb7mVbAakbjb0xrLKA9jiOuHdnAMAJ3sWG0+dWUZHIh7K7t4wRByrAQdBAxnC9bz7lWTJbSSD90q84edwlb1MMhXIYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1GMmjmr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1GMmjmr"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso4913358d50.2
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761580259; x=1762185059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqmXcAScso3k4hCBPZD9l99haBo02Fy/U0g3ei1KQs8=;
        b=O1GMmjmrKRMuRdNj0rAowsqnpWURULNAB3O/Zc+AL3/s3OcOYaawN3g4GbMV+XnsYQ
         I/lCLsZx7vxIo44D5vfkbXDcf5m59TZiooQ/F/Zc/2WNT4NslJ+WTyp0LqKJQA3Cyeon
         Yjwij+bVUSc89fKHqqZ3i7bMJN3HD5wgPXJM/fyqlYB6iqnLfTwY4Pnddw+zJyWX5syQ
         fA72pK469BQBVVnwpN29uTJoU1H9+LPZ88RFVt98Q4lYtdRA55TSk6P6dRIIOoJTA0zS
         JqcIDZv8cHHivtm4qcIldtADvHJO9l2tVj2wET7jAYQ/jhNd+pgoEROQfJ6aqkvPUaxx
         rW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580259; x=1762185059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqmXcAScso3k4hCBPZD9l99haBo02Fy/U0g3ei1KQs8=;
        b=qbGvEXzCWdtbQ0GKBnEpdDe8ywSOR5MVi33YIHIvQWltwpaI53tL5/FfRgToI2ducG
         XvycaIJ+5owtI31HsUx5SAGRlgI7AvpO8ygqKv1z5Ehj5YOKtRH5Olfs9LwTgTs5La3m
         dLAsIehKFCGqgPfc4nh1CN91JgBgE+GeobdXsXI2EiSjMlSZh6AbrcBS++cDCMKxDTHo
         Y2UQFKrwK3BEMWnBqI/XShwmPAVkI7Ku0yhFuIKCWLkXbfvGg2H/qTBJChH7TTZDzqkv
         9e+9+p6Qg4D2MwM+mCKCkQocp6pbI2WkD05l7+KJIQ+QbA3VOXT3o2SG8szG1Uuq3k3y
         zeZg==
X-Gm-Message-State: AOJu0Yxawu3z2ylTreK02Zo1S0pETM+rvLz2xavyklx1n7pEAvHz1iCJ
	/0IvzIQLAHIR66ITLho9LbEMqwFAhD6uERE07VtGudRx2m7bIc0iC/hmGo3ZTVQ3JorQZp63GGL
	9YiXiOJfyvuLbYcVrQfNQuJ8492JuFPo=
X-Gm-Gg: ASbGncs0hhndVtfDTq5fRA0OSNuv+vf4O9b520gfLr6uDstF4l8NYGAE1wqEctrf67l
	1SgJdhDHBYag5fWIJwhLBUPmNLUsNOA3kFC9FeyJB11hmW1E4m0qzyY7ToSY6hG5agvCeJCKZiE
	3pfLfmFESAtIPvslSeK5vrz3/dRLPwcXnOiLBVSU4MLBXSR8NWJfqyl8vq/61arUoETHicc1PTV
	jgVQZqNXhTlTl9XKPh7vCIZ1y5ALYfZobPgAvdWuEur9ZxEQTILeRrs6uGVRKyMcw==
X-Google-Smtp-Source: AGHT+IGQ/mA+cc+vC7aa9ks3qZ+VFbVznjMwn+d5byozBDXjNC3aItcQP6pxm7XGNIA7wnD1egaWd9u7JVtQUegikpc=
X-Received: by 2002:a53:ead1:0:b0:63f:548d:cb4e with SMTP id
 956f58d0204a3-63f6b9fd572mr313111d50.35.1761580259533; Mon, 27 Oct 2025
 08:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027111600.1481-1-qjessa662@gmail.com> <xmqqms5cl6t8.fsf@gitster.g>
In-Reply-To: <xmqqms5cl6t8.fsf@gitster.g>
From: Queen Jessa <qjessa662@gmail.com>
Date: Mon, 27 Oct 2025 16:50:47 +0100
X-Gm-Features: AWmQ_bkwfyP1j55mwzAjSun4iAVXBX8ejwibA30CAei2oYW2-3gwEHNhTiWNDbs
Message-ID: <CA+JX8Fq+HwKX0Zkf59kiC=GaQwFJ1DPTgHGVnJ25t8c8vjw9yg@mail.gmail.com>
Subject: Re: [PATCH v3] MyFirstContribution: add note on confirming patches
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks for reviewing and for the clarification. I appreciate the
feedback and will make sure to exclude generated patch files in future
submissions.

Regarding the author identity, I wanted to clarify that Queen Ediri
Jessa is my real name; the same one I used in my first patch. I
adjusted the configuration to ensure my author name matches the one in
the Signed-off-by line, based on your earlier feedback:

"We want to see that author identity and the identity on Sign-off
match. I can tweak the author identity on our end for this patch, but
if you are going to send further patches please make sure that your
[user] name = '...' configuration is what you wrote on the Sign-off
line."

Best regards,
Queen Ediri Jessa
