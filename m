Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE31F239B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410819; cv=none; b=Hor2azCFI2YTSJ7WOOCC4YeTbDFiArw7MZqiFKZ/cNI21mmOsO+aKDQctRw/xvi0Qfl4mMnkHxf86XStCeEIfHCeQZgGL7NxuAXCokA0DoSDUYRqPeq04T1Dlobzs1aNkqxtFGr/5W62y47dA3MyKGQOSGh/XznLvoQMz3qdqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410819; c=relaxed/simple;
	bh=vC/0ZlRd71VSBHEHQ+/pogL6B9ioUY7R3gEJhFvZFmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fA/w5B3T+HwzLig2urMBsbCQfAJz5ZOa89C8Tqz7WqaMVYgpWWHRaJ5onEKyiyIraZT5dtADhlDXgxPbN7NZ+rfwcKukuawOXMGUlO4bW62Ywzq6457xBsF1SgVJ4u6NX7yaynymFERXUHAA9lnJvjmEJ/fyWI8tosxFdXEuka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+6alKwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mw3rgkht; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+6alKwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mw3rgkht"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FC461D0010A;
	Mon, 13 Oct 2025 23:00:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 23:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760410815; x=1760497215; bh=SkdjuPQlhu
	fIraa2jGzhyaq391L/9P5kAexPeN+LvBc=; b=E+6alKwGk04f2QAucfSsXyXqWZ
	E7xTVlBI+VKMZUv7ttOJA1n+U2+9xnVvorWn6luEU2k6aDJmZBg8i5vb3wJhBljg
	hRAziF1XStMDHGFFvxDS35Gk0lKpoBfXnMWWlPKBuvaL6TN0JKkvd1jDzwIJtQxz
	W6BEHjRtMtp4ogcyWyS0knq48KFllPyjUD0/RQpO6xttoFNXb/g2CRtVuwDNfcqT
	7UBmzzbJx2DH7YEiSMX/T2bAGH75o73OyAobC7A/IvDzHlnxhvFBoIwtfKKTF8zB
	HZmijdOd+3jCGkc/BQSPh/aHcnDi4U/mgT3EJl+90Yoy75zKy8w3HTqU62DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760410815; x=1760497215; bh=SkdjuPQlhufIraa2jGzhyaq391L/9P5kAex
	PeN+LvBc=; b=mw3rgkhtDo1xkvxRP22Seu/kLhx98S/1mLtBgDtOf9yhFI6rxks
	Xv4n2sWaUoR+J2WrVijonCXp5RUa1WLk437i4a49g7CMMSL8W7pOPqgRa8DzuEwU
	wSkhZA5LmGFQFW6kqKf9PPaWhChXL8CLNi2GoK5BAkcU+cwInteRu7hmtGAeL4NK
	fvhpokjVfXD02Jk9zGjbgjLiF+juJrGAcjAxozaKVQ0lxTco+rTEGIri9JKUmjIC
	J1EQruS+4gQKDonHGQVu8UkoTHbYoGJ0WDooAeY+QBbXR+dAshtmqSBCFKx4ZtHE
	eAgEOtEIXI03+GLYkxbxGYiBtija00IAFxg==
X-ME-Sender: <xms:v7ztaCV8j9GE8gfBPoOjuKKzRSrix9g3dksmWpidM1zqEohw91mk9g>
    <xme:v7ztaGARj10vtvBgAlZ2JSCxTQz2GG8qGPQlZKRBfHeGZ0dlIaXQWTNcx7jdBz7Sh
    ucKoOF1JN9kr7ytHXvY2jIb9YeveSVWN1Qzxi04sqrYKB5gyjCn8Q>
X-ME-Received: <xmr:v7ztaDyuhNgoFfegoj_q_7m2AnXyyBUlnH4z8W5uWHs9IJsSUSR4TCJMdFcOmbJE1-Z9t7a_yftrjGhNlXAWn6-sejDuCMAAMhYG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhkhhhuohhmohhnrghjrgihihehgeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v7ztaDCbIvVRjl2Xfvvt_aSPPm1LyqyFBWKf68tX89CUK9C0X2JHmg>
    <xmx:v7ztaAavypHxH52oyuu_5TuySXjZJIeVNbmwpZxaUlk_huGhMM1-Fw>
    <xmx:v7ztaLhqpcSjwLsk0zYF0usircBTH0WS3YynoBKuAWCzk3zJAmgTpA>
    <xmx:v7ztaC7Kwrd8Vxniw5xPgw3xwNnN-2CiDzWxrafZi-WejoHFTrIbkA>
    <xmx:v7ztaKAzXGUGImw38yeqgZGR34RxzgvKQT0T7EZdjYYfO-qmXN9Fkpq2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 23:00:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
In-Reply-To: <20251013174658.236940-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Mon, 13 Oct 2025 18:46:58 +0100")
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
Date: Mon, 13 Oct 2025 20:00:13 -0700
Message-ID: <xmqqecr6yypu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> Patch IDs in Git must always use SHA1, regardless of the repository's
> object hash. Previously, the code relied on `the_hash_algo` which could
> vary depending on the repository, and included a NEEDSWORK comment
> suggesting this should be fixed.

I do not think that is what the comment suggests to do.

Read it again:

    ... should be removed in favor of converting the code that
    computes patch IDs to always use SHA1.

There are code paths that compute patch IDs elsewhere, and they are
not immediately below the NEEDSWORK comment.  The code relies on
the_hash_algo and that is why the "hack" makes repo_set_hash_algo()
call.  The suggestion is to convert that code that hashes patch to
compute patch IDs not to use the_hash_algo that is repository
dependeant.  I think get_one_pathcid() function in the same file is
one of them.

> This patch updates the comment to clearly state that SHA1 is required
> for patch IDs and sets the hash algorithm to SHA1 if it is not already
> set. This ensures consistent computation of patch IDs in accordance
> with git-patch-id(1).

And if it is already set?  I think what your first paragraph claims
to be problematic is that case, and the patch does not touch that
case at all.

Blindly setting the_hash_algo to SHA-1 may not be the end of the
"solution", so whoever wants to work on this needs to be extra
careful.  If the code after this point, starting from the call to
generate_id_list() we see in the post context, need to touch any Git
objects in the current repository (e.g., to obtain patch text or
some configuration data), such accesses need to use the hash that
the repository uses.  Only the final "now we have this patch, and we
learned what the configuration says how we should compute the
patch-id.  Let's hash the patch text following the specified
algorithm" step should use SHA-1 as the hash algorithm.

Perhaps we are lucky that this program has *no* need to access
objects in the repository (my quick scan says this seems to work on
an external text file and does not generate diffs locally out of
objects), and it may not depend on configuration data coming from
any objects in the repository (there are some configuration variables
whose values are blob object names that instructs Git to read such
an object).  In such a case, then the solution may be to always
make the code ignore the_hash_algo and unconditionally using SHA1.
