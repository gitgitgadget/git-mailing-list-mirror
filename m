Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12971B3F01
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112405; cv=none; b=qVTs5iiUQMjb6zcqAdldU41irOCDocIfnLUKVmr6JgiQ7+UvvEC41Guk/f0aoSpC901dTU1Y0EHphA1FVrHowpIadV0nff8ZF+ahC3Dzi4pA74a3Muf127MK28fYj2SjF4lLYW2ErjBbCIssWUTKWwMaW5jTnYI5BEivktnXN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112405; c=relaxed/simple;
	bh=XoukR1gMUl7K9hYc6DHUSNX9ckD/fEnsaMy7vwKxQ2A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbDsnzzS95ixpmrNR86SafkxPgh274YMuSSdYK8gdNZfAKm/wEEmXnnTCkvuNQGOaTB5CIstcagS6uJAFAW8Vvc8VyE8NxbWs9o6xj61hsxOMr2zp9d/mifUKCdjabHGvBaIKJk925J0uXBcRMNEAkvaBoOfznoQ8wvyVLtlt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+WB1xNt; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+WB1xNt"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so71264fac.2
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720112403; x=1720717203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=INB/oMw0pFD5kbtzoMgARmrrVhcqUsUl2diIG2XqldA=;
        b=h+WB1xNtKHyBzAT+ClLwrH6gzUkahZupoF4eMXNtS0DDmgHUNuj8eSRdxpKg+Fyxfk
         8pxCMw6vtWDfE9SAlUwqxE1S/vnekBo9MrSsluD2LyIhxliUYRZ5Fwl3VxCvticjSSEW
         hKcpIuGqn6+3+4F3hexkSP0jbh7/dFtI9M1fyeDbrIbkxvhxfkJTiuZpImp6XSh+hNgW
         2uehV7F8wLMcbyi5ONxHrei4l+v3t0vkjbx3z4nI9HGz9VkfohIwnAhQ9/paMNuIOovV
         5Ja7pkTKDXr6rqeA4jYK8rafUxMcrsMWhzjPgbgPgN829sGYYioX3P5XLzNkF2zxBU8u
         y+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112403; x=1720717203;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INB/oMw0pFD5kbtzoMgARmrrVhcqUsUl2diIG2XqldA=;
        b=EOKmM66YPCQxU/0gEBEJ+k1Qz4KYbuLY0Z8V9TUFUZhoot/T6ZtQZm+ZlOsWNJog+y
         AHmeFP7Rb2zrf1FEEGlqqJn4XKwrwoK/DSsdLiQFCLVSl39Af5CiiqG+GbZsTvMJ6qB5
         HpELL/85AmmBDt1yiBKe8AmUMV7E4HAY2ORytPTo731DLgJWhMIn7NbUeg+8nFaCikrZ
         d4ROYZH/BeW+5LlEK+DTBtcemCSfaRBkhwOnhCxrrwnqwvh3g8kG96ZjiuZNlT8prfGn
         ko9YK+DGTP5HT5Ds1M1tqTEoBiBRdbPplJRtL/mCC3c9E2Y+mnAPVzPWRNXBwDkCcXEl
         fUXw==
X-Forwarded-Encrypted: i=1; AJvYcCUkLPsQrYcWR7UKzd+XCAVZJchv//WYZG00WqUF/wTjWokInWoTNshe/STOMMlvyBcfeDBUre211XlhsPGa2gPb8E1S
X-Gm-Message-State: AOJu0Yz8Hmu1T9MH51HdFzrGy+IlSp6J3EfpC3axWF8ceZ/61MHsXcIq
	J6XxrJKN99yTGODAT2k4OJfwegBhNbyNCy2PkB4wNDyVMW5k1y0JEcfMrg991J4IWXJqf+4E6Oa
	v8IzNxujlSS/263aSeNWPMQE5OthXPwdH
X-Google-Smtp-Source: AGHT+IGI+IlnqsSTDV9QouPebNkh/x5B3JFBHtG7CBHc1eZHKR/zPVx1djJG6gfD/1Z6+KG5TnmMZJ0jdTuTts+KHiQ=
X-Received: by 2002:a05:6870:5b8d:b0:254:a57e:1aed with SMTP id
 586e51a60fabf-25e2bb7aee4mr2094209fac.26.1720112402692; Thu, 04 Jul 2024
 10:00:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jul 2024 11:59:59 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628190503.67389-2-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com> <20240628190503.67389-2-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Jul 2024 11:59:59 -0500
