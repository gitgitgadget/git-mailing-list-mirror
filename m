Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC236C9EC
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229428; cv=pass; b=NY2VHMDdq6d7/d9ixMZNmqNYrqY9GggK2YTVcIN72ClTWESqpnVsfzsXYobWXmjpTl1xsCO0pjRGJP5A13/GcYE7pS4Qq2v62hx/AKrJF9+F2KVfWZJKaGzuwQuwX2+qk31FXTsC/+XBbHJP78DskblHVVTKNc34MeHZ2DvYFIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229428; c=relaxed/simple;
	bh=HmQfakGButUIiojHQDSVkDdRTX4u/HCvZynaVg9Ajt4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=a8SRH2Et73X81Utv9UNzw9q76A6U4YMny9x9ZIRMa7Yw4zoZpbqk6O/8+h+CQYTcT9xNOlRYlMkiOQ1Tle34QXbONE9Gk/3kmz3p5oLWTR6jY9jr531VD42qQkgFONqLL4vTvR1LBUXKfXqqmKrvcq3wDLVUIkhRRJFdh6s0zic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp0t4gNZ; arc=pass smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp0t4gNZ"
Received: by mail-vs2-f36.google.com with SMTP id ada2fe7eead31-7bccaba9c5eso578104137.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 12:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791229426; cv=none;
        d=google.com; s=arc-20260327;
        b=ERYd8y/Fdd0JxLdosr0wz7LKuJ7B3JwNbr8V7MluB2iKQbsCbtDFvn5RXIuJDqyB7V
         qeHqQMpKs780DjFjlFkxp+pYu8DAEkRG/gbYpwNWnchB4aB5f0sM2wzoeb6DQXd/mX6c
         0+Gb1jW55YbSzTlZwSnaQ56LWdaBwzWkp0g6WszNtzCUBdJ1mBm9bkxrIaq4fui0g1zD
         t5C39e5LvzvvBcs4GYzi3KSuf8KN6TV3GRxNsXjCJVn/sfOsPhUjvTTfGoocQIj0xnla
         qs46BGsDxtGh5XzyxBocxNUYIchURXgEImGj5J7SMM8ueZMsPrVcfD4y2gUD7Q9+1lv1
         reqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=aZ0k//GnEZg8WxCvmyxFfoCC4ISovXVmgdtCGWhP+Os=;
        fh=e78/+eRHQcLtYqSqu09Iam+BZDNiMuvXHfeWfrNpXtY=;
        b=BQ/O6y3uJ6RDsQwC6gSck6jnWfUodmmQsK6hlTX5cgCYSUTG0h51Mr46Q3RTo3n6rt
         p02h68tuOAFSS9JI8BkAZ3rAdJkpi/S3ZEMNv1DfuzF+lv9XotlJ7F/+GL+BUszGxCvh
         cfIhXfupYNbmm/U6A5GrnOMWssbQvdTQxKqWeB6KbogdfWu6mvfj5em5hDQHY+ybqzEi
         HdwddgHIvfqbFws+fq1b5RnShHAJ42ivgIvONxfek1c9PJVXrk6EqmFl0QMeC1zxbZ9O
         KjGuwv27t6vWsl0AagrwX0fJb8bfZ8J01TidzWi4MC93qaWpT+k1BjBkr15LealuKzbv
         hw6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791229426; x=1791834226; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZ0k//GnEZg8WxCvmyxFfoCC4ISovXVmgdtCGWhP+Os=;
        b=lp0t4gNZlVMuvZZxRoOgTqGDB9OvkiXA63XE7yjSvQoBNvfQwSuIgFb7lTBYV5QR9F
         yqw67bml+ieICEQnR7a4I63dsmTa1l4/Uy5P6Q2bySEtAAlUO/dZMZzARo/eoAOPisRN
         AJZXNZoWU2PFKn3zg767yu9BpYdbuxxRE8tPkpJ5ksKVFOTJ5zhPnpuhTmu+p2JWEHRz
         ovhKt3RBJ5cIIOm33Aeoon+4ZSuQolukgdmHWoZwAekX1uz79OekJwkatL+NSSycrnNc
         PVrDuHwCgfz0izYVksiKfMc5SgERrIe7AQgqSF05vhtnRJ+23nQVDeNvVdWqEFN6+DbG
         x7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791229426; x=1791834226;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZ0k//GnEZg8WxCvmyxFfoCC4ISovXVmgdtCGWhP+Os=;
        b=S8N9n8BuuXrBx6dehQjeIjGbuMj1Ac+K36l1oDcBzEo1aWusVdfcS+jxTyyLRS7IuL
         FCgtauNtRqautlulY9ORU1UUqGkkheNB1vzxbZ8YFpdxz0+EiW/6W2k2ESJeB81ngplx
         vLsCQH5V1zwVKfqUn9Q1LZcJHe9ZGE/mwffeYSL2BBSDPQozNWX92f/DWX5zYhGVpaK4
         KmA0n11jhmuv5iRBvAvoSIoiJbbgD7LdzcAyl3V8srGLI195sRWE7Ayat/52u4Y5b8KJ
         pEE8drP9tqFw0tjkeM8x5uDUmB7RFNqafMVrE4MN8wgwGa7loMbvza+CmaQCwxj0Jn5W
         h1ow==
