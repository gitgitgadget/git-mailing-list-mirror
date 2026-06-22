Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71827A476
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163009; cv=none; b=dhXO2ys+WOgCshVR18fX3WPTlWiAww5qTHO78cv5k2rl2+NNSrO0DF7qx/s4idnvhHqLJEJ9Neby2xh+0ZV+CdQtcOWyzHCUmKjGownWgHFxiLSa2F7PduylDuF9JrBNaV76R+kIazxOB+YPn0H7GQrTuym/feQb6YrhTJxkvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163009; c=relaxed/simple;
	bh=j22miVqtO5ObM6dr/iH/0OuqbWdhj1n1yqXJbWga35Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gguSYl4HAFn1hxkHg9KdGQD36qMSvT83mcXRxdkT3jsprvYbeWDJpoWrDspJxWfXlKbS4U7YPR5PFxiYP6MNHROjqCzgQKgD7n9UKW7x4Pxi6yI8EGj+y9NklrxW+pCGcDtlaO+X4/QhEVCWe0MyqvYr45z5JC5w2Y8AJYKGBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R2e8ZvUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qqs3Jws0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R2e8ZvUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qqs3Jws0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 81E1E1D000B1;
	Mon, 22 Jun 2026 17:16:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 17:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782163007; x=1782249407; bh=4JzMY9JOt7
	CCIsVZMuHQ1hGma842cInjeGHd2d4Qxmo=; b=R2e8ZvUDZFtGr8V89OHjbqy8JH
	4o+XGxqchSFkoQtzY9lOxEBQKAGShqSOTFLzOPtrB3IfVENeGT+4JhZXlj1m9H7P
	45HoGxfWe7Jt76LJNmyr4zJtbMQ7SSaXGr5rDptWBcQ+51IB9SdhbIby0k3UFECH
	E7YH17/jDrN0l2xjdxdtz5Py5cNBFao31PCNwNePQDjXXA3I+uEMw7zAu+OkfYu+
	oAJsmQAl+lXJB2nlBINm9YSMrvHkSYIfQnP7FWo95mUkLZ6lEFQFlQ3WG8jYeypr
	HWSobpjJsmIrpSy62MeoyiWTBAD3pnnagYQFpzw9k+tNQoUkRR/qA3bg227A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782163007; x=1782249407; bh=4JzMY9JOt7CCIsVZMuHQ1hGma842cInjeGH
	d2d4Qxmo=; b=Qqs3Jws0MM2EljFPggciOUU4Sqqnu64InEfXg/Hn+Z6JvCOHkrj
	6rGJWbayzZvcJW6NQNc7SKzadhDoJH2eykUfzzq+HxY3EN1jL5Xf2z6a5w+lbNwl
	ro/wa9gDZ1dUinpbIe6ZkQL7Z8fKGO/FhVY2iwlWXBvV57H4OsXSPh++WDM2UH+U
	oPEPvioBI/Fht7uQQomWNY/PNtdgXr9tIzQWEAbubuVrdh8gMdi0/Am4GML361mI
	s5jbenA3C+/Mw0TJ73dowDGwwo9NXjFj4ExJ6b4XNsJ7O66lHNH9ft9USsNsAuHD
	5n5lTKbqkRhXrjS713fIEN9857F8jNNCIiw==
X-ME-Sender: <xms:P6Y5ateyAX11x2cGEjGa4ngiyy7AWLOO7O9gb-BQpD8yaGeSHA9eWw>
    <xme:P6Y5aiMQyXPFkB_YF9oMaFDgs9PF2tyPQKZL2zruM2FEUhQRpCl4BVMsto4U3fEPW
    0SMqky6ZA1ZGzTrJgKZaD3LltEYyYfAGy6OWa-wIDhLVpR09nIflQ>
X-ME-Received: <xmr:P6Y5arheSZnF_FLxcVyH67PpV3V51gpBiDHVFos6Yh_XRT3FKYh_QAnbv_WUTeKPQNlwaWrotuq9Knz5drIcUMKGv3EJMGlzzn90zRk>
X-ME-Proxy-Cause: dmFkZTEXyQRxfmSbQKOcwoy67vTSzr4DvjrdIhu2G+CA68fku6TpGxiyw9hjLZBlufShDB
    CcvUJU4pL50tx05OcchGODYy1t6LOJmIB/DQnKme9EX5RM+r/G6VW+DQQkyXAmjACFSauK
    DrOIaJfn4Ix2R1Nw9OTgQKJhVTXQNL1gbZbAciih7Cz03Sw/p4plU8DSXkT5xexnEms4yv
    Wx0sL869wBnqSJ8OPgJhhqiEV+oqhGl+CH2lQ7QroeD4b3IvYtmw+vALemRX/SfZpghdEb
    ecGuNjgJzKj6D4D182PQ0NOkWgfByezEcbWatDDaskN3pNep51Fs7KDkeRNh7aEcZS5nXw
    eEVuZkp7leLvioHTREwH1HJMCpKd4YNFYNrtwGlgF1l1CLP1byIv3EgXFWl0QICx9ZdgxK
    84TolZXJzxQ/hc8ffNTGucYacGtf4CDt/4vaLlqNTwtKcW6sPFRx6L6aq/akbkHmayaUDp
    Dc4hwclhqIjjOHAWfFe1w/Iq9NtMoQa7aXulravb26sfg6IYbf8DQbvGd44TPyWEVDIV4e
    byStSpX3/W6Z6ZC/pdEyoS9oG9Q9RQCOOEhWJvAIkqlDNVWBJC+wgNBet4IHmeIGugDkun
    82pwCsggdNwQvPI593UaFdsFpnUej1IZ/uPQDBlf7z2u+fgZo9c/2+aU6GQg
X-ME-Proxy: <xmx:P6Y5al2yFur6N1w-ZhvNmMk5iJ1OcQc20Q_8htRQjBPeh0UZW4mjVw>
    <xmx:P6Y5ali15tAiGkhq7SLqYL7oR83ApgW0ZfDAq_jGjRTmvxc6K5D6pQ>
    <xmx:P6Y5aleU3gRw0xUSY_BeAgr_FEumI9NmWjRD4WC8o2WVQ0QtvJfrbg>
    <xmx:P6Y5aolmKsbB4RlDaFNfn1OS_ei4J_vrkldc2hBKeIK_szC_KcQzTA>
    <xmx:P6Y5avAaGejEuGtJeClc8xI-p888Nw3oLuMPjDkEpbe4_4OshKV5C8o2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 17:16:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 0/2] branch/push: suggest intended form when
 remote/branch slip given
In-Reply-To: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 12 Jun 2026 11:10:17
	+0000")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 14:16:45 -0700
Message-ID: <xmqqpl1is2bm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When the repository or upstream argument is a slip like "origin/main" or
> "origin main", suggest the intended "git push origin main" or "git branch
> --set-upstream-to=origin/main" form instead of failing with an unrelated
> error.

Sorry for asking a question that may be stupid, but what does the
word "slip" mean in the context of the above sentence?  I am having
a hard time coming up with a topic name while queuing these two
patches (an obvious candidate is hn/branch-push-slip-advise but I do
not know how well the word sits there).

Thanks.
