Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293BBE6C
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938779; cv=none; b=nkddtCLlCYjZxcEFFc82q9eFTlS4Uod4i5PNDKsuph6iJg1eyOdkxHaEH+Q9MTO1srKAM3SWUz6RKW7hwtzcTAPQFO9X7YqCS0sbRqnFWqy3EeEt1hlDx3wQ6D/W/jLcJHmxjVq0TZngYn1qfZ1ibkTabZhE4Z89K0G1W/0eStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938779; c=relaxed/simple;
	bh=HAe2cO6r/ntUSQlD7pb42ujCxvpCyan2Ej759lv7jT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaeVX4ciNj32SFRp9g5pY7cJeL+MKcapK3o/W83+TcWVguSnuLNCX5ApqOq+Wt20IXCBn9Bm+CK0Ma2gYxbPhF906m058/VlLbcNfVcwDmi4ZMRLq2V88PsEbP691bOrge22QxXSJ16x2SnMveJs2+SJVm2ExOza7Zz7UaQ/QIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QJqU+F6Q; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QJqU+F6Q"
Received: (qmail 10742 invoked by uid 109); 8 Jul 2025 01:39:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HAe2cO6r/ntUSQlD7pb42ujCxvpCyan2Ej759lv7jT8=; b=QJqU+F6QLcCs0lLAu089sKM2Mbka2n9Yq2Kx4EjukTjMRRWkCj7pZU9TqqsJzoA76v0tkFUX+cRb/GOLzBlsapASk8zUgZy+FXW/mTrRGMfgl27W3o6mTVDOLCQOIoT5NTcLdC364TMohtV+q6nlGS09HvciuSzGEVrETgjPxMR9m85k41hjCWI4AH86yAGxvVfZ4HE4feXXaRJ8/hfTAA7PQqCvkThSk0THaeGUgxXNLBPcNftabPtht6giJEZBRR/kK+Ejf+SRAP6zzq+/55rPb+b3GSHHGCiXDGTPswzRHy6EYGjUpYmf1wb1fcWx6ygjSfhVfi+fs3+FfEtBfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 01:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13970 invoked by uid 111); 8 Jul 2025 01:39:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jul 2025 21:39:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Jul 2025 21:39:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 8/8] ci: use Meson's new `--slice` option
Message-ID: <20250708013935.GA549322@coredump.intra.peff.net>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
 <xmqqldozzge4.fsf@gitster.g>
 <20250708011249.GA547084@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708011249.GA547084@coredump.intra.peff.net>

On Mon, Jul 07, 2025 at 09:12:49PM -0400, Jeff King wrote:

> I was just digging into this, too. I guess:
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 673b1c44b9..717bd2763b 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -289,7 +289,7 @@ jobs:
>      strategy:
>        fail-fast: false
>        matrix:
> -        nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> +        nr: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>      concurrency:
>        group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
> 
> is probably the right fix?

That does renumber the job titles. Probably not important, but they
wouldn't match the non-meson ones anymore (though I am not sure if we
even slice in the same way, so maybe it does not matter at all).

Anyway, the more minimal fix is:

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 673b1c44b9..7739bd2d76 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -306,7 +306,7 @@ jobs:
         path: build
     - name: Test
       shell: pwsh
-      run: meson test -C build --no-rebuild --print-errorlogs --slice ${{ matrix.nr }}/10
+      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"
 
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})

with the additional bonus that I can put "PowerShell Hacker" on my
resume now.

Curiously the quotes around the whole thing are required. If you do
just:

  $(1+1)/10

you will get two arguments: "2" and "/10". Definitely surprising to me
coming from a bourne shell background.

-Peff
