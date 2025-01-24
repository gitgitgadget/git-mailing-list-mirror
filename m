Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4114A0B9
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742390; cv=none; b=FjTtMZuNqi3e5OIO0+AQulgCr6R30qEJY4/w4L01RJKI6SqM0/BwW/JglOOiIIULamkGVrHoWrGb5BlugN/8Et5Rrg5E7ngVYVHkFTVzYyCfUAoNvRrLNVcvEVVWHgZd+Ve4DWZ9KnGT9bfbZ250x4kZYu/eWCWip3/182oWFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742390; c=relaxed/simple;
	bh=MzBE22tTZQJjA3TOquNdx8do3y6GqaIKKTNbD6MLoyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KK9cXxkswM1AnkziHentsEYFWJf4she8fJbMJ9gII+S3Tg/lAYYKe/50SZsWd/u1aMYPLTrCIcVxBpxHaE7zNdIkS2c7PXK0ER3L/GMsVq8Aof9b0bM8mxFxge/oTvMMw7zJfWlwf2WsXf0eqOZDjXmQxdsvMr3z8cQewkh9wF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hh1iLfVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RT8K4oMq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hh1iLfVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RT8K4oMq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AF39D13800D9;
	Fri, 24 Jan 2025 13:13:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 24 Jan 2025 13:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737742387; x=1737828787; bh=wClpVNY3Sa
	4bx88IGXe3QfYcBmEOIzX6ZJeuvCRZPVU=; b=Hh1iLfVLAKjfDA8b9t/JkE+jN3
	3J2y6gtI3JI84D/yWqY3Ph7lrSi6Md5UYEnQINcdP6QyU9N2p1st5TaOTwjnRKM+
	5WEcvozfhmCwrEXIZcAlZdWv8JmePptRH4K8B4xCB/kw1L2zj9yJgtTNVsN3VuQ9
	oJ5vYLlNkO+9Bq1ru89KprPJJuGcyIhL5rogjV0MzV4bsz6P+IPSKmfWsprGLOcY
	2AvQfua7o15KywYUe8DpXZk4VE5AqmW9h43ezLi3w8GmKF1IoErJnT5/md2ow6no
	tkfLEHot8veQecrig8QWV7aEY3UxjnTq32jCQwS3RD3afOzFpsO98OAa3Hgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737742387; x=1737828787; bh=wClpVNY3Sa4bx88IGXe3QfYcBmEOIzX6ZJe
	uvCRZPVU=; b=RT8K4oMqBnDsvecfC0WTta7fxpli2swuQDvrJaN/vpCjecojI2T
	LkTHIsa5BqVAM7mNywC1/4ArMz/34R5wR5u/qaMpBZM1VrH79xkrsPvHOeEh4QL/
	R84i5ukn0dX4jlbk3p35S8xMOBENFJqNDq7JTu2UpAgLQM3rcEriY18T26HQhVAA
	87t5xeV4hkuuFqE3FWqBpB+ps9kK/ENgdmSO0bueg95eMxVFO8dMXEe8A+No+C3j
	VS2FRcK7X1sfK6IOoHynxxQVMiD3di4gD/UJ7dYGw4it1cAyf27Wf5Lnb3zJVhSl
	iFeFqVjWxsahCLJp+nOuhEZnXZ/AIjEsNEA==
X-ME-Sender: <xms:MtiTZwC9FTD2M962YhegcIFD3ikwvhaX2VOkSIDFoh026DQEFggXZw>
    <xme:MtiTZyiVBYWnLW0jxxLQUyy29WZ0u7TuHcEbbaDP2JvD-5YUZVwHX1gCddBGit3PF
    475WAZqJ5PSCTsCzg>
X-ME-Received: <xmr:MtiTZznKos_pgD1rMXbOIyv6ngxbr8AEwX1hlmlqLZvSonsTRoeyeZKdRHwOpkEUZxo7Dlrh_7hh4P8Er_6R-AD-c_UXfK636agS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:M9iTZ2y8bskX7wNO2qb-SGCdttLpew6PP__uual2Guy0SWPa0sj8ug>
    <xmx:M9iTZ1QGQ9lW0TPcv66bhhOtkFfaQ9KaSnbCYCQLApIlhspAhlDvUQ>
    <xmx:M9iTZxbGj-eWpAfaHBuvfu3HcnDjXQ-dVUAAImgONuyxwV010JqmSA>
    <xmx:M9iTZ-SsFOdS_zduoAhIHs3uD_J0S863vbwaMGLR342M91ay6Og7fQ>
    <xmx:M9iTZ0KulVNI4VODtYC6htQztuErCd_wA3Qi5Qy1fcWtqiXv5hmk8Uek>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 13:13:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/6] version: replace manual ASCII checks with
 isprint() for clarity
In-Reply-To: <20250124122217.250925-2-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 24 Jan 2025 17:51:36 +0530")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-2-usmanakinyemi202@gmail.com>
Date: Fri, 24 Jan 2025 10:13:05 -0800
Message-ID: <xmqqy0z0xeq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Since the isprint() function checks for printable characters, let's
> replace the existing hardcoded ASCII checks with it. However, since
> the original checks also handled spaces, we need to account for spaces
> explicitly in the new check.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  version.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks.  Nicely done as a separate step.

> diff --git a/version.c b/version.c
> index 4d763ab48d..6cfbb8ca56 100644
> --- a/version.c
> +++ b/version.c
> @@ -2,6 +2,7 @@
>  #include "version.h"
>  #include "version-def.h"
>  #include "strbuf.h"
> +#include "sane-ctype.h"
>  
>  const char git_version_string[] = GIT_VERSION;
>  const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
> @@ -29,7 +30,7 @@ const char *git_user_agent_sanitized(void)
>  		strbuf_addstr(&buf, git_user_agent());
>  		strbuf_trim(&buf);
>  		for (size_t i = 0; i < buf.len; i++) {
> -			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
> +			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
>  				buf.buf[i] = '.';
>  		}
>  		agent = buf.buf;
