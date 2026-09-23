Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7F47ACD0
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200044; cv=none; b=VX1OGaUOqrFGbzepFMPMEzDHEj2VS7blCWTOnKJyp27QPuQKeHoLS5XlCwl2wGvLceuLVR6cH+l+HRVHz8dkLsWjEtoWBz5PFOXWy3oc9+Tbqq6ECvwoLgtplBa1MHcImZ6xzOsKJ9YDRKVB6/2bQKDxWnOUOimbpC2nE8PaYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200044; c=relaxed/simple;
	bh=g+M5rvbMrt2oXmGoQZh2+sn9YGqGFyP+4PJT3dtSGO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PnGug145Tn8gsj4iXhFOf5HGDqhiCwdi8hsZwMlIRzkNDhp7ZQynB/Ab3XMwBEcXyazTQmNjE4IzLTgNz9iJTte/Q8j/VZypMZBZv6JHrsd1ZQ9Noooah2sM49pswSDhcg66oNc+PoNOSxlqVqyjSQS2ZS2yeL1Jf7m43z+08e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rhS5f442; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wj1J7d8Q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rhS5f442";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wj1J7d8Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 039E6EC00FF;
	Wed, 23 Sep 2026 17:47:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 23 Sep 2026 17:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790200039;
	 x=1790286439; bh=2YSFLuOLwOVeMXx7Ox9A4tBxkICqlbvO1z/rjcvckVc=; b=
	rhS5f442h+83Jz6LK6toyotvwYOprxxi/GPdJay40IaCN4/XEsTbD0qXHcyY3zjd
	QAWL4ktn7c1UOvIzo19vqGzysOI8m8DMj+hZCD/zq48mkJ1HrowsHy0Wwdm/vLaI
	24jkdcA+HmyLjw2zJTRmIEwMzmBxwv9+zA3snkpvOvyz8sHyv5iLNjvVmP7lhlEl
	mj9V1AhEcaP9+lQsN9W3YbQ4M62VaUKZjaLnhHe9UAvB8k+NMGfqmHksGx9jyqv3
	9nmzlXKiQbs0hSm/utnrR1qoGBRHBegI0th+HAc3a3NUwR1nDIHYEQI15634gmWb
	qEUBXovOyxb2jC6uV1R8eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790200039; x=
	1790286439; bh=2YSFLuOLwOVeMXx7Ox9A4tBxkICqlbvO1z/rjcvckVc=; b=w
	j1J7d8QD748SLlCw8+rKEy5mqRC8cCTKMok4c+cs0GvB9g2itiDsS0C0KFzaCYwd
	nxfPsZezHYniCSr14iyAoN0I7jrvlRQe6pWEQHyUg3VY2ljl/zhECAKgrk9rSICe
	2QiEe9nREAywwVRBBSzqxlq56m6z7dfN1glaXnUUEhg2siat9DTMJZZO0SfGJDm+
	6Zx1zZWQIILyi39JaFF6f51oN8N3knqIbL7CLdEezAui087aMc/V+H+nAgrsTy04
	+r+KlGzS84G1WGPey7YZaZbhNxas4nxwMHXxYEIh0ZBmF1XAAzIVbEyKQDOu5LBw
	/RMiVCsaKBgUj5ZL+JwnA==
X-ME-Sender: <xms:50i0athmpXcvB9psglOhSXNa--6YwEc4rr7jbLnHxtTNHBjtKQwBFQ>
    <xme:50i0akTewKk3aFqRIvSvSanU7Ez_bhtFraLxTrqcAY4O43ZAuhPNrg9glD3R-H94j
    qPavJGsAMfZQ5Wujd7Ou3TpAmZIqiWZxauD2VgZ995afv4dojNuC3g>
