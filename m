Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032DC8CE
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728696694; cv=none; b=tuEDDKghoI7cs39i8JFEnB9CeaiufQ+WbtQJwKqMi16UWWk78OQQeuXYjJnqcH5IwxfuSY0oZ9GzTiwDYFjJnDiEu1R9k+Uj10Ki5L86tuxbKGTX6HECTh4DpuvjFqoYPCpAmKTcZ6mCAOSp8Ak6iCwIjn5A0d3/vUMsboErHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728696694; c=relaxed/simple;
	bh=4kNa9+Y8cbQkWrrBSClbxCBUyNIEQtNEMcaI5MQfesA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kxKVaIQvL2TsNJisdSSBtrR5YXYZfrEqmtZ1RVYSFXegKaGoiVBwAnSb4lkMewf504Uj5Gx98fS79LiDUtE68WwQdTLCBmRYHEwHQcZ8TvpDGit5NiSfWi5nyzR8Nwb3sLkLS0QLhC45coexcceXJtRPudkDYqxITiNjSCJpBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=r9hVf8+M; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="r9hVf8+M"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e314136467so24087367b3.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728696691; x=1729301491; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2szWnGtJqCPvYfBGr2KmCTuYer5QFoHmIQ9Jsc0pJk=;
        b=r9hVf8+Mgoo5IHX+LVhSExkBU9AplaBb1z1fSjl5Qctmm0ma2iI7FfYe0KazkFVn7k
         yaG+acQSUHBYWb1d9d53ZF4OiVX1nYf8R89+7Zk5+cy99Vr2VhLgJaLvldbSZqgjNucB
         zwC1pG8k4Swa4CBvVGxD91tOIT9ZAss7laeaoRFtuwW4KmI0p5+tXPRLJMzUuMZRtG58
         pMivRtqwff98vN/z7Ij0DAcmVKFUdduoy9z8I8+/h5d3SBeFACWn2yf/OLC4zkrOhHeN
         mkLRn8IYvSpHZmdmlCOZvISU+oB31HhdfMe6sJqs10b1fc046U+NQ1CNci8mr79pP2UL
         OXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728696691; x=1729301491;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2szWnGtJqCPvYfBGr2KmCTuYer5QFoHmIQ9Jsc0pJk=;
        b=BGdqBaYkTTcqeJMQzmz0qIHkZAXS2Vc3vhCYKFs+Vvd0slon6v3iB82GfOijwRYISm
         3zHOy6+Rf9xKDY86G1gkHXPQaGVIqKYW7hAS26bkWm30zcJsGykijj5p3gGumNeZaE7t
         VMzcJTY5N/SOuDHB0AG9bJ8QkaTxYbTgoXsmpnoJDYINpD7O4r6P1Ui7JiHx5rjvS95h
         DU//5vyLkK5uBCef0fATIJSXSlk/8hQueYRbha3yz6YphQoeEkAlDrUpapTeirKVZXaW
         EsmbCm6tlsoUaoelxhinNjLA0ns4/1arvTF/WGZ2nikD3LTmGwh6Vxq9qEgM0eBMg8ch
         UbvQ==
X-Gm-Message-State: AOJu0Yy/0rEqvW54Ra6PAltoQ8HXIKkmmEHtGlrJXJPZfcbghjIbohEr
	dVX+wszw5zoBWqXjePiVcF7rNld6TdwOXlz6Jx0cYgnp0Ep8tkaYccLGhTQ/6blDUEvsR3bPYVL
	C
X-Google-Smtp-Source: AGHT+IEPYXbKt3grM4dXbEs9qE7Rxgli9klpuY5+6KqawGHCW6MDlDEMrI8XgSsf2iAxXwwC3SGnsw==
X-Received: by 2002:a05:690c:60c1:b0:6e2:451c:df02 with SMTP id 00721157ae682-6e344ccac20mr35677507b3.16.1728696691419;
        Fri, 11 Oct 2024 18:31:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b6199dsm8220797b3.1.2024.10.11.18.31.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:31:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 21:31:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: A note from the (interim) maintainer
Message-ID: <ZwnRcSrZhH9JdaS2@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

It is that time of year again where Junio takes a few very well
deserved weeks off. In the meantime, I'll be doing my best to fill in
the gaps as interim maintainer.

I'll follow the same process as Junio does, picking up topics from the
list and keeping things moving on the various integration branches.
I'll publish the broken-out topics to my fork at:

    git@github.com:ttaylorr/git.git

I'll keep the main integration branches up-to-date at the usual spot:

    git@github.com:git/git.git

, though like last time, the other mirrors (including kernel.org) will
lag behind. When Junio returns, he can push out the main integration
branches to the various mirrors to bring them back in-sync.

There is nothing new in either of those spots yet, besides syncing the
various in-flight branches from Junio's tree into my own, and dropping
old topics from a couple of years ago.

I'll keep up with new topics over the weekend, and push out a new
integration round on Monday. On Tuesday I'll send out a "What's
cooking" report.

If you have a topic in flight with no response, don't see it in my
tree, or it's absent from the next WC report, I might have missed it.
In that case, please nudge me or resend any missing topics.

Thanks,
Taylor
