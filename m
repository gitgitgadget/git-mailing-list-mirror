Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D352FFFA5
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636356; cv=none; b=Jc/AYJD8UYzVUqjecdDhAH+EUDGMGiWW8j/22Go5d7brrjba/VZCAhuPpsJkXg0kRDUpttVzP/M4K0wG24j+EpiiI5j9OmMibbhNN7gMUruJHH0v+8kpMtxW8jJKxe/jABxKmBDeN57B7XHVJZbxGY6j8MO6NTVbd2Rx4TUvS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636356; c=relaxed/simple;
	bh=FYObw+rxB/4wd3klqJd1tDaT05RQ5f5vwQEvF+Mzhmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b93CcbdKXVwB9OpwO3EeBE40Ivu/ZarWb8VeQyj+yvDbZcy2CfhT92VuIDlUHt55+70LQ/R5iA8jp/hwQSwm1DT8Jw6TlF1LZ/WWrVOlkLNitruarx/oTVog4BkuKArYEGbnkFPeW4eVMe96YZD+M5Sj9tEiTyslGd2MwkY0sFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv2rBxmo; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv2rBxmo"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5e19e72c2a7so51911137.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767636354; x=1768241154; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYObw+rxB/4wd3klqJd1tDaT05RQ5f5vwQEvF+Mzhmw=;
        b=fv2rBxmokvjkQP/q3PFVgoOPUe++Ee0cDgus1Ls1XVxInm2k9jmBARReMf4zRPXCFx
         p+sGO4xJufMKK00BD7WIIfOreoHwjJ/E19bs0+lnPx/1ZB+GdPbShtX7Bd64vMe1raO9
         C5vR+eI/6HQwLhJw0sieP6kjZC6RiOg3oh1DUINAFQb4dWA0cj9tWCpDuBHZbL+aq7ef
         4yaQOk6cLcOP9jyyw0XyNt/g8gmrR6rURPW6J/3Ia2vo42SihFs5cBUgyt/0a6Jh3VxQ
         oq5RymrDvZ/EdGRb0TSxqAjimuUBoXBLTe7rD3jXm+GNtjGT1YfwcL5IFVvLC+MeBQQ4
         k9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636354; x=1768241154;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYObw+rxB/4wd3klqJd1tDaT05RQ5f5vwQEvF+Mzhmw=;
        b=aUqDIpFCBJPRpeLwTS89sLnI+SWikVFsncCgW1QYr7KDHNCfwVrsH2zttUiHrcn52O
         L2+6zdJPs5nj2bdMBsMktmntEblkcSALUoeHq31V0bPktHMYH3Q59Pa1R2+cdK16w11k
         IS8XncZPPYRexvF8PqOc+WQCwgidzfHdV2eItMnFx+kc3I84SlshZX9Xs7NzyDmTBMmm
         zl5F2VxKlszWjm/FKs7fPDg+Xa2Dj1L4PO+NrHVmAhAwpDv1cPcIoayaAA7xZU9nf5kG
         aWkYb2II3L0Q7n3noDMOUbbnMO/4xqM/BlAYRJuOyHxka8cxS23j3XoPbKs83ItZeu6F
         wyTw==
X-Gm-Message-State: AOJu0Yw9WS4VY+YK5yKvVOj79cYmTRHDV7L/SpdWWY9xzspijWFZ+7FA
	vNDgYiq4EgcWPcoPj89vk0bpU4bL2FE3EkFSzc37wqLFWXrU61CrRllxBADMfuSqtvaioUJYJXB
	8Qx6jICGrx1gATFD7zUnNhEozt28BKlYnfjgL
X-Gm-Gg: AY/fxX7A2OSx2dhA8qDgyOFpJQu2uovr0JY7dUMw0UZmrKkHzRsvpqZAX8yHesZdpMM
	zn8i2S5bx+qKYodGqxO0lM2cYvT0sQn2Cosrs45mOPDcCZn6QRiEUMOk07AEwu1nwhfpYqOtSRr
	BReD9JCZmIzODvgHWW891pnaDKsX+ohKfgIkRt8YFG/g4w1DXMn4i4a1+rthSdpKl8jd5EoacGv
	ldz6uxqKGEIwc33+898bt3L9KgZFfi1VqS4S3y+KBYvdXIQQ1JYZylSe6ZSL8I2D1q3L6WIf5O0
	CBu6MQvGGOT6d9qpCutI/mFPdi35
X-Google-Smtp-Source: AGHT+IEzQvb0+sRdzMunN+kV0fp0gnvLhwGYsBhy3iE6JHGsL4WIZ2fl5zqa/iJ0u6iam2r0skJeDpllZBBvFFenqNQ=
X-Received: by 2002:a05:6102:e0e:b0:5df:b5d4:e46e with SMTP id
 ada2fe7eead31-5ec74520844mr83460137.32.1767636353868; Mon, 05 Jan 2026
 10:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wayne Rowcliffe <wrowclif@gmail.com>
Date: Mon, 5 Jan 2026 12:05:43 -0600
X-Gm-Features: AQt7F2ooW07mlRH2yooACtWF4dYw3NZid_oN1cv6AouDBaTQmH-qWFO7eaoqY3w
Message-ID: <CANG6c1XhaL1poT2Myo2sy4xbu86vAXO0xQKe33vg7pERmx=TbA@mail.gmail.com>
Subject: I still use git whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I tried using git whatchanged, which I use probably daily, and it said
I needed to send you an email that I use it.

It's very handy for figuring out what files changed in a commit.

-- Wayne Rowcliffe
