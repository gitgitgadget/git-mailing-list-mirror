Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A71C84B8
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955289; cv=none; b=OpaPMTVGJMmDDMZYL4DTiUPZQCxvdMI0k7geNEuNJC6GCDaozCZs+dVwUEsN39FaJJCYg4Bq9d9pmByMpuNXWz7DE5tBjoSHIx5WwU7S7sGDyOcohjHCckyz+wiwcW451QHddINEI4mBonxZ2R0Hx28ogWLuHN7nMaZ2vRP4EZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955289; c=relaxed/simple;
	bh=IJ8ZbnPvkOJPfbzhT8dQDVl9ldXYRjRjEe1MuFUUsyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn6ogDlf6C+8fRQcYKzpDjlaUu9eGs4rdpZKsXbEZouMdURt1sODVdv8eTij6L2a8XJ65f/9TEG1SIuwiJddbAjWuNJ519/iGJV4qEZrSKOH6TpPpJci3eY9IoqzKhMQhAi8bMiJyOMdMG732QPqbYVSordCkhhBKsaKIv5do1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb8eW5QZ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb8eW5QZ"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40b32b6af9eso24922b6e.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750955287; x=1751560087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iixkx6K/G6v90/0CSXo7iARK864ggqbX1+MwNg80JMs=;
        b=Xb8eW5QZ5zvxIwVlKMDpebnmswoSYJ0Iu5VXZ9n2KbXQRyfym1pyLTfTBM9jvnImnE
         3QFwuX9AnD+Ybp12dBpmJjUis40JtpgkQKkRUe1M+NT9dFAVumhxOFbuuNHeU/fPOp/3
         gby9YF5ZwlUJ5V5/RB/TARY4YPkWWtFsmiW2mXpeyXM1D7btelQaDZ9X4w/o1r7l2aHa
         2/asqIHscuf4buRG0J2CaIO+CVuRVb/kLK67tvBuTjtjXYfsnifPWcacUxBNuj+Rx+05
         /Yw5wkxGfW8yMCtpbSCoOjbu0lsHb4UA/S+F5FYToyygTynyesneAWvQqeZnSh580Ssa
         0g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955287; x=1751560087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iixkx6K/G6v90/0CSXo7iARK864ggqbX1+MwNg80JMs=;
        b=rrBS+0JVCbGWcq2ytp1cQ0Am7sGEdN8wTmcQbKb3UUDund6nwPDicux8IfQFS5oNA3
         SY1WnuzG/losWEwPvi8YB6rKfWtu8A4E9BIu4mGaB8XdHUu8l2tN4agOj15s1YDQaciJ
         OwkvfEoaSvuu7/6WcFLjxQ4pU34aK0zjidFjz3/sSMvuYo110nQexScS++gxhUzfIK3H
         uRCfDP26SEMTMWFZX+2Oz722uJv5sXwMbr36u93d94gdWHa0kgINT4eG5DXnzSvJ1Awm
         s7kHO8/b1zNRSIafKBYtEmdCHm+c2hzNGN9ebB/W+n5YH5Hbw5jpByzNZYqJqSvNi7oS
         DXmA==
X-Gm-Message-State: AOJu0Yx9eQTAbQerMaqJyilZuLpJEySZlU0+Ed7d99+MzIaiUgzJ1Z47
	a00z7ojbyw/IElaRpfmttJe/DwuPzWmRCFl+uF2vYS/iNZ341gcV60Yx
X-Gm-Gg: ASbGnctumzpEB1K7rjx2C8J6ri7NyXM4dN5JpuhkjKWBK4unUGmqgtx1bWpUf3dHQ9N
	1TtPBlUYp4n2wOFk8O0IQB2iHyCd0vneoFX3aaESRlGQBxj72jmiLdI2gt9XJ6NYYYhyfOb0X40
	SAd8TUxNYKxcDrWapNEcNs3FLaFi1jj0JguaG2+DC4cLpFYPMPcyHxxnGylt444BThOiBB2/rGT
	c+a/MSwplGTujp8GKR5PIKHuE8kKlM8x8/un9CoCOU2a6gCY6vtpmM9ATp4zZKm681Fm9OEC6tz
	ly54SJ7yAa/LY5QBcyUs2Zv4mk2V5fEOdp1oCw5oYvrZUXGrFPzlqFWgG16LWFTGIA==
X-Google-Smtp-Source: AGHT+IEKvDAz6NZYwXSLMGwttQRT2/+Yodr/l4u4rLC9mc7tk6gCJHUxqpFDQpRyuC1r/h77tuMrLw==
X-Received: by 2002:a05:6808:3021:b0:407:39f1:aa8e with SMTP id 5614622812f47-40b31dc0926mr408182b6e.36.1750955287201;
        Thu, 26 Jun 2025 09:28:07 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73afaff2412sm34181a34.14.2025.06.26.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:28:06 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:22:44 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120
 characters
Message-ID: <qxewasf6rxt6mnbwvfhxarcbvfsn6cnc2jskpddsb5fhxfhpwq@5d727iud7wfp>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>

On 25/06/25 06:43PM, Karthik Nayak wrote:
> As per 'Documentation/CodingGuidelines', we try to keep to at most 80
> characters per line. However, there are often certain cases where we
> extend this for the sake of readability.
> 
> Add a maximum limit of 120 characters to the '.editorconfig'. This means
> that if an individual line exceeds 120 characters, the editor will wrap
> that line. This provides a lot wiggle room over the recommended 80
> character limit.

I frequently use the format operator in vim to reformat entire blocks of
text and it is commonly configured to use `max_line_length` from an
`.editorconfig` file to know when to wrap lines. Changing the value to
120 would cause my editor to prefer 120 character lines when
reformatting, which I would personally not like.

Being that `max_line_length` is only a suggestion for the editor, I
think we may be better off setting it to 80 characters or leaving it
unset entirely.

-Justin

> Contrary to settings within '.clang-format' which are used for
> statically formatting source code, the '.editorconfig' rules are hints
> to the editor. These are not enforced by CI and are guidelines for
> editors to follow. As such, the 'max_line_length' used here is only
> supported in a set of editors [1].
> 
> [1]: https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#max_line_length
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
