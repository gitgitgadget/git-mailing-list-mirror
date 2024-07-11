Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355E15ECCA
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713950; cv=none; b=tTCa6BOsgSJ32Rm5sjYgKNUrKO6OqgnHnOYeu7vZB5SRM2Kp9ooKhQYIgbqR6FGzDZZRGcL9x8cMGH8g/qr+R3J3yI6Af7WWmI+vPxbIBsNwfEJsBbIzD5SKgNdIRucudvL71Ua9gpTLjIBBhqLxYciGQzRPrHbq+pC5CuRMD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713950; c=relaxed/simple;
	bh=c+tO5fVOsDe7tE2VKRtFFa4PAN/KGIEZf5Zr0wkGuAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfRjs3A2Wdz47FCYRlSNHWQBh5K0ULb63IBseLL2bt8VKc0SDJMTLWEzG++A3VoTYXMvzVquws7D0Fqk3gO6aZ720DmuItmHxuBkCQ1cd6y1Awv1/TIVZg40Vdv5FdVxD6pQwa3n7uwF9+nguiRL7JnXXG3Ln1DYr8mQc4bWUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TebwuKHm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TebwuKHm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A2CD37EBF;
	Thu, 11 Jul 2024 12:05:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c+tO5fVOsDe7tE2VKRtFFa4PAN/KGIEZf5Zr0w
	kGuAw=; b=TebwuKHmx90Vp+hhT39of3sDAaPTWKrEYot0UkhdtYBP7GP5wiubKP
	BFJ6wgJzQG2gBfGA+QHWrnxoWnZXJ1mKeaBnrbqAacAB3G5HYwAg26fAR5Dy6l+V
	CvaJOJz2QSxcloYqhkJnxi7oMLxToEuSbNShXFykGepq0XAn8MnSw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6335A37EBD;
	Thu, 11 Jul 2024 12:05:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 711AE37EB9;
	Thu, 11 Jul 2024 12:05:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH v2] doc: update http.cookieFile with in-memory cookie
 processing
In-Reply-To: <pull.1733.v2.git.git.1720687008915.gitgitgadget@gmail.com>
	(Piotr Szlazak via GitGitGadget's message of "Thu, 11 Jul 2024
	08:36:48 +0000")
References: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
	<pull.1733.v2.git.git.1720687008915.gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 09:05:42 -0700
Message-ID: <xmqqo773syll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6DB67118-3F9F-11EF-9047-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Piotr Szlazak <piotr.szlazak@gmail.com>

Thanks.

> Information added how to enable in-memory cookies
> processing. Cookies from server will be accepted and send
> back in successive requests within same connection.
>
> At the moment documentation only mentions how to read
> cookies from the given file and how to save them to the file
> using http.saveCookies.
>
> curl / libcurl will process cookies in memory if file name
> is blank. Check curl manpage:
> https://curl.se/docs/manpage.html#-b
> This is described here in more details:
> https://everything.curl.dev/http/cookies/engine.html
> And also explained here:
> https://www.youtube.com/watch?v=V5vZWHP-RqU&t=11459s
>
> Git documentation was updated to include suggestion how to
> enable this by setting empty value for http.cookieFile.
>
> Changes since V1:
> - better explanation what in-memory processing means
> - added explanation that http.saveCookies does not work
>   if http.cookieFile was set to empty value
>
> Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
> ---

Here is how I amended the log message, FYI.

    doc: update http.cookieFile with in-memory cookie processing

    Documentation only mentions how to read cookies from the given file
    and how to save them to the file using http.saveCookies.

    But underlying libcURL allows the HTTP cookies used only in memory;
    cookies from the server will be accepted and sent back in successive
    requests within same connection, by using an empty string as the
    filename.  Document this.

    Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

A few points to note:

 - It is our convention to start a proposed log message by
   describing the current status in present tense ("currently", "at
   the moment", etc., are not needed).

 - The observation of the current status is followed by the
   description of a problem the patch tries to solve.

 - And then finally we give an order to the codebase to "become like
   so".

 - Changes between iterations do not belong to the log message, as
   the log messages are written for those who run "git log"; to
   them, our previous iterations do not exist.  We describe changes
   below the "---" lines.

> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index 2d4e0c9b869..e71ca11c10b 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -78,16 +78,18 @@ http.extraHeader::
>  
>  http.cookieFile::
>  	The pathname of a file containing previously stored cookie lines,
> -	which should be used
> -	in the Git http session, if they match the server. The file format
> -	of the file to read cookies from should be plain HTTP headers or
> -	the Netscape/Mozilla cookie file format (see `curl(1)`).
> -	NOTE that the file specified with http.cookieFile is used only as
> -	input unless http.saveCookies is set.
> +	which should be used in the Git http session, if they match the server.
> +	The file format of the file to read cookies from should be plain HTTP
> +	headers or the Netscape/Mozilla cookie file format (see `curl(1)`).
> +	Set it to empty value (''), to accept only new cookies from the server and
> +	send them back in successive requests within same connection. NOTE that the
> +	file specified with http.cookieFile is used only as input unless
> +	http.saveCookies is set.
>  
>  http.saveCookies::
>  	If set, store cookies received during requests to the file specified by
> -	http.cookieFile. Has no effect if http.cookieFile is unset.
> +	http.cookieFile. Has no effect if http.cookieFile is not set or set to empty
> +	value ('').

I reformatted the patch and added minor word-smithing.  A few points:

 - Avoid unnecessary line rewrapping.  This file gets formatted into
   HTML or manpage and formatting tools will take care of filling
   paragraphs.

 - Use "an empty string", which is used by other parts of this file
   and other documentation files under Documentaiton/config/
   directory, instead of "empty value".  We should fix other
   instances of "empty value" in the file for consistency but it
   should be left outside the scope of this patch as #leftoverbits
   material.

Thanks again.

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b86..bd04ca1c2e 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -82,12 +82,16 @@ http.cookieFile::
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see `curl(1)`).
+	Set it to an empty string, to accept only new cookies from
+	the server and send them back in successive requests within same
+	connection.
 	NOTE that the file specified with http.cookieFile is used only as
 	input unless http.saveCookies is set.
 
 http.saveCookies::
 	If set, store cookies received during requests to the file specified by
-	http.cookieFile. Has no effect if http.cookieFile is unset.
+	http.cookieFile. Has no effect if http.cookieFile is unset, or set to
+	an empty string.
 
 http.version::
 	Use the specified HTTP protocol version when communicating with a server.
