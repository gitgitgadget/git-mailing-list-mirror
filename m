Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937223AF64D
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532963; cv=none; b=NRL2eqgK9ph+kmoUQ1MdjQaZcFlqipqUuAqcch22BeWjvCLOXv7LFTJQgo9+dhO0SAxySuszp2CvdA8IjF1XZHO7S7SjHpCfr78dYvJ6vdczYe2oo5WURsfWNV4COybtbL3DyLW2lS5AuaYPd+fKvFpoAxQQIJKnGmPFbHtl8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532963; c=relaxed/simple;
	bh=h6oqt3n/SID8sdKmHVJEpoyGFI3QDmHIYk4eo/YbE0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9rgAdBOTdn9GOf6kzrmB+V1y4SJKBVXSpOZczX/9THqBB9OWll701vfM60xORpXsFhcBUaXTjyZVI3Mv6ZAVrZ4IOySq4KJd/lQGSv7I5T7Pv7SdJZ2Loif7YlVTSnT2eSUBNfyAoOqXS8mBBbhzbQ0URTYvUZjteQSm/c/Ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sV370VcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wW86+awo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sV370VcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wW86+awo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 839867A00B9;
	Wed, 16 Sep 2026 00:29:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 00:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789532960; x=1789619360; bh=wIgLexrhuo
	O9B99AFI3nvvKlMOlWH051xjovpa8EKLA=; b=sV370VcM2lyjHgHADhuFFAWrX9
	vvPXyQ03857CdGNnE+/fa/G6QlVdRmGQK55nk27XmCztM/hI82+uo/97X27RV1Kw
	FAUSFexXKhxgDQ/dVqDrU78nUihXLvH37gs9SDU5RZGOW7xuFCA87RzLG6jBjbeH
	qJ2tNKqv1gfj/db6jbiNYwj/nBc/8+kDI5s1mcR4Q3Qc0r5ThyhUBbZSw5ve9vO3
	iWfGMYhQBfT1BcJNS0ZdnImdxFkC/P1skA0fawKCo1and9AiPM1CQefRZR+7iiWU
	vgfhicb5a4c3qEojX7NPa0m22LTmMThCweLPo+wLtPq7BHapuFqPpXc/N/WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789532960; x=1789619360; bh=wIgLexrhuoO9B99AFI3nvvKlMOlWH051xjo
	vpa8EKLA=; b=wW86+awosI8+xC2y9jghrAWNsYXnCQtQ4jc8vIdCnwXhCIdkFYP
	92d1nIhX15z+uRGSTOvKpwXvHTtjrzI7KFd+Dazmrr3QCTHlbCBAgjX74htX06HS
	P1DVtIc5PzwNHrpDsJVXLLqEXWlsiGYz/l4nSmjlMqbbW/AbIRZzZCgBAVgWGrhM
	xMzFe2MM0ZrfSHbi9tF/H1CRx/2SNTiKBpxfAkO9FnDqzK4HN1/pjposDVesctRk
	pVk8wKw7RR6NbZlnVTWt03jGtEP0btE4IagC8nsjFfffbOBmpNnw90E9cQYt/2LZ
	lH5Y+D81CatE3FYLYK7yoXLpFuu9wTPWgUA==
X-ME-Sender: <xms:IBuqaq-8La4zqft6zZXv7BPhwObKKToz1I-R80U8753TwU5dftfWRA>
    <xme:IBuqaubRw-s1OfxDg5BivmyBph4Tsv_XluBXSa2DRk03iaamIdYRz9kyNdINpjL13
    3qHR38EI9bGNRJi9lhmfiMmDVqJl0LEXW5iAYHTYEUo03CGms0ylOs>
X-ME-Received: <xmr:IBuqap1dwI3n6p1bCOV6lmuPBps837EdEaPI-IZ2p5-UeG_nK6OCHAjx-c2UrwA0d1iU0_9hX9Nk3R7O8zpGSc7PrQY94P5BgW4W>
X-ME-Proxy-Cause: dmFkZTEuV9PBFIWDsG7HYhPOHp/QbGJ3irH91UsmFlF5fJaPs/lXR2CY6/hb6rP0Yvo1aT
    hhmDVCYmmTUqYw6JGbJs1PpypbRj4Asy/ZIUJs3ZDob9Vx+L7t0a70rXFKpgCJgCrImTlc
    XHJqYXxBCfpbbwTjzQiu9fXNDQGh2s9SvYTWDscPlZ6mHOii66xOLcQrVcm9pEYRoAe7hx
    jtS5jPgfrmKIsoBYiGUKOuiyO0u0ipLsJGV6W1dWhs2Ohg5bNfTAaJVGToLe/m4dJbMGEE
    6vvANviLxn3KUqwLQPXu9egjg1JdTfZwRrzqJLh0AFvleNgm4Xp/aVGJWKLrckRNu/0bWp
    UJXmO2Q9d7PjluogVSydhZKSj8JartWWpTZnWs8HqmGZvpPwokwIc8+2TB5PAMqfCyoRho
    VUf25oBQwEn5C4Nv1ebuIsdwqsgrs0KEl5mIKgvGf9JjZhAdRQIYSPRVyZ2o3iQVUK0ZzW
    M0SGRA1YSF2Mpxo6fNieAl8yKzoDRqtgmlPjUUljECkRri0aAvPldd/hoXckXUvZUK+DH0
    ljuxKxv3GDT36nn2/DoEFrMPpkhRDY7iFymSxyzkEOhdI3ikvndmgUlpAtcWDCnUb97aeA
    n4z0QjQ7M1BqCIpduJkP0dJVUD1KLIDgRCAWx/nCuw4uIQZJEUfXrmHwtAFw
