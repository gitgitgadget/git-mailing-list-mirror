Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548C4D9F8B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408172; cv=none; b=pvW8KbobQv/UN9Erq1cXNztbcrLSsZfxpmH3+Lr93bXPLsDX+3XUcNbFgStj+OHFjEuUL/KRJ6Sr46XONDUo3kqZvd88JHWn/PyFz6iWcu5fpZtwBrW71D2poFSwTR+qFpb1id+YmLQvK5g0L2/vl+/6XvK+1MtuOQLzazq8UGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408172; c=relaxed/simple;
	bh=1xXdh5Q5YYolzNm4PsHLvKfRfkrby+2R/RyJijvcUVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L01DZgtJ7jansgFmGRPxo4ot4URvJFMRkSszyhp2UiquPbKo9aEimOqu3kwiVrrhdv+sxktP5JzT7wAYK+IB7KH1M8WSgKFE1iNNGqrXGrZzkr58jzrA+065+3DNOO8JxOqAoAAqBtNFWJKGaP70N9ssmbMD/u2NVV2BgIRbcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=dagYb6hF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="dagYb6hF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1439005f8f.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792408169; x=1793012969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfyrS9dEYV2k0iud8YPLXlNgM02vLB98UFtPS/gD/GA=;
        b=dagYb6hFQca4whDtWV8MNzP0mY7W60SvLGmiwdSfWpr4Syh1OC16aqYYYRnVLWcuYk
         39DM253rierSJ3ePHR6c7U6/rfwxBthA6zfITVbrSB2X4LOsrSyqnIS/6XrIn+kGFpOp
         kdlhngkgVC8fA4RIou/yYynwmqz73fIaT/4jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408169; x=1793012969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfyrS9dEYV2k0iud8YPLXlNgM02vLB98UFtPS/gD/GA=;
        b=woDukSB6LKAbdS6RplEBrwWhcSCrsU3cvK3Y78YC33N22AwVCKaO9WH8LMXHHLORr6
         IeCCG0A+J0PhMvtQfDTdmwPC3SIb01JvSc8hjylUyAI8FmFkFgDtHZPEJLobrQpDb+eD
         yhEpo3kACOpgn8SWM4evEq/Y31aIkNJnFe3MmRbPCWQW8+ve9XDIenBWABx0DDeOt1x0
         V2YYqwzsjD8yH9RoklIn3o+lXzyUPdfodRGZHHYWyoKumDDKQ/1O08+2mfGeAnh6jtGg
         klsVpo2WL1w40CCNCR3Nl7C6k/YcCIPDMUJXJ/hVhWT9OUvlYenbgYPwFg7COk4zDx9R
         s91A==
X-Gm-Message-State: AFq9FYLu9n8V3UWLPShRwyW4CT1orPnctzOuOSY9AcmTCd5Rr2BLPkHf
	WRHCUYuf4IcvEfnioAdsi5x3Q1oKSFVeN52dSe9zKQFuI5h3t6GJsMJ7vIfXbzmEJCXvQiKP7ni
	TUTPtE1vvTg==
X-Gm-Gg: AYBFou1gwHG2GEl0QOaYOF4xaSeefeXcymsY8HtTOXt+0wWVroZ9SUZWrzxRxkErgx0
	2vvmN9e5BDvkbRfoLcyF61ROCodrbYoBEwKkUpwMLHPckUcX0Gw2nqaUJo/DlbbP77nK3EAoFAx
	tj8ufDFvxkftIRI/wFNatFLbydt6rS8fJlAK/OqTKoT4GoTXWsgwOIt8pcfg2EeK0nDImLO6UhK
	mlyCfKFhUe6CLGouwO3ex253WmCeRsApXPnKW/oHfCPrTGzBNA+HZJSJl6P0oJ41doWpXUmD5WY
	PY4FoVV+aRBBTiC9hEmKODZ9fBThBE12mSyMwpjD87AHjvbS0jZQEdYgHCfaQXAvYTEDdvWMoCX
	HIEXqN9WidSZ8w+yjw9j9SXT/CoIYVST9wZPjPm3UAyrsBM6H/D740JF5CJKnFc1Q+ldY/iiBU+
	DkY5VeJp3/i8iQ9M87v74Tu11pHCDR7osDnvRLwgRg9JzCFAGg8joqQYk4X04qH2sfpmgN1pNMv
	C+hpdDKhUkVnyK6h1vNI5QutOMyMLPAxqqz/Q==
X-Received: by 2002:a05:6000:4b1d:b0:48a:fff3:f9c1 with SMTP id ffacd0b85a97d-48dfae76fdbmr24123071f8f.20.1792408168781;
        Mon, 19 Oct 2026 04:09:28 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a97:4482:588f:b276:463d:6918])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm22208956f8f.22.2026.10.19.04.09.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 04:09:28 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH v3 0/2] connected: fix the connectivity check with alternates in deepening fetches
Date: Mon, 19 Oct 2026 13:09:16 +0200
Message-ID: <20261019110918.71193-1-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014181134.56220-1-iwiedler@gitlab.com>
References: <20261014181134.56220-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a deepening fetch the connectivity check passes "--alternate-refs"
as a positive revision and walks the alternate's whole history. With a
7M-object alternate that takes 227s after a fetch of an empty pack.

Changes since v2:

 * The shallow alternate test wrote $TRASH_DIRECTORY into
   objects/info/alternates, which git on Windows cannot resolve. It now
   uses Peff's version with $(pwd) and relative paths.

 * The trace tests use $(pwd) instead of $PWD.

No code changes.

v2: https://lore.kernel.org/git/20261014181134.56220-1-iwiedler@gitlab.com/
v1: https://lore.kernel.org/git/20261014103507.35317-1-iwiedler@gitlab.com/

Igor Wiedler (2):
  connected: negate alternate refs in deepening fetches too
  odb: ignore refs of shallow and grafted alternates

 Documentation/rev-list-options.adoc |  7 ++++---
 connected.c                         |  6 ++++--
 odb.c                               | 11 +++++++++++
 t/t5618-alternate-refs.sh           | 25 +++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 5 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

