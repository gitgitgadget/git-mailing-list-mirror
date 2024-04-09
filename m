Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB1E566
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626424; cv=none; b=cFH4Vov/GOtsVO0nXKkK8vvWq5+8dzDsikg416Qzhoda4kX7KevoSvxIhXiVSZbALgfkiv1E3xa3VRRHWdL8YoOc6pqX26RWt60Q7HRpVowtQy7A8/WU4tTBVyVzxgmtZK/VORzdJ67i88M8UEGI6DaubNN2DCbhzVswoplo/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626424; c=relaxed/simple;
	bh=OQD0XM4DBGiOcq4FhzHhWY+hVK/Vv80yPzfAazpMgPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8Pk7VOMgK7Fg10je9+ekIQV/TBSUQgbubj4Efm42cFMSemQvUWS9ru8/4PUyeIr+WwSPm6HT3HvJnZFYHgAcDTdNmRlysFgPvAhwTB1GzZVoeUESO69B1K11mH3aUbSJFyE47I3uZx/UJWL6N7K9ayVO12hBefM8zlZN3RRw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdEBxOe5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdEBxOe5"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0f43074edso3363881a34.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712626422; x=1713231222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK2QaKhTddNYZ0txuOALbDuw163xb8FAZG+T71fFuT8=;
        b=gdEBxOe5oB+rzYM7Jp/ZgcOcYuNjgedrgHWRt6lVJuW+kT9gn4d5bustze0T4gf4vS
         ceHa1pn8+BjV5f2ZL6BdUviupc2qfGbaP2cw48e0RuXsm+Dx0Nj5XexqB79Hzsgm7YCJ
         cwFzQeKUVKPkyfZs9+BBqx3ZCAhf5S/TzEY78auroEkRCT3MQflMf1pghsDaxLOfHQDO
         /KGCztrz0HvAXPBcXUENGgEtQ3eIE8WychaqFT6isZfRUCO2NlG+rKqEfGkMMfozNlux
         hrJnf7YhEIfFmytZly3linshQkKIQtcy5ggrpDo8PxfkyzANfXvX9HMhHopwpU8/TshD
         G2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712626422; x=1713231222;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK2QaKhTddNYZ0txuOALbDuw163xb8FAZG+T71fFuT8=;
        b=AnycuBYXU7yuy324y52C8mJV2a4xypmMj7j7ukHwB9g2sG3USBh2aiegp5+A968/1Z
         BuO7aBFzgmluVdBZY1xSGAckrsSo2G5AH7LpzP7Aj6wY76VklyqfkE1k2sbzMzlFNhwX
         xCZPqk+rynVnDJlNdVvPjq6ClwsCALMMkfYLdZk062+UmqLGaEOh3yG2fEUL52qMMoDa
         SQBuB/Vasi5lxZ/t5LTLkmkaxiPsJioAcdqHeywvF40AYF0vrFCOPlrRfpsaYXkVrAX0
         oeeeCirShwUEm+ag2IC3g8kx+2mTssgaMjA/ByWqgFxyNv63kqsSxvuA1hcDKAx/HiDB
         F/gA==
X-Gm-Message-State: AOJu0YxOOz3eIQFhfC7xHVvAjX7VSvnznZMhfJnoGKbHOoo8sanWRB2Y
	8CZwHQGXYZwW+w40bo+ZNQnqbb205tt7ZMZ+ftC0f9VnGTBlna1n
X-Google-Smtp-Source: AGHT+IEZLA1UTlWpqxHN6TrWirfdXR+PbZjIZLStXQ09itKFiK38MOjRsy7spwvSMtbgcy3GbHlCoQ==
X-Received: by 2002:a05:6830:1384:b0:6e5:23d8:a4c5 with SMTP id d4-20020a056830138400b006e523d8a4c5mr10340111otq.34.1712626421800;
        Mon, 08 Apr 2024 18:33:41 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id w17-20020a056830111100b006ea2013b948sm283082otq.58.2024.04.08.18.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 18:33:41 -0700 (PDT)
Date: Mon, 8 Apr 2024 20:32:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: optimize table and block iterators
Message-ID: <wpkr5pmz53zp3nuzezfmqme3b3ymtnwx2noeto6ioi77q67z4y@7k7qg6s2eehr>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>

On 24/04/08 02:16PM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that aims to optimize
> the reftable table and block iterators.
> 
> Changes compared to v1:
> 
>     - The series now deepends on ps/reftable-binsearch-update at
>       d51d8cc368 (reftable/block: avoid decoding keys when searching
>       restart points, 2024-04-03). This is to resolve a merge conflict
>       with that other series which has landed in "next" already.
> 
>     - Rewrote a comment to be single-line to fit into the style of other
>       comments better.
> 
>     - A new patch on top that avoids copying block iterators altogether
>       for another speedup.
> 
> Thanks!
> 
> Patrick

Thanks, other than a small question about one of the commit messages,
this version looks good to me.

-Justin
