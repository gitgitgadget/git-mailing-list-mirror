Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E112765D7
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771209449; cv=none; b=RvMSJXGKoQC2A9pY4F7SlYoT2rdpLMiGwGr5nbJnQDWQtNYbv0sxCmKSTJjePxy25VSs83KF2lUVt+Lm6acZydEwe4fOjzCAjTyE4Du23TwF1ZCOqim6kPJo6IjAaR1iJawvBtFiSuqzHYbETYMR415YKZ+fvcEWu+SaZs7wghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771209449; c=relaxed/simple;
	bh=qtcQ07yDNHRHn3ktKMlzt7sgnE2w0wwNOwEjaJWY2qg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fesFMEvdtdTtVxvZeXlqfZceRRKuqBXLD+E9JeZZ52jyP+j/s2u/Cml+j4fRGGivfNtmrduRLhre+MMLneWLjJG+ZzOzXY1OVyo4NmHJM0VWCBZlvL/9RZykgBANLd44i7r1CV2BE74g7CehFSw0ZGfPIn8WkrhgA8/TUHi0pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AmbSxhsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocJwDJqG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AmbSxhsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocJwDJqG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7446B1D00378;
	Sun, 15 Feb 2026 21:37:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 15 Feb 2026 21:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771209446; x=1771295846; bh=N574ZGhz66
	33nL4dYHVCGtMctHDjTBJEvPw2KaAx9o0=; b=AmbSxhszYpKec1x7uMi++ehWxL
	Kd3bYkKOyK2es5zjwuz1rWDavXqhVsTNUF4vwO0T04XMwG5zdgp3MYh3+/Pxn4y9
	XCNq+K8pYK7QV9R+SqMQy4nfY6aOyieHYf7p7fM4bqVjSPACAAZBWoOyUjtb4pEn
	urY4RDGMSActQhok9HKlIKuL+PXCvR4v3T39R9kjgUoJVv8qKZqjlfpJyCSLhNyE
	UY4hzIdbc48ASthKiklCm0oHqWVuFnOFUXRS2gV5Z84wcRbHRMKRLuQ53zxrgRWb
	A7pamHbjQuz+EjC7Bekgp66wwg1XIAFHdFoDo0CEJL8ztkTY2c4u/hRhja2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771209446; x=1771295846; bh=N574ZGhz6633nL4dYHVCGtMctHDjTBJEvPw
	2KaAx9o0=; b=ocJwDJqGiRmkPjCyT7Z1s/yxnF2AZlmTATiH6tuHgphkYLYOstZ
	5VN2k4pYHxyLP0xkOxZtVpQwA98oYtK7oxMNcTVnP0iZQN4DuWs9tVvr/lC3wPtr
	g9ZBJ3xcFyBhk7eipswd+x7qRddGPwhd9OBGVzx0Lwnp8IZ12gV7Do0awnsiYMS9
	XLl0FO0IC6IRyg9YCmSEeUI3rAvZRQavz6d6UeqlfvCBugPeXnP9C6cG/a9zNAAP
	a37E7wZmATrMe8oEZDAk8OAM0CnFiHdGLB+Lc3iPtsDpOVoNujPYeI1aMiQgoR/x
	ktjCAu2hc0TCNFxuQch0cIBuIL3Pkg4+lLg==
X-ME-Sender: <xms:5oKSaf0_1NuYQdfjdDTLzVv6DUBi2Pp0yApoo3w1oJk4vmmEzQto1A>
    <xme:5oKSaVFNRxFqJbSIivOT7w1UMwxzjkWGdRMGTBVQYzrQbwkZ7FkYrWA4i-Y0L2IB2
    i1-VjkDiEFxX8Y7biWMnr7DTdMzjooWsMk5VEkRkxYCMyniJ-NmUOw>
X-ME-Received: <xmr:5oKSaU6_aF1zg93sFr0VTX3fx0mR6JJ3a7DGE1BWI-Fu8Uata_MmLRDs3ao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufhfffgjkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetveethefgvefhtdfhudfhteegfe
    ejkefhleelteeuveeutddttdfhvdeijeetleenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5oKSaTuWgbrLYPqj7K2zRdvyuf-zsH9mjeMf-79RMFmVny_T_e72rQ>
    <xmx:5oKSad4uyytYpMkbvQbjUkWd60GPzcj85I3Pdna3G4_A_b8ryB6qCQ>
    <xmx:5oKSaWW23DgKmuVHlsR0n0aAjDhv3J64v2VyB0e0KW44VqiQ-u3Zwg>
    <xmx:5oKSaX9638TPZ7D22G88a06FaGIL0lzmtz03RSeW2Pk-g_fZq0ZfLg>
    <xmx:5oKSaZqWMltNM32F5gbjfaGZlmMSum2OtY3SK776eHvTRu5LaSwjNC-r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Feb 2026 21:37:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] setup: fail if .git is not a file or directory
References: <20260212172405.48614-1-a3205153416@gmail.com>
	<20260214045247.118013-1-a3205153416@gmail.com>
	<xmqqfr72flga.fsf@gitster.g>
	<f7426def-dce4-41d4-81de-91388fb41997@gmail.com>
Date: Sun, 15 Feb 2026 18:37:22 -0800
In-Reply-To: <f7426def-dce4-41d4-81de-91388fb41997@gmail.com> (Tian Yuchen's
	message of "Mon, 16 Feb 2026 00:22:02 +0800")
Message-ID: <871pil76sd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Sorry, I didn't express myself clearly. I meant I tested it myself but 
> never add a test script. Test script will be included in the next patch.

I see.  Thanks.

> On the other hand, if I understand correctly, state flows should be 
> categorized as follows:
>
>   1. Nothing there (ENOENT) ---> ignore and go up one level
>   2. Directory (IS_A_DIR) ---> check is_git_directory
>   3. NOT_A_FILE ---> die
>   4. *REAL* error (READ_FAILED, INVALID_FORMAT) ---> die
>
> And I mixed 1 and 2 and covered 4 in an obscure way (!= STAT_FAILED). I 
> don't think this code is "unrunable" but indeed the logic flow is 
> GARBAGE. I'll fix it.

The above 4-bullet list makes sense to me.  It makes me wonder what
the current code does and more importantly what we want to do when
we find a directory and is_git_directory() says that it is *not* a
valid one.

Thanks.

