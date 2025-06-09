Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208D3D544
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443082; cv=none; b=N08Tkh0fU4sF+H/5TAarCqOit+xMDPpJePboJpMmzchgta5PEA31P8J8OH1Vxs6tFAjrcC+oXg4z1dQQfJora1PFi6XtZVy4CK5c4HHFxyQkD0MsdzxnyQxA4fbBJQlwUUNMP+OL/nZX39fo9qNEo9aYrhH6AbyXdGtWijdkaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443082; c=relaxed/simple;
	bh=TdmX9//zbvLl3rpCOZ4bq0+HijEsqmKA46+Uap3tE6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZZQLxUOOtYf4NM7Kav3De1sYHWYZ+NF0XozMu/WHTHKJAgZSRT52DwGxkz8TwZuSZfDapRk2CRMIWVPBRvW7AijecfIkGOyH92IQQNQfUU+miAVcyu9ncvGykC5uZ1VxABUR/xOC6PI162yLmeKISQEle00EBrhjM9OpHjEIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=tVHzJk1i; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="tVHzJk1i"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so2245289a12.0
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 21:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1749443080; x=1750047880; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdmX9//zbvLl3rpCOZ4bq0+HijEsqmKA46+Uap3tE6w=;
        b=tVHzJk1idO5orIt7EMVTJON/qDNJ+exM1BBs3kigVQbYKTzFKIb0FxXdk68cqmjoAo
         w8xDm0thHBfN8Wf/r4CjtnFXTubuV3ZYS98ckXkiuyJSvRYgCEidrydpLiDe5gN91UnD
         KFx4+Pjjx6NnvjH6akl6rEV6QtPvmITMtk64c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749443080; x=1750047880;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdmX9//zbvLl3rpCOZ4bq0+HijEsqmKA46+Uap3tE6w=;
        b=M2yy/sOv90HXQTkSOC23H1bgxstxxnK5VnzaS24feh8qH5tyNSMctHvkQr/Yj0RLGt
         N5xhV1mIXoUOnqegiGzLg4yliRQitxO79+z6jQhApLWFVBNCilDBLOTgJPtHH1pwCmz5
         W7vpMaNiGismhS2wKOpKwu31cLWCQvb/igMhPFIG0xZYgNKQUnqf/GzFZZr5GpoDvAq5
         UMEuU9ASNU6sMtZSC95YWsEA9F8U09416zF5B03jS+CvgF6qJhdshG/yjg2NTJBVRNDd
         iKer3BbPm7j+Nmk0/SNuxVOXb8kkMlBmL1SxqdoUSu1w/+aDMF2kr5kT3bJMjiKyXJld
         Dmxw==
X-Forwarded-Encrypted: i=1; AJvYcCUNBmANoUMUwuH8ZuoaklhlwJtYeCuSjdbN5E0UzATEVQNHI2u8CIvHXvuMFdmudTFyuI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+SbgZSQjBUovxImv8prPynZNjFWylGrIqZDFteopickwx/qe
	Vqj3jLQ6EtnHb2reKYwqFz3J8zY9wTWixf1OxcMykd4T3QRxnbxrfrJokOwA7N8+znw=
X-Gm-Gg: ASbGnctevwynb0oQuXTejC4B2yK4saaRciZdz/hn7qrHKLakX10KCmN57PuPRlaDk8q
	IpsZxo9CA/i07OPWMsX3/bhixq+FZy2ybhoJcTLMQk/HCTp6bOs9pvxLb1CDyYxSbA0sFXnLysR
	5IVvLt4O2Pj0reakf5Z5CdnJwmvMRfpMsvc3saa0BbtszuYTvz1H57gYjQM73ILdgALpZkLv9SF
	wV300UbSfyPVj14fS3dtvKovtmpTvTeDMHAXQvQ/fiGvpnqkRGGRSbkhljD7I6TN48ijYGbHYm+
	LDK4U4EgaMVPCzNBh37aEz/xPFGQIhXSXSlWP91tSTmQ12/t4oA0DQ73
X-Google-Smtp-Source: AGHT+IHsfGNnhU/nUVC3leoqXdZcSryX8oZ7Vp8OtlQpBcrGuUTHJuPnQesP+t0JXgTdvZ7wjaZniQ==
X-Received: by 2002:a17:903:22c6:b0:234:986c:66bf with SMTP id d9443c01a7336-23601e21e73mr182532785ad.11.1749443080534;
        Sun, 08 Jun 2025 21:24:40 -0700 (PDT)
Received: from localhost ([65.141.3.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3134b127ec2sm4668307a91.27.2025.06.08.21.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 21:24:39 -0700 (PDT)
Date: Sun, 8 Jun 2025 21:24:39 -0700
From: Chris Down <chris@chrisdown.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aEZiB--73TnO8rxX@chrisdown.name>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
 <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
 <aCTI7VjK5QMht3ws@chrisdown.name>
 <xmqqy0uy4thk.fsf@gitster.g>
 <aCXqqj6gKc7-fjoF@chrisdown.name>
 <xmqqldqwya5p.fsf@gitster.g>
 <aCdT-UQtaaTQ8gyD@chrisdown.name>
 <aD6cJxFXdGfN2XGc@chrisdown.name>
 <xmqq4iwvfx8s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq4iwvfx8s.fsf@gitster.g>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

That's fair enough. Thanks for taking the time to discuss it. :-)
