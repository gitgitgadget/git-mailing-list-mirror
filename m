Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5A2C87C
	for <git@vger.kernel.org>; Thu,  9 May 2024 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220852; cv=none; b=jEWEDxvANb6KHgWWHqVpo1PWMBnSiwUYWs/2h0YN9NS4t7WD14BTkL2d6/Fdox34O+jmjJZ/P1TdtlvO62yauQtxlwIlEX89dhKApfvFm9xV+h4H8Luu9khsTBeeS9qOtuUUHfDygv338Kt1Alm3WMBZs1WVgaPHbD6JG4bvqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220852; c=relaxed/simple;
	bh=0RRxZ0VDQtCkY6Jsg7N9vdFQ3VHHvKdtNvU8jqFI+e8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qobLtQeuxm+M+PhDByh0PaseJZBRZP/JCnS78I3Fdjbs2+KnK4ZADg8Bln1i0DeKAkN5SmbiRKChtNep9i2/lMcUc3HIa+OoGrDlUSGHsN2lDjN/PfIqFjON3Mwb/WK/Ow3fCnby6y3noG4enA5KQElGJzpRBdUHUnzdO2tAQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1s4tIF-005Fgn-1N
	for git@vger.kernel.org;
	Thu, 09 May 2024 02:14:01 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1s4tI8-004RI6-38
	for git@vger.kernel.org;
	Thu, 09 May 2024 11:13:52 +0900
Date: Thu, 9 May 2024 11:13:52 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Subject: bug: git config --global --unset doesn't unset configs in corner case
Message-ID: <20240509021352.se4u7ajaolveyyjf@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When both ~/.gitconfig and ~/.config/git/config exist, git will read
both. But when using `git config --global --unset`, it will only touch
the first one. So unsetting config items from ~/.config/git/config is
not possible from the command line when ~/.gitconfig exists.

Mike
