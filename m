Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BCF1E861
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708210847; cv=none; b=Zyvzgjom/Ez6wKJFtH9fjW7m6/m0GaLvmUGGjgCjeqrDtdZP4PWnCQV1XOmwLTxTx333GAlOiw7N/gVpk1mL3+eiG5pNqMTbH16hA73AYlyVu7y2MELKD1WaTpA36JMR7UF3DrSKAVZHjwFtCIgn88qoW8MSPt4L7kYLkP+5XFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708210847; c=relaxed/simple;
	bh=cHRhUdtVHBvEpTv9Thk8N4mTJNKY8WfjiuhHIV5QJBM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=tthZFfEl1ijU73Ddt8wIG6HtkEAGlx4M5wv/6Ymjl5cbrcthSSF3D8/bZ85aVhVMvJMOxpjp+pHLzGsOZ5V92eKG72a1fqxMECUpi6+rCyDT/y7GnIyo8agiPKdRgxTo3h/ozTQtbFyyoAqs3JWCvRSH2mEyjwjgCP32tRBccx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de; spf=pass smtp.mailfrom=vodafonemail.de; dkim=pass (1024-bit key) header.d=vodafonemail.de header.i=@vodafonemail.de header.b=sUkrKnsz; arc=none smtp.client-ip=145.253.228.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vodafonemail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="sUkrKnsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
	s=vfde-mb-mr2-23sep; t=1708210317;
	bh=P+jmKb9KEXlWpuq4qUWxNdfJJ93R2fmxk2X8wFH2QYo=;
	h=Message-ID:Date:User-Agent:From:Content-Language:To:Subject:
	 Content-Type:From;
	b=sUkrKnsz4+DhYmL0P4lKdxxUSrDBMRUQzIilCnIEnl2OA7bprbGEDP3lXJs7Beml4
	 UjKMP+n2G1/mXab536N7qrXekT9mFfW+z+tr1gBosnJr5/2kMT6dgYWoqMgIkIENqF
	 LweqyDCGoJ0jRD73af/2QuEDerQHUQCKPnHv7j3Y=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr5.vodafonemail.de (Postfix) with ESMTPS id 4TckZP5YZgz1y6H
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 22:51:57 +0000 (UTC)
Received: from [192.168.178.41] (port-92-196-31-108.dynamic.as20676.net [92.196.31.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4TckZK4pm1zMm7F
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 22:51:50 +0000 (UTC)
Message-ID: <de38341b-f69f-4d3b-a4c2-4443e1ec1f6f@vodafonemail.de>
Date: Sat, 17 Feb 2024 23:51:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Schmidt <farblos@vodafonemail.de>
Content-Language: de-DE-frami, en-US
To: git@vger.kernel.org
Subject: Calling "gpg --sign" with loopback pinentry in some scenarios, but
 not always
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 570
X-purgate-ID: 155817::1708210313-B1FFE6E3-1D51994F/0/0

Hi.

I'd like to use gpg loopback pinentry mode when signing commits
or tags through Emacs/Magit but default, non-loopback pinentry
for all other cases.

In particular, configuring "pinentry-mode loopback" in "gpg.conf"
is not really an option for me.

It seems that "git" does not have any hooks to pass arbitrary
additional parameters to "gpg", right?  So my only reasonable
option would be a Emacs/Magit-specific "gpg"-wrapper that adds
command line parameter "--pinentry-mode loopback" to the wrapped
"gpg" executable.

Any other options?

Thanks!
