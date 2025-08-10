Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7F635
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754784195; cv=none; b=mdu04nFlXPUraSv+cjeZpOsiRuKfZgscMXd9rHoAPmAxUXPvcpXGzO/A8Uvy0worXiCrg4Cz+C/yge6zH9Po/zZHEpulcbZK8k2FHAATciLxVLP6MBZ7EtlaJxrBIV2N8A1Fvtt/5vqjXZ5hN0B8dU7/D4k9osw7ImPcRvB4nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754784195; c=relaxed/simple;
	bh=zZHctESx3GznaA9aKEiQMVtwD9pz6CzqCZoAVaIwTDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QQRQ3zkVJO7BSm+F1DWc9eeoMYUCi+CrJwMSyNx7/qJyInS2IUzIbPtgHlitUUGd6jlht6r6z4p0Y96yZka2jGYTFYnEnjuSr8UVgk4hJOmjop62xU/3QJP60nBR28EWbqJqJ4N5WwoAiV8ZsU2+iCtJFk6Q86DpA0a4PvHTUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QItraZ3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xlmhod65; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QItraZ3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xlmhod65"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8035AEC00CC;
	Sat,  9 Aug 2025 20:03:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 09 Aug 2025 20:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754784192; x=1754870592; bh=iLuU/4LSJk
	DB2Iete0sdoPBF6sH+Ld0/tVPdfe/bNlE=; b=QItraZ3nkd26fnRbAHuG4u5mLO
	F8CezL7T7bV9mJcub4UVpybVDekjI2jp+tO/wOJ5WgRmnVYFarlLzP1Lv6q7NCPI
	wQ1y6FeMlBm5y/YcBFmYwLmVRgQ55dDXTxPEo+nhYmZ6sLNJjKo5Zac/3uiFzJ4/
	vyS21sKLlC0oJwoA84Yqv/aphHW3LYzcWFC0SNZ+Hgzuk3DxjEtJKDzxZFZ00qP+
	qx3W5iCWOb++SzL3Lfn1YDp4LmIjRV+azVoauOYcQYtPPzFWUoD/EEu1+I7NxprR
	Yg3rmeAl5de0XbIzTDWZh3XV1x4KS6FvsLGLsBm2bRpr9fwMXkAHfpFSqkIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754784192; x=1754870592; bh=iLuU/4LSJkDB2Iete0sdoPBF6sH+Ld0/tVP
	dfe/bNlE=; b=Xlmhod65IFqPukwj8yBvShD5xFEFYomZEq+NaWrsoOnhOVfIXuT
	MAYFKxY/oMKV3vS9KRU6snxaxc91TXl8PMyEN2bX1rW8FfuA9nOwpHZ2xOFQEORr
	bpRCXjM8xxfA6UyYVqW5ou+xTsEwNYplHAvVMiCsvO1yi+9mbqF0fgtSDVS/rMhM
	KjYEXC7rNsjaQO4JIVJR4Ta/pjdWNK2cFjypwkTQ5hxdUIUr0myJlBc6fmtJUVae
	WX93hTRHLT3GUEQNo6C8TQEaItDsLZnqd+dfDIRZbTx0xKDdvHOsF7WskhwINGY8
	Bbuz9p5cLFS6jfxSr1ZsobUV/o4YE7qOU5g==
X-ME-Sender: <xms:wOGXaAAeQoT6pnZ-5rbpRfDdT2qnPfR3nwgYvg3CSO4NrqLsThLRGQ>
    <xme:wOGXaOBYLQKp5tkMTRhJ4mr1sUOueq1GZgMC1d-8uGzC4RD8dWA5zkpz0e3Uvl8UI
    hjEtvKXy0lIurqtXw>
