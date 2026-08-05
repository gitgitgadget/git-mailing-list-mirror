Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9B35C19D
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947418; cv=none; b=V9jboFgUHaTQrMFwBGn+n6RUq/bK2++O8wxIbSQsu4BOAt1UIckuMP376CIhfF/cYRKoGyR8Blo56gm3KfAUiekfo4RJx4WiSFSgZOhdTJqWGxivFivNEk4rehfBflDy3u8rkmMwtKAFkL4mZK7hP+ETubHDHIN4I6IUlARbTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947418; c=relaxed/simple;
	bh=op0ABmbYCKau2hBBiqVAB38fryfaq50l9gzzAIZGOeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rh6eqbtiHlp2IsgpLt9euKBl9rEdBTjnkdpuYUO9jKetTEYJxMtuVasjGpLDY2hX9P06kidapgQbXIKoQdJWNSTwoeiQv4Iyx1dMfgFMe5RUmpAQQc8PVLDA1v6HQM3ZctN4gvnHKXmx131+btOwh6xtgCrHIduLsPpGFOHwOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pAQw8m7P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A1FEQDiP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pAQw8m7P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1FEQDiP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 542FF1D00194;
	Wed,  5 Aug 2026 12:30:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 12:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785947416; x=1786033816; bh=Sr72+fPW9r
	RT3SRTkusPmngPLEDcfJEzDyrLikHX24Q=; b=pAQw8m7PFVZu0DV9XFW9j1HYkL
	ahQbXTN3ui/oohoGceHzGMNtKuUjqzIF7zUGFW5WbGrc+gsDUk5UYMeXE0TH0ulW
	irC7Gso1WiBtj+wEa/SKHM84uVPAbTjsOq1r9NUxZ9+HQ4LapGOh2E2b6l+FJO4e
	cya15Yxzi9QecgjR/uidPhAwCWgrzchAYVb0lrYA6qO4uWoUgoxfNz7G3NURdoJe
	Ep8eEqjX3XZymVNc5+ktXUx7MhYPDAr4tbRIwp3DqZC4/1hD0yvR9k4qDmv8arvX
	BOWxSbsBMSnnHc+lTMhndGeMFnONgiCoptQd3Q3RLwzvsT/p75eoaVZ89vow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785947416; x=1786033816; bh=Sr72+fPW9rRT3SRTkusPmngPLEDcfJEzDyr
	LikHX24Q=; b=A1FEQDiP+9WK4soFsCasMK9haQmjNmtmD4tckRwVv37CZTUz9ZG
	yp3MyvAtDoW76PtPrK7UmpyxeVsU+ZWH2goGxDXbOZ9aVWoyI150hreFHn/NQ+du
	Zb9g18bscp0v77ni109Bvr8qeD5HgqO8yRkQUUbRaVvhpE8fKtaL9Ltg45TSu9gw
	8d6QQIVvieQnoM+mE57Cypg8MCfHtrJNsxPI8J6IhJ4irheIETPh97pxjEdIf7/y
	MOz8WheQnuzVIsJs2lYG77E+G9/a806ZiPL0tQk44/LaIixWYuWg9D8u6HJ0ZIIm
	1xrMp48v62FlXqaQHPEvHC0XVqQmxIbAm/g==
X-ME-Sender: <xms:F2VzatFMHnEXxSbuBGDh4gm20EiNXqQMkPVKrbiCXeyWC9mL0InpCw>
    <xme:F2VzapxyaCMs5oPM4Ylu2UY62m_-_TJktKwT9yEmLMkoBYNBmmjgMxsMvH2Reae4T
    NmtfJetS3CI2L6eJI5v5ruDalTzN4t769dPKJpdcMF86OTDXlZqVAw>
