Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31856226165
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306628; cv=none; b=nuUAX3xtnpazr+I2UJIT2sA1r/ipkQaelKp0HdoK2CDHL/jKEo6hg018FJeXCkWLUYYfutA5rA5oenvyho5TvyUKW+RTYWgWxniXc++GGUJ4Zh74DkZoNso45k9ZSYvwAvOqqGS76p2PJBFwd1G/uH0tY1OW65z8oWEFSo8slsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306628; c=relaxed/simple;
	bh=LtkBOEA5GgE0Df+IN44N1PVauhnH0X2NISuXjhdsb2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVtqoSO2T1VI58iu0EuYOam0kDTt6EcayRfaV1ZaYVvgnxTFAfvXeW6JkNxPbikvBUxbRRIVqOioe3JDQuMAoBZnSOFgGbni/JfycV+Uen8DbEdHgZjusosH0t+XSOwISFfa8+b2CrC+ci0c0NGqO3IsgeawtEQkQV6uMqRReCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=NL3OEcyS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="NL3OEcyS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2401687a12.3
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1763306626; x=1763911426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tep4hV/UqOSz+DZvjlmQtiHVMwC/P8UVwWKKEvCbiM=;
        b=NL3OEcySNvrkMLJ/7TfJHldqvsmAQFCxTYBR+V0O9W9AKPw2mQwkqXPVsJP9WvxU1j
         srPNuPLVPT+NMDd3MFAmQ0xm8KQD6CQtB3vuOTEuL1vqWfbYn8Z6p1tZN0LrRTh14D63
         0DgygDOtfnBcFCP/UmI5eZCT5vHnaEGO6X2ZEiEjKxzTwV1nQ1KXqVnQu35T/90jl1l9
         SsDgnDWQVycnBRZnffzulegyCvKY4iEZ3TR/mJFIawW+JyaOZZe0DcM697Y10JqDl4OL
         lnnTHZLVurm/jymRZ3jVfQQ9jziOnAX0MOXD2KWI1z58I9DqaAkpQMKIpPB0eX/4e1lj
         jidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763306626; x=1763911426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tep4hV/UqOSz+DZvjlmQtiHVMwC/P8UVwWKKEvCbiM=;
        b=ebtW+kRPzTY8gdeM/oNWaoi/MMvMVL5AlFoPvtjXymy2sJ4YPaXmh5qhIsMICBfyfp
         uUQc3MAN6g0UHJy5n9HVFIRmtm6ynz0XUGUo2gBQEhcmwjtQzRe3IRlpbP9dVVhevZBy
         hbGzL3sPeKjA3bh1ue0t9zBhz0IMPhpw5Apdd9DdXpAMyF4yy8QCaI1Ipw1QqjmfyMGU
         mT4lfE4XgamZ8jaYLM0aIhmcfHdghELvm81pBrpIOLujMGwb95K05IKEmzUVEl4F8FIi
         cGcy8kAynXSsO6FMWohgbof1cnruZi0NAkHroFmSRR6Wb9fh0HDkrAIrGWRNp9QkjdEZ
         e10A==
X-Gm-Message-State: AOJu0Yy4YpuDo/HZ59YsDl+6FWu+jfYe6iTuEDDPeDX0BGs1LJgvVmcI
	s7WUH+namDXLbRj6WEMG+SAM8wIylT5wbSiPb27jlXnURFqOIhVsG23FYXOK5jCAIWbBy6tHcTW
	wzfAFnNthLlECn9I9ViUrmgyt1DUYQvoRaMuM/l+FHD2xbi7i0gPsD4v6KtnnmI+nCGPfqKXjk6
	TxpU196unE43anOT2KxrJvEVQFzoEVb+bQakX5dohI0tNTpjsOBydh8kQ1HaqRHBoiJci/V+Qzs
	0cvXZHb28ZY/x5Hndo6G6BtDDRpKX/8K/ed5H52NxDl6f2XzqqFxTv5WWYS8H8N6O01iexZl5hu
	xs+PKGK2IJ6zdoI=
