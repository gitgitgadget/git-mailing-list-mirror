Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2A13D531
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054304; cv=none; b=eyOj5TfCe6F/AcuItSfSfz7CWATdyKyDh6eP3wP30jEl+NmqnlMdU5MEOF7E8EuFpDwMSkmT1kHsI0fW6xi6nDviSZkUfdFMuy5L6wWWQy1RPkAvz+az8htlurInumZIZHldBNQkr08ft2f8V/eO2AAOqF1PPnF/zj+O5jo69qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054304; c=relaxed/simple;
	bh=gbbfCV0T9NFsgoOjy5wazprU2W6UPm2XeRQEKnikfyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=przEdSK+yMbbtfavW4j0irqH2cvTSU/ts78eI0DbdKjQhE0Gj+fy2pjxMEH3JjK3mjEKm20nznj94yI4I0A4rNYjgDQgzqALTQ1tnorFTCpjntmVfHpsO69lWWVkxTE7sTV4P/uuK89zv0E/qhNhf+/KrX08oqpMLHW7U+f/4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EPLCle9j; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EPLCle9j"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447dec80899so22445981cf.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721054302; x=1721659102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXS5+Ze1Hi0YskFfINng9bxFRfo21BeLhOVkLiyiszg=;
        b=EPLCle9jlX1Qt6dc3sq1Z0zcA5ouOdREtXEr9JXkxaVF3OZagNfmMHWJ4PuQoJWZcO
         N2ccq8ASGwJ+cWvRHmJk8z27J8G754f0h8BcLX1k27oOAE3WfPsVNAnfmMMu+4C7h18e
         +1a8M+ICbNSn54TMCk5/SbQbTLCqEKwau2SBhMHCJ9CFAKIbcOGWZ0AiggccdFT/stOk
         DopdNXzNIfp9nmTBzVC3Wm4B45vvvCM6vBY/Hntej6/tYSeR/J5dC5aNR8PyRtmxAC0A
         xKNeVTeDDOrYKzDDg4YFiBmAAQTtQo+YWEF0iaHT5CunxufNfqBG46tr5SbvCpO2Lp8q
         4O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054302; x=1721659102;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXS5+Ze1Hi0YskFfINng9bxFRfo21BeLhOVkLiyiszg=;
        b=X9r447tjd43/480MfWtVVRB60JM8J2anscQIla3UWHm5OgT0zwdero7fgvHOz6b+E9
         q4vwe+Bi6EqufbdoZrBmrFaP3Hjy3uRwK0RUvBbUZ+fZvoZ+83ceHUNF7WJXEVQQfY/5
         kOBz8vcKRNiPnko4e2ykaVJ7QnBLF4Um4m95a3P3VcfwelvucLKXDlin5xyc+BDRrCir
         427G0SEFnGgL8lqKPHIVI+POvpCzadx6s07vJSAR5leDi1EzFjOvlsXdxwC4IIhUg/VH
         Y8uQFKXNBD2s92s9IYyc6QyEyhsxc4DGESTBSG7YwaMH8oFbhatXV2+LcfMXB+i7obzy
         R5eA==
X-Gm-Message-State: AOJu0Ywk5VcLnvryXQcccFIRVUN4JcWkL4rl4QN2VydORT6yYN3ey7JY
	vW6zlu9ANbMpTXh2b9OaGuiuH4A6sZ7N+DO0fQJaX6yFxNDW2YOI7TJDqBzablBNxd/BSym+WUT
	w
X-Google-Smtp-Source: AGHT+IF1HhmjIi7lVoU7AxUpCiCUj3PZ+6S02fdOR0njcOlSg842RYc83ovuIRSdje4quFU/Hlv3Wg==
X-Received: by 2002:ac8:5852:0:b0:447:f844:54a8 with SMTP id d75a77b69052e-447faac9ce8mr249354911cf.55.1721054301871;
        Mon, 15 Jul 2024 07:38:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f4337sm25406361cf.44.2024.07.15.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:38:21 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:38:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
Subject: [ANNOUNCE] Tickets available for Git Merge 2024
Message-ID: <ZpU0WwsrXCF8BC1f@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Tickets are now on sale for Git Merge 2024!

To purchase tickets, you can visit the conference website at:

    https://git-merge.com

Tickets are on sale for 99€, and purchase of a ticket grants you access
to both days of the conference, as well as any food/drinks/beer that you
might want during the conference.

As a reminder, here are some details for the main event:

    When: September 19th and 20th, 2024
    Where: Location TBD (Berlin, Germany)
    What: Talks on the 19th, birds of a feather discussions on the 20th.

The call for proposals (CFP) is still open, but we'll close it on August
1, 2024. At that point we'll go through the talk submissions and notify
prospective speakers one way or the other. Submissions are open at:

    https://bit.ly/git-merge-2024-cfp

, and we'll add a link to it from the main site shortly.

As before, if you'd like to come but need financial assistance with
travel costs, please reach out to either the Git PLC at
<git@sfconservancy.org>, or Scott directly at <scott@gitbutler.com>.

We'll collect requests and try to make decisions and notify people by
mid-August, which would hopefully still leave time for making travel
arrangements.

Thanks,
Scott Chacon (GitButler)
Taylor Blau (GitHub)
