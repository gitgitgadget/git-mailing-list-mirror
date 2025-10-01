Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A921579F
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325856; cv=none; b=OJg8PFZb2EAoDZC/gaYyUfYjFV1H+ogN/fWjTXDI9G3kxsMw9W0/gBcrnMujjqvw9YL4vyWZJpOsGdEjgDr103D57flxGF6fpHNm/ID/v+sIVrpvtsN3TS3nm1trqL3KitaIvVk7gBzna5xfyzhPAT5lh8fAPd8TMekEz904GAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325856; c=relaxed/simple;
	bh=WpYkXlKinnj5RNCersxHgQfwdV7CA6jHOspJuFJi80k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwLTnCZz9olUPv6eTzh+oixGgR4pDy0/ZH92x1B0of6Tfdf3RNb39AOaN6tC8JPj3LjJkCjpfdu4rTEFMVt5xxiPINT2k6gpfon4QlXrRzrwdm2tneoqC1M9P5qwt0jN/j96CG9wviKMnHhauBaNQVbmS3rMR2rlYyMl7PzIUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3wmFlas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3wmFlas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4926C4CEF4;
	Wed,  1 Oct 2025 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759325855;
	bh=WpYkXlKinnj5RNCersxHgQfwdV7CA6jHOspJuFJi80k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3wmFlasFhcl5IxnrsgKmTP8dTM9uHqKqism1dzT0oGOHq7L4z9QML/mepW6hU9XA
	 5yLC9GzwUoQyVWgVAGIorrT3g8vMhLmmZnnuWDfkFIxIahXZLpWNNgdMvG61EgPpp/
	 mhvuibxQ5neLKO0kIkUlALQvlWlfXHDgz8fJ96no=
Date: Wed, 1 Oct 2025 09:37:34 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Henrique Soares <henriquegogo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
Message-ID: <20251001-pastoral-frisky-seahorse-cd5bdf@lemur>
References: <aNygY8Cm7LEaBzV6@localhost>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNygY8Cm7LEaBzV6@localhost>

On Wed, Oct 01, 2025 at 12:30:43AM -0300, Henrique Soares wrote:
> This is a simple question I have related to the PR diff review process.
> 
> How Git maintainers use to check diffs and review the code? I mean,
> sometimes I see that there are some large PATCHES that is hard or
> probably impossible to review only using e-mail client.
> 
> Do you use some syntax highlight in client e-mail; any pipeline that
> automatically download e-mails and apply to a local branch; or for each
> PR you save the e-mail file then "git apply" to review / test the diff?

There are tools that make it easy to apply a patch series to your local tree.
For example, here's a random patch series from the list:

    https://lore.kernel.org/git/20250919010911.649831-1-sandals@crustytoothpaste.net

This will apply it on top of the current HEAD:

    b4 shazam https://lore.kernel.org/git/20250919010911.649831-1-sandals@crustytoothpaste.net

This will fetch it into FETCH_HEAD, making it behave pretty identical to a
pull request:

    b4 shazam -H https://lore.kernel.org/git/20250919010911.649831-1-sandals@crustytoothpaste.net

From here, you can check out FETCH_HEAD to run tests or do a commit-by-commit
review.

Hope this helps,
-K
