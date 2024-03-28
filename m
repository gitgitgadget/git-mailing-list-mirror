Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096334E1D1
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611982; cv=none; b=YAFJDleYGcsu+24t2RlzsMoXUGvMD4+rX+kuQ8T84SjxL9ov1ysUFm9XaqgCPxPVmlBAcxzc9l6NXqjFFtMCyWYXRZodmKIgW7x3MSFlJ963oxDdu4wqI3GkVisF4UpubvZ3In9goKcKCrIyxkvLeyBeq4k33CPPfCwPlfjAX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611982; c=relaxed/simple;
	bh=JfnA/kSNzcruukZtdhVYRT6lafgk1OhXzaMvddIZJss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZHcphEG8h4Qz1XEoblwYbX6AX5+4idrCprVJWUyrEjohHrRay0nPQTDDPNPcKdT8eqzJeBglko+caRAmxRKJRS2RVubI8xdpZZ+NuLtwXE3PhXd2FAnEl/DwBQjpipNYFX/5+cq83UVAF7+YWTS1RlTtwgwysecQ8NX3erzP7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1zAAVXg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1zAAVXg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609ff069a40so7241147b3.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711611980; x=1712216780; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JfnA/kSNzcruukZtdhVYRT6lafgk1OhXzaMvddIZJss=;
        b=c1zAAVXg1wZ4jV/1LgSKvcWFKgVOmxXMBdiWk8lyb8/g3Zx1NX60shqxfehz/EyeYv
         uVMXOGs+a1fKNZNqgPloLvt+5g17zp46VPsjJLrBBBkzoIUTyNp1PWi0Fq9TroQoGBrB
         LgDQmcCo6wzecAsORr4GU/9LT78uLT5aeAmr4h6CGbZjVcOYKXA51rpW2J6Yuyxixxwd
         TLskiJGuZ+2oWLOqEw34i6UVNs/1S7RgdWK98+7BBWKuriL+HcjwHWHHKQ/QxPkbJLsU
         kFoPS5/E+1LTerN4YHojMJ+xE1OkxIT/5ovSJw/xeyyyuamrT9Z1OSbxZy+vQ81BqusS
         MTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711611980; x=1712216780;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfnA/kSNzcruukZtdhVYRT6lafgk1OhXzaMvddIZJss=;
        b=cVk/NDrY3Vw9VqUylzh3MR03cX82kdjFumkHvxP1X3XpXVfhdv0U2ehHPm3OJVddzQ
         65tbzYPn0uaLLa3tw9XJDS1oQHDSUA7x49dxFqq2NJu5yv2vcIRZN8f6Y1fJuHgOqQDV
         J8eR0AEq7UVlV0EtKk5JVnbL3t9w1oqwa2M61x4kUFeWO7v1cGSzafWc3PWf6rbruNj/
         /QoLZUvG3e0zhX9aQkC6GkFBg9yBOv/IqNh7tlBqRvoqUE+oETFQa2z8oMBfmZVGDf3A
         zS+r+4MWw9ADhJJwVozSgq9eQm/RQcBP+w6TKK+LjoMQZeQpMR2yW3yEYvadZ0cKloBT
         GpNA==
X-Gm-Message-State: AOJu0YxbAK0Ww+XFi8OqRUi+jMxdeJJ9ywLrMuJUv0KRCmDK7KFyNTck
	P2eGGXxLRP/MEYqkCb4twmTVb4nZMnN6BoZR0Vjwh24pgjXsLTZuBKiOKmM5Nw9teH7W4jJBvP9
	DFWV1Ru2fWb25oXftBxElMcTWLJdl0m4755w=
X-Google-Smtp-Source: AGHT+IFKDIgynTwS4ZpJzUFFQaB6uZdsypeOJiz2WHW+ut8sAQLLs0tspbYdZDjXmIEqObMZSwSttJggk3vyiLAuogE=
X-Received: by 2002:a0d:d401:0:b0:611:3105:93e5 with SMTP id
 w1-20020a0dd401000000b00611310593e5mr2016111ywd.17.1711611979988; Thu, 28 Mar
 2024 00:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mohammad Al Zouabi <mb.alzouabi@gmail.com>
Date: Thu, 28 Mar 2024 15:46:08 +0800
Message-ID: <CAAQqY-NKvWMLo_Bcby5-QYPOj-jbWeVA3zGL=_sq2p2bGZQBEA@mail.gmail.com>
Subject: Ignore specific changes but not the entire file
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The problem with:

```sh
git update-index [--skip-worktree|--assume-unchanged]
```

Is that it ignores the entire file.

Is there a plan to support something that remembers what was exactly
ignored, and if there are changes to it, either un-ignore the file, or
display the hunks that were changed?

Something like committing the change but not actually committing it.
