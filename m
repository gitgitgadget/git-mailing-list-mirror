Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568D19E99A
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785925; cv=none; b=iKEYDTrrpcwoARk2pMWigTCQDPYikowgGvcPUe7q5hBZYG/Mm7nxapfORA3tyNW7VFNrOGA1N410VEUjTzO6AWsebbJuI20JFZ/9Lb1SWDdtsFxKYT0gDHOhUvknuvhvZFI61Pvtu05za8ciOziDjX7u9JMw3FvPBJpAIgTcDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785925; c=relaxed/simple;
	bh=+3lTzP984fPiPMOoTZbnNNw0EF4Ax+nIAHLe0gAhjQM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=lXsvGczuvmaWnwPaCykZGTE7wRwY7mMui+VeUj7CgftWRdHysuJiBvAaf2+lLYn6g9JrVc64nWiC3jiXY5CbY5gYg6k6VnMZdBupfncPH+iCSdEgg3bsBUxmxEESXiV4kMw7Wh1t4ZXBVY7W3kzc7ovCLB5kNkD2wmtAwLXBerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAeGYFPN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAeGYFPN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8baba4d5so8191539a12.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733785923; x=1734390723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSZtvwcCE2GnoN4Y/+Rl0YozhlT2TR/fKHeZXQy2epA=;
        b=nAeGYFPNnewjIfnp55GwK0zbrPlKRA5XzPAW/UK0CBVE+SMJX3RDAjCbbHbedJUMQM
         ELpWU646B4OW1wR6M4gNgnxcHvQBEf+mlANkXU7TVUObA/ScCztPzpj0zx6PkSNbT5Jm
         uawRGO/FSNiN5je4k/w07+JPc8kQO0Iz/hF36LizQNOeDeutRS91iY/231HuB+WtIVYW
         3umTqEi9hBCT26PAA/j4b9KQhERNjuAt/srf1SHeqi5JggwdU6lWHnzoPemzLFhfiuEL
         Xe5eeITswGJ1WR4xYlPwUnc+Nco6wnhlLfRvWv7xnFgp3bxkbtvnSVigiSmgK9DIs1j9
         vlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785923; x=1734390723;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSZtvwcCE2GnoN4Y/+Rl0YozhlT2TR/fKHeZXQy2epA=;
        b=gOZsSUX/YfYZvqInjE6Va9uqNJhpGCmbxl2tmsMdiEQQ4HrGB3p+fCWAlyEwjNiI55
         U8I4H33MiZsL+YDZlDt8DQXeBk9F2TNFT6was9ZX/+5U180Atp2yxGHSwiLo/kfaQqmk
         2tn1cJL5qyA//39ND7UagnfAqlk506cTLgfzY+g4LDYUkzNxP6TX3KQd62k/js/NLMgz
         04SdNr5lHFB3sMUwN5hGcp2e3wiJbtU+9VJ8E2tqbSvqqB/gqYHPMTk+9HFE0Vg5H9od
         lv/Wo+eDZsXIA9xPC92cUrHAAheekpRyQTDZw/S7sPT5eyFZZZBx8t4L/Zql/wdpBrZv
         ie7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/igaYget8tsbLqVSQCt6A0v+T16d914Xi5eV7XS7EAtzZS8d4XzDmLZReIgYou88gYU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ko/mO4BAJxo0AszlJzfHG1lumGTTl/9awmWDaHZ+6jw6PrPJ
	oqOlhMLXdK8FolIclrQh4JT2Ftv3EpWTjVQfhuLGSujNSV07nKDvTCNCDP+585Mi9Ycc6rUIZIx
	4AWKOOWd7vBidjI4ECg7KxIqyvGSbUA==
X-Google-Smtp-Source: AGHT+IH8JLMIbpqncObiv7auz0Ko5lmgKzGq0qDcZFKO1SSNbmkoV/m6Wy6fg1i5+7mU2m8zoOudReS908iY9M0ReATT
X-Received: from pfbay26.prod.google.com ([2002:a05:6a00:301a:b0:727:3b66:ace])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7189:b0:1e1:9f57:eaaf with SMTP id adf61e73a8af0-1e19f57ee14mr9349204637.6.1733785923149;
 Mon, 09 Dec 2024 15:12:03 -0800 (PST)
Date: Mon,  9 Dec 2024 15:12:00 -0800
In-Reply-To: <6a95708bf972cb22c8abf1da389350fc9f53c4ca.1733181682.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209231201.841076-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 4/8] pack-objects: add GIT_TEST_NAME_HASH_VERSION
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>  t/t5616-partial-clone.sh        | 26 ++++++++++++++++++++++++--

I believe the changes to this file are no longer needed.