X-Gm-Gg: ASbGncuh1GA82+BuW9vlVxJyvIaWmu/xbP8PajBf97akp+Qlm9rp00xVQPDasBIZAOs
	hOTtu7aWezHobUtKM4LwKpHBTExEqKERJy2ZqlCxS+Cf8YOv7oeRz+rOkltYyLnE9sGLAc7FgEd
	RjXtzTyvMtnxk94KFJ5ppZM0LSpGmG5FFmba+LhgrPqKQqt0sTLnOcsAqjjqA3SQ8SkQHAJYWVa
	SyAuDKiPKYLuPNx9JZzsBvKhQ0BSaUz8981GJeIgjlESEzUNd2XnpRcUZ4l5g==
X-Google-Smtp-Source: AGHT+IEjApGdDvyQN/E8TN3vF3pTm/cOG5nUaE3DEGNAokZtFhx/tLygsjTvhfH7dfSx3FRZSPpvnb6vmOucIJRvpPM=
X-Received: by 2002:a05:7300:6b0b:b0:2a4:65b5:9868 with SMTP id
 5a478bee46e88-2a4abd7a07amr3517218eec.38.1763306626036; Sun, 16 Nov 2025
 07:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
 <b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com> <xmqqv7jcgy8y.fsf@gitster.g> <xmqqqzu0gxq2.fsf_-_@gitster.g>
In-Reply-To: <xmqqqzu0gxq2.fsf_-_@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Mon, 17 Nov 2025 00:23:34 +0900
X-Gm-Features: AWmQ_bm9Y6MFYMlhWoXYaPNWgroYBVrOBs884JUm3aJSwf-JGDh2n2c5R35BW9g
Message-ID: <CAOTNsDwS2er+31iFt4EnhW_ZupPG+Uree_qobBVj9v1q1+0vPA@mail.gmail.com>
Subject: Re: CI Failures (osx with p4)
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 5:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Speaking of CI failures, I think we are seeing unusually high rate
> of failures from random osx jobs failing to successfully run t98xx
> series.  Is p4 on macOSX still a thing?  As macOSX tests tend to
> take very long to complete compared to other jobs, I am tempted to
> suggest dropping p4 tests from there.
>
> Opinions?
>
> ----- >8 -----
> Subject: [PATCH] CI: drop Perforce tests from macOSX jobs
>
> It seems that we seem to be getting unusually higher rate of
> failures from random macOSX jobs failing to run t98xx series, even
> though we haven't changed Perforce interaction part of our codebase
> for quite some time, and the failures seem to be limited to macOSX
> jobs and no other platforms.
>
> Most importantly, nobody from the macOSX community seems to have
> raised an issue here, reporting any failures.
>
> Perhaps we should stop testing the combination of P4 and macOSX to
> save cycles, electricity, and my sanity ;-)
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/install-dependencies.sh | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git c/ci/install-dependencies.sh w/ci/install-dependencies.sh
> index 50628ee2dd..3f718dad41 100755
> --- c/ci/install-dependencies.sh
> +++ w/ci/install-dependencies.sh
> @@ -109,10 +109,6 @@ macos-*)
>         brew link --force gettext
>
>         mkdir -p "$CUSTOM_PATH"
> -       wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
> -       tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
> -       sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PAT=
H/p4d" 2>/dev/null || true
> -       rm helix-core-server.tgz
>
>         case "$jobname" in
>         osx-meson)
>

The cause might be that the macos-14 and later images are for arm64 [1],
but install-dependencies.sh still downloads the x86_64 Perforce
commands. This leads to Rosetta translation overhead. The arm64 Perforce
commands can be downloaded with the following modification. I confirmed
that this modified version runs without any error [2].

[1]: https://github.com/actions/runner-images?tab=3Dreadme-ov-file#availabl=
e-images
[2]: https://github.com/KojiNakamaru/git/actions/runs/19407172619

--
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 50628ee2dd..16ee593d30 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -7,7 +7,7 @@

 begin_group "Install dependencies"

-P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r23.2
+P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r24.2
 LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINUX_GI=
T_LFS_VERSION
 JGITWHENCE=3Dhttps://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.j=
git.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
 CARGO_MSRV_VERSION=3D0.18.4
@@ -109,7 +109,7 @@ macos-*)
  brew link --force gettext

  mkdir -p "$CUSTOM_PATH"
- wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
+ wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
  tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
  sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4"
"$CUSTOM_PATH/p4d" 2>/dev/null || true
  rm helix-core-server.tgz
