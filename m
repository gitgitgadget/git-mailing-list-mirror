Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEA39280A
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091904; cv=none; b=Xn1G9q/OA3tm2GyhOdddge20cz+8l0uSv54LKsJt+yZtVxEyf5A7Ne1z8kCO+cWDVA8arAGplTTFMFoyqlWOEDzSoKPyKk+IQzBVC7h3DDVmrvFyZP7pOrsiV52azz2njKpbz9Gjj9jDh0cLTdxvLk4Eg9E8KuEWXBQSS9CwHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091904; c=relaxed/simple;
	bh=3XEJ+hPmP0CJr5pHZPnxrGTWREOe0G/SNBi3D21xWM0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nTowM0tn5tsIRqYak1NVgZkfD5addvc/KLhGESrtQxD3vLHtG+anxqZT3wR+cr7n/PkDueHq6VkV59jFrdUXBYdOIpWJDaup6Vfr3vpMjofz6s5BWgRaCZypVDXBKVRvKgt1Uga63kZzn9ujgLepgAAOKghDWJwSB1Iv1e3Xr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0OulLOG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0OulLOG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-482f454be5bso15815265e9.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 23:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772091890; x=1772696690; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XEJ+hPmP0CJr5pHZPnxrGTWREOe0G/SNBi3D21xWM0=;
        b=T0OulLOG344Pxm64SrOsvfqE2TcLjN5SDgafU05bv+saNfmDMyB6GkD43EzM8w+qlK
         qJhFL87GhrxY1AmjEDkfe8oM6LwxOfGfCtsC4PpQj1Gtl9juOLVABko4ISvmpqnaIy5i
         js6YCd/fUqTCRboFRXktdwm4Bk0dBCE0PyNza00DSRAou0umYwnQPybSoe6zbnmf18wf
         Ce8ECL7J45WHtCO+XfZMkHUbuaCtzFM6oaC+hW3LEwQjesQJ9cSs6nP6f46UXPuvGyPn
         sQW08NGmNc/2TiFgi6tx1Ip47vcmXszNFHfnpK1RCksYKNGg0cp5ONlvRXW5qbT85Jol
         bIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772091890; x=1772696690;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XEJ+hPmP0CJr5pHZPnxrGTWREOe0G/SNBi3D21xWM0=;
        b=u/bRWcEDbe4fl2HIctMk/atHfPubD3xYGblZYPxhg9raeWmdaVQ3HQPHt3Ad1iUklv
         w8LwOtVEfipS2Veo3Xc0dy5KfoVLLclTBcCazWBI4NfYF/J/atbnJGNFunMYyaC8l7W+
         uoILpubFFk/4RrXBOIQv9CEEFOUvw/nBj4elFabmDMTLX248k4JFUPrRk2GwfLU9CZJG
         duQgHvfwOhRw7a2qppvzkVo4bpq2pTpUEJclHAAFPdyit0vK3/pCIuWvtaH63zraNruq
         LeqZavLhuIPMkTaNLoR3UNo9qbjJjgJnUMfhyy6LeDBpQSwCXXikogr6iHkMplEZmVYl
         9z5A==
X-Gm-Message-State: AOJu0YyoAZoNLmJSPbtl+0J9dWZjfhvTWa+XdXo5EEhILzPEcqGwFnYB
	/SnR8mTBX/I15MXpl8huvifJsxRtMd4oH4Oxgxhi2tBMBEvUjUK42UBaQqFBFjji
X-Gm-Gg: ATEYQzzSUlEycHMye2THVHvKCkobPsEimri50jNcALT6PO66cIJTvyplTzvdpXpEuok
	S7Vs5C8o18K6NDfCPi79GNCjYj3PcWKqK5+KqRAJ3vI+lAbTSd6Bn3U2fOGHBOMA223LwJX68ys
	BF9rU5KHIL9Ll9LetBWtZyvG1L0tfII//DCIC7DOwrW2CPe8zXygADJSGr/92ODowAUFRITwusO
	OZPOq7iXlgty4/CPBCYM73gPMxRO/2dD33DED6fmHqvwZ4TDVZOL4sAnLr3ufeWsIGD6hEZViqt
	H87CqAlP09BdgMXdzHOpLLrc4bbxL1+i7KZR+vsP+MVzTvg8iDsHeyjxxMxMe/gX6ORw3r1HNDR
	HEohSF8BlD5kBA8fiY21xQD103YSLNsmB2FXtdPsJaZE/l/oEAZy22lreDiQF6uWhxzgYikJfXQ
	SvMCk/4pruEwTHEq72Y+IkY315YoiBqgHsBVInpVWxxF9z64qR0B2q
X-Received: by 2002:a05:600c:4f11:b0:483:29f4:26b3 with SMTP id 5b1f17b1804b1-483c33c3611mr36317435e9.1.1772091890148;
        Wed, 25 Feb 2026 23:44:50 -0800 (PST)
Received: from smtpclient.apple ([102.90.97.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f26d7sm134009515e9.3.2026.02.25.23.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 23:44:49 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [GSoC 2026] Early Introduction - Interested Contributor
From: Adekunle <abrahamadekunle50@gmail.com>
In-Reply-To: <CABFJD6-7_bkixVA4Oj_JV1N5hMqFXFqBvK4KBAjM5hqcgC=_rg@mail.gmail.com>
Date: Thu, 26 Feb 2026 08:42:49 +0100
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3338A34B-34EB-469C-9F44-5642BBFFF085@gmail.com>
References: <CABFJD6-7_bkixVA4Oj_JV1N5hMqFXFqBvK4KBAjM5hqcgC=_rg@mail.gmail.com>
To: Santiago Leal <santiagojoseleal27@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On 26 Feb 2026, at 02:33, Santiago Leal <santiagojoseleal27@gmail.com> =
wrote:
>=20
> Hi Git community,

Hello Santiago, welcome to the Git community.

>=20
> My name is Santiago Leal, a Computer Engineering student (3rd
> semester) at Universidad Gran Mariscal de Ayacucho in Venezuela, and
> I'm interested in participating in Google Summer of Code 2026 with
> Git.

Thank you for your interest in the community.

>=20
> My technical background includes:
> - Languages: Python, JavaScript, TypeScript, Rust, C++
> - Frameworks/Tools: Tauri, Node.js, Electron
> - Areas: Desktop app development, scripting/automation, web =
fundamentals
>=20
> Some relevant projects I've built:
> - A cross-platform inventory desktop app using Tauri (Rust + Web =
frontend)
> - A sales record management system in Python
>=20
> I've been exploring the GSoC project ideas page and I'm excited about
> contributing to such a foundational tool used by developers worldwide.
> I'd appreciate guidance on:
> - Which project ideas would be most suitable for a newcomer with my =
background
> - How to set up the Git development environment
> - Any recommended beginner-friendly contributions to start with

Below are a few resources to guide you in submitting your first patch =
and=20
Understanding the review process.

1. https://git.github.io/General-Application-Information/
2. https://git-scm.com/docs/MyFirstContribution
3. https://git.github.io/Hacking-Git/

Looking forward to your contributions.

Abraham.

