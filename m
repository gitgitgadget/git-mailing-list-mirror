Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E1425CED
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006530; cv=pass; b=RZaTHKFiIyaP+6IGHjoTAeDrNqiUeklk6f6C7QBIhN2Ec3XCakQXX7NLrh/dZdzbS8H5TZlW0+TXehdd/Ih3S1f20F0rrEJFbQ6GBvX/TeHpUDdI03L2N/cW7mOw6om3D5eTeC8u5ZPHmusq8I9b9TglBD16qMNYRsfcxsgpk3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006530; c=relaxed/simple;
	bh=PCgzeKx+AnwD1vQFiS7uDwuA59BN1reKgh5n6tInxgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsHGvedO3D4HbZSxk8MYtfFsSFdzTGCi6jvAw0v0aIRoK6jzXztwi2oCaa2xTFLH7Te9jZf9cbYY2wuuMNf6UsoHf3wbAxq7fPffYWZCPvJHgN1bfet+jWZ1HMsdGzpI9ioi1xavst7vesXFWmT/BKTU3N+5zU4X09+BbAMW0nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRksOTCP; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRksOTCP"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12332910300so11366088c88.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 06:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769006526; cv=none;
        d=google.com; s=arc-20240605;
        b=B248Fbz9anWfpGhzyCgqVpMPf7ItnEaGaAPVgfOjknEP3MEaLQFXtTidkSuniw13fH
         Nrq7jOqmqD8buFO2ZWpWK5tJGZ1QqhjKjvb+RTlQ/IKcSvQkBsp8d1dvuVsonaZFdNK+
         2YjgIXWuoDJVGCCAd7ost/3AGZdOAtRxv4GCTs69XAHg4UNFxGZK+h9ZndFPtZe6hzl/
         tJDAHWrQcoPQw7mYqGR3FY7htgGs1p9xDjQRl3NDlFA/21Vx4ToUFM4J6su6ICPd8H/A
         IsF3Tsj79mGwXDKhzBu3TTuMvwUsjLjme/7xsl2QKouoNwcde8Aim+IFbqG5tlHjyiFl
         uEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PCgzeKx+AnwD1vQFiS7uDwuA59BN1reKgh5n6tInxgw=;
        fh=qWSQ+eXAKmPVdYoKkyKdHMiR3b9HeT0yxCytc8VmGB4=;
        b=lS2TYPOVZfo2qqYgjKUCDMOwf1l+7oTIctM3JGNVo5sps2tOeg//JxVY5PHMTFSWNF
         +dFtCLdTjp5pt33ZDjKONTO44jW4kufq70KlKjpEIBi4YTofILEncPf3NfcO96xT16zu
         ah5jWvNwUm4bwqY7pV1h+LUnLidYUYUnuU8pBS9tYogQpQynpnRF2K7hf978c3rWNKvj
         yU9ygv8lUFc96+UJpLBID62Wwa8OkebV6g4Ii8oYf4wwAP0GvyHxl4lVM11bTC6xXEKe
         +O+Br/idNRhoKoXCd42LXckoF30Y4mxTubdkmnu9xqJW0Ef+h1LeI7sX4q0XBs+Lt/jc
         TUmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769006526; x=1769611326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCgzeKx+AnwD1vQFiS7uDwuA59BN1reKgh5n6tInxgw=;
        b=FRksOTCPMLjR3DVDnLhlPYO57ReGYjg/jPWzLMLvTMcjpJiOTgzvR7WQiTbMmc7Xau
         1437WnQ+bXZCBCosAgoUJ3OL+qbEMpwoin4DSSkyiadv8ccnMnFbBJgP4qZ5o2P+MUcJ
         EnpwGNaqPafjAq3cFixbiTXSxtoOY1P2/oxk25H/Kga7HoeQun7Tdee+1GjcrfQ3Gfbx
         TGexuRVnVPW/oa7ELhYNBldvxGImkgwipbuDQSrunzwWxXT6iJdbe34lsZ9VOLcljGJJ
         FTfOqNS7pbSfr0btDDm76yQ19e0yK1dA8kvHyUDpM1QXlcqABKMZIjI2XH/QXhMkN0IJ
         LuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006526; x=1769611326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCgzeKx+AnwD1vQFiS7uDwuA59BN1reKgh5n6tInxgw=;
        b=feunhdoTj9wPf9Y9sWQmiVPuxgJmdv6A6N5wS0yO2n83nJybTjhBnOe1heoACmO+Wv
         Uhik2vIo29HmhwakYfGqjpVQaWmsViRHvRRfNz4HsNFCX+sZyMBSevDNnfxTZbua3L+L
         9K282dc0qUOtMFPpvTZTpLOyTGZ1ro/m5C486h0l5OODByB2nN3gPP0UYP7zQONsiUgC
         N+hqBaBAJ5lU05Pm7OAgt+EkA8MDvID5Gjfn/PTjjznSz8cWx+TqrTckTF3dfJQWAsFk
         sGcwhCSEifKFePsBx/nksWeLehORd11chO4SmlqueV31Ut1Iyl1z7b9PZTDBbSU80uFi
         UX0g==
