Received: from mail-qk2-f20.google.com (mail-qk2-f20.google.com [74.125.230.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDE490C19
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942954; cv=none; b=Gp9cY2DPmCsCADJPwZ1wmHJQDfMrczcIbR6y88yAdWTfdiCs2d35tLgK7qHWF6mAh8LOFtq/7eGIxJGsjrg5TpOmWKuqSGAR0dCT6/Ll8T3TLgKvQG3WRmhbMkz+w0OBisNMex9ZLNodfBt9DGwefbxa9R9fuaslKzN3pYbbNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942954; c=relaxed/simple;
	bh=yCtT00kS9b5P4duRPOofTAGEVk3Yqv9iopzfrYrOfdo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=aep2BjZNBQp/cKPB2j2USd0wyGr5aFfPwGlFRBH5pqg+bpTTDbKrypyufYGxktRjmDAlxvB+7K0unT5ZobhdpyT/3t7NhdOzx2OVU0BN49YxjVtC1tT/+aAva8WZ+qF5QO8eNBnbGgxpxux5UkwLJP/f5MdTq4gvp+gjqG7xUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEUR+qFZ; arc=none smtp.client-ip=74.125.230.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEUR+qFZ"
Received: by mail-qk2-f20.google.com with SMTP id af79cd13be357-939656ff6d9so775952385a.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790942951; x=1791547751; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EqNdXP6yjv4tJYz3VfOkXAdjDbX7AKiExbwyYmBfSEA=;
        b=MEUR+qFZWa9vHNYGbyefsItZjv5zkg0XsekeD+JSF6tkB4yQxD6p38glCsXwYUmUTI
         YVs9/v/clY+cBXuA16euRcRZzdunLjPuLZPUv/i8C5uQ+9+GJ+BELnsCavvbU3mS+Gi3
         YQj4ok0fTsfpCQeM0d16LxKMBOKz7ozHSvWO4DPe2QH05IswTxgGKvTsw6Xlvn+qLejw
         E3mE7GlcaFpbvGOh/NN62JLBbW5kWR+dfe9T078fFVBS+3tEToMVnq+hTrVxXKSYO5I7
         OUCM9bRQaT6raHNtDcxEsGNG8SG+eeRKYBtxVukobxoWKJJhK8L/r9Sd6TXIKcLWQOo0
         1S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790942951; x=1791547751;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EqNdXP6yjv4tJYz3VfOkXAdjDbX7AKiExbwyYmBfSEA=;
        b=A79kEK/TIOxVP5okuiD60KT8N2Vanguxu4pHa2dX3BCZ/s9WFWDDFx13NMy5Em861l
         BqbFH9rnxCSnrs0/MtBSFmYmhTin0CDOSgdfoMYWLJxyyfPVXBtJju+YFWI6OnspaDWo
         6qs/RTrr8Z1SXyF3Xv9XopNNPxB3UDk/4rl6bzpU79yc7rolVStDvy0+SX0C6fGfz6DM
         cUmlYMDqSJgj6Wkap2JOq151a5t2tntQbPAny1vGRlrT4lqej9G2Yo+9Wy5Eq6wmt2w7
         KGqlZBpWbvAzktlpfrj9YuuUnrLuA9RnHmpZsX3OL6vfxf2o1yNbOvy+frTsGLz1H2+V
         A7hQ==
X-Gm-Message-State: AFuF++meRCLHNcErGNV8xlE1I6hqJBlPI89BCsa07IQ1um1TZD/vl1ZJ
	6dtpVy5tggvHa/Cig9v44YgkQiSPp2JZHIujMjJT6AG0oL6J/+C3PIX1HhACRw==
X-Gm-Gg: AYBFou3F4VESKyYNtkFD3SFywNTT69SkppTBMYF3mNUqwGG90trpVLd5ZnTWvjBGyxe
	9Bzn0wdKokPNyr51gVmZpOITiT0sg5gJbtbZdg43aWeSjaFPSvfhQx6j1sXHjTrbd5FFT1Uwt7K
	2kGg18QG/G+DkZHigZTZfHg1nu8aIv6Uxqg5d7DKfL7IGOgYHEKfv41/WPgy9AJSHNCSdq9DdMY
	ugj0Bjfltb3AYstbqQlvdb6YCwEQRqtHjgFOjR8sMPyezw42DZmCiHrpd/a6CgYoj4FvJv3ExfK
	I2fSERzU8lewtHWKjyGjz9j6vF7wVPZzLSP27/Uer+OCN66tzywRpY4j0TooC+UQxUFFNova78q
	19S4SO3b5/+YGVCF9gl6FzKQtOPOb67LBsORdeIDInY8gM8t5/GAdaeSPFy80D2fAP7ERBrOqOu
	hBsTdPnGuBbOipy4v3iRslAneuruhpSXuqoCb05TaDOL8SMkFncwvSog7+ASI8wLH287XBxRUoz
	B7YOF/Zf1Wl/1cp5/MQEp7AOuz4m7JC2L3k/Rh0Dai9ovECk/B5meQRJPKge5Va9a78FXpjwuuO
	2ct1XdkGYnfaxNOMf8WmxPLK96TpsLKMW+DSVojnR+JCukMkWQ==
X-Received: by 2002:a05:620a:2550:b0:93c:720c:94e0 with SMTP id af79cd13be357-93cf188d918mr395366785a.30.1790942950492;
        Fri, 02 Oct 2026 05:09:10 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b10e:b5b8:dc32:fc6:5dfa:ff7c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca21405dsm204456585a.22.2026.10.02.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:09:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] object-name: accept @{p} as short for @{push}
Date: Fri, 2 Oct 2026 08:08:59 -0400
Message-Id: <81BD7B8C-6E7E-451A-9D48-49ABD5FA5F68@gmail.com>
References: <pull.2431.v2.git.git.1790927399813.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <pull.2431.v2.git.git.1790927399813.gitgitgadget@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 2 oct. 2026 =C3=A0 03:50, Harald Nordgren via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>=20
> +test_expect_success '@{p} is short for @{push}' '
> +    test_config push.default current &&
> +    test_config branch.topic.pushremote other &&
> +    resolve topic@{p} refs/remotes/other/topic &&
> +    resolve topic@{P} refs/remotes/other/topic
> +'
> +

I don=E2=80=99t recall offhand if @{U} case-variant is supported, but I wond=
er
if we might not want to preserve as many single-character shorthands
as we can, since there are a limited number that are reasonable to
type.

If upstream already supports different cases, though, symmetry is probably b=
est.=20=