X-ME-Proxy: <xmx:IBuqapZZrIXgaOLgElh3dd9BKz60lECvLphK5O4sdKXmkNuQ19bdUQ>
    <xmx:IBuqahK4nNODKNoRS2gszBwoprqw5C5qACH5ATtDLtOT9Hg3XYHnVg>
    <xmx:IBuqaoGq4sIhcYfoZRkpJpJFO_2_CVBrG_Q96n6DKF9kXagyslaRvw>
    <xmx:IBuqaov1proslCWXMvknsGD2CDDDw-sjgMoIgKJ8_OlU8WT-uqp8Ew>
    <xmx:IBuqau-h_FlyjTd-Qb9nXV11v9JmA9YyvcCsIERsyiaMDvufNuaxagqI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 00:29:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yongqiang Tian <yqtian668@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
    Johannes Sixt <j6t@kdbg.org>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] compat/winansi: fix die_lasterr() argument formatting
In-Reply-To: <20260916042312.35891-1-yqtian668@gmail.com> (Yongqiang Tian's
	message of "Wed, 16 Sep 2026 14:23:12 +1000")
References: <20260916042312.35891-1-yqtian668@gmail.com>
Date: Tue, 15 Sep 2026 21:29:18 -0700
Message-ID: <xmqqh5jpyg2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yongqiang Tian <yqtian668@gmail.com> writes:

> During WinANSI initialization, duplicate_handle() reports the handle
> when DuplicateHandle() fails:
>
>     die_lasterr("DuplicateHandle(%li) failed", ...);
> ...

I do not know about Patrick, but I do not do Windows, so please do
not Cc: me a patch that is primarily about Windows portability.

I'll add two whose with contributions much greater than I have in
the area to Cc: list.

Thanks.

> die_lasterr() collects the formatting arguments in a va_list, but
> passes that va_list to die_errno() as an ordinary variadic argument.
> die_errno() consequently formats the representation of the va_list
> instead of the supplied handle, producing an incorrect fatal message.
> The other current callers pass fixed strings and are unaffected.
>
> Git does not provide a va_list-taking variant of die_errno(), so format
> the caller's arguments separately with strbuf_vaddf(). This consumes the
> original va_list correctly and produces the complete diagnostic prefix,
> including the handle supplied by duplicate_handle().
>
> Save GetLastError() before formatting because calls made while growing
> the strbuf may change the thread's Windows error value. Convert the
> saved value to errno only after formatting, then pass the completed
> message to die_errno() through a literal "%s". This prevents any percent
> characters in the formatted message from being interpreted a second
> time, while allowing die_errno() to append the corresponding system
> error and terminate as before.
>
> The updated compat/winansi.c compiles with MinGW GCC 13. A Win64 probe
> under Wine prints a value derived from the va_list before this change
> and the supplied integer afterward.
>
> Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
> ---
>  compat/winansi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3ce190093..5547192a2 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -7,6 +7,7 @@
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "../git-compat-util.h"
> +#include "../strbuf.h"
>  #include <wingdi.h>
>  #include <winreg.h>
>  #include "win32.h"
> @@ -438,11 +439,15 @@ static void winansi_exit(void)
>  
>  static void die_lasterr(const char *fmt, ...)
>  {
> +	DWORD err = GetLastError();
> +	struct strbuf message = STRBUF_INIT;
>  	va_list params;
> +
>  	va_start(params, fmt);
> -	errno = err_win_to_posix(GetLastError());
> -	die_errno(fmt, params);
> +	strbuf_vaddf(&message, fmt, params);
>  	va_end(params);
> +	errno = err_win_to_posix(err);
> +	die_errno("%s", message.buf);
>  }
>  
>  #undef dup2
