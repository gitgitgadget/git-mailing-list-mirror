Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C41E0DDB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407383; cv=none; b=nv2FhUxH3Q6mUCRTmUUUDPNnbA0uGAtg9c+NpytlnDnb39VHuCGsSl/HO8N17To4GjqbRsqiq/qF9bzkTskbiBRHmirk9FVDxBA30wxrhd+YUpvBKQ1YDzWm+MM0ao1Mjh3Y5rRFFSxWFd2tPoizkooS8J/KPXQRwZX1rwJNzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407383; c=relaxed/simple;
	bh=1PS6UsgFP6gSD8RJ1kdNLDgamTmQm+nH5d9/0VdTgT4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PqFCxPVQETT6lUs9YKMT4i3bY/6vc+VooAikQVtub3hdfXj9tNS7ZIUITHnH2mf4S1PoxLzkV4kIWj44DwVWSZ/fpL5UW60CZsrzd2gy18yajK4W2wcLOmtV/bGQwZjo6Zr87xF37mtmKhhRpcOXOqWw8oGwzzESxB2tvyNvhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6UB6WDf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6UB6WDf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45b4e638a9aso11351cf.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728407381; x=1729012181; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1PS6UsgFP6gSD8RJ1kdNLDgamTmQm+nH5d9/0VdTgT4=;
        b=m6UB6WDfBdR3hcam6lHTMoZVk3beSZzdmuFMNkOfLTanbgkwjsJlajASYdgOU0scNq
         J0alyh0MB0KcE5rOASDX0RsKdzGs5ce+r97JHDXa0boTDTkt2/OqXXYTo5LwI0i0qRpW
         Ms3uQynUhPOxdeB9LdJAZuMySayJXL7wpeSPMRaSIDG/J2FVAZK+TmQ1mbtHP5lraiqs
         JyQwJ9UF5JWxGq+z7JzZ8Qf6ATwW48lWgYBgb3Xow1vlNe8ibSNZGOIMkOdICDmEz3fy
         yE0ggF+JHKWx5KSn3up8kwk2vkYOdE9kyAEWeOOANgZzjRF4ifQKrobEUfOfEuEt123e
         K6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407381; x=1729012181;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PS6UsgFP6gSD8RJ1kdNLDgamTmQm+nH5d9/0VdTgT4=;
        b=Ud14wi6vGJQns12m9MAqw3YNu6i4XCSn2x9XjoQ6M9bVTsdhcVniTqhzuw5qIwGdmT
         wHi/F+/5DFsUSR0OgaCSz9sgpIMfgDRSQy3IBYtPp+P4WNiiRM1Oy4aKk1qu8/CN2rxE
         /ksSKDCHZ9mRgallpuKW10INAaq05RPnQJHzEiB4vAorTYARfOzppneiEJPP07p0tL1H
         SDuib4p+dNFQl1NxC2UvLR4li0Y48d5lRERhxYvYN7L0xB4WTW/OJMfh1azS9z/8g7dG
         JHsFcGNPkqKH18amb8jq6/RhLDWeXz3IoLNdYH5u5mOJNgOLKlnXf0Ai+EZw/Unb1WXs
         nBdw==
X-Gm-Message-State: AOJu0YwB7yGl88DgQORpdD7fLxPmO+ApsiSgGmRpu+AP1rK/ogtPZJdO
	MXJcU09aWijpUzEb9hi04zsEGjL7CKudUoQeMylM78tbvlsr/cgRHfp1DyvW+BxvMxf3VwDmAqY
	p1f6hXCpDOOJg+QL2xX0GO0KJ2IfFkYiHauykIDcOKZpN3fulDPCc5Y0=
X-Google-Smtp-Source: AGHT+IH8uMl4PO/2EHjD9v/8Uax6dIbCIJTGSPTmzudV61FAmEAF+hGPrnP/SlGnU4zsfdAqJ+/3IJQdTQvF7iewinw=
X-Received: by 2002:a05:622a:7e4c:b0:45f:6a4:4262 with SMTP id
 d75a77b69052e-45f06a443b3mr2237191cf.22.1728407380672; Tue, 08 Oct 2024
 10:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 8 Oct 2024 10:09:27 -0700
Message-ID: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
Subject: Interest in a Git meetup in Bay Area, California?
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

After seeing Berlin have a meetup recently[1], I wonder if we have
enough critical mass for a similar meetup in Silicon Valley. I know of
my own team and one or two other contributors in the Bay, but since
there are so many developers here, surely there must be more?

Please respond (directly to me is fine, if you don't want the whole
world to know your location) with answers to the following, iff you
are in or near the Bay Area and interested to meet.

* Which part of the Bay is your preference? (San Francisco / East Bay
/ South Bay / Peninsula / other)

* Which days of the week/time of the day are you most available? (e.g.
weekdays after 6pm, weekend mornings, only Thursdays coinciding with
the crescent waning moon)

* If you are interested in helping to organize such a meetup, please
indicate this.

Hopefully we can get some fun meetup together, or even a recurring one :)
 - Emily

1: https://lore.kernel.org/git/ZqoQcuKz_ynYaBNM@tanuki/
