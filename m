Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581839;
	b=LtVi5p2DutYKyT9AMQMfHRI+xszDkmwUtkl8HFwW/VQCrEtqHo2C3BZ+1iATUfeojPo4
	 x5Wg3zie2mQiD0luFSNZFoHCTxKZrK0aIJkgc5f13LXftqDOyFW1kMqEAKanzASc1pWF7
	 vJY0GyYlSOUghbsPi4cXS1vSj5U+JRdaceqhcb8bYlNBQ5Eh8hBjBuCKer/NXA15LAC8U
	 w/xoRAKZ6gtvt+Fu6iZZCt8gLt020OK1bo3m0Mgvbm7FVPkNdQz2RbLKInVrKjrcaNBM/
	 fXjYuXvvlpuTzywSUJNRFDwkQSvt7ckAmfqcY/O9ZHs3byNFS0cdLrSsNGl6y1vb0gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581839;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=vs1QtHJALFPKXwCL1O8Oh172+Knxh7vsDdYMnfdv6fU=;
	b=VKAzzd6dpOB3JPEkyJZ7r8h5iBCkovuSPNpjESiPsR2F4rtxoMhJLQN/V+L1sCE0F9Jd
	 MHo07U74iTZbfpVyedJ7msChcf7CjdhivvtrZ5cmki75zzNgu5DN9jh8h52r46l9S6QvP
	 TKvx0yv7pf1UKT51O4wjYlH5Rp+5scU4BnyMVeh7dAHM0WTUvFOR8Bv1brc2SzkPool01
	 qQXYdXHCm9BF1N9fuSXZmtkoOCM3bpDlJJqP08iGuJrW11/c76o6TV4i1HSQ8I4XmwzyP
	 ef60aVHPl+iLfJ9b2KY0EYoMvxXfcI17WpQ0B8+fTxcbdubYYjcVgqSHJtGeZKHFURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=ekThMaD4;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB17606A31E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB17606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=ekThMaD4
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69LBNsgT020533-69LBNsgV020533
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 21 Oct 2026 14:23:54 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xJUQE-001GK5-Na;
	Wed, 21 Oct 2026 14:23:54 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 14:23:54 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id d0355052;
	Wed, 21 Oct 2026 11:23:54 +0000 (UTC)
Date: Wed, 21 Oct 2026 14:23:54 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Dan <timelord@gmail.com>
CC: <git@vger.kernel.org>
Subject: Re: [BUG] http: push with token-only URL userinfo fails after
 libcurl strips creds from CURLINFO_EFFECTIVE_URL
Message-ID: <20261021112354.S3kbH%taahol@utu.fi>
In-Reply-To: <CALGWHBdx0V95RoZJvyC7G4t4RpXpQm3ycv+huTQcPunOCm7hBw@mail.gmail.com>
References: <CALGWHBdx0V95RoZJvyC7G4t4RpXpQm3ycv+huTQcPunOCm7hBw@mail.gmail.com>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUEgcAQUNBAcaDCgPBQkBBEYL
 BwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSFpIWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlQSBwBBQ0EBxoMKA8FCQEERgsHBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=vs1QtHJALFPKXwCL1O8Oh172+Knxh7vsDdYMnfdv6fU=;
 b=ekThMaD4Ab6dEaVVZC05TtrahKCmuqke2BvJm/EU1WI/4jgYmuDt9JMfLhhBeWFqOidKmlo5v//h
	Hhvl76q57C0S4cVa054c8Yp93F+mDkjYk5Y0e7TFP/rnuNKjhEVXRbTbBSLSEdX5/8gVQhq6rR7z
	z0o+QHQa908uKMY+onlmi8C1aIKl3LCadP14KAtrvPjr+Jbmxg+o3/OGQwnmIgT4Hm114ZuqdWEz
	kW0wzXhNZx05/u4bhCwUwoMTQJSig/MEjRZVwlYg1wqaqwE5GD/VTQ3jJraBCbzWlUo+YVi4KLQS
	PrlWSBuzpPwKJzit1lYkuzEKCgt9/1DIq1LT9w==

Dan <timelord@gmail.com> wrote:

> Hi,
> 
> (Please note this was done with the assistance of Claude, I apologize
> if there are inaccuracies here, Ive tried to go over this and verify
> as much of it as I am capable of. I tried looking at the mailing list
> archives to see if this has already been reported and I didnt see
> anything that looked like it had yet. I can verify that the new
> libcurl behavior absolutely seems to be causing issues from at least
> my own limited vantage point. -Dan)
> 
> Since libcurl stopped returning credentials in CURLINFO_EFFECTIVE_URL
> (curl 8.23.0, commit 7a6bd027d0de "getinfo: make sure
> CURLINFO_EFFECTIVE_URL does not contain creds", CVE-2026-94266; also
> backported to Ubuntu 24.04 as curl 8.5.0-2ubuntu10.16, USN-8932-1),
> pushing over smart HTTP fails when the remote URL carries a username
> but no password, e.g.
> 
>     https://<token>@forge.example/owner/repo.git
> 
> which is a common way for CI tools to pass an access token (Renovate
> does this for Gitea/Forgejo). Fetch/clone keep working; push does not.
> 

Thanks.  Please check if 76524c2604 (http: handle curl stripping creds from
effective url, 2026-09-28) works for you.  The patch is already merged to
'master', and is described in the release notes as:

 * The HTTP transport has been updated to handle changes in recent curl
   versions that strip credentials from the effective URL, preventing
   unnecessary credential prompts during redirects.

