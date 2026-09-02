Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4F33BBCF
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323797; cv=pass; b=hLDpHXeKIrWqZOP2tVDRG4+4PLNbZ8h5uTPGsUACqlzM6xuDzBD4vp5mmSsV/7wS1l4Ai2eV2QYIOYYm9bVW7BHTV+MA0+CM2MEz5166nvr309bkWwCtp5/pTGY9ADisxgwuN/HnQbVQFNnUkzCM2Uxn1xmWzgciQR1wuR4l8UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323797; c=relaxed/simple;
	bh=YGxsK6sacQMbzV0u+qLFcnaOjZ0jgRiee48RTles28o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOYwl7WRcp+OpdXSI4sJjQLvwDi7lchxf0+VwSEHCI11vEfRLSrh60hEK55KoSx51nhHV1citBsMkeLZ/yw3Q071kU0eUyrWLLUEXuLwPySetOuxxBXVGbJQs0RMiOQAg1mXmYMZpCzhux+7EVFGCPs+VsIh1s65MZlcEP21f84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvVdRzQF; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvVdRzQF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so662991a12.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 21:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788323796; cv=none;
        d=google.com; s=arc-20260327;
        b=OlLWNpOWte4MxNBfh09Lo/AftXTfTWcfA+2TRIW13lhqyCp27Y+AWGMR7oyxs5T0zL
         yd+WKZA0j8rmtqubId7mu2HBfrq0xeZ3SjN8DguoMS4w7OohHjXayRAt3UFoKQZk6dOX
         ruEFPQMA+VMHmWGaMblzxHIW6xSYu3+LsGuTYnoZQqyu4oQ20PwT/iSbqswcU0RcVhG0
         gctjesj1C1YDv73dC6UZJ/IhSmPIJCgGqjInaTZcqTFjlYPB40CfzSIYWcTwbwOaJYpK
         JlFzPNcKiX4+V255RLw4whqOyBRgtR8ykxs6MBtnmanyVg3E/U/8a1QveBP4C/uuWddE
         IVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YGxsK6sacQMbzV0u+qLFcnaOjZ0jgRiee48RTles28o=;
        fh=xFkGNlwBTIbSQlTAuP7IICOn+9qF32ywGtU2a0gtYq0=;
        b=EpHQjit+q4h2R2JDYRjiX9Qg/DGZhHrEn9sfEjiAgZ7uKorzdE5T+7I+tQUYjueJxO
         OiVR6gZxCyeSnwtbfdtP2AJsI8fqhdFyz6B+QMxiCHUp2E/0y4K3fIcGu0jV/4r/8FoK
         ThRmswch4vN5o/EsTSSZVWhyu6AuVhG3AOtIKgdY0piH0MVKSA0QjH5QtnrmRERWvpZO
         dpgchC20uA9e4B/5D3JHLEn20DAF094R3UWy/NggNBdDmbFjtYXZBTkCAUUm40LudLll
         8nREref8lilybye8QjKJ/pB1lFHPWvHB9OYbq0eWPBjEwJ4/jnraohxQ+X1bXE1Mycm8
         FpfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788323796; x=1788928596; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGxsK6sacQMbzV0u+qLFcnaOjZ0jgRiee48RTles28o=;
        b=EvVdRzQF8hNrmKam90/Kc0zjLDYNqkoc3TYHOF/s0gI1B4gYgDo38UDQzdpWBopWNd
         Qilb19FrvTd/JpsH8ZdLcDd6pm2shyAb+WLCZitmVh3LIgXQaS0if1njnnWekfkJRMvB
         2nUjRtLpU+rvVe8LTGlXygqBa+y7Kxs2x6JiJ3hVRNEnGEmdCjUCk8OkC+WLD9TWzIbg
         0lMp/ZXPRcLHYyajxiMBoaIwG3SB2tqMcE/Kmm/IsNSx3AvAnKjUWIYh0YOFXirDCFqo
         zVehP1Y6YFcaLbUcVA5yO4MwVGEkFFRT5pxTvIbzzlqRL7G/1bex0M9Q0dq7DIgtChcx
         y68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323796; x=1788928596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YGxsK6sacQMbzV0u+qLFcnaOjZ0jgRiee48RTles28o=;
        b=X/Y9F79EXa5p2/+r+seSoFRhcDwHmuqOJp4jVCD119oc+yGNUv+WTaLqlTc4QTlXit
         T6lJVxAr7hGC1zDXuhQiq/RyD+0Zr3brSg3EOziZarCMk1SMr2glVUhokWAbt5oduanL
         9BT9tTyyrZvuZYTxeHgAFXp1D/qpSAgx9kZLy293myhJSpCDjQs7W1zPKBJkG7HHYgI6
         gabxZhB4sCC050F6BJK8XS5AyZalMHzE7DYvcALgH1LeBPSts89ro+J8QbTRUK/0HKo1
         RAmPWr7Sz35IkA1qFJTQUE/QYgn5T6NBmd8Z80NvU9c9am95nSOkwhSFQxnGDnXqPt9H
         7MLA==
