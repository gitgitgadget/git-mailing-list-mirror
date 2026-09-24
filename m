Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458D36C0D6
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274932; cv=none; b=o96tyP0oj7stBTsAy7MKQCK3TAzLGinlzv18gkiXOl+MiM+mUiAkXVpPzdMpCcd/f80cB7/NrOrTq0Wgl/Pjx5/x/ESLOIOUV1aTRQmHT3ak03m+AdEazbjq535Pk/emI1ZMxt8YMIFAk+tHlac7OjSMYdcscEZ5/FkkDtrNmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274932; c=relaxed/simple;
	bh=bGXKtgnY5Cdl6qtGj7ORke/SMh/eULNsB5UUUqGE3cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyL4dwB0sxuYLvJzXXq+DzWFZm7SHqqqXd/KKyKzSm+b2aQCxRfTwXryDyDKuCUA4IlBT1uTpYlZVP7Q6RNOhBLlOX/iADqkBekhmV4lOPkYEhNcLlcVTVVjvE7sde0kO1wGTRy8MykFFJheMcbgcuffd1CTslrejV6ZCCfmecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ8jwYjf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ8jwYjf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6aae37d33cbso205200a12.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790274926; x=1790879726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEaiP1io4Bbh9OxXR/NlySqjjzDxirqvqDF75wW2LGM=;
        b=RQ8jwYjfzvzmQ10cDZCSyLZ9ZpsYDFYEgDuZNOHLu4UCPQn7qDDaE/pBLyPqdnsf0D
         XwUCAdF9NokR3utTa6k8MmVOg3WUf6RN2sveyujR9dKfnZSP8zAtHYFaYnCvHkjaM3oe
         yRDE9e0ikYWSlvQQ2wNJc0P8hLQur1AfWHMyon51V/smocjLHc8T1UoK8exPgwM96+Zs
         Gqj4sNfMsBBQz+Jo3D1ZFsX33eu2AC5J/A7DGQTra++SMiJZ74s5M78woqj+1VOF6eOO
         zM2ebr78VFBpOmNSiViQJlma/IB7D+0GpKb++0/p+DX0W6AZMnMhb/3gsBbPMZbUt2rP
         hpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790274926; x=1790879726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEaiP1io4Bbh9OxXR/NlySqjjzDxirqvqDF75wW2LGM=;
        b=okf4VsUqOM/cMVUeaKM9WcLmduRAluGRO0zvRjH/oJri0wCYEnSZPFKfbi5HehUfqw
         8bgz3XEOJH4l41OgwguRJudQjNdKAhlNASf+/7Btial7TdniBhOIYEZlLWlIxKAdPr+e
         YROXO238g0LIwwwL/0mLL468SwjjUVh4q4pwMcy2J5l/yOlvndtwhOk+2ZEKpmwjeqEG
         ZQcU+k6xPp5BMq1+bOAc8GrLjhB22FnM+8EhQOEOQfUPexrOBt5bMwSjligHJrXZqFsx
         crQ237bfCS41IJ8YYhjaD7XpWwmdw8zLh9tkv8K1jehtmJIrhmIR3Q2ZerCtSG3WQKlK
         GP2w==
X-Gm-Message-State: AFuF++mRoGVk6i+uBKDjDkrtNE7xIDdxwvmuDPJ/iVTdSlrhdapxepng
	xGivzDKBWP6d7EQPPKwlkSqWczsXaD7EYtdB773oKMKC8iK09u6jgt0r
X-Gm-Gg: AYBFou22Z0WBo4ELGpLPisZNodyMRUZAQI/iErmmwC8y68iGRecTsFrFMXl/CbXUnCt
	YeBg8qXfVq6KAzu+27qyhGh6u+otXepGZo76jdor5gGfffTL7TQw8p0/2j2KVvlLOFXWxGk137l
	wag7+3ogYPfFYPbmCp0lH8884FAlkpcxrOxp34mec+hr5Fdh7oY/R3V0oWV1RR3SUxriooPXIU4
	gAjD+l48o64XNoJB/yHp9rL5/nn/9Eh05DU0fb4nhzdG/smZMr4uwMZ3iHREIlIDg5g53LBGG2g
	ibDNZjBeTvfZ/81NdcXVEA+l082lYT8XOpqNxWBISfYKGWMD7XnPXQGX0fsAaIyeX/vkB6SNiaM
	rC1VvnVaijF7JcftQHg3HNJKiozdh1Gp3cqSMm1K6h8i71+oPhwfNghiDcctOd0A1g4+MmV1Rfr
	SHeDrEMQvGrODYQJJhfO55FXSqNNviFmDRZu1m0PRXa9RuoFKZE5VYEOfSCJP1yGfIj2MJwms/O
	YJwWt7ze1QDHkJJpkt5C6+LPOEwA8RrumGsjqtA2zdVGONy1++aZzL2Pr9uRG3usPfl
X-Received: by 2002:a17:907:db18:b0:c2a:880d:777c with SMTP id a640c23a62f3a-c2ac2245724mr301290766b.10.1790274925594;
        Thu, 24 Sep 2026 11:35:25 -0700 (PDT)
Received: from Haralds-Air.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757aea7sm736966b.30.2026.09.24.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:35:25 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	sandals@crustytoothpaste.net
Subject: Re: What will come after Git 2.56?
Date: Thu, 24 Sep 2026 20:35:23 +0200
Message-ID: <20260924183523.53201-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.1.gd5f2128258
In-Reply-To: <ap50kgyenpRrsqln@pks.im>
References: <ap50kgyenpRrsqln@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Well, same as there's room after Git 2.9 we also still have room after
> Git 2.99. No reason we cannot have Git 2.100. :)

I agree completely, no need signal that 3.0 is coming until it comes. Once it's
out, not a soul will question what number the release just before had.

I have a list of breaking changes that I would like to introduce, I was hoping
they could be considered before 3.0 is out -- otherwise I fear I have to wait
another 10 years for 4.0, I would like to change the default values of these
config values:

    # Autostash by default
    checkout.autostash=true
    rebase.autostash=true

    # User friendlier branch sorting
    branch.sort=-committerdate
    tag.sort=-version:refname

    # Better diffing
    diff.algorithm=histogram
    diff.colormoved=zebra
    diff.compactionheuristic=true

    # Compare branches on when push/upstream are different
    status.comparebranches=@{upstream} @{push}

It seemed a bit presumptuous to submit these as a patch, but maybe I should to
open the formal discussion?


Harald  
