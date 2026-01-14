Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92D352C3F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377197; cv=none; b=iAdPrt0KX15h2UZAncToNihow5oQrJzQe7L9/lw9IpF3P5AEznEry+9bsifDHSJjT+In5xnl6xMHC9woiUJuDfttKVL8rgQv3nJ1H9jUgjgzsqsj7MpESP0Tvk+0kCAxA39aeIUbiFX9sXT5BN17UViNlfzgBfPoO+vHiikts1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377197; c=relaxed/simple;
	bh=ZazdgyFHURKNvVRhXzR6ObtWjHXiwhhf4GuG+WVYvMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFShzGoUHeyuEK4VOH04ekEQc/EmbvKRgcG0RA7UgYtKYEqeMtCXJ2D6VdJ6zQYlnf2/yNNs7pUfpWRhyJnQW0fNSsqM/e5Rp/Pl5wda3oqPo6M98Sh56IPoZYmeXKDmTMStHwXIC1dtd22hkCYzXuljdSSACt1YGj5yhwsSbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3MLJL6J; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3MLJL6J"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b834e3d64so5988588e87.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768377192; x=1768981992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knscBYhYdwEXz91xgbr1L/yQRi9T3kTNnFMSmSHmjMk=;
        b=Z3MLJL6J+pG+62pdZghCnch/G09uPfnfLsiFzgDGCPSBKK5fsHBA6cAUAQmqZmJLRl
         usK+UzbKfe0HqNRyEN1esZkCIYz/w3wwSIOL8CgSqB/amhJNFcl88P2os35l89a4AIYW
         c2AwM7rhCE9pG4rVjMt5fsdLv14d5BFjHnN0eqdzy/fD/B5749kjRN4ePzRxspy3ATXk
         +sokcSwJmOjofh4cB8hslfbGvS/juqPNkLQhL7s5xGdSi17R19K/fcJ/NXdI32eNGTha
         kTlmICHEpqiKCGN+206iim3OVeHYXxCf3wEvkzzh6RzeXFHcS2eZbdE1qHLJ/m3pcpWU
         Dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377192; x=1768981992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knscBYhYdwEXz91xgbr1L/yQRi9T3kTNnFMSmSHmjMk=;
        b=Gk392Wwt20kitZZXGrQOi6G3PCn/jWf1xofHH+n0IiJb0kgnvKER74UoMWFvsHECTh
         c1gYjlBplD4wIVebNxHWHP/Tlvun10p00253Z8bkELFJlVdZZqLFFhgDZB5eVWGXMYEP
         l0aVmqwYgFQUYs3QOAZr3CJa+/6eeoltVFs+HSHxoaqbkDbY+dr8gc/blORxzPSvUazd
         hYq6clQigAhlImNaaSIsFWBgvS6L9yGWxPKsoP5LV2SKV2rVoEq+/O9OYCuH9SMUGWA5
         XTWO5d+zf6HN53cPDXMjCX3eEfQwcYhswpbTtgmGRD5a2JaBhfPNoQfA+COMbdXGT6qL
         0kPQ==
X-Gm-Message-State: AOJu0Yz0uTuArzcdCGEHXEzR+iNid+IARpl5SPWHUiN9iQ6lVHYKDPOr
	g762CbRZPSBYEfB9HJymgRcdzWzmvBSDFNMtN0mQ+PeIDwi3/3uYwaan
X-Gm-Gg: AY/fxX5z3NrUPsnzXAxpmMudZcSI9aXaJM8T/IfVB+s5pnDchkYmMFAFPBcqBIAK5yl
	Z2bPM1DS8p7zos1NrOZBGzG/1IoQS/lUf6+/3kfVTG23qstR523y0jGbOdqAW6DbHiBnFA9BrAz
	LLDAPows2qKz8jZAxtKXIqRQoJ+LftZKJSUmvrn29Aa0kHjir1tXpFPEBUdgMDBgimh5mrypsBb
	3n0Su0FtpMzPDp92rVrOgyRexPPgN7UZgrmUfay+jytcogYV9OM91d/pd5W/ZWQhAkzWkQaAvLW
	TBH5Pbb6/pu1zsR0XQyWnz3eM9LJ7QEllNcxmEX1pmC9n9cARVd+Gra2Ns0QhG6Ps4DQS/uRbe7
	c7OYLh5XW/cwpQY1qKkjct+TpS3AG4S3Yq49N2x6Sk3mRr+nGWb0esdQTDROEbhQZWzVA2CwVRF
	LQ0nKYAmxTiOFN+ro9NlugWu2Lvcgl556KPzSnt02vkwWgc4a7/VMW3a9Ic8L6YuRWByYUkIIDu
	jjT
X-Received: by 2002:a05:6512:3da4:b0:59b:9f92:301f with SMTP id 2adb3069b0e04-59ba0f5e230mr603952e87.7.1768377191751;
        Tue, 13 Jan 2026 23:53:11 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59ba1049bc6sm465538e87.90.2026.01.13.23.53.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 23:53:11 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Triangular workflow
Date: Wed, 14 Jan 2026 08:53:09 +0100
Message-ID: <20260114075309.32911-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114023408.GA858378@coredump.intra.peff.net>
References: <20260114023408.GA858378@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I could (and in fact the script names the remote directly already,
> because you can't pass refspecs without specifying the remote). But I do
> occasionally push a single branch with a bare "git push". Usually this
> is the integration branch, when I am trying to trigger CI manually
> (e.g., when piling hacks on top in order to debug a CI failure ;) ).
> 
> So even if I only do it infrequently, it feels weird that a bare "git
> push" would try to push to the upstream remote (which I don't even have
> write access to!).

Maybe ’push.default=simple’ or ’push.default=nothing’ are better settings
in your scenario. Then you get explicit pushing because no push branch gets
set. And thus 'git status' reports not additinal status.

> Yeah, though @{push} is usually not explicitly configured in the same
> way @{upstream} is, but rather a consequence of how push.default and
> remote.pushdefault interact. But it was added for exactly this kind of
> triangular workflow. I sometimes will do stuff like:
> 
>   git range-diff origin @{push} HEAD

I imagine the same thing could be achieved with

    origin/$(git rev-parse --abbrev-ref HEAD)


Harald
