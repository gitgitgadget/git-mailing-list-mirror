Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A9146A85
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405377; cv=none; b=Qa9kePUhZDUN5NnQtRzidWnFMNzkq+Woh9OVpPey5f15fRF+N7kHrxqtjQpuf3Kez+Evy/s0zl4dxt3O2Wixr0R7743+uhgeiXyZjR0nivKsE5Pn/CcqiTqk4yHdK2gl6chcRpP6JnXexN68tiOszTdEm9o+OsiCTOBGCwyGWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405377; c=relaxed/simple;
	bh=6Z/GqCzYUt+zyNGn01Wo3r84CLCeEKW31+tLC7Fm9zM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LCyANVZoGhgMXoUjhyq5quWEsgs4w3eKupD1hBfAkFLt/ipYW43zOW7BM0qngOt/DRZIJCQn8Sp0Yk++t7g5GITci/+5DtVfdo+NnE6J9CiZBPlJ/BIuZkd2IP5P/Blb4w1Hn9frjd9jxPtuF9ABgblkfppsYPvSDiDhC0sOW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gre4EQh+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gre4EQh+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso13687445e9.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721405374; x=1722010174; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Z/GqCzYUt+zyNGn01Wo3r84CLCeEKW31+tLC7Fm9zM=;
        b=Gre4EQh+x2e4Bz554GiIhJcqlgUpxKin4KVSbZyPJnXpeud2M8F+FH/v/vwaHo6sg8
         AUfnZMt0oMD3I3vJ1+CFk7HSheH5Su9c4QUfe8fwRRsIxa+E5R81geoZPtH4acdiEK29
         FcSmunyeQaJ5ofRZJlb84J7W3PcxEesi5CuR3ICgW+0nyGZLBJkyTrYcOCckoVO0234B
         660d9Btlqomn+E19peiuuNUaRvG5G5OFbjmlOlhDe7yIIypl4KXl+ekN2WEObhQffXnT
         mEAiLFL1pdLJYOUCbMNzyknt5Wx3Lbzay+fmE1/0Z57vGp0Q1Iz/u9VJydwyDj4E31Hu
         zicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405374; x=1722010174;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Z/GqCzYUt+zyNGn01Wo3r84CLCeEKW31+tLC7Fm9zM=;
        b=VOOWet6ia3cbvmoEkt/vJT9HGPJz0uKYawMk+w3Boalj/3k2K4V8BtZw0Qv9LDqHjw
         2PYt5vjiCrD7DIQNrxTDIRlcw66p4cvc8luEa3tHz7GdSPFfNBtINpUIXl1NApRuvbWu
         mTCz56KZSz+g/7cwju99RLYPzprO5WmuXem46Egj7BT4B2RWXboWtZ+luN6Gbw0IsmRj
         jQR1lr63cQ4OZevSKGTUsx+sTPVkdZYZuLsFbE5n5MehGhXNoqNS7dwXHzy5LmhvKvco
         0QewhQH5Y6MR+Ba7z09j2uYFyOM74Cnz8nYV+zkN/gQSWIUYgWFa5nk4mJjy1GzYkSt2
         kuoA==
X-Gm-Message-State: AOJu0Yx85t2HvcqsR41izPqrxEmFLd3iOXEz4pKbR+WsN1h9c/dzTLA8
	qNijmre9JjP+MeNksgowYMFzaDzlO/bvawMbkK9LdkaEPSRSahM5gdqm2JkR4kDX8VpcH+fYZbw
	Pkzqc9N1MBPFfW50EZ0QyAiL7cUq49Z2vgJ4eBkpNWoF2EdUEVJdz
X-Google-Smtp-Source: AGHT+IGzdM1gHRPv7TDIfE7vYZcitME3CV7voHkJnir59RnnZKsAp1kHDuKFhLuh8vX6ddAyXLgnH2E8ByCiM1BWhhY=
X-Received: by 2002:adf:f7ce:0:b0:362:8201:fa3 with SMTP id
 ffacd0b85a97d-368316205a7mr5869992f8f.34.1721405373305; Fri, 19 Jul 2024
 09:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cory Kramer <corykramer@google.com>
Date: Fri, 19 Jul 2024 12:09:22 -0400
Message-ID: <CAJ7O7F7Zxd-FUbdJh-zxr1FOrUmZQuwx4CHLbQ-ppbkSN79Z-Q@mail.gmail.com>
Subject: Documentation Bug
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the docs for git-clone the brackets become mismatched for any
options that have a [no-] counterpart.
https://git-scm.com/docs/git-clone

These include:
--[no-]single-branch
--[no-]shallow-submodules
--[no-]reject-shallow
--[no-]remote-submodules

For example the first option will render as "single-branch]".

Source: https://github.com/git/git/blob/master/Documentation/git-clone.txt#L12-L20
