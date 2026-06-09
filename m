Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F063408608
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008705; cv=none; b=kT1fTm/+SKtMY2JMMTZMuRwGjO1+f+j7BxHfs8p+VVGbzY7avJX10gyfD6hfhQD8m1hN+pJYqyA+Rr8Dutm64VjXwzJFDUeHOu+GoVGnSLtn6ihMcjrnZzZmLO1Torm6GvHnxZvJWvjkBDYl3u5eoD0CmFk9b4DIo6HX/pG5NzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008705; c=relaxed/simple;
	bh=Mb5fiISFYReZiVRh9HVhk6gf8kCRTgUfc23RmVs2diE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5IOPu2J7tsZZ+trFZLSHXaASQYEJY1t1QDV6nsdQg+tUoRFbH4fHrrr2QkA5yPmsgtQKBDtjI/nv7x40tCU3JytL9h67GG4B4VIMAmF63pTiQ/XeRcepqPaCyxVH7JsY8/m4bQ4ivEOhYbhEv4WcELovjOaQ1qwi29mCKVkpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KlL8pmgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSZkA8kb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KlL8pmgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSZkA8kb"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA5D07A015A;
	Tue,  9 Jun 2026 08:38:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 08:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781008702; x=1781095102; bh=RMuLIKXIlK
	KmqXj26/1ttt3GD6miVriwteij95P9WFw=; b=KlL8pmgC5ik7fkQL598KhFlx+e
	eCiGCewgGjdn5yW//T7kGFZMGohr2Sz2t+htGG6sXC0uf9xKAkUMEyspgszcwEui
	VLiiUT/vXWqJqbVoG6c8PV+9Z6e4+5puc0ftBUa1/3CcoObjA74Rv28Pkar6ciTH
	YDam50YgIYiT0Eumi13ZbR4ztkifCmErZMh2HpCCH4F0O+kG86XFdzAmO9PHtVf5
	oxjr/Gjzk8jCxYqMQ1Xn6cTE2+j2t1RHQPSPK/2bH4JtO0k6q91Dxq1xcZoLzIlP
	UmX0UVk7MZloIRV22MCb7rQ6ja+RCjaCoBRDJeuG9P058FWtFZupoRYpN+Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781008702; x=1781095102; bh=RMuLIKXIlKKmqXj26/1ttt3GD6miVriwtei
	j95P9WFw=; b=ZSZkA8kbeMXVGeTVWwQgUzKEVKLCnBS5vOsu8gtEVlH+AnbMOgF
	pa1mdnj4kL0D2vEyQHWrPiSoMSvNT7ryBybjN01zg1qvhkGg7C0uZpqbBCQnDXzy
	++XY1XpB/AU5xa8VEB8A4YP1m7//vMvOLY+Rdp+4gob9BNOwufqk5ceE5KuUuGcv
	LZv7K3cM3K3k+IxQUM8cadiGhdAsPkAo3ozN4Hn9u185/DQsHMzaMtpE6vuPjWet
	T/E72PDymqNe9wYnOTXSG2YsDUWYq4/yMi4/oOd08gL4GdlNp+++nQmGdaj/PEK9
	vI+qIDuRsAJsZqRt+0uO6N8h688aUvk793Q==
X-ME-Sender: <xms:PgkoahPuu1qQS86z4JN5X6WBY7o_rXkCbUxGKoy80SQrkEQmoF_IOg>
    <xme:PgkoamN0O2xUp6Lsjta9d2Ibbq3DLXH3wNKkDsYGFJ2cTUT9rQk64mUsC5tKioTWj
    mkOH_ZUH9Qz-azXyxSsBDy1Fi1sA-x4NKE8VtnVp9SR57Xwnft6>
