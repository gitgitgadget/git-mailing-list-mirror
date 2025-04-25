Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696BB1AA1C4
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607945; cv=none; b=JRHzmAzTBdDW6m++dNpxEiF5v3md8GtRh3OgU29uP+SYYePfZZ/8hwCRKoooNNY02vd8KwFwg3Jk0vdQknXfirV+ldyUMVXQTX/neCUZe8yup1au9XUa8edow5J+/wqPsYTxPBmXfC3/ixb8OjjqtLRfcZlbOpIebPSBMoLTqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607945; c=relaxed/simple;
	bh=l63kKCS9LykHSQZpzMhtjnlmU39szV1bw2YGI+3fn6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsGMVZKBldVqHP08jmxjx9q52KmhCSv8M2+VegeTNxHOwrLQmx9BiiRiHoj7FD9a+89VGGICC28nudey9P0dz2WMYG2LOho/2aprq5LnM+AqALj8d//CEbrGxo/9NLD3M5b2qgyciT9+z1hnIfTKJ83imVV5jSHSmG0O7liqEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG6f0qwA; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG6f0qwA"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so1251206e0c.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745607941; x=1746212741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w7QkPrTMOSapOCt8UwSV6o9FhJZsxWudIKDblAEmLA=;
        b=XG6f0qwAIS/vA/1EN6sOPaG1M4uALAwqd7WcfW1KWvNPCW17GW5FgOg5HFKJChvwLv
         V/ID3MYto7nyGbNW23j0nEZsvPuC6pKa8gUpA2ll6at6qmtChA68+MkmLT+PJUJxDoEz
         DYOLYmR7QvcbUpaB9I5ZUhjfejFu58urDdChnQBgevPQppRo0Lm3EBiTxApcT5K2XhHg
         8oybOVQEi11W5QjcEXpq+ufyh+x9eHGU0nCXnixGO7nOs5gngo77Ljy7xMlWPd6eBRqP
         Vg083yRuNOLadDrMRiH8a5xKM1GsK/DTPg51jGxIRe8CzIuv/8X464ECZvVcpg77rbbU
         xTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745607941; x=1746212741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w7QkPrTMOSapOCt8UwSV6o9FhJZsxWudIKDblAEmLA=;
        b=HG7Z3sYGDfnNnXjHt9fVRN38WGYovI4OewrgqiomX74bo36z0WjFmgG68/iYwHOulE
         p/eyv/DVaAeO10jfzf/hvXt2Oc7aaXCWe8MxXCE9W9ADwM+K09kr0kVJ8Nc1L9jzkNbc
         4X6u/g9ji3BSOI6R7wdfP3/Ik9us/Vdp04BAD8RGJGJu6pS4dXdzfvHqiN8pAErD4Mau
         6XPS6wgqZ/4B/xY1ke95+iBX+6OAC4NuXsJ2zzXdha8+imBY5RSl7BthxP9KLM8YTT5A
         claXukez/iH/FzYtOqWnI+4hqD6auKv9sxsM/dOvWMY2WGT8AeE1q3H/VRopbKx+liAa
         jlWg==
X-Forwarded-Encrypted: i=1; AJvYcCXFQ06uqgp4JCm0UoZQPDusRy537bkYFGhEuVkqgMxcsOWnhbDQVK74ulbjhsLc1wmi6j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQ9WytAsHIVveEjxyxrhKtnNRnF1Vv9RG5f0MZblK60vIS/Tb
	x+aHrSoHokm7Pxp9weP+M8Vil39z5D4hUr5VXggIIxT0Z+cBwp3AqzWTy7M3s/Oio6FLSeww9xS
	kgRD2b2mLyW+qVedpAS2EYYYuIQ==
X-Gm-Gg: ASbGnctdP87gzqSnui/ZHnbT41XZVGk+swhTmRObVINHjjgwfim5T0TJYAiJ8VHJk4E
	TgqbCGe+C+R2+eYngmSKNYiHhwXltSnYQ0Xt0O+bos626/TsPJQ5Zac6JNPnzpoptBIldi8ujPL
	Ig5F1F+DuVVQ2vg/3jtE0DjYb7UuzPQUPU2ws8bJwkmViDZw1ca3I=
X-Google-Smtp-Source: AGHT+IGlAGXeGM7NvMOjG6qoojwFzKr1uUf2RT7sm4bSZXnCq82Ojl2RaLbNHnSY3j33DAKVTHyZpE9jaMEShvZKX98=
X-Received: by 2002:a05:6122:32d3:b0:525:aeb7:f22e with SMTP id
 71dfb90a1353d-52a970e84aamr558773e0c.7.1745607941219; Fri, 25 Apr 2025
 12:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D4949EF555E2A96CE745B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6irNaLLsRRf-aEsRbAmnvLJPFhDGnD0j_D9fY_ZbgAL6w@mail.gmail.com> <xmqqtt6ctbim.fsf@gitster.g>
In-Reply-To: <xmqqtt6ctbim.fsf@gitster.g>
From: Erik Huelsmann <ehuels@gmail.com>
Date: Fri, 25 Apr 2025 21:05:28 +0200
X-Gm-Features: ATxdqUH_nOgDj30tUQKrQb4QDiSvC1uZbWtr2Tv-0KfwdYknZ-mvGkiSrh0f1SY
Message-ID: <CACOoB6hh_jWqC3pxiVVAkKN9+mPVUeUodKqFRmMe_Da65a6Bdw@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP server
To: Junio C Hamano <gitster@pobox.com>
Cc: Aditya Garg <gargaditya08@live.com>, Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net, 
	Shengyu Qu <wiagn233@outlook.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 7:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> >> Authen::SASL now finally supports XOAUTH2 and OAUTHBEARER thanks to Er=
ik
> >> and Julian! (Link: https://github.com/gbarr/perl-authen-sasl/commit/95=
8a3aa165d30cf4e3cbb36dc45306de627aa13f)
> >
> > And it's official: https://metacpan.org/release/EHUELS/Authen-SASL-2.18=
00
>
> Wonderful.
>
> We tend to, however, try to cater to those whose distros are slow to
> adjust to upstream changes.  What's the ETA for the updated module
> to major distros?

To be honest, I have *no* idea. I think Debian is stabilizing Trixie
now, so maybe it's in the one that will be after that (in 2 years?).

You could however decide to support XOAUTH2 and OAUTHBEARER only when
they are available? Then you don't need to increase the minimum
library requirement: there's no API difference between 2.1700 (the
current version until today) and 2.1800 (the newly released version).
So if you were to probe existence of Authen::SASL::Perl::XOAUTH2
and/or Authen::SASL::Perl::OAUTHBEARER, you could conditionally
disable the feature if the probe fails. (Using "eval { require
Authen::SASL::Perl::XOAUTH2; 1 }" should do what you need: return
false if the probe fails; true if it succeeds.)

--=20
Bye,

Erik.

http://efficito.com -- Hosted accounting and ERP.
Robust and Flexible. No vendor lock-in.
