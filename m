Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160015D5B3
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007887; cv=none; b=knzVPLdNk8HZDRtxSLXBIxUoVVN0iQlNZfLuBpexqvVRm9FpbL3xFwpZtvuQ3EO3zriSkWyKCWKAAv9lS5Dd3Mh1d5TSzJ3dYqmIhW3GbjAl7oYrAsKqow40Jxd6WFCm12FqpHRVSR3B6hjmXD7AKGOfJryIwUWNj6GPx7KYiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007887; c=relaxed/simple;
	bh=55hhk/GA7mofodoQENHNAwKO6OevvLLVxruKuljmKwQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LrUolc3nUnh1bNfYjK0RH2ThbnsuczTcVJt461MKiNuhNgN/rXHn+JwQR37Ye9ha5V9hiJzIQlrwS8JYJ2NyxUDTFIxVOXfuXWA2m6De3cmwnmagXva3a7sXimYjIFUabcSXxAczWtnJC2+wHvX/7u7Y3h2kNtZ/AjAqNwijQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Hww9y5Eb; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Hww9y5Eb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1720007526;
	bh=+5xBpaHVZ5q7cBGoQa+MnpNvkX/FdbJjxRoIx0+oxfg=;
	h=Date:To:From:Subject:From;
	b=Hww9y5EbfpPYAzV2sB6JAj+r44MHFmIu8/TVAj+4BMJ/LHsGBi8UZsVg6316rEGWq
	 lh6N0WzFEpGcbPe0oUPktvfuGqc5jXvdPyBnovWrpke1zxcL6/ylXLa51aYBI9bH9R
	 xKjOtff+jvG1L7V2G1mqr1efvflwcPPbHANCbVqkyURmOlPAdiwH+ntUI0UVfsG5tr
	 rJ5vNv5AtPgmc0rQqtoimNB02RS3AsmqF0eOcjzIimyE8x5yAjG+NDpFEQsL31bJ0m
	 QgVOH8balOnJUcUgv7CXNPz8npdmNRx26OxlnbiCdrFVWhIAKitphvmyvp1laWS+ki
	 VlbKa++U3F6Pg==
Received: from [192.168.42.22] (i5C74DEAD.versanet.de [92.116.222.173])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 2AB043C1354
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:52:06 +0200 (CEST)
Message-ID: <a04b3417-4590-48d1-bc6a-88ca44edb36c@haller-berlin.de>
Date: Wed, 3 Jul 2024 13:52:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
Subject: branch{u} not working even though upstream configured
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: -

What could be a reason why branch@{u} doesn't work even though the
branch does have a remote tracking branch configured?

We have a user who reports the following:

$ git push --set-upstream origin test-456
branch 'test-456' set up to track 'origin/test-456'.
Everything up-to-date
$ git merge-base test-456 test-456@{u}
fatal: upstream branch 'refs/heads/test-456' not stored as a
       remote-tracking branch

Git remote shows that the remote tracking branch is configured as expected:

$ git remote -v show origin
* remote origin
  [...]
  Local branches configured for 'git pull':
    test-456          merges with remote test-456
  Local refs configured for 'git push':
    test-456          pushes to test-456           (up to date)

Any ideas?
