Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4591E522
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265842; cv=none; b=U3imOzurOhkety3/8gHGCsTCKfQ8ceQfyIZbiK8Z+2pkwgkV+eEMKeKhDvl/uIMMJVka6DtwDqRmOR787XytT4ZKF1ASYA4v9OPpAPD9Twv5FyibY4cPj+2muHkaYKLWoRVdAHX+TkrDGsoeuAoOzfkJZndYznMNnHYmkWCekd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265842; c=relaxed/simple;
	bh=WdWykITtm30AHAVrJnnG6bLu/gWHY456wdFTp1TACbI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Q2gvj+NECFocE06sbmSrFt04U8M3A5pXWeiCNEMHPJrX7E64XM8tLUwD+H6kRgEAtg7xu6YY7ISFrW8t803E/pvMRUSDb/Luhy8Uit9GO2qwk7W8wcxULBPquf72VRlPL2DUW80Nzk0MvNpiG8S5Eb6EN11Oxm8jJjN7mSz+uHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHqFWzq8; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHqFWzq8"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so11282846d6.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738265840; x=1738870640; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdWykITtm30AHAVrJnnG6bLu/gWHY456wdFTp1TACbI=;
        b=DHqFWzq8Kj7/DWm78YOgFxnm1LohXB8CE9fkWhQkLSxakXPWp1xFTC2uqv4vG2juP0
         wipA0OYeNl4wAsmRXk7DOSa7Yxxsqp7VRds3IHr9ejBXz/8icdndGGtFJ+XSEw1YU+r3
         tJWdTLUkrEMUUC3DC0EKDA2n80stZVD/hp/IQ20MqpN8z4uueli72rOL91evjIXUplVG
         0QA3WZ/NzaNGtBS3JqIKFG4zewmVCK3TCMS9xve9l1SycYDHn621eZoJZynivpy0drI3
         IvwXdni6U/S/Yj/zZqWAJTxeX7/wkLUsy7fKIsmiSPPsdvNT8pz0JlEfJD4dAiESHIzC
         68ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738265840; x=1738870640;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdWykITtm30AHAVrJnnG6bLu/gWHY456wdFTp1TACbI=;
        b=E3AngoKLukYcqecREWEa1Y8ZeZOpORPBXIpYH3GRvAAUbf0JXSIqzALQzs3OhOyKzc
         Fa1JRdFXaKScnvia//5MBD/TGF5svKCGWGHgLDb3UvnQFiPf83Nm1rMPCjGRjfiGFmeR
         nVx56tDIKafGLheLPTJqrxmpjus0kRYUsVtLZPUuPA+NzXuquFuxAWWS1q9Vh/gSJvNq
         Cdkt8LLHjejlM8pZHGpwD4peKU3YKNvFW52KL6aTug8oQ3YPqGU6npkIj3KIEkF3vLnl
         XWnYCuRXacUUJtJKc0srcyaIqCttAGXe20YWjZCgkYFJmkyUJNHufnYUCIBnUw0+ztjx
         UYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCNJNY177B8u1tCMNeWWmNV7KSp444KG20NVNxX3NPde3uskEUxvG8QsVTw2RvfeGKIeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2u7EtqwoAgE1yfH1HTlxQX9/jkrlOXCA4MUOX+Wq30LcLdFTb
	LX+ivo56G1sFO302oJ/Vk28FW4DZwZWjnbtrvr1U+ktG+WHnndZu
X-Gm-Gg: ASbGncuvju0AnyG6b5Q1sQExbn1V4TglDJZNOX91H4L46+LAjvSoTpr23PKv4XcSUXv
	kYJE+1BtQqgiOfmcgW43sqd27arkTGa6LRNNWBa4jtd5h5adBWLcDuVab9GzjAJv4s+c/Hy7lVU
	u179D3w2/fsWOyRVD1OsJi5XEr/uUmNoBwYrbHlpJq7d4YJ/Rb5IubQY1DTF6XTGNYtAGJ54lSA
	3jDFUTvkX5FLRE0VEUKAz61hPDgKiGIjD55iPLhZ5IxgtgtktbKwZvUFV+kufhnZO9aLjBRuHxf
	Pa34X7+jKHvDIvaKYBNu2i5fzKWJgVOXwvrUTV8w
X-Google-Smtp-Source: AGHT+IFPO4+Cu00Vpcwxw6W0/MclPzSR8rCX2mJiDORuWI0ykvvB+jsmS9eieEyuCipxkzhtLDV36A==
X-Received: by 2002:a05:6214:408:b0:6d8:aba8:837b with SMTP id 6a1803df08f44-6e243c78da1mr103203736d6.41.1738265840077;
        Thu, 30 Jan 2025 11:37:20 -0800 (PST)
Received: from smtpclient.apple ([2601:5c1:8380:760:c1f3:891:f16a:c37a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f3e55sm9353166d6.16.2025.01.30.11.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 11:37:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
Date: Thu, 30 Jan 2025 14:37:08 -0500
Message-Id: <EC3D4518-9330-4D08-BFE9-0A45E71112C6@gmail.com>
References: <001801db72af$20a35560$61ea0020$@nexbridge.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <001801db72af$20a35560$61ea0020$@nexbridge.com>
To: rsbecker@nexbridge.com
X-Mailer: iPhone Mail (21F90)



> Le 29 janv. 2025 =C3=A0 19:37, rsbecker@nexbridge.com a =C3=A9crit :
>=20
> =EF=BB=BFOn January 29, 2025 7:24 PM, Junio C Hamano wrote:
>> <rsbecker@nexbridge.com> writes:
>>=20
>>> This appears to do exactly what I am looking for. When I create that
>>> file, git picks up config values from that file.The question is, is
>>> this environment variable actually sanctioned or is it just coincidence?=

> It does
>> exactly what I am looking for.
>>=20
>> How about reading "git config --help"?
>=20
> Yup. It's there, thanks. So should I figure out how to sync the website wi=
th
> this
> or ignore it?

I often link less experienced Git users to git-scm.com, so I appreciate if i=
t is fixed in some way.=20=
