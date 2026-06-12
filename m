Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3B35676E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295055; cv=none; b=F59D6GiAJNNoh6WBq/8VdHcEQzT85Fi+dmmBld0+GC68pQVFwZ8pdNCG7uyOchsP4gMBnWsXekA6hW3ga2ETCrj+oy3f+sWIC7+7TKKXv1Rgzywa6cVvHD5LTofGCURsm2DiEWPKTwKDpzTnJ5/921TLeIuQtANv3wQ+jxpNBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295055; c=relaxed/simple;
	bh=G6KzRIhQ/oLyfoGeS3p7E11909wvjl/B/ek1yFVEumY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P4FJKox3FiwGTzJ0J1U0xfulp60V9Xwfjev9w3QUri3QGE2ARgTp49ToPY124iniE4uA7sCyokbpD7FusYQIBrYvf4YOrS4AOkTAaYL9eyhXJCPsDB1g2w3ZZGAt5/faPKYZmaWJWmxIQhCo38ferXgUnZUX/dj7gg904vg5Z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QIWK3LRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+FG+Icd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QIWK3LRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+FG+Icd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A07BD1400051;
	Fri, 12 Jun 2026 16:10:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 16:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781295053; x=1781381453; bh=vOWd2C2qmH
	Wp691qBlfpoNfmnRtdnn9oFj61VhX1G7U=; b=QIWK3LRfPeSQWOwyplKW2RM5Xm
	YYisLu88AMV3t1KmUXkZmK3lcp1fRxQf+UbqNS7hcrQaS5fbBATTRyQLSIMnOOBa
	8oOSLDNcvgATwYfA++iCVHG4DYdUfS1qx7oTfd3m72Lvkcr0rpRjxxfgN9JlFT7+
	oIfX0aFKQ3lHblLv958y3FKoXYtLjVdD7eh3SDJZnfo8a5Kv5YUe7f2u5FsWGn4d
	b4qFd+0brsT7cWr//yGjYkzxrjmWJ9nFL/V89mA94kqf0dgQky31w+qyFBhVxr6e
	iuqANXfO/jWJMi52k3QcQtalUZaud3zhVPC64SMyLIOJTJVRqaiwU2XAwHzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781295053; x=1781381453; bh=vOWd2C2qmHWp691qBlfpoNfmnRtdnn9oFj6
	1VhX1G7U=; b=b+FG+IcdsoD/V2aFop/LFYPEUpi5gpOuptmnZI52qqTvMIWVGTf
	9h8rC3dC9sSCaYEY9AaZfRY4HFQKGiaQSn3gCYjX2Wi5zSKyXhG6dwPV1x2UqrUi
	0oL9sKukwHimn9mpbcZRTn63jCX/aCfylLOQ51wNesgOawfclipf7B6dhR1E0o+W
	jGl0sb1iBSVqKSSa3DwYmS73Ow+/BGdr446BcGgPlyG0aXcBW/11xg9KQzCJrKCT
	2hBIUorDgAZfnJ2Gyrk6EijxfhB7Luk0V9FzT9nrrCw6pHp8NpFFn7dBX6td5jVK
	Y4/XDNoWauOgKW7uuYAsCiL5YzpgeYdFSmg==
X-ME-Sender: <xms:zWcsas6oRRer9jhZ7LAl9k396L_ROIUMGi9vO5Upb5eLwT_cJuh5Gw>
    <xme:zWcsak60aCPwHQvAV8u1yl4Tjx4wOe6RaFWmr3nC8KQ5XFijVtP8qGP1qK5f7FKKh
    gVEiUruBcYZUxI7LlvRZy522yPnkYW1GrqQ5Q7yaIaHOplHar1jqg>
X-ME-Received: <xmr:zWcsagfnZG_skrPiTVw9XArq1u9INkNm7lunU0zIuP3LBrtDAkOu5LW4L7iNbvLzpFh-uIRfXVoupxmH67XYznrcmigjP2cYIG44>
X-ME-Proxy-Cause: dmFkZTFyYh3AbL/izsfuhe7HRIKVOKbO1C0kstr98pT3k8o5ZZ71Fvm/Tz2Fsa1VGeVz/s
    Du8HdQVG/G3yJtH3Hv8EVTYVZTdwh9sePTFQAwT8NjsPNW33ZjcrL2njMgPckmCSXeSg4a
    3z8E9mqDuqdcYJOsDrKNGYPqeRlBno50m5nuRO7YKPeUZPbf17wkqsrxeXO/qIbV0qQ/G+
    O1nOQXvrkVq/Ua80v43AxkW3AjkmqN/OHYyjmRsT+b31oAd8tyjnFiv2M695GJLi3IsMdP
    J/+2u/UAkmu4FJBY2vlvVr9BgOm4a5ivky6DgioDsI1jIZAwpBg8f8UGUDlgZvPiSy5kKR
    TL0knPv57hdgkwfiaU2QsVOsfiL2dP07pf+Ai2ICDoud+BYUQCkC1+CDYT9vD3qCtCtZCw
    Uk0DHyw66rlnrKQBDxyxMLETYuhNXeVEPmiSBZQMMdLwjHqauZke9MhegCxuToJSurzl5o
    XOrlNnZ+sej/K2H5BpJb9OF/Wv9HVVkU60bheK1hnJJRuSXnnK4wBekD4JvIP2NB+r4JPn
    pcGqo3/KmXTEp91dS/1e5l5IOwrYwYD4JbmoDXxvv7iKB2drI7nCBYk6kcbPzww6/XI0JU
    7SCTc1Qdc8mGL+TAZpmPqgEdw3LzaEUNWTjBOCntTeUh6bNieZe/ohY6Kbng
X-ME-Proxy: <xmx:zWcsagC2GvvueLe89kSBQBOFTeDMYyhArj2opCaxCAMXgkk3EQg0xw>
    <xmx:zWcsar-zJF-9gJZXkygkv0mHQxXQN3YAPhenW5OG3oNzdrejw6HoNQ>
    <xmx:zWcsajJwyCDmdtJxdBFvq7GOJpOs8l38DY4d6J2ywhZaH9Y7yTn0DQ>
    <xmx:zWcsasjEJ1x1SyAmlL9IDiS4c1A_IdQwCAz1d1GLvfxjw5IbiF2j0Q>
    <xmx:zWcsalGfCTTk1m6Q9EjmTk_K-XlhkFGVYN5zwyBs63k7TfGemBa-NDHW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 16:10:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2] log: improve --follow following renames for
 non-linear history
In-Reply-To: <aipTOsH8LKTSwglj@collabora.com> (Miklos Vajna's message of "Thu,
	11 Jun 2026 08:18:34 +0200")
References: <aipTOsH8LKTSwglj@collabora.com>
Date: Fri, 12 Jun 2026 13:10:51 -0700
Message-ID: <xmqqa4szh644.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

>  Documentation/config/log.adoc |   3 +-
>  log-tree.c                    | 133 ++++++++++++++++++++++++++++++++++
>  log-tree.h                    |   1 +
>  revision.c                    |   2 +
>  revision.h                    |   4 +
>  t/meson.build                 |   1 +
>  t/t4218-log-follow-merge.sh   | 119 ++++++++++++++++++++++++++++++

t4218 seems to be taken by another topic in-flight, so this needs
renumbering.
