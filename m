Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE014D435
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443575; cv=none; b=LBzFWTzE0L9TYuD/7iZ1ZAlBkOsd+RfPUKTu3Vj0p/030em7k3ye2BNTBA65mZ8X0pDTCSP5MPIpECltJwfqaqoq8iJW5hdnarg1rn+luD1TdiaMwnO+5CWDkX/w2ucuK53gsvhg6Zn6USbFPj7wafYp9ZYWQ1iWS+/MqFK1lHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443575; c=relaxed/simple;
	bh=lOCrZ9aQiI7wytX7Gp80o7K17JB15J+qCMDBveR2mPc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FVSzGaEtX85HoebMzzFwYJN5j7cgKRPcoYMNQE04hr3+psZEjPvLRYgjgZbxXzOP9VavuLf0HDBsZMcWiTl4KcjW0PUgiO9ks0PIh7j38g+dN7pFWvs/w+CEBgRcd9OYpi0NAtGFKGO70UhS0PjvYcjetxnQAcvupQSGPloU7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwkVl85i; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwkVl85i"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bbc1cee9b7so24651246d6.3
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723443572; x=1724048372; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOCrZ9aQiI7wytX7Gp80o7K17JB15J+qCMDBveR2mPc=;
        b=AwkVl85iCBMGFGl+l5VEAs8zuRpSJiB2NDPIHk+ngtrm5PPHDG181as8ii7OLs0kYh
         AcOtSblPJa8OSoJg9zQ+gIP1ufJ6Pfq5iMKtdcDwe1FkSSVtUVuhOzx9emca6fiIdeq6
         8RTmd8f9u7fYMq1eTcDQq8/ZcpzoHlhlPHasYoTT0S8IpHucA0HAUkmWAEWtbmEzw4CQ
         +Y4qvtnFBRaaiZyYIZIGVdqcg6ADwcTURQw71yQAD9DRX+Y9POxlUDDaW/nO31LlMXRb
         On0xjruihrM9Aq7aJZKXWHq8CBNdPFXgmlj47pHooXs7JYKKstVdNDc50JHzJi2Z/ePd
         iWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723443572; x=1724048372;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOCrZ9aQiI7wytX7Gp80o7K17JB15J+qCMDBveR2mPc=;
        b=GKVqOfI93yA82UTc/I1xzjYL8DWSYmBIjFoz6qu2hJlv8xgOEKorNC9bsaM1/Nyd0F
         1Cc8xgVc361lhT4k+3915J94G3/a21kKbPmX02K6DgEuCk2ya6mjN2ph+66HipI8er1b
         e1JTiHyH9NePDC4B/Y2eEroVC+LlLIdMQnCGzb2owpBHBi/lP4+ufgbTKRaOeVDIEyFq
         MG7r4Q1+R/DybVO1fS+13Soq5tefbeCSkwSWbBxrGXrA74gksaax/v+Lldt8lrKOhNRh
         aqCvDgDFbHO5B0LulouEdyynfdhmu2szDQDlcww8zwqzB3s/UdU/DjWsjxGQEz2x3ced
         cSfQ==
X-Gm-Message-State: AOJu0YwqpGa/FQB+amK2WX2ifjsK+niCHj+SCdMWJb12qqhacNwGfx7x
	3cVVeO7rg5blS5e2fazv8Bj5XrLLzMZjXTMc8eTVzuWnpl5MHJXms5QFvV90pdDzyE0dZJO9oDa
	k1mFOaepx+vncg/iww5KTYpytDztKawY=
X-Google-Smtp-Source: AGHT+IEbPcnjwNc8VmvHox3QA2SCCnbEL1Er1w3FV3hV2nhcikEh8iSRb6gejwbl4JpLMGxclUCmpxDPFlpBtJXBKAU=
X-Received: by 2002:a05:6214:2b99:b0:6b7:b3ee:5d74 with SMTP id
 6a1803df08f44-6bd78f33a56mr78937066d6.50.1723443572459; Sun, 11 Aug 2024
 23:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Junk Junk <shealenjunk@gmail.com>
Date: Sun, 11 Aug 2024 23:19:21 -0700
Message-ID: <CAAyo-VCL9tsuOaZrngciiBmbAKuwLtHxtDwaU17g1NfPEbwgBw@mail.gmail.com>
Subject: Feature request: `git rm -c` shortcut
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

## Request

The omission seems conspicuous enough to be potentially intentional,
but I would like to recommend adding the flag `-c` as a shortcut for
`--[no-]cached` in `git rm`.

This might conflict with `git -c`, but git seems smart enough as it
responds "unknown switch `c'" to `git rm -c`.
