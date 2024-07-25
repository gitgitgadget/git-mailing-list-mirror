Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E913A884
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898997; cv=none; b=Xrg3otDQL27ZFEgIH5oYZW+4gtJFEa9bMcd5jeVP5qNYjcfoCHofUZJvxUNWAzft4ShmKzHRncQKUHyRlo/jYRf44db+iWaT9WEcqXhz07NHba5d3zCSUOTb9/lIi/RJMC210+0+XdRxRDprFOosmnyL2jRTVBcu5a1GrRPD0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898997; c=relaxed/simple;
	bh=d4oGuLIbr2Dsp3IaIiiwO2hAfE0ofzh7pVJisTleI6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NdmBNQ9TK9OBA41xWUfv2bgJ4ZDNJHJc22KzXZ6rN3BQAEr46/KiWpHc1pXT6XEdXGSvuTw99yXyV6FjXanfu/nMEHvrNvXsU0AS7s4epO9Ma2DJptfR+AVDNZ2DniIBu/XH+hILQs41J8Y3nlp4qAVONO0fyABCdnlgBk8sQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+WESkRT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+WESkRT"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so122254a12.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721898995; x=1722503795; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d4oGuLIbr2Dsp3IaIiiwO2hAfE0ofzh7pVJisTleI6w=;
        b=C+WESkRTbXLi2kEZep+fmkcKv0oBTs+2lOn/j6+6aUNP/Ib++BLa0asxBsNa41Cmwm
         H4OSoHVvFGZ/X3KpRReyGkVXruP5t1nUvr/K9sInpt66EbQ5ugHuyOiZRdhk5FYqvKJP
         HHIMnhrwYhSEurnN7Dza8CxYD8z00HKXoYo7WG9/pMc3p5q13nTH7FG2KsG93re1uYMf
         CDLAAj6rKE94AgYUhrSnur3vL7Y7u5l8vsGscoj+l9EW+7imtJbRcnsdEu+qFObjAqml
         N71/C6Kc8j7BG6cIUMXv/92ykppOrqlxc8aGmZzHquTXR0BHeyO+lhd4DvDo7kBHLIIk
         IPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898995; x=1722503795;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4oGuLIbr2Dsp3IaIiiwO2hAfE0ofzh7pVJisTleI6w=;
        b=IUye+7UIgDuxtM+zV9+g6TSYZXTuf6zI37flyjhku664ZCquJztvLYyLFoTA9BfcVK
         QXL2LDrNjkSDewC/XYzROlwXCkDBCccPYoSQE5lG/yvJlVuwlSIG0kWlID1Pj08ptcl1
         fc/jL6ZbwLZUxWx/+yWcl+OSM3reLhscYzV1DC9fWnwz7pf6zJwTikU5G6yOVCkMoaZ4
         Pukluba2SCrE9IpBVY+VMC4hiUSL1ZUcWSVVtTwe+sm9tSzH7ataeIj0sYNDVJE1jkr/
         MCu+2CEuSdjqocxqU5WgZYgtUhiMiTpD8zdQcUphaRyHkGJiUbbAutzGfrkgLGIzs39n
         ozNg==
X-Gm-Message-State: AOJu0YwANSm+Rpc4k4yu+aWzv2/2lc93Kt8TPwPASkbMe9Pf+R9PFo6y
	8CwtL0pfsEFLAg7GxkKzhdl4MhQUhL7BIHhT1FYuFps3iKD7J3YY1L0LxBuimvA1vWurIpF9qaj
	uT0vN/0xRBFCWC8oAe7CIM4A93axzsw==
X-Google-Smtp-Source: AGHT+IFFLNJrg7svxczKtr7g5Aeq/77MkYQCz7aaIFGcFEFtVghNxgBtCCk2M7OolhN7xf6bJ1rVwPoS3h1+ijkCsz8=
X-Received: by 2002:a17:90b:2d82:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2cf23772e9cmr2579555a91.3.1721898995103; Thu, 25 Jul 2024
 02:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dirk Wallenstein <dirk.impersonator@gmail.com>
Date: Thu, 25 Jul 2024 11:15:58 +0200
Message-ID: <CAF5qVqoPcji2ZpRWg1NayRcNbbzMg_q5=XAKOSwtWU-zjBHY-Q@mail.gmail.com>
Subject: unsubscribe
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unsubscribe from all and everything. Please.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen, Dirk Wallenstein
