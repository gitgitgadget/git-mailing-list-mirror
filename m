Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49771319870
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251432; cv=none; b=IG4sa+loOlPinVQDC1aoGepwNHp2g82+jLd3vGRPTWhSxZIpFnYJBL1Z+1aIc+fLNdSa2Ns0YZ1BQuThNZj54nQBOI6jz00cMqQujT66KWCHibvQnc6/kw8bHHo0bGYGfKjME+tU8K48gH4F7tmTWqcPNlGdnHyLSx2MKXEtKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251432; c=relaxed/simple;
	bh=7EaOKBOk2OZELxQvTpbd/v+j66dqvm5ign54mtGJN08=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=s2bzwydgd/Gk5PC56jCn2dZcrbcnJuHI7FFQRYJLICRVHLXKxfr+w/SG0mZ8HIwJKI9KfZab8TIjhG77LKnxCBCY0xyztiMsWmEQiub+D1T5ydqTuabzfkbyFkLsJqJVxOmbYvEg2DqF28bKpFkgkc5S2Lp1iF3R/oByc3MXDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANFAjYuC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANFAjYuC"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-333f92d60ddso13196171fa.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755251429; x=1755856229; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=evbycEvweMxPuuE519PwXKoxvDSvxby31FNXlE+FaSI=;
        b=ANFAjYuCtRAy+6jGK7QkQw84wuyL6YjZWdixw6Qd1ZCAg0jXPeA8ZUCpKYoHT/ejmU
         RwcqkMEbLrFtPSoi7CfZoB4Phd1rp5G4US13KgBtOxlGSuOFf/3/BjVfaujH/ArI3OW6
         oeQTTYE9zuBQMHkW9RT17cRajg6Qba5/Nqa+139eBc9bGPqs3J99ixyFnYgnLZr4O6v+
         ir4s88jBs7ky+wJXporTttMbDfkq15KyaqHMnnBtyNFu9ug80U9ujm5FTH7/GENpk75G
         SOFIeCrvXMi5FFvibbKBD61E9jAJBgB99R1g4JAUxUL+YGwZjLtxMnt4dd/OmFLNBHgZ
         IjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251429; x=1755856229;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evbycEvweMxPuuE519PwXKoxvDSvxby31FNXlE+FaSI=;
        b=kM6mrn7L7f7JG6lUPr63f0QqtFlHarqKt2RPILioJ857CFmYNsDvvfECdJSaqlmg//
         25ItnFSdw/Tt3DJ8s4xeO+Xt/aFCaQiVLKJG6ojA1Fw1abEBOg04tjxUqjHqlUwO7Svp
         uN72xYctOBGOwX7p8bj4t3+GEnolm66qHwzuzurL9Yg4k7zofOsMN2/T7zPtDcVFEegR
         wNc+8Nxfa8cNwGHu0/YzlUJ8uI8LZdV0g5s388OYgo1K/Dz1pWl6ZeILHhxTJtmdnu/A
         DgWKuhpMUwiCOw9N0+wcS5jD03bWR4bYCpWe+cco6qymj06SJnh3w/HJ3yJjnXLvDdMS
         IUVg==
X-Gm-Message-State: AOJu0Yw+k1TCTh9h9nJ7Jwk4D4qa0S4sJLO56yBUiObeTRAic4JyT7go
	XIM+gOL/UGlyBC36E760Kq2rnlvWobua4ljrSUkyNXltXs6ts8QGDR/wN2p31cj5S5hQIr0KWRN
	HMGfG9U9rvvGmZLJMeTWlAhrBUoRf5K3Bskw=
X-Gm-Gg: ASbGncs+LQ8C3X6K3j9hdcuNtpjTVR5iZaUd+qjUiaQOXWpnuHcO5QJrFGIqCznARMx
	u5mFJU1ey/TpS+H4uqVQtamQ+ZKJI0wy21eVcqgp+dxciQguTKLciF2TRBVCy3N+ebT3An6oZf3
	QXnU0GQxfN/bWYsEZn5RaV4rOKRP8exvPRBq205jvpMZMx0d1Nrk1HjSEwhFR5uWU5QfcRXATEF
	2NDuOCRvaVX/IoEgIDomkQInQgqm5PwgsaU1OIC
X-Google-Smtp-Source: AGHT+IEqcLITzSLctJDD9CdA/yr4uxq4HLCP4Usj3Xd4gpyrjrmH/McyuPttXurS+pjYolsa72nBZObUy+n8Hs8GTu0=
X-Received: by 2002:a05:651c:31cd:b0:332:63d6:9a06 with SMTP id
 38308e7fff4ca-33409a0f8b7mr5438161fa.38.1755251429202; Fri, 15 Aug 2025
 02:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Carlsson <carlsson.richard@gmail.com>
Date: Fri, 15 Aug 2025 11:50:17 +0200
X-Gm-Features: Ac12FXycNAd-LnE76B39j45SzgBYGmO62fgW8Jj9cSSgYj1bh1JyRLGIyVpdpc8
Message-ID: <CANKG3zmtFmFfUDtARuOyAgv8Le+Rotwmdv-sWWnQ2Ca+7d0DRw@mail.gmail.com>
Subject: git may delete current branch on case insensitive file system (Mac)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This was a fun one. I accidentally upcased the first letter of a
branch beginning with "d" instead of
upcasing the -d option as I had intended, with a surprising result
(Mac OS). Easily reproduced:

% git checkout -b dummy
Switched to a new branch 'dummy'
% git branch -d dummy
error: cannot delete branch 'dummy' used by worktree at '/Users/riccar/...'
% git branch -D dummy
error: cannot delete branch 'dummy' used by worktree at '/Users/riccar/...'
% git branch -d Dummy
Deleted branch Dummy (was c32dfb2).
% git log
fatal: your current branch 'dummy' does not have any commits yet

On Linux, you instead get

% git branch -d Dummy
error: branch 'Dummy' not found


        /Richard
