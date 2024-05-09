Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7D80034
	for <git@vger.kernel.org>; Thu,  9 May 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289205; cv=none; b=Fm67ndP2cCbd3b74hs8s/2P7IFijM5NrDBp3RBFZtYwF9zRrLh/40cfW8nQsTnWo+wlDNDa3mZtxQIzI9NEN/4imBj7TTi/2g9ocmksG+n7gy2OU5/DOZ95CH0kHaeKUPe5NXdN6H4xw3pj2FZQhKUx0i3B/6NBLnFhBtdF6VtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289205; c=relaxed/simple;
	bh=q7aaVHYind3iJyTEUF18MDjRRdz5a1Lq5OrRniPfm9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKLn6fLOcqEPPBk9EkzkJUiKUTwENrjCY3IKxuKRVACqMLckNUR7AHyW/uuA994WjnB+0ySjRGhDv/kmyB8r+UyeWZx0fc8826l/EfgQa3jeEwFqD5tnrDTBNIq++WnDiMMMIgEIRUUliLr0vJ0NNoONps9C1+CudCs8gCd4ieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pe3fVT0V; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pe3fVT0V"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BFAB2F927;
	Thu,  9 May 2024 17:13:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=q7aaVHYind3iJyTEUF18MDjRR
	dz5a1Lq5OrRniPfm9Q=; b=Pe3fVT0Vv7HaupCj1HZhbRccgi5VhKEQmHaVvuuA9
	REqr0IiaZJddGh0sAXk846I0FEBKyV39ux0AZ7+jbsDHCIATr1yJ2FVn/nlQ3gad
	o4muolEHFCZYCWOXrUijuch3E/C7mkrM0zm4ZgU4mCe+F5/XlfWDLtqq6ji0X2NT
	TU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 435B62F926;
	Thu,  9 May 2024 17:13:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C425D2F924;
	Thu,  9 May 2024 17:13:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>
Subject: [PATCH 0/2] Describe patch-flow better in SubmittingPatches
Date: Thu,  9 May 2024 14:13:16 -0700
Message-ID: <20240509211318.641896-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-119-g0f3415f1f8
In-Reply-To: <xmqqy18issfv.fsf@gitster.g>
References: <xmqqy18issfv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F5ED44EA-0E48-11EF-9D11-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

So here is what I came up with.  The main idea behind this
"counter-proposal" is to make sure we do not add to the pile of
documents a new contributor needs to read before being able to send
"a perfect patch".  Reading SubmittingPatches alone should be
sufficient for them to understand what to expect and what are
expected of them.

Junio C Hamano (2):
  SubmittingPatches: move the patch-flow section earlier
  SubmittingPatches: extend the "flow" section

 Documentation/SubmittingPatches | 126 +++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 51 deletions(-)

--=20
2.45.0-119-g0f3415f1f8

