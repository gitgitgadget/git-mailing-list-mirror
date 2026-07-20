Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5B1FD4
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784506838; cv=none; b=KVZe54+AYsOOS30fO2Ma8vJsDWKQivJmgWYKrVtYhFo8KBOvM+/Yr14ItOukqaAqeaRpIhG6T04kOyaGk2wslAjIdR30n5V8Dc8LLxqzmnMAKw2DxH8Rtg4y7mF7J4HDpp3LpK8a40MCfdbPrweeRy/8genwshcjUg3CHQzjJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784506838; c=relaxed/simple;
	bh=j/O+GcjuPphJ4kmDd2UsUpIvAp163x3h00NsJSkD6BM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=La5qf7foi5ACqih5XFzqhi7U6TKp/aQdyTiO/I3s4Cdx8wM2lYcU+rBFXFZvRjiiZpwmIlGJXu6NIediPbE7XCySSxzHkx7O9p2BOMZrqdHdTf7mx+NCyP0cko/dBR3zMedbPiUuHI9+DwJnHTvWYiDEsu7QvrVNu1wwS2k1XzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdheDbDS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdheDbDS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf27856f9cso38344735ad.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 17:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784506837; x=1785111637; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j/O+GcjuPphJ4kmDd2UsUpIvAp163x3h00NsJSkD6BM=;
        b=MdheDbDS79p4a3ZXUgjQITJBh/QAOrdZIjKpY2RMmKZBf46JEPTkSOdnSqjPYbxRdC
         YBxG4wU2wrTVuoOkkNVHqDHimN4SjhBobP2Us9E0KsPp+ycEx7z/OGta/CGvHTNqh2Oe
         TozeM7oFhzpWqaWJRIB1gn8nEqX2SrYa0ZgzuuD914GC0mXX1GlNQHV1As4hwBQ0YpWp
         KRAhsnaZxWPo9SGibC9cBHDDE8Nx4ZO4FZhyyqK2gAmfPz4otqdgJiESxfVun4Ibxd6I
         1HxAFjl6F3yoV18QOopW1vevROX6mc5pVmy7Yh6xJHeYu0oU88pV17m4rhCr2KvE/bKH
         Kx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784506837; x=1785111637;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/O+GcjuPphJ4kmDd2UsUpIvAp163x3h00NsJSkD6BM=;
        b=f4MfQ3lXsn6Tzjid/h5cXKAUDxopvdu1RwCVXmU465bd2EjUN4RkFR3fCHxA8CViRS
         fy/Sd28S/4zEF/0rUuew3Wbi6UfvqPEffomdTOCn+cze2XdyWIwDS4m4tX57MNH7+bAx
         BrsDtZBFnRdN8r/27fky3zDvG3VqPNfnLcG1FxdUd4oSn3vf/2wBdROnh3dVRZsvh7Ra
         DouFCz9lBQStOfLRApQUWCYlt4vV29kdz/r8yghlCoW+EZ/WMPL24JLzCG1le1qQ9OAD
         OZfOhvmtpfsyZ6nJ86tRaDXW6Rnve9+S0GSfr2Z804vkYeIknx59XHsKXFurLRcsHa65
         YNnA==
X-Gm-Message-State: AOJu0YxisZf9yk1PeFa20i2ikhv6PE49Ct55pNSg4fTVNT/2OZshId56
	5P59bc3NvggIzccnutXRGWlpwP+gaE0/BYidiLo5iGULf/8gQyDmTXt7
X-Gm-Gg: AfdE7clYG79Sw2HeOxzLrpzIuXLUw3iuXxXOmNtkogmSZSHHcUFk4Sttn3W8N5jJfAd
	epEcBZ0xHE+/Wg3r8MOtr8XfyQ+L7HZklEPMcHVKwZmpRyClL2hp22Q5OH1fRqp9M06EaaZibsq
	7gNsI93aOvpQ5mrXqGli8z9jx1aGospZ4yrabRGRQTzsuFxllzGrIcT/UGEVi6cqJ7Nhg7YG9PR
	K66we9djkQ+7qHtg2NEWUQPbpEqpdIIleRIjjlUhorZr6lg73B4EkgdH/4yBpQz+pY7Po1SKtFy
	zqviY7TRW2erA9Qfe6Ucz6EIY6vafWuNypngxvM5SSLLKmF8IaTHKT7uBvODoYxwzUpq8jqA94/
	a1oNedcWLAZ00Rceh+lbywqJRSTrjvaZNCwjJekZs1NkPZd6MWXRwesLMUUvvFogTo4ShR/i1vg
	BbE2edKAHa1OQhKQiZM7tJckx23w7ApAQ=
X-Received: by 2002:a17:903:3805:b0:2ce:8551:318c with SMTP id d9443c01a7336-2cf349d1747mr115849075ad.40.1784506836766;
        Sun, 19 Jul 2026 17:20:36 -0700 (PDT)
Received: from smtpclient.apple ([191.181.57.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b037sm31858569eec.27.2026.07.19.17.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2026 17:20:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC Patch v2 6/7] repo: add path.grafts with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260717133015.32040-7-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 19 Jul 2026 21:20:22 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <DB49CF15-4980-4213-8463-4C0FE2EC8438@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-7-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
> `git repo info`. This allows scripting layers to query the active grafts
> context cleanly while scaling transparently with active `GIT_GRAFT_FILE`
> environment variable overrides.

I ran `git repo info path.grafts.relative` in a repository with no
`grafts` file, and it returned `.git/info/grafts`, which obviously
doesn't exist.

Wouldn't it be better if we check if that file exists before
returning this value?
