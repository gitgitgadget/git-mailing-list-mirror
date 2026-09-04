Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E551A740
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545169; cv=none; b=Z9lcrffrSCnyWTqb0THDxPxkTLfL9DDVMw0ip3yWMU1RMFqWfbcWRG/QKcaec5AdT+LIyXHfUab0mM1Fd+hBWfTT2pyO0gh0gc6eKB+kMfTr2MJT0tAXliayBLzqIHFrqGgPk9CROSf98NFHjsZV4kDS90pIU4XX/kJ18FYERjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545169; c=relaxed/simple;
	bh=J2baGquR7CTkLLSmiLtKxNZe+30jdDv9E9URPj8C7a8=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=qKpcxX7aP7kvp/DIfP7uK3ZrpZdd2GXT2hv7OoUjheLx6IEOeI/Vx0fIF8Qo3t5mfE30JtpVk6R0BpiaBHiLN5EP11AZnZRmtJJS1firlYF6mudbdGE2lXzFyXF4Xeb9w6gWxhzy9eBCnGBnLFudKMzMYywl1wZBdaBwZr1ZJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com; spf=pass smtp.mailfrom=artagnon.com; dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b=T4/1V2W5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vM28i+Lq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artagnon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b="T4/1V2W5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vM28i+Lq"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 998637A00C4
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 14:06:06 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 04 Sep 2026 14:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1788545165; x=1788631565; bh=J2baGquR7C
	TkLLSmiLtKxNZe+30jdDv9E9URPj8C7a8=; b=T4/1V2W5ssYC0e4nRMLu6+mMm6
	DYeMwhLKhydt7rVmQnLKcOjYbKS+0g+8kK7DBfii0xZKcjq+eWzliWwp/LLdybod
	mLfviVDbcCA2vcR9hsyTEfkrs6aSKadE6IQ5Vk8tyHtE9cFsIIqhIJg3p8FoeEnK
	UCCb7PC7c2oxBMCL0mrBuSxPjOCbfW//VFEotJBcc1uJJRQJaF2IASPCjVbEZEXw
	T4oPkJGePzdiRKOMeZqiA0CHS5Q6wFkbx8nQr4ld+F/5DkpS18sJqnNVaVBq+FED
	DocVyFgjn4Gx49vJ0wyy8XJrK0HZytB76dqVSxBJw8133cQXt5vkVIzswRMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788545165; x=1788631565; bh=J2baGquR7CTkLLSmiLtKxNZe+30jdDv9E9U
	RPj8C7a8=; b=vM28i+LqpdrXB+PMRaj0K/eGBRu+MR6MwhEMY9T+gmTvBnrZvMX
	EPZFkNgkFq7AsInbJgZWBIonXDKgmqrC72CV/ytqKJWL6BXM5QO0fb9bxEKBF9BD
	/vOlg/t46gEf+1Xa6QMIfkBNi3m11vOP2Cs2NCOLWI/Kk+MyT3MEuV8jaudOI74M
	a3AeOnUnSoATCaboGD/5EQ39rjyUthIaLZsvWlNTRggVpTx0xc9GsT1WAeFSi1C9
	tNhD1ZE4YRwKz1+67zXpO9k0U0akMIk/NeFWzQbWt67+L1zlIIJoKWNDME8z4V83
	kb0HYUYsRpEIov7QfOe0jD1x3voPYOLEU6A==
X-ME-Sender: <xms:iwibasqJ_niCg6Z8mbjsb15c9zYvVUs65yL3gchzADzdsz6dZELpfw>
    <xme:iwibatf68kGdE5U-eFnc55cS9WgxzU8GRIjZCs3ctG1Tp_E3P5H0Z2f8Vheym0D0X
    OhIJUVDBoUEUPkNAqfzlhLJODK17u__EcVoeozHeLcGTxknXH2-220>
