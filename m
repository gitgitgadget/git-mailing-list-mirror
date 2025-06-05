Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440CF50F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749088016; cv=none; b=pg+Lgb7rlyNGp2uf8DxIIzbFGt6VDWGnUtZF50+ZyzMMOPaZJFlxUaJVk8mfrxiDSOGOUbShrOjuInfaFnwSm27NQVufAkRswS7XcaE7rYqJvoW7svD+SSHyY5GtsHh353LIEKzFazUmGoG52nXO+BWtj49mhcs7YwKQrZ1EQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749088016; c=relaxed/simple;
	bh=fJI0GIFAsuqsGy79iHFY6HPG4BqNwkZYvCp0KUlPWV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QzHLBDAMOeq8uAhhx8Bw5MwSjp+mDoeCNXsdlSRxY00Jz6LPccmAh28OURGQvYQDbmEEwU7Hc0NAqtXJ5VtXo3aZR2wxZ+cxmziG4N6Mmi9I6s7fZ5Js++8okx/dV+UWV2zEJvMGWROka6sSS5FsCmIsQDCAeGbDCC2pe1RxkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzuVsjdL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzuVsjdL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fba9f962so452979b3a.0
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749088014; x=1749692814; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDUAtbk4hfCmMdljbDMQleCS+79THp6Cd+DEAfv6A9s=;
        b=jzuVsjdLskcEjh0rUT9aEchRQl/ECSlgpTVwYzQCr2C7oKyR5edxk5QBsf1gh++k1w
         mh1I5y4cbtYPmYCm9odl7GwZWkYRgQVQm6byIqqp/qaTQeLoPzVukAbZ3FSPEn9angmM
         3gtU1CufYqf8bZCXEsnA0+VPWWk48ZDN1qJaYloBA7PVI4fFYk9Nj2p4Y3pPppQj8r2Z
         dI+Dv0bw3njW5xCthgPMR6qDxuXUobHqBXfBcjBGzRd0HifipGwBaI5ekpQBeK+GL35m
         K0Al5dW6cekE91T2j7PQCalaBGteF6QktsdX/Kk+Cmy7sB8Rh2mfNj7OOB9cPsFoMPQD
         Fggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749088014; x=1749692814;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDUAtbk4hfCmMdljbDMQleCS+79THp6Cd+DEAfv6A9s=;
        b=QHLo1Sp+NpNdeVutDjzdsouuVDdX9S5ke9+Jxc1oHDpxWb1o1xDSpwmPOs5STZAugA
         7NEXIhVIy+UzEKMzBdtm+FAWSzsACq0QgxNDUYBjGuvBjltAZJTF4qP4wT/lVCYz5FbM
         M7JX0RgIPnCwNdBSfVPSXWuZ9A5eqbiJ18nV0mYhn9X9b4C/3kQAC1pwqI6erFg8qU2u
         YiqrxEvNVN8vOj/+aBB6tNgyPg7wfEboqjH2hkO2fUvaHoxkg7/dkcv6voqyrSjO+49H
         Lrl4oUZJh5tR+KVyZlCGnEF1Q9a0xxnrbcGc3KOOtfQxOBOsJ1GPxBLbPDgRo8PfYoFp
         9Ytg==
X-Forwarded-Encrypted: i=1; AJvYcCW3BWtsUR9BZ01hvXxSeMQyxKhbxNCXUkgbJVqlj2NHZWpTxQv7clV0UauvLEU+61aW7A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4FNwE1WB6vz09O7hU8GaWhlRhLNJC61HVpFbR7VKdOqYy2BI
	Vw6iB62K0hjX8h869YIjYQFoeypE6bp4DL2dhkgPzfaa71Uee+JeokwW
X-Gm-Gg: ASbGncttqYFmdklN4jbwWiJmd5tPWJ0qBZdeVsX+KMZU6/lUnb/AZNxzusGyNjtqlu6
	QiRJnl2A/6QjaDZ/fmRw9cYLngBJwujjzg4SsRxCRF/tJsj8ArX8q7g9QjmBkTkUeZJyRSQAxzH
	U2K/lBn9F930WJV/qPFuqQ8K+bMOBjLqEnxhaob9I/D2m1pyMUS807D26tO0K0g/PpVpdMDiPcf
	J3bgLODPWvO6HhAyqVc9vRtfACbIypM8EA3RGhU9bb3lKtssiN9mGaA88SHio9/lWs4P1mPXW/s
	6jmi+Z/3VigPJyv6a31d31PSB2h+oAg=
X-Google-Smtp-Source: AGHT+IHuJHnq2stCiD5nldNnCmAd6XrmWjW2hE6rFGXguoLx0ehlfup9TsE4wDt1ZRd8SDmyW/4uNw==
X-Received: by 2002:a05:6a00:2d85:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-7481851605amr1798809b3a.9.1749088014471;
        Wed, 04 Jun 2025 18:46:54 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcf6f8sm12188782b3a.139.2025.06.04.18.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 18:46:54 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Down <chris@chrisdown.name>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  git@vger.kernel.org,  kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
In-Reply-To: <xmqq4iwvfx8s.fsf@gitster.g>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
	<CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
	<aCTI7VjK5QMht3ws@chrisdown.name> <xmqqy0uy4thk.fsf@gitster.g>
	<aCXqqj6gKc7-fjoF@chrisdown.name> <xmqqldqwya5p.fsf@gitster.g>
	<aCdT-UQtaaTQ8gyD@chrisdown.name> <aD6cJxFXdGfN2XGc@chrisdown.name>
	<xmqq4iwvfx8s.fsf@gitster.g>
Date: Wed, 04 Jun 2025 18:46:52 -0700
Message-ID: <87wm9rklir.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Chris Down <chris@chrisdown.name> writes:
>
>> Looking at public dotfiles, many users already work around this with
>> global shell aliases for "commit --signoff". This creates the exact
>> problem
>
> Users conciously using a general customization mechanism to express
> specific intent like the above is one thing.  Project giving users a
> tool that is specifically designed to casually set and forget before
> even understanding the implications is another.
>
> So no, anything that specifically targets commit.signoff would not
> fall into the same category as end-users creating aliases for
> themselves to use, I would have to say.  And we do not want to give
> an impression that we give tools specifically designed to encourage
> users making casual sign-offs.

I agree.

Although the FSF copyright assignment needed to contribute to some GNU
projects is time-consuming, it forces the contributor to consider "Do I
own the rights to the code I create?" This isn't the case in many US
states if you are an exempt employee, which most Software Developers
are.

Similarly, when you sign-off to the DCO you also acknowledge that you
have the rights to license your work under the projects license. By
adding this option, I worry that contributors will just configure it
globally as a prerequisite to their work being accepted, and not
consider whether they are even allowed to make the contribution in the
first place.

Collin
