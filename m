Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D9192598
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791980; cv=none; b=t8t/4jRA38lvfT+r+hoqQXNzLfvJ5pBOHYuwvzxnV3+2gL8+x2yICaRWkLD45PiW1dXTrVpxO2RSaG0Et+qGciLx/2V145/wa/WvCFOoZ3olUm0zQpDmmdKZdCL7he5h8etKv9GnfFrPzjg8xwAcqDH5i83TWd+3DQcwpLDfdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791980; c=relaxed/simple;
	bh=OHfZBviiEHLwUK0DXF+Ob3SL5z1i5OgOatpT3oe43YE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdhMKBlKg5LUoFsewFgMohG9cAANpkjn7ipcY4hDUkFn598ozQ9lUIffFaiVrWRrKLup5y0Cbmp2MET/KwEVyjzw0+hl2zeEFhP/EAHDRWWyr+2XmIY+Cdp0Hxg0A31RrTSPtjzTMrpXUYwRS9bGxQlfiMN7bZ3upgqJQzPCDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ALn5BzPs; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ALn5BzPs"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8d70c65abcso950564276.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752791975; x=1753396775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHfZBviiEHLwUK0DXF+Ob3SL5z1i5OgOatpT3oe43YE=;
        b=ALn5BzPsf3All2PTCKCS8FkYFpRQROSNyVqMLJHq8zDFns7mEj5AcodFrJGYGQEOrN
         DUlPff4eu7aeb1EslkR6xXe6XIBENHFuAki6f8I/Frf6dVlrgofPTRBxNESCKuoqo67a
         7M0k1kl9mXh++PfG2n8jHZkxoFvWiW9JH8D5YfH/jvfoWd0hcGe9KymxhFHFnkiA/LPr
         AJy04eQjj8eErqqvcRosGGH6uuZvXSxXLuDTLPhk9rY4U6iVQmSDb8rASd2SEWZWXqoX
         1cnIvx6F974zeF0WJbg/bV1MYgEdAAAFixiWfV1jXp7Z9hpdNk6XqFIPsgfWhkPm4KYj
         BqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752791975; x=1753396775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHfZBviiEHLwUK0DXF+Ob3SL5z1i5OgOatpT3oe43YE=;
        b=ffDbw81g4TPs+9vHHkrtXdHASH/rM+quOpGp2eKZr0pvlHSI7T+Zbe9akqcBZY0gVJ
         AmWHBybxvhW6lw5irqPW+6kaQMPjb0DeP950MNVeBmPLzNHqbvVMevz4Y/jfhKDG6j8t
         2pS8SDLYncoJWB1R1W4sZJkbC1+R//qUFp+F/0ZlzSqdRYM0CDM4DpJyZzECGLTasAvN
         iJ1CGV7+5pLFeycaWdLsxQ8R6qromDUY7rLHrSbBxcFlXAgAqEZK0ZrLxjumvKohlAPf
         n2GV6g7vJ1B2k2xsBKd4QuqRp+FXKbYOCHxkmxyaGxZLz0O0kYxRFwAR0H1/HuUs92UV
         xQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCVX9GQtMEpHyGyowhfwlBNp5fIcvkokgTCuz33+Pd+xyomWb5cjx9rvdhy9QUYs/kkZyow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTE7wednqT21iZnuXxRabY6rdLyl2VHjlBmkaolN26yklthJy
	TmU7bl5otF2Emd2TBReYZGELwK8uWAzw6AcAyumKzIcwUmMYcIPY9pcVIBSGAfP2wfZmKMeWts3
	GDKAL2Q0=
X-Gm-Gg: ASbGnctyVQunZseEFERNhoTDzAQOnCvw8m6ea5f2zBlpnHRL/OefhaYXQSWmtiLAqkC
	6ci9PZFgpZ/4kfIVH26wttcXqYWx5iduMIHGVQ0OO2hTxvY6eJEUxLZQkkztOQHuNrXr8dlhCGv
	sl3+FA3PrZNVjYJtnwBUQp4PY8JSiaTlB7IPf2AUBdyJsyF7qC+wGsch2IRDUZA2/nmz0CjTSYG
	je5/lywG5gexmPX8lAJAUGYtGuR7PW36B7rZ9n2vRbU1vjinP0cldrqHx+12v3Z+Gljo8NufTot
	btvhKZv/ejDdJldLZNLIUeFpb7a6nUYzExPrGP3ahSn3DgQtEmv7s/0OvrO3+VuyPTsPmWzth2F
	qDTD45ZnUZC7sXiMX7yfIRVFpGpz4I7btcZUo1cC7RJzt4Z6HNYvojCfWNA93l0Kjw1YDtg==
X-Google-Smtp-Source: AGHT+IEvIL4CxbuCDDJQP/UzesbmM04awFHqwwHAv14aGz/bzPLScC0Pb9NXUqI1QzE4W0qwsDjWaA==
X-Received: by 2002:a05:690c:64c3:b0:70f:88e2:c4ae with SMTP id 00721157ae682-7183517be47mr133761337b3.37.1752791975511;
        Thu, 17 Jul 2025 15:39:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7195313d34asm453057b3.32.2025.07.17.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:39:35 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:39:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
Message-ID: <aHl7pRs9pgUTXKQk@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
 <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>

On Thu, Jul 17, 2025 at 09:30:43PM +0000, brian m. carlson wrote:
> In addition, as I mentioned downthread, because our intention is to
> support the Debian stable toolchain for a year after the new stable
> release, unless we are exceptionally careful about dependencies, we may
> end up with a case where distros need to use older dependencies patched
> for security but other users may want to update the versions to newer
> dependencies with security fixes but that do not work on our pinned Rust
> version.

...or Debian users who have an older version of the toolchain installed
and got an unfriendly "cannot parse 'version = 4'" error when trying to
build with this patch series applied locally ;-).

Thanks,
Taylor
