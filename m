Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3942070
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246022; cv=none; b=AqpPgi//RzPLVkk9g8vRD4jwsYsYO9kVJyLjVsDA/Q2nI1ydH/3JKHu2s4hU73Todm+KnU6JojBh9cfm6K/D6Fz31tGzLFlHJA79+N/6euwqnmh4Pg7WEMreBIPQ8Fl1KFZgcPkYpBUbnebRUl8eABIHzYCd2Cv38MWXSgFhtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246022; c=relaxed/simple;
	bh=jGIYcjiiZordwZDuMZpjpYJWxOiMIWgj7bSAjK7vKuE=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p0QrsRxc7l26QVByzD0DxVb3y91hjMaO7sR4E463W5Ou4fi9RF8GOXyV2WtX/rLf4jPnCXfFwGyzUZ5BPymnV1p4U73rnpTCORoGm+0EH6WKI2wMZlTuOpxSbSFn0X+jmihchjP1NWhOYh6r9fw24opzelT9JpEPOhCo9EcrhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rbacXGsU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rbacXGsU"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713246017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSbmIeQ3yfE8Fy1SpO7VtAQD5Zi+G4+gC7a+5rjypjE=;
	b=rbacXGsUaU8vVzR4IRrsJ1cFDUN0ZQ7LqlGWDxbpV5v1guSmww/2qhtkBrUiw7JgZPbj4O
	PHgGOoAtV1WaqwU95Bx/aJf9dQLA6pnoq7Aiv0NbDszmCWha+ACv3nODeOJK9pb8BpHim1
	ufz+1TebSLsuEqH3Ol8yyGpgp+NPnCjxx1mV40l25DLn8RR6v3jwMHUWcKPzOypr5aYwus
	WJccLkJmjjOlhLkj3THLStyAcb+DPKTQtoAmk2rf7i8sEYLzFR/nfhCv1viNwqLABgqYkX
	MwLYDB1h3tABVBOKT4woU4nlEKxK693d7m6MQP8AKKfR/UyQZIWYJ86ONa0nwA==
Date: Tue, 16 Apr 2024 07:40:17 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Make support for multi-value configuration options
 more consistent
In-Reply-To: <cover.1712016667.git.dsimic@manjaro.org>
References: <cover.1712016667.git.dsimic@manjaro.org>
Message-ID: <cd4a48d415af215fde2d7e593d28c055@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

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

Just a brief reminder about this patch series.

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
