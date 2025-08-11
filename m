Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08681E555
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923671; cv=none; b=cqZdmKgNPNN/b4UAMPjFD73K6XfJ66qc+CFTaBAQ/i8ulyxbRLFCNfbEbm8dL27+bBVEzCK6lh+zdSNxQ9ui7+BWBq/cJXuwu8Yr3iCVOyQVgrjRjgwDZ+JcMS8UlOXmmLZkBW0r+G8f6YatgvclYGDqs5oRkw7Sx4zqDn7g40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923671; c=relaxed/simple;
	bh=ute0VcaZ0fKrSlDkMS/ckrknxVE0txcmvJiBrwA9lhE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ge0rxnDPLITMEeyVW2pXhiyrfaT49m/93eaoqKO55BNsMlpuuMERoLEoZzSb1QY0cTIyslIXAxNJmU88KwZcHBKdctaQ54q5/CxTBgHUFkoKabNs9NqGDe3KsWRer8lGhkFQBds5CcyW2uV4L3JYY7wlCRs4e+mZVtijgbwMaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJw8tVoc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJw8tVoc"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30b7eba97f5so1506617fac.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923669; x=1755528469; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2VfjAttlVgu+sbsa82z9ipbqKF+wab93ANLbEavEgU=;
        b=PJw8tVoceUb26W2Fo1DLQRC96gxAYgnUIwNijWGQJkH+XMek6FxvEDHt8QDGZ/nXOK
         j69zC1kcu74WJzit7x7OTrifNrnitxtjDsZ8hyTGs5gBQuJ6U1Y3N6/pAf/JUNyeVNcG
         TrdJPCuO9RL8InzGybTqqm97RpD4bKMPVbKI/3UXAO2aEc4CM8X0jZ52MwjT7vrmbjz+
         CJXOPlqpuM3EGQvnx5BNvYOJ1xWUkc4vFdAajEkznWtPIUYmp9aYw3pqj3MggO6jmNgo
         gxi19qmjXE3JEbq8OpZh8smTrK2tpf/RHDohy9EMbWl7nUEG3gHOQZnd1zqj6XGBahso
         H3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923669; x=1755528469;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2VfjAttlVgu+sbsa82z9ipbqKF+wab93ANLbEavEgU=;
        b=hYn0tP2U0/8WJXIY59CXy8Ht9QYxj4isWd5d1sjswPQ3fTapbP0LjMVu7JON+C+DZi
         KaLwJKQOeVt6uHH4/wqoag/vxfD+M9qM2QqDRXhv4Ga8eMR7NZrXPVRQbBa9A834gjlw
         OGJBtMen7hRyKOiRmDpUjl6LbZaN92oH+eL3U1uJLUM6UqjDh2LkHdjWNFABGMbd84nV
         LvPYH8iipMl6GIa9r9HS0snXrdcKHs0Xly9uQWCo6f5eT/1kJ9al+VorBivRqYmW8Uhr
         aNJofy7ZVJcWE/f2BRQAfXEVrmYgWoxzUdjSC9RNk6O4Tgyct6uzefap5XWR/nmTJD1r
         RfzA==
X-Gm-Message-State: AOJu0YwqByThkAX/gP4b070Ql1bHcRK6Nk5ttS31GUSO15b+RNjqT8pl
	lwNIgu0AeKShLWxM/uXfhD4z4VqgMgRpiwCvibnXtdU7nOVhhjGzmSKkhUXEZr5scP/uFGRuVMW
	HfT80twFP78k3mjAy6OVK+k1HODgrCKiUuzey
X-Gm-Gg: ASbGncuVkAr+g7R5GNGzUMKvRqOJWGt089LlwcKLEKSIhPvn3ND9Q/+yRTJ2xAAVURJ
	Gb5LyQ51haQGavSv2LjZQriNCgK59ZrUrqfm+Y4IoJuqgpZULsZyHjCFtJVOUVV89E8aTgyRVvE
	7wF2PYRuOko74i50GysvCuaAQINJT+oEezpjcYYQAM3GyyP+eh44AA62tTR2sCc/s7NppCxQu9/
	qoy9fo=
X-Google-Smtp-Source: AGHT+IGZ6hp3evnsRZfoXACu43F/tw+OPbiu/v3rPUfdC+EIYvy8EjeuJPduFonFGutMbv+7fHk/fVmYs/7cJgTWt0k=
X-Received: by 2002:a05:6871:a207:b0:30c:46b5:6a92 with SMTP id
 586e51a60fabf-30c46b578e4mr285831fac.2.1754923668934; Mon, 11 Aug 2025
 07:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ryenus <ryenus@gmail.com>
Date: Mon, 11 Aug 2025 22:47:37 +0800
X-Gm-Features: Ac12FXwrk-F1pjyjRD6Ch4HCTx7fd5s0w8-5_2pHLuX11XY472NML7AENXkJ-IY
Message-ID: <CAKkAvayK9WRBLtPL7XCsBP=UGbYMnDYE6+EPRpCxJioryNeBBA@mail.gmail.com>
Subject: [bug] git clone: -c key=value missed when cloning submodules with --recurse-submodules
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Given 2 repositories, the 1st is "parent", with the 2nd as a submodule:

* https://remote.host/parent
* https://remote.host/submodule

When cloning the parent repo with the below command:

    git clone -c key=value --recurse-submodules https://remote.host/parent

While "-c key=value" is properly applied when cloning the parent, it's
missed when cloning the submodule.

Here the actual key/value is something like "url.new.insteadOf=old" for
authentication purpose.

Fortunately the following works:

    git -c key=value clone --recurse-submodules https://remote.host/parent

Ideally the first form should also work.