X-ME-Received: <xmr:PgkoaihcaZArAUgQ9dwWAT48I7HzSwUn1xBVPTP08iLfBlVad8Te6Mq4TcwhOTGoJXQ1LXbbeFBxiR4L7yFCtLDMHVp8UYi7qvK0>
X-ME-Proxy-Cause: dmFkZTF6PAABKYtuq8Fd4CqaAJCsGqszChj7GYkh2k2ny2/Hc8+6fHVVBfa+EaiihKs8gA
    qwzBqC7tHyvhHmTJW3rxIiUH//g1UIhmRelweF/I5kExi7j9fKPpLhTgtknfh+9FRGseRb
    GROI+HgwPF9mZyoLpaeXy8wity6xnNzoz041rSy1y8kzgeNCeQIn7PhjS2aMu5ftFI7jk5
    HkOXrNA2bnTkqQbRCDfBXteeJNefi87t5IDfAFq1EyQB6P7eDdBJz8pQUAyl+Z52hwIN1B
    Wq66ZgH3mQFo82gsCLUBHWX7O2KRJrQu7eWYBjxFDJZmSdLSRhysk0Hubd/Na4Nf6D6TNB
    /G2jB7rwnz+4trC8SIOYLJTqnBOsxhmGDHMly9vEBeWOlSVEbcFYgnZJTY279fNXMosIiP
    PL7zcL6JpoTcH9+/7JpHQ5XEaqctD9BFWTGUUpF+xul7rsGqzFSJcKBcY6iCW5H7PUIVky
    WjVFMlPXu8OtQ/qS/zUxoeiQ6HQx4orscoIMRfUwLIAiseQuyombubnWRCZxHf9MVtZpym
    w9BQ2T4HFAGDFrIIblCohStO4+Jk5AGDIXmR3FQcKPg1daCAt9cXcTxEnCsSGftZJmWOz7
    sM6dZK81AU8rvoDpj5ryjsN8AAM+FpUmPwd7E6+pkvU2k7I/4m2D4p7jktVA
X-ME-Proxy: <xmx:PgkoajubN1kfTnVjGo5WuX7Ii1c82ZCU4BvrdEwglUeW9GJEOJ6-xA>
    <xmx:PgkoaoTuPH6qQaUCK9gdyuVTyo9XAnT6XQ83RZmUVPIXjc0vQR3Nbw>
    <xmx:Pgkoav2FOSoeh9rmC88TZKkYGgHAO3wWGytq0ZjXhzONECsL-d8tWQ>
    <xmx:Pgkoalu29Qdec4J30YrHEQ9hQ4PnWKJW9PDTXIDD6zlywrKeVa2lMw>
    <xmx:PgkoahZPLF-v5AhzFZXY_UeSAszdUr9fpaF_GtEjkCV-mdFD9uGenT6g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 08:38:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 2/6] branch: let delete_branches warn instead of
 error on bulk refusal
In-Reply-To: <CAHwyqnWpkF-8czt8+G4GJpMTb1qXG6FtN1HKrT5H+OcfAjQL=Q@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 9 Jun 2026 09:52:30 +0200")
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<a7672713f67d6a44992c0f0cf989770c7e9ca38b.1780684553.git.gitgitgadget@gmail.com>
	<xmqq4ijcvb64.fsf@gitster.g>
	<CAHwyqnWpkF-8czt8+G4GJpMTb1qXG6FtN1HKrT5H+OcfAjQL=Q@mail.gmail.com>
Date: Tue, 09 Jun 2026 05:38:20 -0700
Message-ID: <xmqqa4t3ubwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> The GitHub CI has been broken for some time, maybe I should have told
> you about this earlier, but it coincided with a period where other
> open source projects I worked on also had mass CI failures, so I
> chalked it up to upstream issues (GitHub, Linux, etc). But it seems to
> have not gone away.
>
> All of my GitHub pull requests have broken tests (see e.g. which a
> quite minimal change: https://github.com/git/git/pull/2313). This
> makes it harder to detect actual issues. But of course it's not an
> excuse.

FWIW, the breakage was observed in my local testing, and that is why
I found it so dusturbing.  Apparently you didn't see such breakages
that can be detected so easily during your local testing (otherwise
you wouldn't have pushed it out to update your GitHub pull request),
which may mean something in the test are platform dependent?
