Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF528504F
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021712; cv=none; b=EyfFzhXls0IB/calP2rwXPVtW8EhZ7lHpmfB98DYF0320xFixq6QIF00cVzAfAvuYl7mS66xFtVVKG7BR2o/19lSCPTqy0eazJKRzZhJneFQXk7DEjiD+xpGAXOF6e6oPeXklqscgCDHe1ke2sG2yvAc/GN9B3HOyFtjbXcU3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021712; c=relaxed/simple;
	bh=RzyU8IM/mpw2W7nTZ7PS8/BnN74qwt0tU86aJv++wSU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHN7b7enSyV2IW0xphhJAl54gEq5jhQRJZ8W9q1Tdr1BsFGANEt1dsbmVXRzHw6lZS3ZrziryVl0/T/55nlvWpNe6DcH9EQTR5/t3d7kIjC6OfGEg+IsDFc3gfoyGLYcej7FZKzr4o87eUPY6ePR0+iqTfjMTTEl3MUP9nuEHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=MHDa+bPT; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="MHDa+bPT"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68A6Rwkw026562-68A6Rwl0026562
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 10 Sep 2026 09:27:59 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4YGM-00GWAG-QY;
	Thu, 10 Sep 2026 09:27:58 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 09:27:58 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id ef424a8f;
	Thu, 10 Sep 2026 06:27:58 +0000 (UTC)
Date: Thu, 10 Sep 2026 09:27:58 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Mike Hommey <mh@glandium.org>
CC: <git@vger.kernel.org>, <gitster@pobox.com>, <ps@pks.im>,
	<sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] Move rust gitcore crate to a different
 subdirectory
Message-ID: <20260910062758.RcjdX%taahol@utu.fi>
In-Reply-To: <20260909013858.1729643-1-mh@glandium.org>
References: <20260209224847.1416916-1-mh@glandium.org>
 <20260909013858.1729643-1-mh@glandium.org>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaUEgbCQYMCQQbKAsaHRscERwH
 BxwAGAkbHA1GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
 SFldSAUAKA8ECQYMAR0FRgcaD0hYSFFIGBsoGAMbRgEFSFhIWlBIGwkGDAkEGygLGh0bHBEcBwccABgJGxwNRgYNHEhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=x+GXDEi0q6NMxIhO/uMAV/dxPFz3tcJEV/ncZqZntLM=;
 b=MHDa+bPTHmLihMJFVrXhhGG93I07/EyPKVL7c3jDjNkyNXjHSvIs80uuXMfGvoIKA5IjocrRLohO
	bXXo4eR2631whgCxbOkZqsGgDkgOsHex/uVSo4vt1Z4RJ/D/2yNLSQFfs9DLAuM7NXilHcFRulPM
	0/9teMQXYy/YV5ASLJu4gVtP0UXL44NNKLTBdsSXYKLwXpZv+MQdyXqosChEwQMQIIbP+4SGeRDB
	ORCm3sULP7HjEmckxe9KFmJv+gXVNERSZCBawhYf9XQHISxLC13GNUe8BB53YQNlQvJLmm20Z3UR
	gwDC6oLdVeazjkpFsEgK1mPOOVcBQYVJlP2OFw==

Mike Hommey <mh@glandium.org> wrote:

> [...]

> diff --git a/meson.build b/meson.build
> index d86f2acd2b..b91d30666e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1782,7 +1782,7 @@ libgit_sources += version_def_h
>  
>  rust_option = get_option('rust')
>  if rust_option.allowed()
> -  subdir('src')
> +  subdir('rust/src')
>    libgit_c_args += '-DWITH_RUST'
>  

I think that's bound to fail---there's no meson.build in rust/src, right?

--Tuomas
