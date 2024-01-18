Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A8208A6
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564974; cv=none; b=s2f1CUZHnOj2QoGsSizwv8IbFLyzGJwT0sAV0fYoV/Y9Y0XT/uKCnMKlJci0NFqAZZCHPqzkBD/CbfQmIfGpi3ekwQegh+oQM+SrWZk1Mhmasjol7eqOnHifDLXo/zM9zBmQTuRN/U3D4BIkMtKN+W/Gv98wiEntZe3ViczRtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564974; c=relaxed/simple;
	bh=07qIZiD7zRorqtCaKD/sULqNYXZg2bRzYa4Zsq5xwpI=;
	h=Received:DKIM-Signature:Received:Received:Received:Received-SPF:
	 Message-ID:Date:MIME-Version:User-Agent:To:Content-Language:From:
	 Subject:Content-Type:Content-Transfer-Encoding:X-PPP-Message-ID:
	 X-Rspamd-Queue-Id:X-Rspamd-Server:X-NC-CID; b=QZZl+fH8F1aiBRjN0224CPp/uzifE9ajUqMOUR2v0tcvM/N9icKlyquYLW+BHysV0oEAofaT5bYkI6KSwwL8g0xzrWjTNiOZxe4qQIQuWNzh+te3wufGlKuuFNQ6yiSUJpZVA/PFhnLWwkmfvQbSogXNPxDS8gojV6KF5cc44ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=MBT00N1T; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="MBT00N1T"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4TFwG92xNwz61nr
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 09:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1705564961; bh=07qIZiD7zRorqtCaKD/sULqNYXZg2bRzYa4Zsq5xwpI=;
	h=Date:To:From:Subject:From;
	b=MBT00N1Tc2OTn2N26wWvhjvbPwOLusdXsRHAp7cBt/Qu0hsbWCStL6X8C2CKZ22lm
	 Hu8Tv4Vv33Ca2sA2jXgCTBnM/jtfZbmlb/oxIiEnqWSvuIf3yR4YsvvZrOwSI0f56W
	 QuDl8R774nW7gOiarTo2Gx5CNB/qXvb4OkW/rbDxVdBsBiB5tGsDANRvwFCa8BpJMf
	 l/MpeT/ggqUu98Rpp+agIBe+ofY+rIAIZ3r1I8a1yCrZWvdFTc1DA8f8iVeej1JSAF
	 KaEtv3Fk2u2HUI0wKHYp/Eq3dq0vHeB+sKaNjbBMQfjdhiNZtQ8GivBvLowhdPWgP0
	 ec77tGMTGfBtw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4TFwG92FJQz4xNs
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 09:02:41 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4TFwG90Wr2z8sh1
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 09:02:41 +0100 (CET)
Received: from [IPV6:2003:cf:cf12:700:c0b7:a2c4:a056:7bf6] (p200300cfcf120700c0b7a2c4a0567bf6.dip0.t-ipconnect.de [IPv6:2003:cf:cf12:700:c0b7:a2c4:a056:7bf6])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id B9102100861
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 09:02:35 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2003:cf:cf12:700:c0b7:a2c4:a056:7bf6) smtp.mailfrom=rdiez-temp3@rd10.de smtp.helo=[IPV6:2003:cf:cf12:700:c0b7:a2c4:a056:7bf6]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de>
Date: Thu, 18 Jan 2024 09:02:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-GB
From: "R. Diez" <rdiez-temp3@rd10.de>
Subject: git fsck does not check the packed-refs file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <170556495682.3940.13502137905897943463@mx2eb1.netcup.net>
X-Rspamd-Queue-Id: B9102100861
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: L4iJljwBGXLqOrOOaiXFckud11WUTYQE5r8WpHHx

Hi all:

I have been hit by an unfortunate system problem, and as a result, a few files in my Git repository got corrupted on my last git push. Some random blocks of bytes were overwritten with binary zeros, so I started getting weird unpacking errors etc.

It took a while to realise what the problem was. During my investigation, I ran "git fsck", which reported no problems, and then "git push" failed.

One of the very few corrupted files was packed-refs. This is a text file, so it was easy to compare it and see the corrupting binary zeros. But that made me wonder what "git fsck" checks.

I am guessing that "git fsck" does not check file packed-refs at all. I mean, it does not even attempt to parse it, in order to check whether at least the format makes any sense. Only "git push" does it.

What other parts of the repository does "git fsck" not check then?

The repository check is suspiciously fast. Is there a slow way to check that a repository is fine? I mean, something along the lines of checking whether every commit can be checked out without problems.

Best regards,
   rdiez
