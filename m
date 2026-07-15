Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40741A54E
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141343; cv=none; b=YLgQBX2PFe2l+qk2c3/HKT7brDpPwgjZjaPOUoWK0MUCk9uu6F+zg/DpQRjN6pSk3BJJDAFoRa8td0jUx38JRSDcTm4lFAQB6Hc6jOfUVk3/dLJDQgYm6JKtxjAD33u2aDKiWREVQoEcfPWVCvE1MgDl5eam9p60teJ313ZRe6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141343; c=relaxed/simple;
	bh=+gkt5lLAvxwFmJFAc4kgViBgPQmU5aPvaRPyqpF3G54=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rfzicr6RMHOiSsZKZqZ6cs2WMkxranUHZ8uR3nsjtzaxYR2WBqXGAS2Dbgz5qklz8S4mpy4kzTTjP3JZqUJMvns1OXFAuQXbBlAmc51az5czvi7tN04gVXNSuAZ7aB2xxvUQbYPa2bVOCnA0eZgvt280XDobmcWQ9nisHARBROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCfqD1RR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j30TrVCU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCfqD1RR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j30TrVCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784141339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dy+DzBq7z+RvJO53R9hltpa/rofJ2oXRgWcUvUdNtSk=;
	b=dCfqD1RREATtg1Q0d+EUxSgdFovw+Q6hEe51td4tyG5qEOBi42uYHbfU53mTFSWVM46YbM
	KJQxUyQW/Ra20eycfpc2+mpc6t0JwQC/wB3vUzxtpsUBrtRhjuscpbE6WVLI3CI99yeXZT
	Z2vnWxcLvKf+h08jhRVCEg2b6EJKi6c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-zCUtxJBLNPCiq1rT9GjoHA-1; Wed, 15 Jul 2026 14:48:57 -0400
X-MC-Unique: zCUtxJBLNPCiq1rT9GjoHA-1
X-Mimecast-MFC-AGG-ID: zCUtxJBLNPCiq1rT9GjoHA_1784141337
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f113592bf3so46132266d6.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784141337; x=1784746137; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dy+DzBq7z+RvJO53R9hltpa/rofJ2oXRgWcUvUdNtSk=;
        b=j30TrVCUi3AWC+nXg48fQ7eq2/Ot5kXhwFADnbQfklr/5fy04gariOI12/C4kWbOkF
         k0RRq4MYVcJQZSQMRzeYuYHkGZRxgcGmsWsqid8WCxKwQphdE+rwIPooxgm4c6XMwuYe
         Pfviel+By9P/wFn9MDFvOTl8HJs7gJsxQgfkaOFznncgk8NfLdU5T1F99Xpxl1Bcixd/
         a+JZzB0Al2QBsvFC3jEr6511XSGIDNjgVRKM6wvb1eQrxDFiR61+F/B09ai8u4iXEM/5
         dN0j0Bgu7ceMEfMwgGsWpHhx/oAD6KllL/m5aMl7SzTkfZL7K77GhiJ2y/Ow2g4A++oW
         4m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141337; x=1784746137;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dy+DzBq7z+RvJO53R9hltpa/rofJ2oXRgWcUvUdNtSk=;
        b=fIUVzTqyOuZeasZodZ7tZWWaC+XwhArvrMU7X2+4zE3/0vIdRKYPCU4OSNqKQKyuJD
         kexAlfTn28R6kpYEVxzfy+iP2KC+1djfdj3an7L715Nk9ob3hAEYjJAZdL76K+zmkVT9
         QK/0YsEi0uF4m4ma3zo33JsFezkqJ8kgbzo2NmRO8MWgm7HVNGWuj5bXkDjGXBYVlbr9
         i0Z0tQIAH5OqBXB1w83rU6VWihMEXF9b3d2KTKhr6fHrLuSmS6b41hg0a4i2wgE7LO38
         aU8YIJJfLFmXKnBFvCz34DBy6B9cnfw+U88cHPbYXLkjhWZgAtg1k+pDIfiY2Vbdd8qH
         BGHg==
