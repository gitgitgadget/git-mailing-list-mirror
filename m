Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6712F5B3
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342283; cv=none; b=WW+Xa0AgiNPESGw9S0G56wo+oB88dGg+xEu+eTqDxffGBalZJ/icFKVAtc8r82fwPYhhkUxiuo6rzjpmllgVTNQCQdtq/ooNfDKSYWQgL2wiopoZotIRQX5W6Zb24bqm6qTd4dKE/dQNsWFG7tcYhXkdQrrN4dPUmBwF5l/7Aa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342283; c=relaxed/simple;
	bh=FCr3kyyaIOMKH8PS1zDVx1C7L+oVSuUmQHap3zgqW00=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih2PbpC1zEujxTfVwSYkzOTAYoFcWmjKCDSHOgxaVG77TiaX0kuZddkj1KVT+aYUwHZEMISknsQfINj95OwTsKGd6/qe6cPnnGT2fBL6926i3E051HGdqmgMESBAHFODOowWQ5HWYX0qN5GcsleF9yVFSUO3l0WU3qoAus6JlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TdZGkSX3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TdZGkSX3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9615A2F1C0;
	Wed,  7 Feb 2024 16:44:41 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=FCr3kyyaIOMKH8PS1zDVx1C7L
	+oVSuUmQHap3zgqW00=; b=TdZGkSX31zKWmzXqb4+CFiflg2aniVp/AzyvBbT0a
	yBjZ95qqbNPsG3CBI92Pha9iV6FwxboMwMAWR5cGjmFcaXg6BIVYlpNHn0Bj6dbF
	PeGC+5ymawU4QrOfOSeXu2/DMX/XXiYBf2z67Y8J/NlPeyk72ZtbV4Y8TQL083ZD
	1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F43B2F1BF;
	Wed,  7 Feb 2024 16:44:41 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 419F42F1BE;
	Wed,  7 Feb 2024 16:44:38 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] minute "git bisect" doc updates
Date: Wed,  7 Feb 2024 13:44:34 -0800
Message-ID: <20240207214436.538586-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-561-g235986be82
In-Reply-To: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 179378F6-C602-11EE-AE52-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"git bisect" documentation was a bit sketchy on alternative keywords
"new" and "old", that are used to signal if a command is from the
part of the history that is newer or older than "a significant
event" the bisection is trying to find.  Here are two small patches
that improves the documentation.

I am trying to flush my "stalled topics" queue.  Here is a small and
(hopefully) easy-to-finish one.

The original discussion was from early December 2023 and can be
found at

https://lore.kernel.org/git/CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5V=
hUFPag@mail.gmail.com/



Junio C Hamano (2):
  bisect: document "terms" subcommand more fully
  bisect: document command line arguments for "bisect start"

 Documentation/git-bisect.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--=20
2.43.0-561-g235986be82