X-ME-Received: <xmr:wOGXaKBBSV_rQpZJs_rDxyvYF33XfxyNB4XM0UZnA-FCHirRTbSoh4YALGUGHME6ru_2hW_0aIF6C3KM5_MA1yZ8mMXSFKoA-q02h1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgrhgvghdrhhhurhhrvghllhesuggrthgrughoghhhqhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wOGXaBpuvNcLdvf6jCSLoNvaA1ju1QKa34elTqVg75JVPf5WBIS6og>
    <xmx:wOGXaMmWGjadJo3ie6wBJyTxoEIWLwKQUtLO_9ZUyl3YdW9zFSFB4A>
    <xmx:wOGXaJwRUJKPwVZ4jEJAZcSgHLSdN27hnAYR-Bhveuav0h3sqUouyQ>
    <xmx:wOGXaM_oKrcmfhjdR5xVBw-rGNMTeG3f0_7-ohUJ5KL-RJ9tcleyzw>
    <xmx:wOGXaDzwlmDLy-SbF1Z81oPL_uJ-sXAKZ_hbSIOx-N1uXH3k4Rz7ltWE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Aug 2025 20:03:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Greg Hurrell <greg.hurrell@datadoghq.com>, "Greg
 Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-jump: make `diff` work with filenames containing
 spaces
In-Reply-To: <pull.1950.git.1754674979929.gitgitgadget@gmail.com> (Greg
	Hurrell via GitGitGadget's message of "Fri, 08 Aug 2025 17:42:59
	+0000")
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 17:03:10 -0700
Message-ID: <xmqqjz3c59hd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Greg Hurrell <greg.hurrell@datadoghq.com>
>
> In diff.c, we output a trailing "\t" at the end of any filename that
> contains a space:
>
>     case DIFF_SYMBOL_FILEPAIR_PLUS:
>             meta = diff_get_color_opt(o, DIFF_METAINFO);
>             reset = diff_get_color_opt(o, DIFF_RESET);
>             fprintf(o->file, "%s%s+++ %s%s%s\n", diff_line_prefix(o), meta,
>                     line, reset,
>                     strchr(line, ' ') ? "\t" : "");
>             break;
>
> That is, for a file "foo.txt" we'll emit:
>
>     +++ a/foo.txt
>
> but for "foo bar.txt" we'll emit:
>
>     +++ a/foo bar.txt\t
>
> This in turn leads us to produce a quickfix format like this:
>
>     foo bar.txt\t:1:1:contents
>
> Because no "foo bar.txt\t" file actually exists on disk, opening it in
> Vim will just land the user in an empty buffer.
>
> This commit takes the simple approach of unconditionally stripping any
> trailing tab. Consider the following three examples:
>
> 1. For file "foo bar", Git will emit "foo bar\t".
> 2. For file "foo\t", Git will emit "foo\t".
> 3. For file "foo bar\t", Git will emit "foo bar\t\t".
>
> Before this commit, `git-jump` correctly handled only case "2".
>
> After this commit, `git-jump` correctly handles cases "1" and "3". In
> reality, "1" is the only case people are going to run into with any
> regularity, and the other two are extreme edge cases.
>
> The argument here is that stripping the "\t" unconditionally gives us a
> minimal change, and it addresses the common case without bringing in
> complexity for the uncommon ones. If anybody ever complains about case
> "2" no longer working for them, we can do the more complicated thing and
> only strip the "\t" if the filename contains a space.
>
> Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
> ---

Because (1) I do not use 'git jump', (2) I do not use 'vim' or
'quickfix format', and (3) I know this is your brainchid but you are
offline this week, I won't do anything to this topic other than
possibly to keep it in 'seen' to avoid losing it.

FWIW, I do not disagree with the decision of this patch makes to
"break" those who has file "foo\t" to help those with file "foo",
even though I usually frown upon a change that robs Peter to pay
Paul.  Among the three cases considerd, #1 is the only one that
would matter in practice.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1950%2Fwincent%2Fstrip-trailing-tab-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1950/wincent/strip-trailing-tab-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1950
>
>  contrib/git-jump/git-jump | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 3f696759617..8d1d5d79a69 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -44,7 +44,7 @@ open_editor() {
>  mode_diff() {
>  	git diff --no-prefix --relative "$@" |
>  	perl -ne '
> -	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
> +	if (m{^\+\+\+ (.*?)\t?$}) { $file = $1 eq "/dev/null" ? undef : $1; next }
>  	defined($file) or next;
>  	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
>  	defined($line) or next;
>
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
