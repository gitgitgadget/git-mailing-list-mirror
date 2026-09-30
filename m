Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8774F3EDB
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780404; cv=none; b=mntyhEaCOe6Y1kgW+rQaqTl0C4oJQkgCwIu9HCuAg/Fb7551hv2FMZVoqIUtOCqwi7p++/XRKKn6PL7zhuuYwDhZ7sW7oSYHIYtsez8cYUbppXmKB54MmineUnxb4VOzK4TGC6SPYrOCk9BklWU4qaCqgBurrGY+O5s0X0AGn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780404; c=relaxed/simple;
	bh=5LAzJn+YTIAouFoSNPtb8S1v+th4lfJkhLE/7k4E8n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9cPIzRXdJCIFN9Hog5NgCJG7pq5jUOtd7LwaJWZxXE6guuoSu3NumCXGGCWxRMnrw0ayVmqHY7CHxMCMxpuqRGmywsVSZzDfDY0IoSNTOtYN2wN+P5+EhiAY6sgxwLqk1GWJXGIOquwx0u/Yo3msLZvVDgAHzszG2db+M4YJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3RaxQIH; arc=none smtp.client-ip=209.85.217.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3RaxQIH"
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7b206156cc6so4434595137.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790780394; x=1791385194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LAzJn+YTIAouFoSNPtb8S1v+th4lfJkhLE/7k4E8n0=;
        b=h3RaxQIHs27HqSLrZD1DojvPdYqxxa3WC2EGcxJfYPDjPklBiy1AeCWxoAgLd6M/qE
         h4qElJ6H8O/eErpE45geH2aCumtYop02jsSq/QFhME5avqjHFFNhPIjQ3czSKRnp2/c/
         lori2L5fCtfVXcUGldNuu5n3TjGF/CLPku4umI4WTK3sRWzSPRJJS1i/G8bhEG17Uc9U
         87rgFdF7NeQ/en25v+7GpjWg5KWDSLS3AXqvpeGDbLCxbHXJUJk2Xgu902HxkMTYvnnD
         iJw3Oyf09ET90RnNkuSiPpNtXlYNOa/NveibLYjTGUSaOeOz5LA42BRwA5faIJgbu6+7
         E+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780394; x=1791385194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5LAzJn+YTIAouFoSNPtb8S1v+th4lfJkhLE/7k4E8n0=;
        b=dHaPkU8B3ZUsXr54mGunrAx9EPVuU3GC1DeqeCEHlB9lpvgXgQjrBn44lPb2yv9IaP
         TuipzRLaGuu35fnl9jYMDF01UasOLv3D1/IhKl4EyB6r2JVD41iwKpMoIBZSL7bhzBXz
         tx4+rJ/NGLeB/pdxDk/c9IYTofAE6hi4INJzWnjcaadJp/+OgGjr2elliZFVXHybuUB+
         SL6rB9HNpzyzYRLSumpEu/CsofAJgyj64OFefEIUlnp+biAFhprJBWHzrNaR5bap5gCX
         BX4z+5MDuUasKKC1NMKYV9FgYVt7Cz139fUQX5/mfkMi4IERyTQIChXHmR83CNKD5/8U
         bKPA==
X-Gm-Message-State: AFq9FYLoTeSqRGufdS8Bwu28x7H2VcREAO3J9DwsHDDwbEU5cM7VdFjV
	hAVthG4eIQcRI0eHrofDIDzzRDrh5JlKdGLt9lrxTSWdHqeya2suk/aOjdflusrQifz30Wu4s5Y
	wAroMWirkzmFj0QHLNJ42pYhN0dvMiS9/zML/yCTmoLg2YE6mvtsX/2o4kPI9134AmS4MJLfqSE
	qoGSh2bi1b1ubRkQjJ7B+aGO6GrhZHwGKJkvOL3w==
X-Received: from vsas15.prod.google.com ([2002:a05:6102:300f:b0:7b9:406:34d7])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:508f:b0:7b4:ab28:785d
 with SMTP id ada2fe7eead31-7be72ea3a61mr479362137.16.1790780393604; Wed, 30
 Sep 2026 07:59:53 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:59:52 +0000
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.1.g22a100d00d
Message-ID: <20260930145952.1840998-1-rmistry@google.com>
Subject: Re: [PATCH] blame: default to ignoring revisions in .git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood@dunelm.org.uk, code@khaugsbakk.name, 
	sunshine@sunshineco.com, abhijeet040403@gmail.com, rmistry@google.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

Gentle ping on this patch. Please let me know if you have any feedback or questions on this approach, or if there are other reviewers I should loop in.

TIA!
