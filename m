Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0297FD
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017874; cv=none; b=EHQAOGgyVPbT4MBrY+pn+sQs/t2Zej7wueOHuBox5/+GSeQMf+gOZJgwM8ajCaD0z9xcRrc3F89bzcMlAf1oWdXjxJaaYAQb2krTnV+PI1Zcw2h0XmTudN3o//Zg6QZWUUsSjCMFUarfnBg/M2aNpY+zd0YdFBGNSZgODT5TEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017874; c=relaxed/simple;
	bh=o+/OncVIYW6QfANI6o4qeEu7ES6LdMPSLWRxaboJEW0=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nizszc8jcYjJANXVQZ+JirS/7Ixq0yaOGJUP+MEe9m9HLJ5MbYp+vixlcQoDQfokzKeqU+OlyKOIxu/TNljjemcXJ7uihg6K3pZfcvgZG5xZW4bT+vLiky7Wzt8fuRTbpjUsYED3xdCaIeJUPvS36HoQ+mArQ1M0JY1JdFTy2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=A2PWP53O; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="A2PWP53O"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712017870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMOVheujdBsRhpmwyqySZWbyVIxN/ME+ItgqTQ9NJh0=;
	b=A2PWP53OQX+ojipKTPsZfC6PVHfprnJf7gST4eKQQfGCe9D4FEB45vp7XxMD4tWyxEcFdp
	37kH/9NsrXC+0GpcY9fP6K/sTXwHfnoYHFZw7qb9J8J/TQIsyMfZNLAp1MEGUgiNvq61Do
	cqihpsaEIegTtEGqIbdgLLkgcW4se8FDrTbv0kd5PoKDDCLHEoaxHtxGnS99pSVtCFXDU9
	zKsdlF2RI3E0PE1limIMMrMZ+TxUQy9kN08fIp6QuQrAqJ2cwsgcwHGvW+mDUrQZdKAIDH
	S3P3LpLzpD0w4Aye/S8Y6j9nqRxoSYMYST7/uvvi1fOnS99HPjG50XFkdTW1eQ==
Date: Tue, 02 Apr 2024 02:31:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Make support for multi-value configuration options
 more consistent
In-Reply-To: <cover.1712016667.git.dsimic@manjaro.org>
References: <cover.1712016667.git.dsimic@manjaro.org>
Message-ID: <833011f0a807b6176de6fd8a8389b1bf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-02 02:13, Dragan Simic wrote:
> This series adds support for optional placing of additional whitespace
> characters around the commas in the multi-value, comma-separated values
> for the "diff.dirstat" and "diff.wsErrorHighlight" configuration 
> options,
> and the "--dirstat" and "--ws-error-highlight" command-line options.
> 
> This makes the way multi-(sub)value configuration options can be 
> specified
> more consistent, because exactly the same additional whitespace 
> characters
> are already allowed for some of the configuration options.  It may also
> make the configuration files more readable to some users.

Meh, somehow I managed to forget to include the brief summary for the
"what's cooking".  Here's what might be used for that purpose:

  * Allow additional whitespace around the commas in 
"diff.dirstat=<multi-value>",
    "diff.wsErrorHighlight=<multi-value>", "git diff 
--dirstat=<multi-value>"
    and "git diff --ws-error-highlight=<multi-value>".

> Dragan Simic (3):
>   diff: support additional whitespace in 
> diff.{dirstat,wsErrorHighlight}
>   t4015: whitespace in diff.wsErrorHighlight and --ws-error-highlight
>   t4047: whitespace in diff.dirstat and --dirstat
> 
>  builtin/gc.c                |  4 ++--
>  diff.c                      | 14 ++++++++++----
>  notes.c                     |  2 +-
>  refs/packed-backend.c       |  2 +-
>  string-list.c               | 27 +++++++++++++++++++++------
>  string-list.h               | 10 ++++++----
>  t/helper/test-hashmap.c     |  2 +-
>  t/helper/test-json-writer.c |  2 +-
>  t/helper/test-oidmap.c      |  2 +-
>  t/helper/test-string-list.c |  4 ++--
>  t/t4015-diff-whitespace.sh  | 36 ++++++++++++++++++++++++++++++++++--
>  t/t4047-diff-dirstat.sh     | 33 ++++++++++++++++++++++++++++++---
>  12 files changed, 110 insertions(+), 28 deletions(-)
