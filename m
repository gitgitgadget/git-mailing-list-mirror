Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29911C8C7
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981422; cv=none; b=PD1aZWCewd9NuAaPWhJF7b3uf6/RUQTT1Uoq1uMb3QFHN0AZerNwaYUUaEGGPI37Z51+x4yETqnIlJyxzooqsyVIUj50y/ivsdrJ+sziQwWhv/BPEmcJjrxzibSk5/JTO+PWALlkCkrVZcE+YL+2SqODdk/eECFL7Cn7bTS4xHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981422; c=relaxed/simple;
	bh=eEeY4tayhl3Lce8fNf47XJQA4I+i+UtJfyOm//iBops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpXHwmcUOS2NEiPMb4L7LW/HdW9wfGPCXigyCjZL0GIVqZk6nuo5ZILu+w/bOx8xy6VdgE4ljRhN/thIt9ERs035D8vdTxD4j0yMJvRknU55NSW09SLsfz80goSX87vBrVsVuaS2k/RlN4PTGW+Vz2rGhHgtoq4kL4R3fekwBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0tQJWtal; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tQJWtal"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso32465ad.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741981419; x=1742586219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfEb2LfbOasu0GL9kkamVPXFGTwjqQSj4iJD004reUk=;
        b=0tQJWtalHmonxr6yAz6jKwpcYoyNu9GY2kvYtPKTZxj+DrwrC9vJFgirCV3xh+5eFX
         dNmH4Cyma6N+NYcO+zqp2L/yp1+AvwoBcdVqU9NuzfwwniS5H6Ny8Np604KND+oMAtpj
         +KeavMJa7MAZrh10/GhzXaSfn85I/bYyxCEHCEvsH0xLYEeNC5RdC0aNlrp2ly5Hm8LP
         vpMXGgYziV0QSvBWbYyXIN6OaD2L0ucc81Tgrl6bWYi5/sWI6paAC0SPx8STZ6Rry8j4
         CVY7ETUPKYvGPE4dxkQnG0bxbZIYXlSaJzW5hO3uFR1fwMgIyPPyIdwKw0RsYJfY93ST
         1G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741981419; x=1742586219;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfEb2LfbOasu0GL9kkamVPXFGTwjqQSj4iJD004reUk=;
        b=d80K6NllyD5TDv0k+7lPNTQXGeCr733vL9Qr+fbVePAVZ7AjEuzVFK+JvzX/oj7pis
         klZoa4rj2gJWUChCyCnQz+fJpk5mbO2JiQtBmQs+IfnVRsndsNAXRNIIeXcqAbsy6sFX
         h4MoEb3VxDw3gxdi3DF/sTiUJTn0CqHRgETpihvZRTKW1YlFZHZ/jD9uifuuCQTkgDOy
         HpoP7wxYyMp3fe1rUi/6tmwo2dC6Ag5XPIx+9r7z8XMCvRnv/svXEFC5oGUxOSa34+Dd
         bUn7UAhNrbqsmqJz1T8w815Bvd2U36DBeKHsyKwT5pRMf8jWZjk3vsmA/ZggkM9KK3Em
         b0xA==
X-Gm-Message-State: AOJu0YxldHCjDgPHHzmSpIv7YdA7WoZ7UY+4Lonf1dmgpnAsmqJnCMZE
	w6PZLFLEArOdBdLa/ZWvJZXCBRsrou1WZYgLEYXtP3q5yo4/IXmyv7kVPXwgCQ==
X-Gm-Gg: ASbGncuifPR94SAX+rq7weuACrgMJaasRrXiwffG6I62X1Qa/uq+5kKbeswC/PQMKC4
	gZNNP5M6gfQvyq9t2N85LYa8i46VupYh3e9RuKD/WNBbxeJzgwJ1r+vP7N3KXxIb3mA6QbhieAv
	vd9Qu68G3ohb/+JZ+vtG8vCrCJ8ZzG4iNK1gSXYQKIiIFHQrAwQa8gbwempz9xgrZD+zciM3+/w
	xBrWXZb9UKHnq6Sk//7n2WN0sPy7oD+4341+dYH9/HlCziWvtWKnA/SL/rhnZ1SHB6pVx/Mtb7y
	jJwjCS1708Z3NQk/F1pn7Xy9Cr9eDPNP0EIIHDRMHGo=
X-Google-Smtp-Source: AGHT+IG6PXmQkABatpLlf3jCKNL93txr/fbj3+EV9k6XVPYiwHnLrp/SbNhpFD9reIVpIpHH2Ri/hA==
X-Received: by 2002:a17:903:2f4c:b0:21f:2ded:bfa0 with SMTP id d9443c01a7336-225f4010927mr349605ad.25.1741981419156;
        Fri, 14 Mar 2025 12:43:39 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:12c1:1687:7cf0:db6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ce5sm32234235ad.252.2025.03.14.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:43:38 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:43:32 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git-packagers@googlegroups.com, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Problems publishing Rust crates (was: [ANNOUNCE] Git v2.49.0)
Message-ID: <4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, git-packagers@googlegroups.com, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqfrjfilc8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrjfilc8.fsf@gitster.g>

On 2025.03.14 10:16, Junio C Hamano wrote:
>  * Foreign language interface for Rust into our code base has been added.

Unfortunately, I've run into problems publishing the new crates to
crates.io. Specifically, the build process for `cargo publish` is
different from `cargo build` in that the root of the repository is not
included, and therefore our build.rs scripts cannot find the top-level
Makefile or any of the Git sources outside of `contrib/libgit-*`.

To prevent squatters from stealing the libgit* crate names, I've
published placeholder crates, which we can replace once we've fixed the
build issues.
