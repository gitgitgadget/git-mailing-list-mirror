Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01B3E16A6
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179783; cv=none; b=u/K97Keqyn1yrYoml42HLQgxfHVX6ggjRl7B9WgLo2W7AT35ZiIx+cY44puN7QxbDvSKzwkjn2VDA49CSm2Owv4wrRzT1fJjthdNv2VwY7qPrOFJ++VplAwSqg4spDQM6IHvzoeIg3m0+4wCC9nvl65yG7jSwf5JxYzFBhzzTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179783; c=relaxed/simple;
	bh=3eqx6bTc+kt3IRPfhwnLhhY0qvuxA+UCcJ6lwEwj1Z8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Shxok1XIXzMOBNJy58Uhsvoi/iNWGMm+/bLnvNU8RUxXZ88ti+r9yFnbwfuKoJpjVRuXpMpI4qshMpGg89jASTYDvN5x665KTLZanApzQz0jYGjG6ndjun8Fax+TXkUNWZs+DED1A8XHhJAyzWp0UcwD1Q0WjpfyS2EK+GUuCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=A5F3SpNS; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="A5F3SpNS"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64J8a0Dk016900-64J8a0Dm016900
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 May 2026 11:36:00 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wPFvk-00FiXZ-Fw;
	Tue, 19 May 2026 11:36:00 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 11:36:00 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7a67c629;
	Tue, 19 May 2026 08:35:59 +0000 (UTC)
Date: Tue, 19 May 2026 11:35:59 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] describe: bail of --contains --all is used with
 --exclude or --match
Message-ID: <20260519083559.onq6r%taahol@utu.fi>
In-Reply-To: <20190226215348.5119-1-jacob.e.keller@intel.com>
References: <20190226215348.5119-1-jacob.e.keller@intel.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhaXEgCCQsHCkYNRgMNBAQNGigBBhwNBEYLBwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSFtIWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFpcSAIJCwcKRg1GAw0EBA0aKAEGHA0ERgsHBUhYSFpaSAIJCwcKRgMNBAQNGigPBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=k2OSp0tVz8M1FH7hB9VoLxh1RWmAHdvGq/MX5+74qIk=;
 b=A5F3SpNSSWdx156GReg9x+olWVJ0wQ0Hq5dsABksewDhluabwuUwO5DTrYclVom7ns8XINdvsetP
	Hc61Rvpla0GqwtmyUHtzs3c3wKlS50Iam0rP07ZFEvak53b+Kznc4E+uL1UNurtrgQ11ojLTNhAC
	uVyD745Bq4PdR/9gDNnXysZijq4ShItlaKM0UsNrZcKbAhYkY7j4R1aQacF8WrwiKcF1tg4ABYD+
	tI0ERvy/4Q+a3m8l0WzvtyX/ZcuwRDirv4ob2Ikv4mEyXcJGGHSrGqO3BYNaTqCyW/uRBikZmkTi
	EwM+Vo3E0ttFZfwZ1bfE68yTPMmZfoZuSvY/kA==

Jacob Keller <jacob.e.keller@intel.com> wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> If you try to use git describe --contains with --all, the exclude and
> match patterns are silently ignored.
> 
> This results in unexpected behavior, as you may try to provide patterns
> and expect it to change the result.
> 

I got just bitten by that, and yes, it was quite unexpected.

> Check for this, and have describe die when it encounters this, instead
> of silently ignoring the provided options.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> 
> I just found this while trying to use it, the patterns weren't being applied
> properly.
> 
> This is pretty quick/dirty, I haven't had time to write a test, or anything.
> 

Would you like to resurrect the patch?  It seems it was never merged,
nor the underlying problem fixed:

```
$ git describe --contains --all --match=bogus
master
$ git describe --contains --all --exclude="*"
master
```

>  builtin/describe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
>  [...]


--Tuomas
