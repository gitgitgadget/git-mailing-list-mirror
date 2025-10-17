Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCF1758B
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665964; cv=none; b=B2te6ovuOndeTd6buaD9eElD3P7hx0Z8AYiYaofBAyAoRanlZaXwZPTtVmhRulhPX2jG9sFr1Xwh/4x8aOOdkIWuh3rS7PKPWiUYoPTq4dZyS8xweo4Tu5DkTH96V//nZX+WWkjrPRns6JrNKBOMwdsQ6QrFmgR5yMr1qi8rZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665964; c=relaxed/simple;
	bh=dag9QPAgcZWgdk3tPns3ET4iL0H+PDVe+fqYfbTOwac=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=KbhXboiYZ4+oIZUDtSI5P57hlyI9mn+5Kd03aSCtKqXfXzlhu56HWIEn3Woxeh8IGI8RHIMWELwVAePO55cnHd6q9UUq2pm4ITwatmF0cA+ZDNO0hiRYi8brQYjwbC2m86ZSUbvMsnr2svbvcj5DEtbPO8iOySrhYUJzUNKpH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=MWcxG/l0; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="MWcxG/l0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1760665956;
	bh=B2DBkJG9d2OqiuFQ8fenJRdMjsiCjbhA21OtapawQpU=;
	h=Subject:From:To:Date:From;
	b=MWcxG/l0M/qDwk1M1kwFZOav8mfu8SG+PCNl1ULe6Gnb1DjVLJYQQEcyxabT8bjlR
	 neUT/+PZxp5tXcXXr7V55uYFcftNLW/Hs7xsNFRUcsCvyUp8EUSRsWf/UoiFahWNYW
	 ZPDzYuX+eS7ARnIQcckbGqcB1hSaz0jP4NmudjOs=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B943966218
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:52:35 -0400 (EDT)
Message-ID: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
Subject: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
From: Xi Ruoyao <xry111@xry111.site>
To: git@vger.kernel.org
Date: Fri, 17 Oct 2025 09:52:32 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

When I test git-2.51.1 I hit a test failure in t7528-signed-commit-
ssh.sh.  Running it with -v reveals:

unix_listener_tmp: path "/home/xry111/sources/12.5/git-2.51.1/t/trash direc=
tory.t7528-signed-commit-ssh/.ssh/agent/s.fTyCxA5V6V.agent.dX2yNWQUX5" too =
long for Unix domain socket
main: Couldn't prepare agent socket

So this seems an issue in the test harness.  Is it possible to fix it?

--=20
Xi Ruoyao <xry111@xry111.site>
