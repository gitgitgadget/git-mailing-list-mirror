Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB872417E9
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892661; cv=none; b=WgdlOd+TNJdcU7/9qoKGwoZLbknaKIbWaFpEUSs9s+OvNPwew2WtfJfP1gF+B/u7d0x7c9hZs+Vvux+8BVVfUZf/X0hVzjEx4wvc5Mn6VZf3rqk9ZRjNwet7GsqN5v6HKrUNlffRPD9pXAr5UwX5XvONfldx6GW2KpLYfpxIlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892661; c=relaxed/simple;
	bh=cvEFICmjOSOgsW+3VJ7ErMcQI7fg1Fi1/b0S8Ct18ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBJ8bCpLs/ikGKQ23swI7XE+uDnT+IujCShhGjha/DZc1z/6Q4mrfy1+1F2Y3UNClJFMDuRt1jBlYl+DM6XRP5vgFgKK3Uj9hiNnTA0LyrED81Sy5K1iIpzTaQByxj/Ok466Yh95zjsvMjdrJmLbvIm27a3QQOgsXgu51BDuQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=kAAA7wBq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="kAAA7wBq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso62777195e9.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1739892657; x=1740497457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8Kc8FOPcNt06WkJaIavVAKPYZ50DvC11/IgIR+RLIA=;
        b=kAAA7wBqVUBl+CArXcO9ikijVuR/YySnzx1KBQQT8mEnliiMVaTalwAENYKs8rPO2T
         fkCuuzYCTuIuPwbyer7yaB/Nmyyn+5GqRGoFmNRaPv7s1SoVNmLq2qdJ0z5D4fbKMmRt
         ZyiD/7LkuM+aOd2aP/8kXV8ryhC0prtdrzCM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892657; x=1740497457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8Kc8FOPcNt06WkJaIavVAKPYZ50DvC11/IgIR+RLIA=;
        b=iiMkIc1QW7A8hUS6CKb6j06hXnG2sCTR2pWbvxOs13d1vRYEDhF6+yd69ZCjVHJjcr
         p+qJJG4EViHGFkMAs6LtEb99W6IZzomWTs3PclDTdsi1JOOhvXbxERgxFeGZRVdjacHw
         lHPIHm56gG7Camr5OL7lBxblW+5xMC8q36BHql06fdLjvAEUJNGlcogbIKTFO/XqQZ4X
         PTlSN3LiiE7S/Zig+PIgRJM6anR2+ddgxApQe46CcelPcSCOU1EbwtPdhIb1vrcFUKe4
         lQIitKWtszTnw/Tae1Jwz4nIyMJ65eT+rAnFXTtxqNFcbxnkM76khqANFw3rf0yd2dQM
         sc+w==
X-Forwarded-Encrypted: i=1; AJvYcCWk+gcwDmeiQNAnA0vpaVyGd5XNCThgfyeQhBO15YN0b8TgVLv69u80Sn779MtRLaIC/xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaA5rWl7CNnmYnQsjrwXVC56XbH7ss3cyd0e/G9lwleNAm+9y
	lVp5FhNFcEX9esK7nGRB9svyCl81UM/1R/gPNWbLEqcJ8m4RTP9AxSXYTGQzQA==
X-Gm-Gg: ASbGncsw1uhvOhDSXDqoJ0ifcjyJOJCqzMpylqKKeSFnPHnGehKWd58kHw8bVPcL1e3
	sG87kIYsnIGjmFbg3jCSwP3QuOjLBRfC63HQVnostwm423vKnBs7tQsfERYdq5JVs/VfmfYFpdS
	M+ItcAzDTY6blM6+wxmt2rKkN21NjwnZArw8/Ba1pUWt6i0SB/sSJ5grJifB8Dfs8E/yH+o4vK1
	yNAxJeQHH777hYsZ/dhKuW5qKr9iVrgHH7a2PXPoWdS6fGpv3DOjgIBoDpmTOQOW/gcYEQfK0nM
	KK2hdBbyXy3WGYhiFNIeFbQgmKhhM5RLIFSiBpmX3elvYNrfraqz9wIUw72O14mqb+KthKMRhwf
	0NLtEX3Phr4VP1z6f91c=
X-Google-Smtp-Source: AGHT+IGHdSzri+fcdDClAmadKca3VFPrioG1In2zRaciOSyJoqFi4Fyg7RqZnyisDqUUzxmQ+3O58Q==
X-Received: by 2002:a05:600c:19c9:b0:439:5760:39a with SMTP id 5b1f17b1804b1-4396e716e8cmr148600845e9.23.1739892657079;
        Tue, 18 Feb 2025 07:30:57 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8ddbsm15327718f8f.47.2025.02.18.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:30:56 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 51IFUtdY063556
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:30:55 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 51IFUsbk063555;
	Tue, 18 Feb 2025 15:30:54 GMT
To: gitster@pobox.com
Cc: ps@pks.im, git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH v3 0/2] Fix Meson Perl version check
Date: Tue, 18 Feb 2025 15:30:41 +0000
Message-ID: <20250218153043.63535-1-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z5c4OzzHWOo30Hu6@pks.im>
References: <Z5c4OzzHWOo30Hu6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Suggested comments added.

Peter Oliver (2):
  meson: bump minimum required Perl version to 5.26.0
  meson: fix Perl version check for Meson versions before 1.7.0

 meson.build | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.48.1

