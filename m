Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5D2A1D7
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721516476; cv=none; b=dj1rNrv4FJSY9kReM2uUxk5gkKGXqf3YLh2JO22MlE9bKeSQkWT3RgyxIIdFXuoF4Q1D3UuUuTacgXPwV36VAjv1wCUOT+CLq8Vh1ZrkLIb/QVeNokERcbX68T3I0jT+hFP6FfQSHhGU6XwwjSZhwIwiKI9R/RtLzfYQHiWWuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721516476; c=relaxed/simple;
	bh=7T7ZYwR10uUkUgugInv6KyjVUeUrOjLgvZBzkisdcN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+wzD9jliZkmVYVsabmkvJYf5Qm20OnopJkyjh29Rt8x7bODp7dTGogJ/sV5skf9IoJ1vhfF+gexdw6Zo5Y8XnIWADEU/hucguJ3okS/nL4sseVuj6sad/Qqj30fY1B8TMh8qozbm50BbOkZ7e5OyTBuI9rPALKLbZewwQYJzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KGo4rPxr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KGo4rPxr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08DB0278F5;
	Sat, 20 Jul 2024 19:01:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7T7ZYwR10uUkUgugInv6KyjVUeUrOjLgvZBzki
	sdcN0=; b=KGo4rPxr36LTcuoV0xyRfoKThbmBJD2VL5QESSpctXpc1WZKKZHMRH
	oc01hIH5rdDY9/dDNNUZ5XQbTDtMz2QWwifSwPZlrd06l1xhBf2K8pepVmLSJ8me
	jLkXSi3gI50iQSHyBV/N5Ia+2Z/kmGCQADCYgrkF6asohsJy1hJhM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00AFA278F4;
	Sat, 20 Jul 2024 19:01:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A0A4278F3;
	Sat, 20 Jul 2024 19:01:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] asciidoctor: fix `synopsis` rendering
In-Reply-To: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 20 Jul 2024
	20:30:16 +0000")
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 16:01:12 -0700
Message-ID: <xmqqsew3hdmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6410B8A-46EB-11EF-8296-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since 76880f0510c (doc: git-clone: apply new documentation formatting
> guidelines, 2024-03-29), the synopsis of `git clone`'s manual page is
> rendered differently than before; Its parent commit did the same for
> `git init`.
>
> The result looks quite nice. When rendered with AsciiDoc, that is. When
> rendered using AsciiDoctor, the result is quite unpleasant to my eye,
> reading something like this:
>
> 	SYNOPSIS
>
> 	 git clone
> 	  [
> 	 --template=
> 	 <template-directory>]
> 		  [
> 	 -l
> 	 ] [
> 	 -s
> 	 ] [
> 	 --no-hardlinks
> 	 ] [
> 	 -q
> 	 ] [
> 	[... continuing like this ...]

Hmph, this may probably depend on the version of asciidoctor, but I
am getting quite different output.  It looks very similar to what is
shown at https://git-scm.com/docs/git-clone/2.45.0.

Even more puzzling, with or without this patch applied, I do not see
any difference in the rendered output of samples I used, which were
"clone", which has the changes from 76880f0510c and "add", which
hasn't been broken by the series.

 $ make -C Documentation USE_ASCIIDOCTOR=YesPlease git-{clone,add}.{html,1}
 $ man -l Documentation/git-clone.1
 $ lynx Documentation/git-clone.html
 $ man -l Documentation/git-add.1
 $ lynx Documentation/git-add.html

The rendered result is bad in the same way with or without this
patch applied, and "git clone" manual page is simply incorrect by
mangling a handful of command line options.  A recent bug report in
the thread that contains

    https://lore.kernel.org/git/xmqqle1xjm1s.fsf@gitster.g/

gives us more details.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3f2383a12c7..78e407e4bd1 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -202,6 +202,7 @@ ASCIIDOC_DOCBOOK = docbook5
>  ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
>  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
>  ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> +ASCIIDOC_EXTRA += -adocinfo=shared
>  ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
>  DBLATEX_COMMON =
>  XMLTO_EXTRA += --skip-validation
> diff --git a/Documentation/docinfo.html b/Documentation/docinfo.html
> new file mode 100644
> index 00000000000..fb3560eb92b
> --- /dev/null
> +++ b/Documentation/docinfo.html
> @@ -0,0 +1,5 @@
> +<style>
> +pre>code {
> +   display: inline;
> +}
> +</style>
>
> base-commit: 76880f0510c6be9f6385f2d43dcfcba4eca9ccbc