Message-ID: <CAOLa=ZSY1y4wz6M9mOLvTCPoeCmceD-HKqT5tomF+BzbL5yp4Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] fetch-pack: refactor packet writing
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000bc9e3b061c6ee095"

--000000000000bc9e3b061c6ee095
Content-Type: text/plain; charset="UTF-8"

Eric Ju <eric.peijian@gmail.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> A subsequent patch need to write capabilities for another command.

s/need/needs

> Refactor write_fetch_command_and_capabilities() to be used by both
> fetch and future command.
>

Nit: mostly from my lack of understanding, but until I read the code, I
couldn't understand what 'command' meant in this para. Maybe some
preface would be nice here.

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  fetch-pack.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index eba9e420ea..fc9fb66cd8 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1313,13 +1313,13 @@ static int add_haves(struct fetch_negotiator *negotiator,
>  	return haves_added;
>  }
>
> -static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -						 const struct string_list *server_options)
> +static void write_command_and_capabilities(struct strbuf *req_buf,
> +						 const struct string_list *server_options, const char* command)
>  {
>  	const char *hash_name;
>
> -	ensure_server_supports_v2("fetch");
> -	packet_buf_write(req_buf, "command=fetch");
> +	ensure_server_supports_v2(command);
> +	packet_buf_write(req_buf, "command=%s", command);
>  	if (server_supports_v2("agent"))
>  		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
>  	if (advertise_sid && server_supports_v2("session-id"))
> @@ -1355,7 +1355,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  	int done_sent = 0;
>  	struct strbuf req_buf = STRBUF_INIT;
>
> -	write_fetch_command_and_capabilities(&req_buf, args->server_options);
> +	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
>
>  	if (args->use_thin_pack)
>  		packet_buf_write(&req_buf, "thin-pack");
> @@ -2163,7 +2163,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
>  					   the_repository, "%d",
>  					   negotiation_round);
>  		strbuf_reset(&req_buf);
> -		write_fetch_command_and_capabilities(&req_buf, server_options);
> +		write_command_and_capabilities(&req_buf, server_options, "fetch");
>
>  		packet_buf_write(&req_buf, "wait-for-done");
>
> --
> 2.45.2

Right, this commit in itself looks good. But I was curious why we need
this, so I did a sneak peak into the following commits.

To summarize, we want to call:
   `write_command_and_capabilities(..., "object-info");`
in the upcoming patches to get the object-info details from the server.
But isn't this function too specific to the "fetch" command to be
generalized to be for "object-info" too?

Wouldn't it make sense to add a custom function for 'object-info' in
'connect.c'? Like how we currently have `get_remote_bundle_uri()` for
'bundle-uri' and `get_remote_refs` for 'ls-refs'?

--000000000000bc9e3b061c6ee095
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 18964e4a6f4da9c6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hRzFRMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmZRQy8wUis0djZQRkRPVTd5K3FhbitZbWY3THhXSQpvRjRmNFRRZGcr
ZGM3OWFBTFlJckU2cWlVOTgwb1hxTkE5UzQ4NktuL2ZKd2g4cjByYjFzclNjY3BkY0FRaXJtCkFR
aGJQUGd2QnMzNDJNdVFLRmFmY0x2NERlKytjZnBZZTY4ODNiMTlKOUZjUDFSZHpjY3g3aVRqWm1n
b0luYXMKQzUxaUJMdnJLWHRRcCtNYmJlWnR5UUVta3UzSHhCTjBTc0toZ1BqdHI1NVhza1h6NTBk
dmc2ZExQbzZzZDlucApGa0o3WnBOLzJxcVZ2b3p0RUhEN01PeHBjeUZ1Mk41ZVhFQndLMG8yV1F0
Zndwem8vSTBYOUF6ODNkeHRjWXhTCnoxS2hUREFkTUFhaStVOWdncDZoMkxOUnBkYW5iSGtUVFBE
S3c2b3lQWWd3eHBjZUpac0l2ajE2cVVmTjhRaGMKc0E5WnZ0dmV3QUZJUEwwQ1lNZ3R3WFNlWTUr
Z1VRQno2WFpkc29RUHVRQkhTSnl4VmhYQ1NUQnhFcmNwdFhtaAowR1dHbTN0VVpsenRyR2xjRkpV
cGx0T3VubjFjbW5JMzhnS1NPVDhzUWtSN3p5VXV1TmZKVzNkc2xPNGVtaXRlClU2L3dXTHhBVUVv
TW4vbXMrK1lHQm8zY1IvY0UyMFQvdElEN1F1WT0KPWRrQ1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bc9e3b061c6ee095--
