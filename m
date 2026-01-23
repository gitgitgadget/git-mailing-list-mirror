Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF24311C27
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158461; cv=none; b=Z7ugJnwYI1ltcYnuYR9Fqcnq5UXkFgB76lNXC7QIpG7jNCEXy6cFQhPDcX7/0pBRGToOqX6dCGLpzLFBHPNmLWaDjzu4/gCAc1lf54ToUoGd/FkvfsCzTFcUwXmv4ukQJc46JLYMmSnIATs1LqVfiBqmqvZWxWmsf1YCHve81ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158461; c=relaxed/simple;
	bh=HZvI3KhbtnODgVnvBGTmBo8DCAu7evkJSLoUl49ASm0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t0MRjP61ft61l//f6zHFUPfS2Xi9iGCUB1cXwHxrNvUy7i1vQMS+HOCsARTgFEwPFZnm0KSDRRQrAiFIxRiatZ+DAAlPoHuF4H5csD+wSl48BNRY50rt6TtYOlhxZ3/YSFX2obH2zwA24SAMpAa7qgPXEYgvC8nvPSWZ30CdsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIDYIHR8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIDYIHR8"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fb5764382so20241677b3.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769158459; x=1769763259; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZvI3KhbtnODgVnvBGTmBo8DCAu7evkJSLoUl49ASm0=;
        b=LIDYIHR8bj+HDvhJTSMQIZdm34h5/8CSj62a1OXFBjj6EynlKa2KPAyMb2lZnPz502
         IphEO58JdKzNRPT2ARsHYEJBnJchBH6+AeknKz/B+gOM73ma3UFUast1QbZqAU8rj9OK
         jthyjKp2CqNsq1jRKGR5HsP9DPbGUxInzmRApKxtpcbl6VOMlMJCFp18697IRyBk7cNZ
         M5Eb/J5ABFQ0wjhNEBfZOd6Yw37SQjkA3QsM2m4rsnK6X9l4hBpyXdD5ZyEygWU/4hAe
         3Sx9echg8Sln5bP5fBHNzyd6ZSTm94JAz4in91viY86QCWfNU/kr7vxFnuB7NHEeOFa7
         a8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769158459; x=1769763259;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZvI3KhbtnODgVnvBGTmBo8DCAu7evkJSLoUl49ASm0=;
        b=HxgB87q7MLRL9W4ThKzX9NaHElK8iaZJT0oaKe5xD3NSToRpMExCsaUKQGjc0VjLQb
         YwADblk1cspaielRBL/Kzc0OtI1QsKeNW2UM8i+AL2rxWlt0QU7IaRbS8e5FwQSrLY4O
         p7Y+jy2PpuhIVq45wP2Fo4+PJdl8XYpAQngNngryXE4ZV9x+8pCRj8r38i+jV5oDtuLY
         we/9mjWQyOrUFq8YuJrLvaMG6GIETK4G3b5OlWPpAEvtH8NMzql87sLM58DCkZLdn6Xa
         GnIfUrJz9oM1Gdux4est9Sq2JlQJO2TaIGWZEhLlBX4jWZT8jJS6YTtN3dgC2PpPAVKu
         JQ0A==
X-Gm-Message-State: AOJu0Yydw4tIZNaLctCdD6Ex6T3nmZA0Ld4bJN0zTTotCEd4UEWihO/d
	nAggCMRgPQXwWO+NmmgjgTsBb7UIE5Zc6aqPukmJL38RfwUMcHkHt3rW
X-Gm-Gg: AZuq6aLfBHCmdWBaq8xPA2riX9hhllRrjOOd6U4eXLIY/hCNJNqfmwPaFjHIbx3iU5U
	8sjYsjCq0FMy8dSjvon0RXa0nmAQn93AU3AjcxplLo8kWDdHRGoRN1Sjzca355NW+mIR3BJv8PO
	oWdpdBnnL8EYcG3kR6DFljThJ1eRh1Z2nfQfx0Tqq8fLCRoEZh/Pu47e12ayoakUpkN+xqhFlnt
	DgK1q/eadxKMsAoyrUxJOVw0auEYRT7v7GHehOvVampBXMAxrydFB+rhh6GdDZQDaeW1bpZz3Ez
	7PPyjwJ1rHUciKsizO8wTCw2ite2kr8dXKviwq1DddTuh8Idya4OjXQxTtuqDL1RhidcrZMK6EY
	SW8a4XhUGjxkQgmvfJjPLZtLoVIZvDov6jJnKSnrWPOCyVwAAard45OHm7a9tsdmQKZrEejEd9d
	Va9fajKd9axUdgydxDoTDMOLr33M/S52zczIj90mlM0ffMrK1w0gOc6+hpIHJXuuiXkzfDyG3gP
	D/dYBWjg0k=
X-Received: by 2002:a05:690c:39b:b0:792:75e3:2c25 with SMTP id 00721157ae682-79440b9ab09mr3224757b3.66.1769158459396;
        Fri, 23 Jan 2026 00:54:19 -0800 (PST)
Received: from SL2P216MB1885.KORP216.PROD.OUTLOOK.COM ([2603:1046:101:97::5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2b9e7csm8036707b3.41.2026.01.23.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 00:54:19 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: "peff@peff.net" <peff@peff.net>, "gitster@pobox.com" <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Pushkar Singh
	<pushkarkumarsingh1970@gmail.com>
Subject: Re: [PATCH] reset: avoid reflog update on no-op reset
Thread-Topic: [PATCH] reset: avoid reflog update on no-op reset
Thread-Index: AQHcjEVGzCYZL1GDmUa/efyV04yKbw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 23 Jan 2026 08:54:15 +0000
Message-ID:
	<SL2P216MB1885C5C9B75A38AE99E5511DA294A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, that makes sense.=0A=
=0A=
I was reasoning about reflog entries purely in terms of reference=0A=
updates, but I see your point that "git reset" also uses the reflog=0A=
as a record of user actions, even when the target happens to match=0A=
HEAD.=0A=
=0A=
In that light, skipping the reflog entry on a no-op reset could indeed=0A=
break the assumption that "@{1}" reliably refers to "the state before=0A=
the most recent reset", both for scripts and for humans inspecting=0A=
history.=0A=
=0A=
I agree that this makes the change questionable as-is. I=92m happy to=0A=
drop this patch, or to rework it in a way that preserves the reflog=0A=
entry while addressing the underlying concern (if there is one).=0A=
=0A=
Thanks for the detailed explanation.=
