Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8A27CB04
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770503931; cv=none; b=ShBQOygM3aOX/SWmoWgmlgLPq8vtDl5OZ70BpcoWQIdI0Vv/AfZAkd9ubd8K5NohXSotPFXbwb+Zr58TBpQhGx8YZOpPKV9Nr61xlavVEmFAGLHw62Q6cnx7+38z1AlJECIGEsM3fsqDRYgDCTQxIZ+n57PnQy1mBDcnYWIzwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770503931; c=relaxed/simple;
	bh=JzdJFLKPgAzf0CE5xBxc2/ygWvIl7RdWYsNaRlzGiEI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hfrMkEc2RXK90GDdQUexotMjtNw/dmNP6QXuGdwjBCTkeUKf5RX0IIsf2mXGFqrjxSF+4wjh3SBUhp1+XnvoGPnttyEF0X9wrITGwzVPgK8XZ19QJTCDPKZ5AFt6rn4pIVC0YwdSHTG1okQ8qJTzBaak64cbFj32mlSNMXxv0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVGuVWCB; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVGuVWCB"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64a28af2f4cso2606317d50.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 14:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770503930; x=1771108730; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ9a1nhQ/Q+jnf3kaIm+emJmxkUAluRI95N3gVIjAw4=;
        b=jVGuVWCBBgUUmbyE/Py/f8KFzb2wUpbuNCCegXG/RAjp4g4I2I1yi7BbFjxiyU9q7q
         nC346Bm9SXhpr9ohBrH08Xnj7VfjLxd21lQlDldN3fqngHZO55vVgDyiru7+VAAzqYiu
         8yyEsykOXwZD2qg219KlxOJEZdgF57MhYl+aTdNwjU82YpDxMxyEK6hq9D4pVdXKcIqV
         B9Y0MwnlClw5a7uN+jSH/3AXj9wqwkMDZ5464vHsvuGAANNgYpkwd58VP0fpichtQO1X
         3cxfIhvN6MZ7Z4OMXP4oR4zQEMQdAUjQkRWCMiMUMh1Mjtr5bds6/M1imnZVP33mvQdp
         plBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770503930; x=1771108730;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJ9a1nhQ/Q+jnf3kaIm+emJmxkUAluRI95N3gVIjAw4=;
        b=rlAidyhIrAlE50pgw8jVaAdbpluoFlg8D441BcfavAHDbGJCQ0O/rgmdOvvvAMElkd
         EDz72lhYsvXEIxn1qP1ae+9grZPwKM3wyd/AuZBJi7H4PNbypdg8DLxpu3StCRMZP23t
         27T7cEZXuwemmkdgI+xmIYDrJSwjbJC1Y/Q4b9dYYIp0YYJbVAGAFh1m30dLCgFDZfEG
         uJh3NwSQzDrROpGmtNe0ICZjvogw2NU0fXBk8vwf+3NhiQ1yV74EmIE8tUBFOz1ie5Vq
         3MuoQnLLCyd8wQfWcNwuJNP3D2IkXv2+d7QH9iIX2EPsqIkHSOHHP/Yj3QC1Nv3cSCVL
         8WbA==
X-Gm-Message-State: AOJu0Ywn64GL2K8VtYp/AJqhm5IKzejbLJOCOaDH+aRMejQvQo7MuLgY
	BPgi0nYaAjU8Y6No0gY+gxZh5Tt+zqdksS0yFjbPm9KX1KBsMTaS8Cnp
X-Gm-Gg: AZuq6aL4k3d/b+F35bEg9IC3WBeQ2J0d60TTZ1G0O1aM9Px1ZG5h+KDkWedS7OVWp8E
	6jyiqEw7oopI/XExiEfoxjEnmaY5/ZYiMSv/61iAlvi9BBZpvjOl3hIQK76exFEuqMf07Ir2RcS
	OC78hY2cOR6ARGhDKzNow8BQQ+/+HWJEcnlSVmYk++2+bcKGnHCNLu2bwEwgoBK7+1QtDzw2ToY
	MZqifmWdjDV02g6rOoiszZMz0CCW8wocAiPtnRg2wsqVHakJsTWSo/Gg3XymOVzaEmXa6LdfhGn
	7+H2/HKlCs/RsCwrvp7JTuRcgNIuqxzlzRKtK/Ea6Pq86qf5o+f2kC33imtuxopiIclzCwg0ICO
	FZIjTd0wHcqsUJAF6klbZu9bdv6sZ/gid3i3WDTpCuNI6+FfTJet6t1XmztXU5TCEtrURO0ZRpd
	4apAXqeV1qkX8fv/EaZnmf0WYuyJl4TTdio0CJ1HAuy0LQ4qEwNJqpXxbwwJgLB9smV34/yLWFn
	+XgXBc3ECIQ4+ZJe8ffviRQoFno
X-Received: by 2002:a05:690e:1206:b0:645:5433:8576 with SMTP id 956f58d0204a3-649f2514cd2mr5709837d50.30.1770503929655;
        Sat, 07 Feb 2026 14:38:49 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:f491:fab5:d912:1b75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f255ea25sm6083197d50.17.2026.02.07.14.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 14:38:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation changes
Date: Sat, 7 Feb 2026 17:38:38 -0500
Message-Id: <E6D69F2A-31AB-4370-85F9-CEE718E14327@gmail.com>
References: <20260207215924.28863-2-ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>, Evan Martin <evan.martin@gmail.com>
In-Reply-To: <20260207215924.28863-2-ben.knoble+github@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 7 f=C3=A9vr. 2026 =C3=A0 16:59, D. Ben Knoble <ben.knoble+github@gmail.=
com> a =C3=A9crit :
>=20
> diff --git a/generate-configlist-deps.sh b/generate-configlist-deps.sh
> new file mode 100755
> index 0000000000..a873e976b6
> --- /dev/null
> +++ b/generate-configlist-deps.sh
> @@ -0,0 +1,5 @@
> +#! /bin/sh
> +
> +printf '%s\n' \
> +  "$MESON_SOURCE_ROOT"/Documentation/*config.adoc \
> +  "$MESON_SOURCE_ROOT"/Documentation/config/*.adoc
> diff --git a/meson.build b/meson.build
> index 3a1d12caa4..4df7caa206 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,6 +720,7 @@ endif
>=20
> builtin_sources +=3D custom_target(
>   output: 'config-list.h',
> +  depend_files: run_command(meson.current_source_dir() + '/generate-confi=
glist-deps').stdout().strip().split('\n'),
>  =20
Ah, woops. I renamed the file locally before committing but forgot to update=
 the meson spec. This line should have the obvious change to use the correct=
 filename. Will send a v2 when I get more feedback.=20=
