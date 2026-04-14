Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7028B4FA
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205090; cv=none; b=XgBvS8aCJ6zC6RegrTXSOESRf7n8+9isjpUJpQfteo2aK+lecHA7O86+UI6+0W5sbbn7VFxB01cBwq31oNRJmHPAI9ZPRAq6hr/Fd3cY8nX/+YPeDWVhmb/ePhaXeoG55afsvjNIj1KlZNHmQip8RUSSEKu0z/zKkfnybluMiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205090; c=relaxed/simple;
	bh=s/ocCQ37Bi5vyJwREvaXl4IaaG+BkiTr9/8T1SwJutE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJLf2qdYsbSgmyeraMVbZqjFPIuVzb8qPrbsgr/tXWQ4tzSJGpBibGVl0fmdc0wzeShbPvI+mzAFUuWCQr8ecFQ+15hbv05IKUW1Hkf77wNGt6NGqXm321vf+Yi6TbZouo/2ZWk0vWN4ggUaqkCWzjIZPKJ3jzExKkVhcQfj2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EDH8oM1D; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EDH8oM1D"
Received: (qmail 350792 invoked by uid 106); 14 Apr 2026 22:18:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=s/ocCQ37Bi5vyJwREvaXl4IaaG+BkiTr9/8T1SwJutE=; b=EDH8oM1DOhXAew4zNDXXru7Pll9MgFVioMSZ4qTsRtOSK/2NuSHi2ontis4IxAYKAGf1Jvb3pw8oRFAjodw79w9I20tOubEJIOU7f9Hp8qStrdfK5IixcLlJBSnC1N+/Yc8GW6WB1X2JxlMzir9yTQOCceUEgJVkvQdQxHd59/HqXptRLa9Q7Z5Oa/+lzZEpV0RgBimUerwosz9VfAFWihBmKKVYKNtkvTM2dt7boDRqJ0WY5b/rNsbou+7y22tSfOMgP/6M9yBCN1OBqabTexl2kLsq/wmLcJbfV5CaSyEb8aYyDyEOZVawy1Unal4CZ8/j0WD0nxZ4EIDbNNP/8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 22:18:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587119 invoked by uid 111); 14 Apr 2026 22:18:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 18:18:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 18:18:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Message-ID: <20260414221807.GB3475104@coredump.intra.peff.net>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
 <20210221192512.3096291-2-szeder.dev@gmail.com>
 <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
 <ad6pEbnSKzUOkS2k@szeder.dev>
 <xmqqv7dt8cyj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7dt8cyj.fsf@gitster.g>

On Tue, Apr 14, 2026 at 02:11:00PM -0700, Junio C Hamano wrote:

> I was wondering if we should remove "test_might_fail".  Its use case
> is rather limited to very narrow cases, like
> 
>  * we want to kill something but it may have exited on its own
> 
>  * we want "git config --unset" but the variable may or may not be set
> 
>  * we want "git foo --abort" just in case we are in the middle of
>    "git foo"
> 
> all of which is clearer with "|| :", and more importantly, the thing
> whose "failure" is protected against the test framework declaring a
> test failure is *not* what we are testing (these "config --unset"
> are not about testing "git config", in other words).
> 
> So the extra ability test_must_fail and test_might_fail have that
> they can detect uncontrolled death with non-zero exit status (aka
> "crash") is not very interesting---it is more like "As we are
> running a git command here, it would be better to catch than not
> catch a segfault here as well", i.e., a nice to have item.

I think the main value of both (but especially test_might_fail) is that
they slot naturally into &&-chains. I left a similar comment in that
other thread, but to expand a bit, if you do:

  false &&
  true || : &&
  echo everything ok

you will get "everything ok", even though step 1 failed. You need:

  false &&
  { true || : } &&
  echo everything ok

except that because it is shell you have to add an extra semicolon after
the ":". ;)

Syntax-complaints aside, I think it is a very easy thing for
contributors to get wrong. So I think test_might_fail has value, though
I do not care if it has a different name.

-Peff
