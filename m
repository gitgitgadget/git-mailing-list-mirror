Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CF4921B1
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730220; cv=none; b=bZT7YpQvkdZE0S47q/HHAa5bmRmIB5ysLTISGkE2JMR58xA/gxh6z96SgW/HUuJkI/jek8LZvQswdOFLjgPjVTLkWib29ZI7lmG6VXzJJ7R8hFPZP3iB/iQswbk/zpvkMX7Bs8UJ0pi42Igt0SYVxwxov29yW6bRXJHDZ/STT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730220; c=relaxed/simple;
	bh=LEOTZhcqReeRFJGjF2o9Zidslo3RErwDLDRNJs83ADo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brg6Hi63O/OqTR0vrtOb3Vl3YmG8pkJHhA1XZ57zUI7yDql4btLVrN9Rf7PIKwadO9cOxjNRnhAK9+nktu5QMUFkqjw2u9LnHDEHoioy0tQTqEcZti3H4rdPI4dgETE6WsBj2VXqY+80rw4pK8Bl9Jb7fTzDqdB7ZKO9u8M2xio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=FfaiylUz; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="FfaiylUz"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LEOTZhcqReeRFJGjF2o9Zidslo3RErwDLDRNJs83ADo=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786730216; v=1; x=1787335016;
 b=FfaiylUz+YSunbeVCy9Nhg9+9ASZXZkE4MXxG0IMPrJ93PEPtQmMz02M5XhowaA19eHZH4GG
 zRTZkS4hB4sWPNV8mwVvgVBfbA1H85MCUzgBD2/B+oKBKYjLbvBd/Ju5e9nrWarh75hNdmjJwB2
 VnB9xIM4Ph8W1t+Uf2swNPkX9ZvgkgRHSdOdVWhc+KQ5K0fduveVNq5g5zJ0J/vtHY2klOfTrbl
 26kww+HXPdoSwhsTmW2Sucup0WDmPay5kbQMgWFne+0gee/C86HACQH8+9KI/vZh1BqMulN6W2u
 EQVnqQGTAXUWYj4exUD6mSI1qS5Q7mmUfXb0RS0dWQzNg==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (117.176.242.163)
	by smtp.migadu.com with ESMTPS id 799aa14e18ce3c9f;
	Fri, 14 Aug 2026 17:56:55 +0000
X-Migadu-Flow: FLOW_OUT
Date: Sat, 15 Aug 2026 01:56:49 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Tilak Raaz <raaztilak07@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] submodule: warn on valueless active config
Message-ID: <an9W4XwY8X4ZFHpA@wyuan.org>
References: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>

On Fri, Aug 14, 2026 at 11:07:29PM +0530, Tilak Raaz wrote:
> Hi everyone,
> 
> My name is Tilak  (he/him), and I am a second-year Electronics and
> Instrumentation Engineering student at NIT Rourkela. I am preparing to
> apply for GSoC 2027 and am starting my contributions to Git.
> 
> Regarding my background with Git: I have built Git from source,
> successfully
> navigated the codebase, and tackled the NEEDSWORK comment regarding
> valueless 'submodule.active' configurations in submodule.c.
> 
> Below is my microproject patch resolving this issue by switching from
> repo_config_get_string_multi() to repo_config_get_value_multi() and
> adding an automated test case in t7400-submodule-basic.sh.
> 
> I look forward to your feedback!

Thanks!

However, my suggestion is that it would be better to place your patch in
the main body of the email text rather than in the attachment.
Please take a look at Documentation/SubmittingPatches [[attachment]]

And it also seems that the automated program 'b4' is unable to recognize
your patch, which may make the development process less convenient for
the developers and the maintainer.

$ b4 am https://lore.kernel.org/git/CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com/
Looking up CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com
Analyzing 1 messages in the thread
No patches found.

Please correct me if I'm wrong.

Thanks.
