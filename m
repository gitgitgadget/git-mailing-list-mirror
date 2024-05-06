Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420915A5
	for <git@vger.kernel.org>; Mon,  6 May 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004083; cv=none; b=mJMw2eGoUngYimATXEdxqP7988kppVQLad3EBLgGo60O6d5eY18BseJSl53sUCSWKthKE0h1a0LqTf/2l5iEOSFTtoyM1IBRq9dlQEmnRMCb/Gze1A/q+lU9l6hgEnLelr//CEMR9zV0iIxrHROeGU9Fa8NrfwQ/1QrEpcADJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004083; c=relaxed/simple;
	bh=TfI3NBhtv4P29H0JgSOTqGqLv9EsDtw53bH+eVsxt4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7BEOvf2y+PByaI74D9vmtEA8um72lKyHw4nd5PCPbFhfGff7m0W6pK2HxYM+2G1pQlRYvEeccPmeMn8LlcGCLS7GxaESDM0b7A8OyLyTywHFdi9frjxfCxrikWgxkNLnsnu2mR8PVBXchobCNUtOEH9SU6d7rZnApQ7Rcvy4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS7fNkPA; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS7fNkPA"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c96be1ef20so595015b6e.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715004081; x=1715608881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq0qpGHch2DLd5h9sKPxYU7/y0ZXnun09oDLHkP+sAE=;
        b=CS7fNkPAKwCF5u0amO+C3ORmpIXYsSA4nrvOzI7hnDBDpXEw1WwGo5hJpZpGzHl5Q7
         APgT0v2pJBmZ9ZgHBdzhpi3Pk6hDXCEAmcq34FiwZVAP+/8yCqp4Z2u2gdu+Dq3mHoLH
         bQr9cDvg91Gzt0y4f0u6EaNMV58KhXbaQ4dw4yiiKP11nnTFHq2Lb8rdVern+RR5F1Fm
         l252aWiegIeeiwRXK7/B0QGprU8Mew8kGHdBnDSV+PVcneU31df/ykMRutZXrwYZct4U
         57Ptlm72ttJ4LCLEYLUlFQ/cYTZrfhTC0Ap12qZfxmY578ZaMeyO2v0IA9l88f2aOfnc
         JK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004081; x=1715608881;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq0qpGHch2DLd5h9sKPxYU7/y0ZXnun09oDLHkP+sAE=;
        b=hdnQWfgeW2dD6l5I5nveuNvoKk9S88ycxRnFW/osUkEfsJC84Jds9WhpACEe9zEdda
         FEdNkHoNejSLEGN3a+b6Ig6ZiP1YfdvSdM+PQnZ5bwBiDVmev4NpYBeA7TL2Bm7vQZP1
         50D2y5qObw9F9HVWMMXvQGJJ/POjOy6umW0w1nLr43ahsdf2+GN7z4T6eV3q33h4w+xH
         oq1EXZqFoVa+A4o3xUH+fo97n1gBDEcolqbm4qxZC/ShMjxv2hx9rgOaO0rtDA78YUug
         4Gu+sC2n8ge7RGx5aRR3+5iNAFD15uJkYJPNFCi7e1Nd74KWz9pAANwf+dY5CLAwHPlV
         Bs/A==
X-Gm-Message-State: AOJu0YwVO3IA47RzRsOF9CfwxOMu7LhJVkvyNsY3cNzMpgeKUdvyirpf
	+eXL8juteJAoJ3KRrE1c96DR96XZgwU8bSbLEKPNCGPc88uMTf7/47HNiw==
X-Google-Smtp-Source: AGHT+IGvZx3NEvQd9hjuvYJNKragjhcf1TpGDGRiNOX67N4s/nujdjgo/lfMeyxSTubJWV6nvVauGA==
X-Received: by 2002:a05:6808:1b06:b0:3c8:6418:4cf3 with SMTP id bx6-20020a0568081b0600b003c864184cf3mr13229366oib.38.1715004080257;
        Mon, 06 May 2024 07:01:20 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bq13-20020a05680823cd00b003c86e2d2479sm1398691oib.34.2024.05.06.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:01:18 -0700 (PDT)
Date: Mon, 6 May 2024 08:59:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Message-ID: <6os32ofwwbxe3r4w7rnrpjkyz2jtob4rcucq75mjsy5gkioowf@euxp74pjq6xj>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
 <20240503172110.181326-6-jltobler@gmail.com>
 <Zjh-3dCL2-MnV-PE@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjh-3dCL2-MnV-PE@tanuki>

On 24/05/06 08:55AM, Patrick Steinhardt wrote:
> On Fri, May 03, 2024 at 12:21:07PM -0500, Justin Tobler wrote:
> > GitLab CI does not have a job to check for whitespace errors introduced
> > by a set of changes. Reuse the existing generic `whitespace-check.sh` to
> > create the job for GitLab pipelines.
> > 
> > Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
> > available in GitLab merge request pipelines and therefore the CI job is
> > configured to only run as part of those pipelines.
> > 
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  .gitlab-ci.yml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index c0fa2fe90b..619bf729fa 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -102,3 +102,12 @@ static-analysis:
> >    script:
> >      - ./ci/run-static-analysis.sh
> >      - ./ci/check-directional-formatting.bash
> > +
> > +check-whitespace:
> > +  image: ubuntu:latest
> > +  before_script:
> > +    - ./ci/install-dependencies.sh
> 
> Do we actually need to install dependencies? I imagine all that's needed
> would be Git.

You are correct. Git is really the only dependency we need. If we want
to remove the need for the install dependencies script, we could fetch
Git ourselves during the pre-script. Another option could be to use a
different container image that has Git baked in.

-Justin