X-Gm-Message-State: AOJu0YxWVijTeptrbBT51+v44yi3+ZzScCkjMHlWKD84wAV4HkMua5/v
	c1u+pRIkdRyrJvHfMPl4ys2/G67O++C776M/eEQMcqRWf6Hv3dKvQ0ElxR1eYUGBdzlx841+FcJ
	F8xOHB1wnUePou1+YGSCIMqp2vpFVPAFwx3n+bbGku1MWa0ROJK/ZjZ+ZWwj4X0hGNP9T1T1zNX
	3cleEasQrlPTwt+/VKZr5bTSiZRhs4qAsffLqvgw==
X-Gm-Gg: AfdE7cluw6OBqbt9W1X9QKnJujLTiwsoRTh57HSOgGTCx7PFAyt9lVprXQWfrkKQMsW
	p4hIKnZ+Vbj3yL/u+Fuvg7CW5hpWtnG8vpnvJ/YtPuvXmTfahKD+WRAizHVDTtRUvPNYVnS82EI
	Tns52rK+wYFrfyQM7hCp1/ivJDvdUWem4Fn3HdY24+O9j7OsKTQtV86VaUPquHpWlXi1NNPI6hS
	tPOQtE0f/M09v097gK44H/WZSf6+Uo6ERJnmXic0MwAeFPuHUWFHNkN7qNo+EbRrI7+6FuUDCdn
	z1ZEL6T1jqMPoZOCKOa76gdORDMbyYq5HpUkx9KbHv1Ua06P34JEo+xeqSQEILJZqKDFzyiKvyz
	HpSd/5vWi5x0=
X-Received: by 2002:a05:6214:411a:b0:8ce:f1b:74ec with SMTP id 6a1803df08f44-90402262ad7mr200320866d6.25.1784141336907;
        Wed, 15 Jul 2026 11:48:56 -0700 (PDT)
X-Received: by 2002:a05:6214:411a:b0:8ce:f1b:74ec with SMTP id 6a1803df08f44-90402262ad7mr200320486d6.25.1784141336268;
        Wed, 15 Jul 2026 11:48:56 -0700 (PDT)
Received: from localhost ([2607:f2c0:b108:7100:8918:df5e:c83d:f5cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-90749b913absm62933556d6.10.2026.07.15.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:48:55 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:48:55 -0400
From: Peter Colberg <pcolberg@redhat.com>
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
Subject: Git 2.55.0 breaks revision path filtering with --no-walk
Message-ID: <alfWF9cBPESuLBgS@earendel>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Since commit dd4bc01c0a8f ("revision: use priority queue for
non-limited streaming walks") in Git 2.55.0, git rev-list
--no-walk no longer considers optional <path>... arguments.

https://lore.kernel.org/git/pull.2127.git.1779897003.gitgitgadget@gmail.com/

The following example lists all commits between two Linux kernel
releases that modify paths within a given directory and further
modified paths outside of that directory, too.

With Git 2.54.0, the second rev-list correctly filters by paths:

% git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ | wc -l
2026
% git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ | git rev-list --stdin --no-walk=unsorted -- ':!drivers/gpu/drm/' | wc -l
146

With Git 2.55.0, the second rev-list passes through all commits:

% git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ | wc -l
2026
% git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ | git rev-list --stdin --no-walk=unsorted -- ':!drivers/gpu/drm/' | wc -l
2026

Reverting commit dd4bc01c0a8f ("revision: use priority queue for
non-limited streaming walks") on top of Git 2.55.0 restores the
previous behaviour. Specifically, the following hunk that no longer
invokes process_parents() in the no_walk case causes the regression.

@@ -4390,12 +4394,13 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			break;
 		case REV_WALK_STREAMING:
 			if (process_parents(revs, commit,
-					    &revs->commits, NULL) < 0) {
+					    &revs->commit_queue) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 					    oid_to_hex(&commit->object.oid));
 			}
 			break;
+		case REV_WALK_NO_WALK:
 		case REV_WALK_LIMITED:
 			break;
 		}

Is the behaviour in Git 2.55.0 intentional, i.e., was --no-walk never
intended to support path filtering, or is this indeed a regression?

Thanks,
Peter