X-ME-Proxy-Cause: dmFkZTEk2ZDq5jM/G5+HzqROyvveegX1VnX6qt1qvDnM+p7ODCF4aYZK1/G8pBR15nuuEg
    1Qby68NCgcMwhuffLvP4L7s/vQ4WFEJihfOpU4Lgti+lgifk+H1fh3bSYifW78Xk8o7/fs
    pp5mgcu4dCQNFFj+K21w66cuHD1lsqZ0KmH2A3DTfLW6sMUDVYetg06AuhsAEvxCZxRGlK
    6moFSm1HhyhkX4MDBWVkczKv3uoajY7Yv+qihapVSslXRm7jbXU14nVnlHkrkwCEDOnDiT
    XonzmooEWkxEwtVFDRjpYgZkl8JhxMAxBGdHyTT+ZlnVo4tuD2WBDVnAWM8bX5b4KV95rs
    xcxHoJj3niFE9VYrdgy2Y2+hrsj88hCEijYJ5J+KzU7bIGBsF/ESnxoIclK9lLciwT4Ppn
    wQHxVQpnwUHUW+vzDGEUSeklBhoERv3sbx7TC2uRCLDB18WBTynd84J0y86uHZPjBFh8Ut
    fwNKbm8EobtzAX2LlMXo0C+AB0h0ibwLzpd0gHZ7rV7w/pkbOCwtMXKZknAk5Qewp9wluw
    qZ3vkQa7uQRDfFBLjWl0hP+qYPX/94x6+UkRSh5seyMLoitF2KEiTDVSMTayqrbWIiQwfr
    AT95hWwvcnHp3Eqd1d53/mrC/DUZVEY6ecJKTSxeTUPXZsrLp6Y9Od4RZYNw
X-ME-Proxy: <xmx:jAibau7pXZ-4Fgg-n6D5A2s3mC105xk-LyYowX573Sz2MRSqIoIbsg>
    <xmx:jAiban3vBa-JCYKRcbeHfk7NhGCecfjot7JSsD5iUJlZf9NQWkulJw>
    <xmx:jAibaqU7EqnKlWlHlUNzVMYeODJ7zhLZ8B5CxMBVwBA8TWq1G69ZXQ>
    <xmx:jAibai6QIDKTAUcJ7Q-wujMH6oYAtcOPFB5tVWYhwTeO3Ksa3VEksA>
    <xmx:jQibapPDEXFMO3RRXPOZK9nSgB0CA88b4iGz8qok7ug5aKVo1F24h2_E>
Feedback-ID: ifc014702:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CCF85F80082; Fri,  4 Sep 2026 14:06:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Sep 2026 19:05:43 +0100
From: "Ramkumar Ramachandra" <r@artagnon.com>
To: "Git List" <git@vger.kernel.org>
Message-Id: <7fb200e9-ff28-4b22-9d9e-dbdec83c2835@app.fastmail.com>
Subject: User report on git 2.55.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I recently bumped to the latest version of git on macOS via homebrew, and here's what I've noticed:

1. git-replay now updates the ref, simplifying my git-reply-checkout script. Someone on this list recommended it to me in response to an issue I had a long time ago, and I think I can safely say that git-replay is an invaluable tool. Thanks!
2. git-pull often fails with a dangling remote ref error, and fails to update the current branch (main, in my case): the workaround is to reset-hard to origin/main. I'm not sure if this is a GitHub issue, or a bug in core git: I've never encountered this behavior on older versions of git, with the exception of submodules.
3. git-diff sometimes exits with 0 code without printing a diff, even though the worktree is dirty: the workaround is to run it again. I've never encountered this behavior on older versions of git, and I think it might be a subtle race in core git.
4. `git checkout -` sometimes fails with an invalid ref error after a pull, where the previous branch is a local branch. I don't know if this is due to a background git-gc with some behavior change, but I never encountered this behavior on older versions without an operation that would cause this.

Before digging further to find the root cause, I'd like to know if there is some explanation I'm missing, or if these are known issues?

Thanks.

Warm regards,
Ram