X-Gm-Message-State: AFuF++nAAJMOJ3bzEpNtTSaKTkn8Or3mYpj+9e528fyiP+u6ToTDd0rO
	D/g1GafeAKr3jeGnEprB4yu1xgiTdAlW9wGRRDTR6OsQRdnghuAXKBJFbxjK9hOOOe7XQHxIYUc
	Bir9dglhg0SERr4ki4PRxnid9cdjp8hpv4jgQJjY=
X-Gm-Gg: AYBFou3nJDGeSYiyVzPXjZcv1BeoGY8Hy7IpsWcBYcLPLk7T+Li84XI2xhZPt43vxST
	YdF9WLfbYQ00rmrhpDbeVy6s6PMunxfs46pQOAdOdOn+FPqEaMbfl84rJp471OpObffjKsTunfe
	Rxif9yfn3Ak3w+6rvebKeG4q5Ou+1MahY0L8CbIc8SeuCrWb41+FSV40hHO+ZFpG5Fu+Q1ID+9y
	zT9OvwRFLylntEGGUEyhn4LYsBrjJ1sAsdvsv7MvQmWGQCrYhKCSQMnCT1ni+sK8uRedQGg8+X1
	3lMdmo0e0lygEjKC0eTXHa6/8lTDFQs0tLX6+uik8egyuULmu/KDmAU9ymemi8od71dG90uYFs8
	JRNUrVPeGkg/TFQR+Iq1J3rLcmn0LGw==
X-Received: by 2002:a05:6a00:35c4:b0:857:73e2:9107 with SMTP id
 d2e1a72fcca58-85ed99b48fcmr3814254b3a.23.1788323795629; Tue, 01 Sep 2026
 21:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
 <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com>
 <CAGWgyh9154HAPs-YoMz6G02TfcLe3CCcd93TJjg6e+hQsmZxVQ@mail.gmail.com>
 <CAGWgyh-fXm2WdAqZDjYeHAuucniWnoathQvsFP+rDsKvxrs+eA@mail.gmail.com>
 <CAGWgyh8ijbA6gUcSgdkrwRtjSAfYbpfU9WitmcnFAr-ObAZ+RA@mail.gmail.com> <CAGWgyh9NjgXgJcrPs_1rWc-8U-e3XbvcpnHuSQjc8dv+7kX+cA@mail.gmail.com>
In-Reply-To: <CAGWgyh9NjgXgJcrPs_1rWc-8U-e3XbvcpnHuSQjc8dv+7kX+cA@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Wed, 2 Sep 2026 10:05:59 +0530
X-Gm-Features: AcwNN1UWPwBEb2k7EiDaKiqmchnKkJmku4IC7R-7StOpdu0BT_61OEDALzikCyU
Message-ID: <CAGWgyh-rK=_SGHwVHMMGOgbsAEpondXK74xtym3VekAYzmHT9Q@mail.gmail.com>
Subject: [GSoC Blog] Submission : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

As GSoC 2026 comes to an end, here is my final submission report
for my project "Improve Disk Space Recovery for Partial Clones"
https://siddharth.shrimali.info/#report

Thanks to the community for reviewing and sharing your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