X-Forwarded-Encrypted: i=1; AKwUvByX0UGdVOzJMGGyx5xAKL8PsAqo1nhY67MMgAapDatZU1qD6Le0/MlO/biZ3EteIi4un28=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAvWCFwizsjY4LXgGY6jD+aML8hJvUbG1XdqkiR9/eigMW1HYM
	rtDFx6tXqUx5cjMNhSUFVQ88UOJcyVb8pxmihNNRy+ke82YFYIOaWcIJpDPH/56BVjXcVeV3ugl
	FAdXiS53dyT2AAYeR0f+OxuPVeyJGbeb2VA==
X-Gm-Gg: AYBFou0nQMhmiDCejTPv5gocbQer+02cwwfOYXYpWOW5ePnFhYMPoZPABXOQznu9saf
	yfHB8Iow6Na6qa5LkKsUwbwtryE4JC2GiIx1fbXebGM2SrBdkmsGPxdswGkV4PXPeAoFLr/qPwg
	+KniesMtwd1Mi8NmGCiFfMP53/hcuPq6EMpA6pGH/J8Hm4VVus3pXT2882cPE6FigWvK/nizDMG
	5wVCTA3W8iMgkP5v318YAC1R4myJw8km3JdzaPtNkHO4C7JKgQMzfrkY/gp/P/mwkHaIEgZtld3
	GhHGofVuMC9UmtLohGFsJr8oYKKU20lloIroU62TteQ2Mbn+74p6AmtxF1MA5x6hHuK9ym7019B
	AkbJ789yQP9ZpRDhyZlaQknjWwfqzPu9AATUmBSUjEQ2iIkw9AWNFscNn
X-Received: by 2002:a05:6102:91b:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7c3881ff813mr1214534137.21.1791229426194; Mon, 05 Oct 2026
 12:43:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Oct 2026 15:43:44 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Oct 2026 15:43:44 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-2-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im> <20261002-pks-odb-move-alternates-v1-2-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Oct 2026 15:43:44 -0400
X-Gm-Features: AclHuK-QbO1lu2Qr8bAAU97bpcr3LhpM-HIkggqAcfzJNPPBqsJDxOmbWoarVsI
Message-ID: <CAOLa=ZSNHWFw5Vj_5qg16ipp1QA0pDcV8h=hOA=ma4hy6F_LcQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] commit-graph: stop depending on `struct odb_source`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a930d6065d1d1949"

--000000000000a930d6065d1d1949
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -28,7 +29,7 @@
>  #include "tree.h"
>  #include "chunk-format.h"
>
> -void git_test_write_commit_graph_or_die(struct odb_source *source)
> +void git_test_write_commit_graph_or_die(struct repository *repo)
>  {
>  	int flags = 0;
>  	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
> @@ -37,7 +38,7 @@ void git_test_write_commit_graph_or_die(struct odb_source *source)
>  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
>  		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>
> -	if (write_commit_graph_reachable(source, flags, NULL))
> +	if (write_commit_graph_reachable(repo, repo->objects->sources->path, flags, NULL))
>  		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
>  }
>

Shouldn't the caller of `git_test_write_commit_graph_or_die()` send in
(repo, path) and we forward that path, instead of using the path from
`repo->objects->sources->path`?

--000000000000a930d6065d1d1949
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6501c2ef0e5c1ac8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRC9lNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFMrQy85TFpGdDBpVmVteS9XQlNNU2h0TnJtVzFzUwpvK2o4dVRTWGU2
cjFIM3NiSXd3S1BibFczaUgxb1ZWMjEvMzFvc2tWMlNXRktJUWJHanhNdjJ5Umk5K1B0S3c3CnJD
bGdyUHZuMldGL3h2ZXQveU1Hb1o3UVVHMFVNY0tmYUMxR3A4alFCdWtpT2gwRVFlSlFFbFlFam5N
eEZuU3AKYUQxbjBtOFZqNGFVcVNDU1JoS25EUFRNRC9BcldqbFZtbnRrYmdIZ1EwS2t2R0hqOEN0
bkhuNVJZMlYwV2NyaQpGems2NjU2SlE5M1NSak1vZGQ5eE85U1c0NHVCRGkwMG9oRmJmT1IzQzVp
QnBvMDdna3VEZGNIRmtYVnhoZ1lUCmVxNHRuRmNsb2I1RVBRcTFEYkxRcVJCdmNCZXhXdlB1L3ky
RVNMM2NlM3BZVWRDbXBlZjJWK0F0cks2T3JvbGYKbm9nZUtDTnVVVGdMUmhGbGljbERMZzNhc3lB
MUZPNlNrTml3aU1meUJ3NHU3UlVySGFndjNEMWRlQ2xhUzRjaAp3MTFuYllKaUdtL3NJYkl5dXVk
NHh6bFFhaURETkhPVTdpMm5RZzZTTSsvY3dRcU1NVkxMM0NEYUlSL3NMZVY4CkM5eWNWeFZIVytr
ZXVBcnVtRW9XUWNuUTZwNzh6Tkx1d2p6NERrND0KPUxhd08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a930d6065d1d1949--
