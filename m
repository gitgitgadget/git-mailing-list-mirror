Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1F36F411
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764516; cv=none; b=HeBt92T+XbRm3/SNapciyTvviKaCDfQlNYlumvXafVwqdkNYposRBOJ9jgSyyqAZ1LishocPa/4KbdPLp0Qn2K60nXt7l4mhczhkiGiAa4HbZdS7NUL+p312NeZGZdrwphtH8TW0fZDYw75ATgAMmyKRw4/5SBPc5Kn4wxAOwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764516; c=relaxed/simple;
	bh=3RIxY5rDFuE4zQ8ek56JBgqU9YMUjtYyBHQh+KT3+vE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TsC/b7adHN0/4bZR9FNtNJUr2FDT2NSqZkrzCzOs8V3DLr5NZkznmloqrayaYgpUuQYvw9pZiNaVshgRaEwmzsQxTOACuhjvLFnpEMnfGRP1GF1uiVDeUkdmn3+VcDzIMj8fOGQ0tK/XALJlo59EapQkAcx2kF7+3O+KNlBquLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gfQxvVAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZy6FTNE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gfQxvVAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZy6FTNE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AB6351D0004C;
	Mon,  3 Aug 2026 09:41:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 09:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785764513;
	 x=1785850913; bh=A/Q886mQ4DdjooRjwBeZpTkeujDuv/0ZlNHyXtBo8+Y=; b=
	gfQxvVAgMm9501uDVnFjBrBY7PuqnsfD5ycmq8JJ+FIghGdIuaBygVrijAGQ0jrP
	nQ8AueuWMggYREuApxccrmeWFzrm2Xy0t0FmJVeAKqsjjJqOk2yLzDLRZ7yqf/ZG
	mqSpusJTy2CNWhkDQUOKycd8yKbxo2ZzlO9oEPSNI3yzNenQ20tiD1kO/IwpYdhi
	8Gza4Op8hlJ2BXIBQ7T0WbfZvYVTITFKD8lrIrWbyISwjBm1HkCEmLR+CrDJvWjh
	cqjAuqvuvg/honf2Ze+QxaJ+ukSSDAEsUhWbo4PpRP6NWpWN4TprasUGfemDVKSF
	/5uC6htuW24np3BjCepdiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785764513; x=
	1785850913; bh=A/Q886mQ4DdjooRjwBeZpTkeujDuv/0ZlNHyXtBo8+Y=; b=a
	Zy6FTNEfFEdq6ApwJuLestAgy5vqeWsoazdDW6u9PGqMRFxvmsLuaCmhmmEO02nt
	xRlQaOM066ve815hLUgfu+g0PuevjOtNmgcGIkJx0bRVbM+UFRz0QzyrCKWIzZxd
	+lH/wPlcKHHqTDE3/ausxEzm7AlBC1EJwYVu/XlxLAqDUw2sa/uzo9SS/IMfSwwY
	Oy1B09M7eLkmppGEOqkoXYrMxi3WBv0U9AGYlifh/acbgwIlkrQB2B+xTBe7zjrR
	KQrKk7zWL3jeR66tyFAdSfMER+083k35n65QNZ2/zbstgpZEZlmAglrGkfCf1zjZ
	9ogDsci8dkYv9GUazKdLw==
X-ME-Sender: <xms:oZpwattuk1k0hi_M4-ImMJua8Vc7SS2rm0S_9vFLP_W8zBBgQTESOA>
    <xme:oZpwaljwq0Pcz0jmELYsFNla_qp5PtEA6phDCfkA20dgmjompGe0VnG8WO8JwA1Bq
    arjk4qnVxulXTJgbSCkP0T7MseMJbGoufv8ZGhHi5kOwwKMGqv0>