X-ME-Received: <xmr:50i0avWWw1gSQbF3TNlMzZVhKgPBTC2FpLtaxnNbsEC8g8E8iTQ61JtxM2J0i9RLqeIvSKOsju00js8H5FSgaCWWLOc1OZjEtX0n>
X-ME-Proxy-Cause: dmFkZTGEumRp68M0AggadBm1UFeOtEXFMbA3KAvVt1ahaRYigRMQ7YEVghT7n8y3p9mLbs
    d4+LgbYE+PNV+cO3ZD2nnbc2PSTss+IPXEL3PlUO/u3flddpMw0zMYTVRty4F/zNBtV4hB
    nqX9omI4adcRlwxivyPu+8u0QBKanat2892QN/L7QjxfTQ0BVMDnGlHaK+Zny27WhnXsR1
    9uD63BaSbGhAPud2nmzsQfewt7NApLN0ZbdTqYInQ6u1OZIa97Yka4PjnxWyMDnBxD6Zwb
    mjdGbtFs005Qz7xKmY9RaxpJFZ+5rWGaBinyg7+GDs8lc+euJ+ieu8o0X8E0NWXrQ+WRGd
    f9ukLLElzqgeotuMQpFXUJ2Ipg+1EmdPom2Q3F8jdQp2ODhd1wNqJfu+udYfGQU7PiLQvw
    OcAF7cjpUHiwhleBxRA8krSlIEfmsJkRt0KioPrEWUvNEq6G57az4JLKkVrvIId0t0wLUD
    LWVGamqvkcmSiAh7qKthvibEiwiZri92ZNT+aK901cQsC4eKCE9eDvA/Z/EvLH9ZpuTcuQ
    9bau9MkgPjJL37nlKxdq+52iJmp2JgUy6N3uFmBaUjZ5NZLyVyB6Z82HDBDTZyBq1nB3nW
    sUD6XwAhsqV+k9sg+doX10fIf+tXyxZs2JEHo961yWPTs4s3vcQpnljZm06w
X-ME-Proxy: <xmx:50i0aoTScrOOTThsps29p4O0rV28D7PUnxu1TrXkJdcK-CGDUw6crw>
    <xmx:50i0apkOa2KffXEotI6wGJhRGCiQ7dXCARk8oSNwSkJJBumgObpPYg>
    <xmx:50i0au4MDIzcPdqLp09rH5uZpqQZ74WfK7gAFGfZ28OcJzT5siklVg>
    <xmx:50i0aviwATjEUSFSi6uqqIGRTROnPV0kxRDlKS89n8vb4Df0IfhmWg>
    <xmx:50i0aqXkK6mX4TsPFOnyiJo2yqagpAgUDrjN2dXoHK4bgery11-jvKqw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 17:47:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: graysongordon-gl <graysongordon1@gmail.com>,  ps@pks.im,
  git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <arQ/nOH+o3XwQFD/@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed,
	23 Sep 2026 23:07:40 +0200")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com>
	<arQ/nOH+o3XwQFD/@szeder.dev>
Date: Wed, 23 Sep 2026 14:47:18 -0700
Message-ID: <xmqqwlsb63o9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
>> From: Grayson Gordon <graysongordon1@gmail.com>
>> 
>> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
>> OCSP "Certificate Status Request" extension and any stapled response a
>> server sends is ignored, including responses that explicitly state the
>> certificate has been revoked.
> ...
> This patch was merged to 'next' the other day, and the last test in
> the new t5585 fails on my system.

Sorry about a premature merge.  Since we are not in a hurry to take
this topic in (or no new feature topic in general), let me revert it
out of 'next' and give it a clean slate to try again.

> ...
> I added that 'cat err' to see the error message.  Turns out that 'git
> ls-remote' can't even find the repository on the remote, but the
> prereq is still considered fulfilled.  Is that right?
> ...
> This time the error message talks about missing OCSP response, but the
> prereq is still considered fulfilled.  Again: is that right?!
>
> Instead of the lack of a certain string in the error message, is
> there something positive that we can test instead?

Oh, that is a very constructive and useful suggestion.  Greatly
appreciated.

> So this test case fails for me with the following trace output:
>
>   expecting success of 5585.5 'revoked certificate is accepted without http.sslVerifyStatus': 
>   	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
>   	test_line_count -gt 0 actual
>   
>   + with_ssl_verification git ls-remote https://127.0.0.1:5585/smart/repo.git
>   + sane_unset GIT_SSL_NO_VERIFY
>   + unset GIT_SSL_NO_VERIFY
>   + return 0
>   + GIT_SSL_CAINFO=/home/szeder/src/git/t/trash directory.t5585-http-ssl-ocsp/httpd/ca.pem git ls-remote https://127.0.0.1:5585/smart/repo.git
>   fatal: unable to access 'https://127.0.0.1:5585/smart/repo.git/': server certificate verification failed. CAfile: /home/szeder/src/git/t/trash directory.t5585-http-ssl-ocsp/httpd/ca.pem CRLfile: none
>   error: last command exited with $?=128
>   not ok 5 - revoked certificate is accepted without http.sslVerifyStatus
>   #	
>   #		with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
>   #		test_line_count -gt 0 actual
>   #	
>  
> libcurl is 7.81.0, apache is 2.4.52 (whatever is shipped in this
> slowly aging LTS...)

Thanks.

