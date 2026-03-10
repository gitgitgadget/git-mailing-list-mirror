Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA43033FE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154887; cv=none; b=lqWquvSpF9vgXyxmF+jL3gRt4CS8XmxGXEI7elZOjozRTDzOYi7V8aWG5TAL+9fk3F4Tc49J74KQGsP9mkUIKaAYzO5lYx8ScBtFQAhHgPFDt16QGshFp8Wm9g+zX7g0WBoJWlzjVMQ7PAc++SQqiq3OG3P2MJ7ghFUfCA1hFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154887; c=relaxed/simple;
	bh=MNL+BWnHERdiMwFlgMeaXaZ+/gHD8c6lwrJ6alX70ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmOrksLws2zvlKPqsfc+TrtjaoRPB/KGsfHJKs0s+Q3QExfTH6SHq+TtextGPWZ304Ol+Lbf9kXeYE1wPr4u1W4dSFvIv3470xl0/dlL5zApNYlUlh3opaIZFD+ZmS7AANrqdNo5G9YIoB6BSaGJCGsqd1a6uMxDARXgOITcJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXmSXf8X; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXmSXf8X"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so6150526a12.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773154885; x=1773759685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUFaQ+wso9VPu/qzybJZFS1HOWYrBQoRhXt9+dt4Qxc=;
        b=BXmSXf8X4weaeEIWo2NVOD0NMQm2fl6BteEosn47wsZXdvnBHueVgr072ONGScdfOX
         7CFSrRG1RfveB9qw+5roW8ik2sWpiImPMRjHGrcLJUGqd0V0NUA8/TqOgCpD/Oh77nCd
         v5V34hZnLBFVWlnzaWL6cPwAdr1r/VlyXS67/1ttVVkGaD3zSZHkXy+VWXsBY676pgZW
         aZlEw3bxZZvj7jPAdTMpSYaPqE277hK85dVW9DA6M2WFCNiWC8/OU+Dvbewd92GXoDOf
         AdGUcacPLbcmIooEMqlasETehkMKK8lpvVVqkjEOQc+wv6ua32CL6dL0zpDW3Vyj/Yqy
         D1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154885; x=1773759685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUFaQ+wso9VPu/qzybJZFS1HOWYrBQoRhXt9+dt4Qxc=;
        b=Tk5u0KHyOlLmKfe6bTKmPdhe79R7f8f1YBGo8nXt+aIyE4BZrfDlrgBUcEZPmiOHwK
         dSJXVIzNcusujDPHgSuGIK5YMZtTd3oqEmVvYUOzzX2bfi0aoltruBDD5kNQOTI5+l9Z
         7BZV22uusDfaJfu6uczmko7Uzl1SFzQhSarIVAbhmrvtwzvmyUfZpKFNzXMSrwyRZf6g
         AFaAgWNo+CDZrCldomcXLqG16e+/qUR5HxzzJh2jV45xI0ZC0obZcN2nWVhn5EpmP7Si
         78WMbfSZu+iStOFUtaaPY+2t7qemgsFOmGXr4GJOtyaksaHA0Xbi9QdSH9qCV1FhTXs8
         uq1A==
X-Gm-Message-State: AOJu0YympSl2ohm5vIiY7NEm8xKQ8+ug4m5wqz1yxNBTaVGOOW5KRtdp
	T99SGSMRHcRO5xbb8LDp7G1BZFgTnSnDQH9QWdtlznPxJq2GYM/uu2IJaaV2pA==
X-Gm-Gg: ATEYQzzoCwyVZuCBBlvTeOv/lQfyxMbxyrTK3bHvynF10DvpRsgP6NqkD1WgQf6k+A9
	WanNjf235oglaSmytjUfXb/o/W6Q5Qv1FtVF25JwkI1WztJv6Cq0KCUrj1tp4zg1RAB8utQO2k+
	dR63/CS3Z4dLPBUh5pLKl2pNTgjGqSlGIauzUPeMImuLd40veJpLiR0K97JA6i3a7hxekkdSvN6
	ZJDZAv63oOStL+rN3jz9ussO3Zvqg7tm2MnZpLyeoxJb+MsmDcUTR/x0sdHDec0G+/IGUHkba2y
	eztIS4tahZ+c3zSivx2IjWy+RLGN7laxScLGBlBWqoHHA0NjYhVnrBJUMCx8F38c9UrBJP4Sequ
	Wk0wLVCswPVlTOwxNctTWtmPkOhNnHeonblsTyY9ytEY0r2LOlRP1QrH+VzpJQ+ZWcGz+usQLon
	KNmzbIkZGWc57YR4fU/jskoZje0q1FmiMpNDcRweU7FSE=
X-Received: by 2002:a17:902:f707:b0:2ae:a481:2a53 with SMTP id d9443c01a7336-2aea4812cf9mr31644725ad.5.1773154883565;
        Tue, 10 Mar 2026 08:01:23 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:25b8:770b:44bd:3ff0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eaef2asm156273045ad.39.2026.03.10.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:01:22 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com
Subject: =?UTF-8?q?Re=3A=20=5BGSOC=5D=5BPROPOSAL=20v2=5D=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Tue, 10 Mar 2026 20:28:24 +0530
Message-ID: <20260310150054.126372-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAP8UFD3=FdwyX66gGaLg01VU+Euw=fV8s4gPPOXEXDFn+11yRg@mail.gmail.com>
References: <CAP8UFD3=FdwyX66gGaLg01VU+Euw=fV8s4gPPOXEXDFn+11yRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Hi Shreyansh,
>
> On Sat, Mar 7, 2026 at 9:09 PM Shreyansh Paliwal
> <shreyanshpaliwalcmsmn@gmail.com> wrote:
>
> > Changes in v2:
> >  - Added links in the 'About Me' section and updated reference numbering.
> >  - Rephrased and revised the 'Pre-GSoC', 'History' and 'Proposed Plan' sections.
> >  - Updated patch statuses and changed some wordings.
>
> Thanks. Your proposal looks good to me now.

Thanks Christian for taking the time to review it.
If there are any updates to the patch list or the proposal content,
I will send a v3 in a few days, before the final submission.

Best,
Shreyansh
