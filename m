Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262102BE7CD
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415041; cv=none; b=R725ZEA9Y/+kiHaVWJqAfJOQZjrvCoW7nYjkUrGiWL6YrvbQWrpaWYYBeaUBbHckkJZtNbfixq3QG12rZUsIDTTNbyN/QIA+YRS//Eerzv6RmbEqFDdx02OgsYv2wPcksJskErSKJUfPnjFGziM2D9qQIiUHzcemVdY2Pcbaoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415041; c=relaxed/simple;
	bh=W28DQ/ful25L28eEU0GkfR2tDKaBYZzRd45LTAdb/Fk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eF6gfCoTODdYVYOLOJxPLvUNpcXhUxReYeVoMSHeibWWK1cVKbqnxeaCwADrdpvhbkPk6mI9fuvHYyaf8us2OB20U/JZlnXd8BoJREmHTkjalcwztj9dBcGorx640+8XyPYtHGMQlHYuYPImzyOTy7CgrXWV15bU+lTq6v4yVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OdqtLUFE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OdqtLUFE"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88432ccadeaso120748739f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756415039; x=1757019839; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgjdLQGl234OKlGeOvqt7KfTA4EHqSjWn8yxYvmR0VU=;
        b=OdqtLUFE6lIjlFh3RSVGZACuAbJmfhsIspxCTK0zsQ/mstDaY/O/UmhGOeptl0nGhL
         v+Z0BRdjhGfYcVsOABc967fI3yKZt3o3iwMSn2Rwcc2XZ7rXs1gfijM3qem2XtUVADq9
         Utir7w6QzVG7MtiiIWUcquWHZTrSY5lTDHyuv3ApsQbVdXclYKqCzKRv63JEj8+sk1wB
         0bktcrSRuLdCfS88lEVojt5INiASsW62dRsEPP1R7gVSi9USb0ypdTOp8blslgmICLUj
         Rcs8NbBr737KpC3EOSPEjzHDr1rRoc1aV0Zq41s9nBoQK+hMErwduoAtaMQ9yDQLtcll
         OQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415039; x=1757019839;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgjdLQGl234OKlGeOvqt7KfTA4EHqSjWn8yxYvmR0VU=;
        b=UbYPa/5o+o7ljqDU6paM08VtTf5nXYKv2lazIxXe0K0u/Mez3CPvefSovXKj1xPWu0
         gtXGpjJa/ZNbCUD9nm9mfGD0K8xFQe2X6Bp6Zc8YmC0QjsKaRMucDis1eLIuL60L1f+D
         YvHhaMNf/DXaisp7BgDdzNheyCJH/I428C99/MFi40JKhJHDmw3uMNc93h64lOz9Wjgh
         cXUVFMCUMaMcKZ9P6JHacFq3uo7wcAPUIThPw1jJKIfUVqi/KDK19aOTepYPhacEOsIK
         3qGiY3M8spUfUsBJ4IqkPkzTxd9Abcx1d4LiKErrjbEORt4rN/MC6+F1KQM9s35gDH72
         VpkQ==
X-Gm-Message-State: AOJu0Yxg7VxC4/whMM3xQjNG4T91a/MA6vjHVe3APw/m9xuk3zkJv4md
	GhlNPqcc+2R/ij40YpY+1CkNqFyJN0Dyi30hdSiKzY7WJoSmtsY5v99nQMVOQ489k76KCbYKfm9
	KDc9o
X-Gm-Gg: ASbGnctACBCZ5SC0icSUoOe1JQ5ZzriM8Z/VlRCy3qnmXu9W8V8Y+NP9EECzirNnbIP
	+9kK2IUHhbetiMwZBGhN7KRw5IXMykxKHZHlQ3mDPs2flI0UoGR48mRFzyFdBijlcnkR10WVID/
	jYn91Jm4xApyrJJN4Cv7KbvIIUFfl+i4b6GeyDuE7VVBjJMvOZkr8YfuXcYTEAec+cog3Z45rDH
	M53jnL6gux5jtClj3QELpEewyY5S/aX/uR0nqAaRgNnTZZ+Xv69LitQpwidnLvO7d77hJbRTaiS
	QIS3DSF81BndlrURPcivNlpO6Bm8IsrrVmyfkEgrHG42akQpZL3WZQpK6VBhECYpT2ouS6nYoNv
	D4ZUPM88HcrMiLBTVUm7g6Wvt5KG95PP83nS6j5ikJYISxnMpOf1PidGLRmWD9udc1tXaZgZ9No
	73BT2rse7gG2kCYXIECtlB14Qm1Q==
X-Google-Smtp-Source: AGHT+IFAMttAY0Acg80/4zmVO/K8SpAUgKkaiA46cfUGiDOhKX6V3Y7VPKUyS2m6OHIefuGCqIjrpg==
X-Received: by 2002:a05:6e02:12ea:b0:3f0:3510:aec4 with SMTP id e9e14a558f8ab-3f03510b057mr91212695ab.8.1756415038875;
        Thu, 28 Aug 2025 14:03:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50d7be03cf6sm32268173.4.2025.08.28.14.03.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:03:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:03:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Contributor's Summit updates
Message-ID: <aLDEPRnXqazmxwzq@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi again,

Following up on my earlier announcements[1, 2], I have some more details
for the Contributor Summit at Git Merge this year:

  When:  September 30th, 11am-4pm(ish) PDT (UTC-7)
  Where: GitHub HQ, 88 Colin P Kelly Jr St, San Francisco, CA 94107
  What:  Contributor's Summit
  Who:   Git contributors (more below)

If you haven't yet registered for the Contributor's Summit (whether or
not you are planning on attending in person), you can do so using the
following link:

    https://git-merge-2025.eventbrite.com/

In order to grab tickets for the Contributor's Summit, **you'll have to
enter in the special code "git-20-25" to expose that as an add-on**.

As a reminder: the Contributor's Summit is intended only for Git
contributors or people working on projects or related tools in the Git
ecosystem. If you're not sure whether or not that includes you, please
feel free to ask :-).

We're using a large conference room on the first floor of GitHub's
offices for the Contributor's Summit, and will have large speakers and
screens for remote attendees, as well as many microphones for in-person
folks. For folks participating remotely, we'll send out a Zoom link a
day or two before the main event.

As before, the main conference schedule and agenda are available at the
usual location:

    https://git-merge.com

, and I look forward to seeing many of you there, either in-person or
virtually! :-)

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Z+L3Mt58n18KUNzs@nand.local/
[2]: https://lore.kernel.org/git/aEyiLhDjSzQhpJnK@nand.local/