X-ME-Received: <xmr:oZpwam8j0b4e1ZBMvGDTUiUr7bmod6n-pQvB8oKtdaszQjR_JdFE5JNARZqnbbJwawK6Vyv_FdtUqL0geKx-wcQTKjsMpWRcMA>
X-ME-Proxy-Cause: dmFkZTGFn0QCDRNG/vud9myZOo/fDw7QSq3q36db2OBaAcrVtVe+w37ZrzvP1mt2T2NVA8
    tBzWSoeUqkvWf5AOq2Xb8HiD2PhsYQnbcF/eNZA+kY7UlCkX7Q2zWp6vH6pgeeFlyfS2tH
    a0ctqHlkJU2+zo9pYK/WkjH7uQtPDvOdPVpc/k1TWKgsDJuQpGs+5BcRMr/CmMjKN8ksOA
    4wRwYyDw5lmMnjpfOCAXJjseKI+Xx5apczpbmPb7bwS31Xh/c0oxhue1i/WPj+uMGQvK6Q
    ougm6uWkETfBWH/GkjCf4SwqgJm8MsPuIdml9UqOoMvFUzZzA5FRSzvkJFhYZTxPHtkArN
    5tImsM8s/gseur7Crh44BAcmcTbqDfohd5J9jeIKP00T4fYMD+8Y6uCx+JA0XiDTgFRW1b
    fhitrt5TFYRS4Ay0nFW7QCseHVsO0Zf20tRVTiGXf8exSlGTYIjOLCA+qVXjHlbdwNUu20
    7aj0MUEA6GHCxDlbTR3IiE7Bod607FkrLMS6eQTKU5yfnK4O1ysowVm49iBozjm5fzxwQe
    dMsBR+SLg1isIKh4B1S+MlIlNsnWY/33mr53C8FZGN5cO60mfKboozf2thL0GL1vD4VS+c
    Jnv+54lbHEqTb7hCT59EPldj6vsNMw3gU/vthX3Hwl9JwqqbqGIDGFalrrdA
X-ME-Proxy: <xmx:oZpwagvuHoYZCTIaQshCsVWiZ07rdXg6WW1LnLtSGGoIveSfJukbGg>
    <xmx:oZpwairLawkXhyK7dlBsDFJSZYNJBAKUuFfOJmmaYFpi5YHrZNIJ1Q>
    <xmx:oZpwaso63XLAPGBk3NTs39APf417nVSKiVlnVlT0_5LTS3J4Y8q2QQ>
    <xmx:oZpwapbU_otXdOoMMzdgbOXMXKyFoyCRAqbrm-ShD5sURheCjuK2NA>
    <xmx:oZpwapMSgG5cgjTLviVsk6p_aaHxwTDOKf2teW2uLga4UM50o7eyJUOa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 09:41:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Britton Leo Kerin <britton.kerin@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] completion: complete tracked paths for 'git diff'
In-Reply-To: <anAqfqcEueSKmAH+@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Mon,
	3 Aug 2026 07:44:25 +0200")
References: <xmqqcxw010me.fsf@gitster.g> <anAqfqcEueSKmAH+@szeder.dev>
Date: Mon, 03 Aug 2026 06:41:51 -0700
Message-ID: <xmqq33wv1fts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> I think we should check whether the '--no-index' option is present on
> the command line, and simply not call __git_complete_index_file() if
> it is, to let Bash list all paths; i.e. each of those calls should be
> protected by an additional 'if test -z "$(__git_find_on_cmdline
> "--no-index")' condition, perhaps.


Ah, I did not think of the "we made 'git diff' work without Git"
mode at all.

But I would avoid scanning the command line for '--no-index' for two
reasons:

 (1) "git diff -S --no-index maint master" would not give you the
     '--no-index' mode.

 (2) When run outside the working tree of a repository, you do not
     have to say '--no-index'.

These make detecting the "'git diff' but not Git" mode tedious and
error-prone.

I have not tried this, but if we arranged the code to fall back
further to Bash-native "paths in $PWD" after the completion code in
the posted patch found nothing, would it be sufficient?

When trying to complete an untracked file in the working tree of a
repository, if the file shares the same prefix with a tracked file,
you cannot complete the untracked file without a prefix long enough
to disambiguate it from the tracked one.  Such a prefix may not even
exist (e.g., 'foo' is tracked and 'foo~' is untracked; when you type
"git diff --no-index foo<TAB>", you get 'foo' but not 'foo~', so you
end up typing 'foo~' in full).  In that sense, it is a regression,
but supporting Git usage is the primary mission of 'git diff', so
the trade-off may not be so bad.

Thoughts?
