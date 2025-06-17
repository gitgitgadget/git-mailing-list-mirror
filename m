Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C82DBF7C
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158842; cv=none; b=cTpm/X28zVhe8W4uhczIFVg0RScjooOjFkemfsqZIQ5MNH7MbUyC+aPAmvcYCcGffw4FFh9CfYTtiQnMPdvsDYlJk0826vf1bZyYsrPWCl8Fzn3qrNyqR/CxjhjgauGQQDgOiIwm6PHROjfgI3koa+hx7tZb+wwu6mRCgqNA3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158842; c=relaxed/simple;
	bh=JWzhd9dGMkwkPkg3parCJOvvDEUawJrobmuhXAU7Q60=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=upGdg4TegPs5QUOU2CGeaAW8a/ZmhK6n78ToFa0gbXbTJBM9rZxFdWREyB9LMvjqa6vG2JeQs43Tsi6A1tO6PHQFztY5riBIpsXABKPwH77VW1jtjyQpMDVukJXfwvRe5YKxgZ6bWmuV6SFt+9AyP8O1LC4ELUpTLPSvTYKSUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VRLD5DsD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dJ/n9BJF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VRLD5DsD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dJ/n9BJF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VRLD5DsD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dJ/n9BJF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VRLD5DsD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dJ/n9BJF"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 584401F391
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750158838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3NAWGMTJg2ugW9eI9D7FcAjnfQgbCBFnwlC9F0I1BVg=;
	b=VRLD5DsDCQ8lvTdoHrHwZ/q09dQwGoeWhhYaPpMGM7gMwGL/O9+BCuD3D/WvRXLfdXXH5A
	6jIgVc5YetCUW/oIHK/WyUAylbajOGkEoVWsekAuvKeliANtnqVPUBJ3K09I/sGt6Z22bi
	dLvL6o7uzFphUozUk0H6yFcW6BnZ910=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750158838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3NAWGMTJg2ugW9eI9D7FcAjnfQgbCBFnwlC9F0I1BVg=;
	b=dJ/n9BJF9bcI1bVpRvwGqeauGclSMeUncAWr1BmcjngH7ShznZi5fmF66jDSAE5dX+vaVf
	BBc6g3OTHDUY34Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750158838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3NAWGMTJg2ugW9eI9D7FcAjnfQgbCBFnwlC9F0I1BVg=;
	b=VRLD5DsDCQ8lvTdoHrHwZ/q09dQwGoeWhhYaPpMGM7gMwGL/O9+BCuD3D/WvRXLfdXXH5A
	6jIgVc5YetCUW/oIHK/WyUAylbajOGkEoVWsekAuvKeliANtnqVPUBJ3K09I/sGt6Z22bi
	dLvL6o7uzFphUozUk0H6yFcW6BnZ910=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750158838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3NAWGMTJg2ugW9eI9D7FcAjnfQgbCBFnwlC9F0I1BVg=;
	b=dJ/n9BJF9bcI1bVpRvwGqeauGclSMeUncAWr1BmcjngH7ShznZi5fmF66jDSAE5dX+vaVf
	BBc6g3OTHDUY34Bg==
Date: Tue, 17 Jun 2025 13:13:57 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: git@vger.kernel.org
Subject: Rename detection fails on symlinked files
Message-ID: <aFFN9UHCspTjliMv@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-3.74 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MIXED_CHARSET(0.56)[subject];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.74

commit 5d51b10d8b5206ef5eeb9d214237b2ec2e0b789e (HEAD -> master)
Author: Michal Suchanek <msuchanek@suse.de>
Date:   Tue Jun 17 13:08:51 2025 +0200

    rename file

diff --git a/somefile b/somefile-renamed
similarity index 100%
rename from somefile
rename to somefile-renamed

ln -s somefile-renamed somefile
git add somefile
git commit --amend

commit 377d9bd045aed61c7be55482f3c98f8f9d04a33d (HEAD -> master)
Author: Michal Suchanek <msuchanek@suse.de>
Date:   Tue Jun 17 13:08:51 2025 +0200

    rename file

diff --git a/somefile b/somefile
deleted file mode 100644
index a53032b..0000000
Binary files a/somefile and /dev/null differ
diff --git a/somefile b/somefile
new file mode 120000
index 0000000..fc49048
--- /dev/null
+++ b/somefile
@@ -0,0 +1 @@
+somefile-renamed
\ No newline at end of file
diff --git a/somefile-renamed b/somefile-renamed
new file mode 100644
index 0000000..a53032b
Binary files /dev/null and b/somefile-renamed differ

Can the rename detection be fixed to detect symlinked files as well?

Thanks

Michal
