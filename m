Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033774414
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613745; cv=none; b=uzb7Dk9LskpjqFdkJ6ozP+gvIKLftXUCQQwgh2PRrTjPTP49VGbG1UhTSEY6dJTu5mQRk6q/0V5Gj15Nvjc73/cljdCbQlV4xIyRyborAV6Pxnfpd9H66RfnNSk7UVfUfSGLiEV+sLzINCKrUo7RHO7+FRrnIlRiaC55Tw0i8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613745; c=relaxed/simple;
	bh=DrcsbKL8EBIuBM8Rf6eQtwMXwyM0hXC0uM49qSZpGi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6p5PFb9jDMVV32iiSeTrUwtDnos93rY1oHqQZFdCkZzUOCbKn2LnxxhwANvKi85NLdCZ5+GaOcKfmUbYHxrkWm2DeF9NxiiFLIqoBW/QHOy8TknM0R0JKRA5xc88HO/Mz7SC1VxOeSuLoXgaCgahb4yltp0HVXLGhHPzqPpk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XGw/fANy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HuwRpJFg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGw/fANy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HuwRpJFg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DC37211400A1;
	Mon,  3 Feb 2025 15:15:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 15:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738613741; x=1738700141; bh=5htc02YH70
	T3wuNI2SOsyJ7Dk6boan3YkEFQKk2YXiw=; b=XGw/fANymgns0SFjcgfMtzWTLX
	qi7tN8E+SEwEkZ5D1o6lbcEJxeJNkhCRjn0Kybxkum0p35kLkYNdKCzxTPCFPrez
	3+i2lDPUhFRP7P9koVB+RVd4n0WGrzlX2q5euXngUGOQANOzA3MAr8f82zSp6yI0
	BFccIBBO+BDzd7u/yBgvek3Ufz1eMPwSnMaH7q1Yq68jhkSL0MdSyNyAEWhitlIa
	8gXssBhi5HKEjS6OJoynYLIS6YCxYhgL9mTrngB2brKMH58QHlV5alFrtGH327p2
	R0BU0wgR7vKivdwvN7ElPq9eT0LZ54iZ7zgoM4MVe9vcZdxs920jMYAGbD5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738613741; x=1738700141; bh=5htc02YH70T3wuNI2SOsyJ7Dk6boan3YkEF
	QKk2YXiw=; b=HuwRpJFgYpMAtge2s3IXp1JgNWyhDzAny7UL1nF0Bmd1Skxzm2t
	6+i5l5Cp0YeEnElPlT3XnG5y2+B4PKyeloBuD55J0fBH261NEOo5jo77JvzOoPA7
	sNMqR8ViFmicIPxV1QyaNqz61u6J1F9BEpg7NoiWvOKqM+kMCNoyo2L6dcxB18Pw
	mvDC9NhU5jqnKisBpoWdD1TGXsUHv9MOvtmr+tGF9F/zjrHf50RJyr9LqfEdRqvG
	TTomDXD6z1DhxQEX4fn52XjWLmtBZWAXJ6ssTDvpQYg3eM2XodM1gFovgMmfYtKo
	OuPBJp67i3R7ND0Ueax7QQC2cYpnrlmXx2g==
X-ME-Sender: <xms:7SOhZ-Lz7uwipJspOkbxfYWSTLGpa4EYzrUEu4Fql6-UJDalW3_Otw>
    <xme:7SOhZ2L_KKkRpVaGYIbv0TazuMH8xfEVyNGWPoiEEtOBe6lftIYcpYrcppgNwO_23
    1RHwbc_MmccZNCT5g>
X-ME-Received: <xmr:7SOhZ-sgnz0hq3J4n7TrBFnY99UIcuvv1YRVJFzdcmo4ooHO_MeTudxwA5CdFfgrF3VqvlFxbmXXvB7_CT95kl7n_d4-tCVgWd4H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7SOhZzaS25tmQIOzwHLjqXGixzoNUuD0axlEjw4exlEoxR1fdQO5ZA>
    <xmx:7SOhZ1aJ5Xu47vg1SO66MDGjB9kM3HWmR6A-n0dzbG8GQmiR034tUw>
    <xmx:7SOhZ_BZTaqfFwC16t3TZFDLgCLzXFkNgGbZJIRGpKiOFMMxDldVMg>
    <xmx:7SOhZ7Z8mn0aqoTvFvcwDZiJS277fI3Pgq9MB0eusyAiCSoGF4tbig>
    <xmx:7SOhZ6MVafRI1oAyVuNSLAXXlLMpOB8nXZa0anXyExxYFk06YhZxadD2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 15:15:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
In-Reply-To: <Z53triurDqskbRaA@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 1 Feb 2025 17:47:26 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r6-52eBgT4TUYG@ArchLinux>
	<xmqqplk4duuk.fsf@gitster.g> <Z5zWE1M4u3NrROI-@ArchLinux>
	<xmqqikpv9cq3.fsf@gitster.g> <Z53triurDqskbRaA@ArchLinux>
Date: Mon, 03 Feb 2025 12:15:39 -0800
Message-ID: <xmqqseou239w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Fri, Jan 31, 2025 at 08:20:36AM -0800, Junio C Hamano wrote:
>> shejialuo <shejialuo@gmail.com> writes:
>> 
>> >
>> > As I have said in the previous comment, we cannot detect the error if
>> > "HEAD" itself is corrupted. However, we will check the referent in the
>> > later. So, we don't need to do this.
>> 
>> I still think you absolutely need to diagnose and tell the user
>> about the broken HEAD.  With your "don't check HEAD because a
>> repository with a broken HEAD is not a repository", a check run in
>> such a place may find everything else in the repository perfectly
>> fine, but because the user wanted "git refs verify" to tell them
>> about breakages, you would want to somehow tell them about it.
>> Either it is missing, malformed, whatever.
>
> Yes, that's absolutely correct. However, I don't want to do this in
> this series. Actually, there is no check for root ref. I will add checks
> for root refs later.

Another thing I just thought of is that what is your plans for
repository discovery when HEAD is iffy.  In the working tree of our
project, you go to a subdirectory, say "t/", and then corrupt the
HEAD, would "git refs verify" still recognise that ../.git/ is the
"repository" the user is interested in, but it has a broken HEAD?

setup.c:is_git_directory() would say "no", so I am not sure the
discovery would work without changing that, and I am not sure if it
is worth doing (i.e. when the user knows the repository's HEAD is
broken, it is OK to disable discovery and force them to say
GIT_DIR=/this/directory).

