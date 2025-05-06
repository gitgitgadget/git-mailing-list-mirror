Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC62222D5
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551260; cv=none; b=uX4zlpDvbwf/IrN6ako9EBCgblPboV/gYUa7x4JCxCg+1Spyj49JJ4/CaOrCZlKz3tpFRIiMRv5SB2K6Ys5rmBScAitJe95N1yOKwkV4Nr/BOPy36YkqLdHeSqnKjnymHtfpFbVuy5CS9YAI3OzCRx/6Zo2rcDPxbwf1264CXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551260; c=relaxed/simple;
	bh=42eLmT7kYcFWWjHx6Lb/V5oumtwrIpUIY80FWf81zU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayJ7D13c+kO+crlzlsWAfkMh5RvuvCYCPhOM8eCT0H3Id0LfPtyIGBn8dnEBMIx+OdaxrwnU0vLovkRFQQrdAvRRoiA6JESeN5YWRTkKQXpen97vHUtmH68M4S83HUgKJQWYzlll34899iI1E9I6uGbgow7maCZ0pQnU4pTkrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJfpZoPR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJfpZoPR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54af20849adso85716e87.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746551257; x=1747156057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42eLmT7kYcFWWjHx6Lb/V5oumtwrIpUIY80FWf81zU0=;
        b=fJfpZoPR9txGuThSmSwygC+H8hv5bse8cqnX4GpL0xu78J5mDEwefhC1TihOVTRy6B
         TqVtc4AW/eKs2HGjMnQiDkxhkLlHcDy/IW2GO+rsVe3rfbnER0xJFrvHNRAZ1veGWcyE
         P2tmzGFnpCpZFa8VBsjxyDao6uzoCFo6lD684tweZQJbTf3xh6rQUDKIiTsBYLBbe33w
         VJ3o9N/xFfuXIjEw3PlU9I1x9zKzkJu3u6HT/SaCTNZ1K7xFYwRuzTo5iSYYunD9S30V
         /T5cfN8uTUqBfohhHcQ7kE5koCaeyrZ3Wu/CD8A0ST4M9S34xMXsqVGJgzha50U88mRC
         cN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551257; x=1747156057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42eLmT7kYcFWWjHx6Lb/V5oumtwrIpUIY80FWf81zU0=;
        b=IAlNKIQY3XC8Tj1OgNr30AVN9KUE6kHIGZpZdTs1xWwHVflZFrL5wXfcJWxWlBqhg9
         pcxvczkdjW1NrqPwOJ7e6868cRG9gymXl2MzgbIcHvtbouJ/GfCgzAvfCrhoXG0GequK
         JVjcZCFvUBfBKPOXhPZlT/1UGqhOx8NeOTnAYC0u3rgEUTVzUcMeVS2iN2l4P5x3c0nj
         8NRYvOKXHAmOcsD6mczAb69tDpUXnuVczmkYxtRE4GDpLRSUaIOUEBwuCh4jBRJ74rDK
         QXo8Em1v+rpfWXMfmDI3W41czxsTWYppcBSjDx2YK1t0f0nD729cg2qboADpr86Ud40Y
         FDrw==
X-Forwarded-Encrypted: i=1; AJvYcCU4yUw+L1PH/U74ZCBXMH2xTjYuC8mW8WwBxcuVDg/8eT46DnH/SZ62Cc281eHP+cdnIqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzneRhL9zpJvuhTraIxpg3vBnjQIfzG2VYa34LoBVD9P8OZHtil
	VTcrITeANlUxkGut8lTBGExc3fPkVyWyKUZyrB8rfYjubIuYslRA8eHFHMPg0bFTdpwXdlqODnO
	ujBZFCPzYsNG/1Ck0RRW+6hQdLsQ=
X-Gm-Gg: ASbGncs/ZaVzKjC70exyfa+r3GieJaBYthd5jkkDbSF+CvRTpg9xXfRSeki1Po9UQJq
	M2GH5P2pNXCEwQ1xNNAnSCPALzhAdZSuEuAQAgujdi5UJhopjrT74We2TCiBeYo5ndmaS55Sfcp
	K7Bni/puzhGKZoD+VG8Hq8CkBhte0PKwGnOKkDog==
X-Google-Smtp-Source: AGHT+IGlSwWTa9GR7lxx3fIv5T1DFTBr/jFfWws39OZrVfPxnuS61UnTgMkk8W2loWi8c5C6sCQnlMpktZaHfOYXIoU=
X-Received: by 2002:a05:6512:3d05:b0:54d:3ea7:9110 with SMTP id
 2adb3069b0e04-54fb8f55544mr286677e87.27.1746551256222; Tue, 06 May 2025
 10:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
 <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
 <CAP9jKjFH_2CmvVAQwfk4KKTjDyMne2Wq9rkVnn+XB0dD5BEOCQ@mail.gmail.com> <CAP8UFD00bzcrdLLXwjy5yUrvXpnjTDG6ohMTahgpziRD63udUw@mail.gmail.com>
In-Reply-To: <CAP8UFD00bzcrdLLXwjy5yUrvXpnjTDG6ohMTahgpziRD63udUw@mail.gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 6 May 2025 18:07:25 +0100
X-Gm-Features: ATxdqUEyotqNlFPTRPMqG7pdzNpsu4o1lIMS1iYkmQsVy4dMjrATvuPmPD-Lmm0
Message-ID: <CAP9jKjE6RMY9Me0bZVHdz6S7VseRY37JBG3jqUKkzNhD0hLimg@mail.gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
To: Christian Couder <christian.couder@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 09:28, Christian Couder
<christian.couder@gmail.com> wrote:
> Please don't "top post" and reply inline instead (see
> https://en.wikipedia.org/wiki/Posting_style) as it's the standard on
> this list.

Thanks, I rarely use email like this so overlooked this aspect. I hope
this email is better? If not let me know.

> If you want to replace pre existing "grep" commands with "test_grep"
> and pre existing `git config` with `test_config`, I would recommend
> doing it in preparatory patches that go first in your patch series.

Yes that makes sense :)
