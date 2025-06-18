Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669221D3CA
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280347; cv=none; b=WJ3v3GEQJ6cN2ESjLbeZddZMH2iVVbz8X1gFNTIH1qnKMhlUdEg2IgcOpt1l8Q7q7BVWv8ZWzcsuIkOv1GaFU9d2rUg8nlsebN+pF6unM5jqIJ9HGr4L+yckKXCV6FsrguJytyFb2MW2nJtvVPbU4O7fGbwf29tmHpAjIP4hwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280347; c=relaxed/simple;
	bh=l1OgEILcRR8O69WnzEedDWCZLj0yxvriJq4qWa35NLQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sAeMA+T5VXTBRZ+S3oVNBFh5X7Xv1P8FrWPx37PtgfJWB5Zt58l7EQlCJ5L+Oq4WGr4h9PduwWpooVUDPozuvX0ncenvzUMLgVGyyqw13BxDQtikJYDD47PyF6drogi2HujoynqVYoQJj0qISGJhljYPYXBcno17tFWtXW2UQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qumulo.com; spf=pass smtp.mailfrom=qumulo.com; dkim=pass (1024-bit key) header.d=qumulo.com header.i=@qumulo.com header.b=BNX480vG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qumulo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qumulo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qumulo.com header.i=@qumulo.com header.b="BNX480vG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3138d31e40aso11509a91.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qumulo.com; s=google; t=1750280343; x=1750885143; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1OgEILcRR8O69WnzEedDWCZLj0yxvriJq4qWa35NLQ=;
        b=BNX480vG70gWC3gLjZ3JpULewq6aR24HUKL9UV97RI1g0vuG+pqFPeBVwJWjDl3TZj
         E/hUd4W3Sfu4rSWKcN8qCDNXx/LSnGiDmwyfDQdw4ZuQXoMWY94PvI0pH9s9QLNyfygj
         9wkLMkkamnmnUpIzpt0nFK1R+KY/H/Jv98/Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280343; x=1750885143;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1OgEILcRR8O69WnzEedDWCZLj0yxvriJq4qWa35NLQ=;
        b=nCBqvq9EJfstf9ItQpLK2PslnDMceNGbVRk/SQOsOwtW8RoNbq8tMil7rfxF0bIUOL
         zdxQ4SEAk5bh6Ta8sgmhB3eFIVZZhkUU4G5QcwJ2BAh74xvqEumX0gGjiGBeYUHbEgmk
         K8rRfpAO/HGEneQkXmDBnSOHj6UMmOFpinaecfNCm/h86cAU6pnL7M2BsI+7FfC7y+lF
         iiuUIzKA72MmHMqiRu0Jls91wCtoPJ3VbF3JWWRxaN9Rfg+Xagj7QPr/Fu/tVINvFR0J
         jYqe8nk2ORwSkkyi8DKIfbWQlE24RUwoyzx+qlFr/94XrPuvifym4eUuro6JzO4kMO/G
         wrUg==
X-Gm-Message-State: AOJu0YywlItApu5Q47lN5BLMbaru1GDknXaH9qYmliGGLR6wEJJg4XhY
	Qxm9BHG80Co/D9S+PPdzK/WdPnoK30QIdwTQJjHG4WXm5yY7xC5DshmqHe/7W70rNA2Il29Sc+U
	CIGP0SeG5pCj456EAyjyG/A7JOwIXfs08qhqgSetd9ehBbbmCnb5MBUiiQw==
X-Gm-Gg: ASbGnctX8x1o2mzavjF15ad38bfDG08jyKvhUq/3YHiNFsuF2Wwr1m2XtaS5HT0Gxh6
	/o6ha9u1FdWhGWbtWWrWMKJMCkE40gCHnSdtDjQMllDIt0/gdGRQw3CNrvZ5KZG5am4usNaI1rC
	g9Op5NF1XjWuIhGc1oiarCBWlO6Hv73V6YhARnULZZ/w==
X-Google-Smtp-Source: AGHT+IGXrM2sFxpHQ2ogER75VjRp2KlyK2bPQNmFl+iW2qNUuK20g+GmPGfTb9ptMXFyPOjIF6xITJ0V/8IQSDpkv10=
X-Received: by 2002:a17:90b:4c8c:b0:311:e605:f60e with SMTP id
 98e67ed59e1d1-313f1db7dcemr26733253a91.20.1750280343345; Wed, 18 Jun 2025
 13:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haylin Moore <hmoore@qumulo.com>
Date: Wed, 18 Jun 2025 13:58:52 -0700
X-Gm-Features: Ac12FXw_1lzoM2tobRH97ua2xbf3EepGQpk55q9CbDkoDgE8hwVWcCfNWNCJj6E
Message-ID: <CALnKHDCH_174KnP6Um+G8YCpDBGNNk40xS0T2K6VtnDv9hE37Q@mail.gmail.com>
Subject: git only writing 4k at a time
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hiya list,

I've been investigating some performance issues around git clones over
network mounts. We have noticed that git is only writing 4k at a time.
These small serial writes are making it such that even though each
write is only a 3ms operation, the total time balloons. Looking around
the source code I found that reftable_writer is initialized by default
(though I cannot find the block_size argument being supplied in my
cursory look) always to DEFAULT_BLOCK_SIZE (4096). Is there some way
to increase/configure this block size such that larger writes happen?
In git/Documentation/config/reftable.adoc this block size is mentioned
in a manner that almost feels configurable, but I'm not sure if this
is just internal for development.

Thanks,
~ Haylin Moore