X-ME-Received: <xmr:F2Vzasj8vg7eEC-FLUk8lZR1rgPpMH2iDP6Xn78ApiShJSguLGE3_0MrJxttNnqJcinJPMKSgXklT0TuqPAEeMwnUrZ9Im8sVg>
X-ME-Proxy-Cause: dmFkZTGEAflfMyh9KX3YS8OB/zyY5YQgFh4s659BYcrZp3XeU32RoC6OAasStrKvT390Qx
    OafsEzNV5nhMhNeB+bW7a1dTYJhT8UwiXIY9klVjxyjP/6CHTVoaySDEOvXEQGXrGmJ5iE
    kEnBNnjvO3QAYMGWpUVMWeBO8qrEehjt3OGiTSAW4WZBgXZ/UWOtxMxWRmf+wj253mBqq5
    t7T2h7dV2gspqHmg8LRsp3EyT5GdDo9VLMMkbhytsfyNmrb4mAB1nyqwPLr7qES+l+bQuj
    NatL7gNrFjV0DRs9/JwGX3PTUYWILqzE9k3zQjxijAlCwSARG4CPlzS91kwwFjbgy3eatG
    JGXUWKM+ehmzB3+mFn3aCyTJ08SwFZ1nojhY5kLZvdT1u8punEoqI5SM0uktzNGhXy/ewQ
    THGRz+aYL7oKt0/EXMe59pY5bQGZ2n35mRDwQ/IwM4ZSP4eAgiAzxuZITzLxmYh5Px3gdv
    0Fo1yBq+iOnJ8YAIn8KohlYfQjtoVVRACFEAqDpewOL3v5cGRS4qLKufvv3n3ox3XajAEd
    /wp/Tk6/otPx3isubhrJchZnLZGPxprDX68Btx5nbgm2aeTjSK2zwefBIxZUL8PB2o7YIA
    PcE6KUxSlGwYwkhgAtCq4C9RoTJ1Q/MRDAyZaVm9BohRzweRWMLATv0JY6Sw
X-ME-Proxy: <xmx:F2VzaszUlz8OuQP97MHKwUIDvyFOTeKXVTO337Utpl8MMI9UJKtJHw>
    <xmx:F2VzanJeRvuwgHl4u2ZOg6bHfFnm4nUEs9dUNu9JIiIUJtkMpa_-Ew>
    <xmx:F2VzarQjei0n0Br04aIqSY0FDYVKTwpl1zMgON1g_2y1g5vZoeVZAA>
    <xmx:F2Vzanr114jsCJ1CbvYn0ErSDBFwGutAme36g9jduSFSTGZk40LLrQ>
    <xmx:GGVzarYzC_bLYy7zQEDmt1M5Sb2PErpCeDWY4DtXBhFEWpbqj7sXk4Rr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 12:30:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Xavier Morel <xmo@odoo.com>
Cc: git@vger.kernel.org
Subject: Re: `git push --porcelain` has no effect when deleting a ref which
 does not exist
In-Reply-To: <27d95520-409e-4d1b-b8b1-37a910bff604@odoo.com> (Xavier Morel's
	message of "Wed, 5 Aug 2026 09:19:13 +0200")
References: <27d95520-409e-4d1b-b8b1-37a910bff604@odoo.com>
Date: Wed, 05 Aug 2026 09:30:14 -0700
Message-ID: <xmqq33wssf6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xavier Morel <xmo@odoo.com> writes:

> Using `push --delete --porcelain` with refs which are extant correctly 
> outputs the relevant information in the documented format:
>
> -	:refs/heads/<branch1>	[deleted]
> -	:refs/heads/<branch2>	[deleted]
>
> However doing the same with refs which don't exist on the remote (e.g. 
> because of a concurrent deletion) has the error written out in 
> human-targeted text:
>
> error: unable to delete '<branch1>': remote ref does not exist
> error: unable to delete '<branch2>': remote ref does not exist
>
> I would have expected something along the lines of:
>
> !	:refs/heads/<branch>	[remote failure]
>
> which would be machine-readable as documented for the `--porcelain` 
> flag. Was that intended or is it just something that fell through the 
> cracks of code convolution?

If I have to guess, I would say it is because nobody thought of
covering this usage pattern, which allows you to randomly throw a
deletion request to probe what does and what does not exist on the
other side.

Patches welcome.

Thanks.