X-Gm-Message-State: AOJu0YzkAtM8OUAv++toXRDPETBRjGi7JxHar+ZOtPmrcWCtLA+8SkLU
	JlDjqRxBlRewwL15dOkIA6NTindh7bINIpOJPbq7tHSDsPZN/zBZIjRMUVy9q8s/5sy6MkRtj+f
	il+jri8HF2KkQGQEzDMigOf7puHmi75g=
X-Gm-Gg: AZuq6aK+EdsptidUwDXrwBneK+Hu/0eSTpTvFANWodsA77GGtT0ssGwto550UmIIP0S
	d/yfOeYEnhD2r9yBIhC3EjrNj6RX1oBd0pRB6eg8An6c//Dd/lGzHngtIalkYlzpgFnROh+ARgi
	8cV+8TYzwvgfvSgkNIHwaPsoqmztQxM9L8RbBbBUAetu90tiBNjJufcF89BAaZiEACQ0NMnaB8W
	ZU3EbTdUUYtlQb+LVtl3AHEIVqb/fSPnFywl0qxZ1tGB1E5rBnzm9HI0Tn8DnjdWcGHOWMyT5NI
	NEZz46YWyMAaSDTCVAlwQX2quX0pnV33YmErRzN2v+apG4e3361KPgrr
X-Received: by 2002:a05:7022:2397:b0:119:e569:fba9 with SMTP id
 a92af1059eb24-1244a75ea44mr12286812c88.24.1769006525833; Wed, 21 Jan 2026
 06:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <CAE7as+ZX8n4b5GypTACNCd9dWzNZTVf7fmH+5wfmEvDwEUXX6A@mail.gmail.com>
In-Reply-To: <CAE7as+ZX8n4b5GypTACNCd9dWzNZTVf7fmH+5wfmEvDwEUXX6A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 21 Jan 2026 15:41:53 +0100
X-Gm-Features: AZwV_QjD2ys58JIlhEHi9IXe1gx9Iv4ewXCuad2jery5DNI0VwDUD04vpduxcXg
Message-ID: <CAP8UFD12hQCp+=aVkUjDuiTJ6r5BM6RaBkz0oLPbdqzaTjCgxg@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ayush,

On Wed, Jan 21, 2026 at 11:39=E2=80=AFAM Ayush Chandekar
<ayu.chandekar@gmail.com> wrote:
> On Fri, Jan 16, 2026 at 4:36=E2=80=AFPM Christian Couder <christian.coude=
r@gmail.com> wrote:

> > If we want to participate, we need (co-)mentors, org-admins, projects
> > and micro-projects ideas, and we need to update existing pages or
> > create new ones on the Git Developer Pages (git.github.io) website (or
> > on git-scm.org if we want to switch this to it now). Please chime in
> > if you are interested.
>
> Yes, I am interested in co-mentoring for the GSoC 2026. I will also help =
in updating the Developer Pages.

Thanks, I will add you to the Slack channel.
