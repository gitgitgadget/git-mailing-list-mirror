Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EB3161A1
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200271; cv=none; b=VichJlEzDz2PpP7uZXAhfRHjUBVOcdlJkrwL1mny34YlEAUmNZJ+XKEYmH2sspzecSMKGG9mDnGFQH1kOpBUENY9UaKoi/pSzexaitxZiR9uPdWgxPol2ABcJ61mPsFn1WTPT3iZRwQabqm/XfKjrqz+3IhUFpHgZhdtQ4MuYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200271; c=relaxed/simple;
	bh=MpllIZieEouxPpn353QnPX7pTnduhs4ubjKyEbCWB4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLVcBBFxCDmPTcdVLJq8krUJNkYqk+w+vtUYe1aOADW89mBSqHp4AMOLseaXl/utSV5Q9b3Wyx5P/9rSd16VOZxKi5B7cX16u44ZOW+MXCqdj/Z5TWGoagIoxltfPQc0WLDrF8H5rTdJSqp081rUg3sF2GSXGV7oCfHQAwyU5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ65QhAa; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ65QhAa"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ad70765db9so10006661eec.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 22:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200269; x=1768805069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MpllIZieEouxPpn353QnPX7pTnduhs4ubjKyEbCWB4c=;
        b=hQ65QhAaAoERcGUxx3hwSbYRt9/Z2bedzXp+wkZpXxrK9NP8o2OR7b7nWglacKbmPQ
         hOGfbeXJ4cj7ro8XnSMzYSkfDfSyFK4mZd5jXo6NSKG0TzU5G6dIebYxl0/PPmPGKTZ0
         KB9Wf2ZIGBZHqr4/yp2lOVGv76liyl5C7ynAfC3kKNeGCIf7dyNZC9EtbBZK0UZQeVaa
         qel7o+C582+78dnBNxyScCar68u1I2x/VriZBQsJNS3WYHgNuaB85okvjI9Z1PqTgT13
         2J+qsk3BKRDEtrCzPvhM4HEAJ2qN/WMU3IXnM3T9F6v1gRcQu1QJgQW7GRXG449gAks0
         2JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200269; x=1768805069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpllIZieEouxPpn353QnPX7pTnduhs4ubjKyEbCWB4c=;
        b=eUBN/GOGzSXZ8/VXOqg9H4Ue2tiNesYJVP+XAvCqnBvM7P9JQ+ZBbeR+VeYnOzWefe
         +jsdTpoln8d5ytccjKuaN29/nAI4qCEQ4vPkeby8dirNt3LUO2OXu9HOXWGGqKyx1NX8
         OyY5mIS5NpBKx966JKrVZ96zdyE3kN9CDUxCJt1H9lNnX70E3jINdhXlXXt0niJlzDDx
         AFnSmkFAA5mYdFkE6jSgp4UvLAUqvlvpi8OEzTbjmMjjfs3S0JsrZMAC1xZW7c6fgLCZ
         VSOnKEcetk1b4Be2vQVjefkJ6amWMdCGdVaezLlS6fAslio7QRlrAgczb0KIbFUTz3l9
         np5g==
X-Gm-Message-State: AOJu0YwFcCu1mx8T53yQMtXYY14ffP6O9v4ABdASP2r+gyJasGa8MKBQ
	o6GH5V4n1d9QvVv80k0DlmWoiXNeqp7pcwokvIaO2U6wLgpF73n7MPnXMguhgA9qh2sGGpSFe9Q
	D4AFBV1Yydkm/zgspg3TosmqnlsmtW2bCI6ao
X-Gm-Gg: AY/fxX6iuVqaPCAK7zdmcgpljkt4xYkwlV/4dbxoqolvOu1yIS+S6jXGHi9zrhNLRnU
	VeeYHLzo5mAEFY+VfNlEhP7mMX3QU5At9fxMPmJ2bVsNCSeXWM35iJjt5+jV7mzquyD2CJEQglk
	SKnQyfymBCEWNLLRWuCR5bSjUDWdM0VwIy8gReU3UHou2by4HIOCnEMdUOSClu3SweD19i1eJsq
	3F6Qqzl1LefLNr0K6eNBHk178Fo8l+VLtoGBZ92Sw1SBGmlfEhm7OLrCSJ+1WwLv3oCntt9Z/1v
	srZC8zBT5nGjncuDWD/UXPiM3AcVjlqn7xfHdE1tImyBICyqHw505MNU+0H0lbmlvv0tkZY=
X-Google-Smtp-Source: AGHT+IEJsn3/nyWVm/IBqqjOHA6RdywpEZl+dYju0SOj9gEpJPrJaXBLvaqGbRYtKync+1e+xvU4e4GqsB9vrePnpcw=
X-Received: by 2002:a05:7300:f585:b0:2b0:5337:1d8b with SMTP id
 5a478bee46e88-2b17d25d1f5mr10867967eec.17.1768200268794; Sun, 11 Jan 2026
 22:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
 <20260111072950.9463-2-deveshigurgaon@gmail.com> <CAPig+cQgF2yHL40OnOB=SWMHCv+z0hLTAwTD8q18-DGPHO48cg@mail.gmail.com>
In-Reply-To: <CAPig+cQgF2yHL40OnOB=SWMHCv+z0hLTAwTD8q18-DGPHO48cg@mail.gmail.com>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Mon, 12 Jan 2026 12:14:15 +0530
X-Gm-Features: AZwV_QjDmHR_94pLqQ-_-N0gETDpZSsOQUITADJmiMSO37EzBuuAAFAj5q4hFuE
Message-ID: <CAG7UgERQNob=JBCurxcS0+Ev09quzYHkTJoaRCvsw7xShHYX2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5403:introduce check_post_checkout helper function
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Rather than forcing people to read the function body to divine the
> purpose of the four arguments, the function comment should spell out
> their meaning. See the many "Usage:" comments in
> t/test-lib-functions.sh for examples of how to write more useful
> function documentation.
Thanks for the suggestion! I agree, I'll send a v2 with better
function documentation.
