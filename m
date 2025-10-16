Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C43254B7
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626535; cv=none; b=ZyKY0AA84pR7hwrOf6SdqtHgyKUFuuJIga9j/amcJrN+IQ4sDjvJTJPvnAviO/xHQGn6ebPli9wNTDlwxMAPu9nwmmKrvRBo85EbdsLAWwv3O5iYqpILeiaB770vQ5TsHw/mrLvVFI5FLx7rWuTnU9NpX1MLNuERZSKagPjyk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626535; c=relaxed/simple;
	bh=rk0Cvrh75FeznIuiTucf6Pv9ijrUeG52K5LJEIZ4M8M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dV9ouIKF832Gh2pEl/uVCdmqVnJ80CScRaISCAVA/KZ4vQ2XNTSy3kZQgWMlq+DdjnBv7U6ZXYCj54lvxjt1Z/2GokkKPkCcBBMI6YZEAhG6E48VdBpIi1r9+ls1mqzLX8Khgm1NF00AoTg9mt1h5CVWZVLY3f7S5VXnnNB7HUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VK1LwgR3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VK1LwgR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760626510; x=1761231310;
	i=johannes.schindelin@gmx.de;
	bh=JdjESpIGIwMWU7+RnKiYDge9oOuLgVyQkwAlT56GDiU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VK1LwgR3FZtC0WahEW7rPIp2G00qCAEQS/aHKzjQG7/AybfLRVzh37PhDhzkIu6U
	 gq/dKu/zUcKUUMQnIJl6JGaEHLuHsrZSuetLxPbT5tIlANNU46fQYHH9mOBcvlwJc
	 f1IZ6KCdaO2Ajg5gbHBGeNc3vK7Ny3NJRVvE1fUdrStFgKih7WihppO8w7Ilrzm1j
	 ZZhL9CSQfba398avPJOi6+KPDXVtzuFyswsGsAkjFVJJaw8FojEqXMknl70ldHTEs
	 mqxTzQaQp9nExA0f9rccu3T1A7JO76QsBOOaPH76G922YMROh3J4HRWCgAsmF/JEu
	 yk48/smaCamqxFqZvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.131]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1uipxM3wR7-00VsHu; Thu, 16
 Oct 2025 16:55:10 +0200
Date: Thu, 16 Oct 2025 16:55:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lidong Yan <yldhome2d2@gmail.com>
cc: git@vger.kernel.org, gitster@pobox.com, hi@arnes.space, michal@isc.org, 
    peff@peff.net, =?UTF-8?B?5p2O5Y2a5paH?= <charlieio@icloud.com>
Subject: Re: [PATCH v5] diff: ensure consistent diff behavior with ignore
 options
In-Reply-To: <20250808033019.78817-1-yldhome2d2@gmail.com>
Message-ID: <527ba5fb-5fc1-b34c-9c93-61cd919da78f@gmx.de>
References: <AC10362A-5B05-47D0-98CF-DE6AD468F01D@gmail.com> <20250808033019.78817-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-657185293-1760626510=:23249"
X-Provags-ID: V03:K1:qJuhOHhDTk6E2TSOhZiVkmyh2zE0QQq1DGUpH+iCc5EXo6uLpIM
 8fIe6bNka5ZHQ2/lqftuprVxk6KP0RfJreIuujGT0/7CL8m4PZShurzbzgFsBvFFDhMC3je
 vWkSlDtgWJJUNoTczxaSlJxLz9cR4x7uSQyh0ftwLtqu9+u+E4S9Zc8O5PmAe7JcY3Tfc/c
 bMvg4eWQi5ZIal1ZGfsZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qaC65JtUiv4=;1Y91ZhUUDdoXAJVQOMtM8lLHlfi
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-657185293-1760626510=:23249
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 8 Aug 2025, Lidong Yan wrote:

> @@ -6778,8 +6816,15 @@ void diff_flush(struct diff_options *options)
>  			     DIFF_FORMAT_CHECKDIFF)) {
>  		for (i =3D 0; i < q->nr; i++) {
>  			struct diff_filepair *p =3D q->queue[i];
> -			if (check_pair_status(p))
> -				flush_one_pair(p, options);
> +
> +			if (!check_pair_status(p))
> +				continue;
> +
> +			if (options->flags.diff_from_contents &&
> +			    !diff_flush_patch_quietly(p, options))
> +				continue;
> +
> +			flush_one_pair(p, options);
>  		}
>  		separator++;
>  	}

I'll play =E1=BC=99=CF=81=CE=BC=E1=BF=86=CF=82 here and relay the bug repo=
rt from
https://github.com/git/git/commit/77f8e1002be5c736e064ed0e656ba51c82d85b5d=
#r168025843:

fcharlie wrote:

	This code will cause git diff --patch --raw to produce garbled output
	under certain conditions (e.g., using --ignore-space-change and whitespac=
e
	changes). flush_one_pair will output --raw format, but because
	diff_flush_patch_quietly has already output a patch, garbled output will
	be produced (actually, no diff_flush_patch_quietly should be called here)=
.

	[...]

A few exchanges later, brandb97 (AKA Lidong Yan) suggested this patch:

	diff --git a/diff.c b/diff.c
	index 87fa16b730..4baf9b535e 100644
	--- a/diff.c
	+++ b/diff.c
	@@ -1351,6 +1351,9 @@ static void emit_diff_symbol_from_struct(struct dif=
f_options *o,
		int len =3D eds->len;
		unsigned flags =3D eds->flags;
	=20
	+       if (o->dry_run)
	+               return;
	+
		switch (s) {
		case DIFF_SYMBOL_NO_LF_EOF:
			context =3D diff_get_color_opt(o, DIFF_CONTEXT);
	@@ -4420,7 +4423,7 @@ static void run_external_diff(const struct external=
_diff *pgm,
	 {
		struct child_process cmd =3D CHILD_PROCESS_INIT;
		struct diff_queue_struct *q =3D &diff_queued_diff;
	-       int quiet =3D !(o->output_format & DIFF_FORMAT_PATCH);
	+       int quiet =3D !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_r=
un;
		int rc;
	=20
		/*

fcharlie then responded by promising to test that patch tomorrow.

I will hold off from releasing Git for Windows v2.51.1 to await the result
of this test.

Ciao,
Johannes

--8323328-657185293-1760626510=:23249--
