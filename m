Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995C1667CD
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241774; cv=none; b=qR9jzFibrUugYhR7arzfuCjug4L5PguqaFQjzWKoFH/t7t9qLtE6lwoSqCCNUk1GXFiBxoitjrrvUqkD2krRJXMQkX97/qZQzggf2AVUwwcwzt0sQLu7FAOUzIiGLTssb+FP3wJytUjWhWHtZxXyw8aJaZmoCr3EwGuZzhBJefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241774; c=relaxed/simple;
	bh=ePYjwCGR2ljyM5ZPCensg9KM20Ke969EuH2xOv0oLAU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEm1OeT+mJnp5sH0oiE3wHICC3eg4Ma1l/A/aLPDBEc5RIjbViplUl5GsgJwF2C2rHOKl3RHMkxHuI8zI54/UzLBTu09VL9eD/1kNytekWpSlYXFDs0GLQgfsQggAzbvlhXUqO5oR6lclu43SAkj3S0JXoV3N6M3Ooz4V/YxUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZgp663n; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZgp663n"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710d1de6e79so1475552b3a.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723241772; x=1723846572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZK70FsX2cUwzV/Y61aAtiIiJqqCN2+H331fj47X9pyg=;
        b=jZgp663nUXouowemX3VoKihA1KU30livoz1KQ0oF7eOgzug3JZ5Ju+mlLcCVQVdKRE
         AY1CxHKnmsnJxLoQMy1LdorAAhtj3H/odLF9ZR5cYo3rWkQnQTCBmRtRHLv7fpEdtz63
         gQbKWQMIUu5xEwx1+mG8yaXAG+8Co4YnTrzsTZnBI5jn/Cz/IlkzywC4z4qQKNYuIwci
         vxtIx9PmFeCIti9Geroe7XxkWYkhF4jY2Fu1lG6Djltdvf7lIQ4WGlCXGM5ylf8KpJkx
         1YrshQt4PcBSzAGP9bWf7gDke4qCn04yAqQTx2eGzYCpNrs7sHhMk0zr2+HbzHsEEQHa
         stnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241772; x=1723846572;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZK70FsX2cUwzV/Y61aAtiIiJqqCN2+H331fj47X9pyg=;
        b=pfCzYbDGpWgbaRwJJ070WCSkkpj3cdwOpW7uCGToS3K42t0yzqpYb8g/57jJi7czrx
         kY5iRJqlyS4ekqQxuqMbRi/lyUASuVuF8iKLTpzYvpdplXwCz7TrsS4BcvS6y61l0o7A
         CHyPtQgvHWUU/NMj4+w+mP2MH/iAFLWbXiXpKsvA8lobVwbGcV/AY6oLnzx2tQa3s1Fh
         oT38X2hgaHy+4jumkSoXy4ixOHQCY7Eqc4sNmHR1oqV6VAzzaV4dtFj5Ym71gJaZZrJY
         lwo/XNqavkXxPUK6L9b1IuiFGwOmir6WplrDyRGTMyLe1Ii09X5fokZyu4Q3JK3c3SEW
         GzCA==
X-Forwarded-Encrypted: i=1; AJvYcCWJi1frdhZiM40NFnT5rZRAd+uP7uXmpZTR7AcqXNX7DNNYdQbQk7vvjTW06D3sWE0AA5Za30/JMol3l7FeX+dHEMVD
X-Gm-Message-State: AOJu0YyoEzEWSbyJIEVzzBuLZQ2lQ+ZczxreCxlWbOtmBPGl5pPV9wig
	6Eiav6m9ssFkIS3ApuWxWWzUsi3aRpY66WPA61YKj+v+MWt6dWLnYhG7gxdMpw==
X-Google-Smtp-Source: AGHT+IF97cU0Gjz6t7Dxc7Yqo5WjTeSxFPTQtfFj7uT1tm5gaj7iOYeyQ2k0OzsOhh5nRP9SaLyzyw==
X-Received: by 2002:a05:6a00:2e91:b0:70e:8f30:23e5 with SMTP id d2e1a72fcca58-710dc6c3374mr3335808b3a.1.1723241771425;
        Fri, 09 Aug 2024 15:16:11 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ade4fsm234643b3a.51.2024.08.09.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 15:16:10 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:16:05 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <mhwbjer3ti7psyuves7defo4grpdb4gaiz3axq6523pjglbkzh@cw2vfdyccgxf>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <ZrPvSWoUOEaUIjWq@tapette.crustytoothpaste.net>
 <ZrQgY1pehCH5O78w@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQgY1pehCH5O78w@tapette.crustytoothpaste.net>

On 2024.08.08 01:33, brian m. carlson wrote:
> On 2024-08-07 at 22:03:53, brian m. carlson wrote:
> > I left some comments in the series.  I think this is a nice first step
> > as a proof of concept, and I'm very pleased to see it.
> 
> I noticed a couple of other things.  First, the code has not been run
> through rustfmt.  I think it would be helpful for us to do that since it
> makes it easier to not argue about style and it can be easily enforced
> in CI.  It will also reduce diff noise, which I expect Junio will
> appreciate.
> 
> Second, cargo clippy complains about some of the code.  It's again
> helpful if we can fix those warnings or, if they're not appropriate, to
> disable them with an appropriate `allow` pragma.  (In this case, I think
> they're both spot on, but I have seen some cases where I've disabled a
> warning.)  This is something we may also want to test in CI in the
> future, and downstream users of our crate will appreciate not getting
> warnings when using clippy themselves, so we should be kind to them.
> 
> I noticed these because my editor complains about the latter and I have
> now intuited enough of rustfmt's output that I can tell sometimes when
> things aren't formatted with it.
> 
> For those members of the list who are less familiar with Rust, rustfmt
> is the standard code formatter (and formatting verifier) and clippy is a
> lint tool recommending best practices.  Both are shipped with Rust and
> using both is customary for Rust projects.
> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

Applied Clippy and rustfmt fixes throughout V2, thanks for the catch.
