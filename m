Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16132517B1
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069125; cv=none; b=Tq8OBR3djbaNv9tVw676904Uby1UgS17vCQAlwWDeaudYnCStP/k2la3BIYyNnqD3kBTZMc0tn+fwJwvAkMXEwam6bAm8PKrHPs6Z0ebCy322XRYyqGfhHr41Rcvk9SXJutAZhJSe7htR91O8MH3LogYBzAdSxqJc0EKlD5DtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069125; c=relaxed/simple;
	bh=9WMGddIp7Ce07D1tuKyFc2qr7XCJ+R0SSBbmeciWRXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrOxkx/+EH6isp5xmRkq62qZSozjLDvdIMGMuO43fCcmPVXxGlhaG+kzd1XcZlIvyeRK99YnUZVRyITXE98AT+gJ6IDXxIw1MkWYx6hyJiJpADKNBox7YuJ+rZ0xUJttty8/aaGVnpPZLwqo2bLq0u+q+RhSDtim3ZSuX555Pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjrB5N9y; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjrB5N9y"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-31062172698so51386581fa.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747069122; x=1747673922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8BzvQhqlYgpR/FhVx632WsxJM/OhJ4dKR0Xtuqt6Hs=;
        b=EjrB5N9yq8+DxewaRlwZGE1kd8C2Dif0slZDhm8MrTTWi091U3nGVvqS6UTHqLwFmO
         eAeFr8SAmL9qQYeGbX6v/3zT9JL+T2YHrc2OEMPus3jUYxe9BByBmHIG6ZThGowh7l2O
         pgz1R6D7DQmUMCFl6hWf18JVDWBFpNxFMo/sxUgTHKcXSckxsviopK1zQ+Db3lWNd1k8
         sUhy0ezK7AXUs3FtR0FUW37vyRUsmsWbEozYj6zZKOzmvgO+/ekR8JOUHWo6rPev3/yU
         Yp2knqZ0FRsozM+MlZo+Cv++KUKLjw7sRzfYcEbAs0Wk9CKNOb7icgFJwlTpqS7259ek
         UAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747069122; x=1747673922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8BzvQhqlYgpR/FhVx632WsxJM/OhJ4dKR0Xtuqt6Hs=;
        b=Jj1DYLhYjOS9zdMUq2ETOx9d2+xq/CjzIRmhh+lwpzEda+dXT4fNi94KBp0kBzS8Vn
         JZxR8CxaDPUG/Cpck3xf0qdHTdPBGOI6Hp1dedncEbgPbPa8Ez/7uQzQMcdaT+AG/CWI
         0knRk7BtS5gmx3TmeDakSDmO+MT93hgQCVyK1rjS90Vifptunj36kpkLe6XIa1Yj8VOK
         QRh4h+RT8N8S9OlEVUt6edusvwGkaJXbCgOXXqOkfqlkd1sdbkRdbhPxS3mnWxkTMUBz
         1W+aVDH2+FqO6Qo/3KGjc237x0Y0peHosszPHTdS54KjdDSR9ht7yvCOadnDKKpHex8V
         tn+g==
X-Forwarded-Encrypted: i=1; AJvYcCUhrGwFeRkMCt/ArbzBxvzM8IP9huhlfM7iXe45ucZC32YqOILo+rTXpPqlhpZYsw73d2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYaFwlK1ZaXFCk8CbjV4Kq+aO1sBsaJM5VLuMomPvyfCqj8U4o
	71l7Gma3uSyvB7utge595EkrGtQIWP/Or1cq3aSK3vUa7kjj1PZjU8oyat4owXhLv00Q0j5k04a
	5exC4TiarHXDgmpjWo8mh6gVOIUQ=
X-Gm-Gg: ASbGnctOp8KwxB9Bse9NbOU21UILkeQTXj2EqvbNF7yfX2nSnknwzSw9/vMHf13kAnD
	g/xjVnbqWIbCBIBl/HbKykb41YLSOq/FrpCFqh0ax/8t4r4V+h0wZDkt0pb0F0gTIrMzKSwo0j7
	F3thwpgO30p099bSOI2PAkWMG+vS8H9KTzJFROFA==
X-Google-Smtp-Source: AGHT+IFC+nQArZLyLXfuYUWX574QQsWWUNEIUjWG3YDWk41EO3qvgHliI6GHjOAS8Q9rHrStDvAptslRTRy+FV4dqok=
X-Received: by 2002:a2e:be89:0:b0:30d:dd65:233f with SMTP id
 38308e7fff4ca-326c45456eemr49420421fa.4.1747069121367; Mon, 12 May 2025
 09:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com> <4f92a1b4c24a6942fc55d305865bb55833d13c45.1746884789.git.gitgitgadget@gmail.com>
 <xmqqo6vyvtcf.fsf@gitster.g>
In-Reply-To: <xmqqo6vyvtcf.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Mon, 12 May 2025 17:58:30 +0100
X-Gm-Features: AX0GCFt9RgYPs-nudn37OHxQJ5RU7rgCRppHLQyyjwIUkh0qGotH5jTe2pwZO1Q
Message-ID: <CAP9jKjEYgEBBGrPnJ8fkaWuS8RPzBeBqFLE7aTJd5x9PcWu=7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] test: refactor to use "test_grep"
To: Junio C Hamano <gitster@pobox.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 14:42, Junio C Hamano <gitster@pobox.com> wrote:
> These mostly look sensible, but I would title & phrase the commit
> description to 'use "test_grep"', not 'refactor to &'.  It's shorter
> and more direct ;-)

Thanks - will make sure to change that in v3 :)
