Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC701C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 20:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjBBU4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBU4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 15:56:24 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B98692
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:56:23 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e6so3137623plg.12
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fNwTp/1t404HjDPRjS3E7TURZwJDVunwh8BtWyWwoI=;
        b=heCOM9Q72OxXMq9ueB0EyqeObIp1Qc3DHt4DUbNIgXejgtBl7A5SustkwCUdXYsXc2
         CRTDcftJb1FsNb5M3j+fo4+tR729uBC2Ws9NHBbvSbNJPdm+2fxG20BvipsjwR82GyfF
         1aPTVPVH6tsn9488Y2rNlvyV3Jk/KKonVeM6dW+K2neECdstLdh5IKq16WDimvFJkLtC
         C8/SzGqczLrz/ttbXa/KmqeJCu1BiCkQPRN2KUEGyvKJLzyLATB3JXaV0ckS4mOfUNyJ
         UxJWNSVrGcNLT/vaEj6vxCnXKiOdB2PE0H9U6o1qus1F3ZY4dH1VNN7ldM8mGS7q6X7l
         iE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fNwTp/1t404HjDPRjS3E7TURZwJDVunwh8BtWyWwoI=;
        b=eD+DiYMNilUaTR9MrWCZu5MGv3mOTNeNmmeRbSx7KyRZaDJv8mGvmKmnLFlAwQLZ3B
         Q+0sd/mOk8uIG3lOQk1tdYxJtyqANhc1apyQ1yIh9S66FiIEbElCt3+uQgwUgvZB/EoB
         76+hjtXblsk/kl9LgCFAjiYB39kOez8HlAeKaqMAhVp+1Q1EK9DGW1FsskH2PDtrKKRy
         uSUnBQxY0Kd58b5B6qBo73WrXJNFSy+tETNN2RH9ooBmF9RJV+hk79Nopl2n3Hh2kP+N
         vWM+zBTCX4wm/IurMimeLMTKh1D0JP+KibTZkhCSgHVT939MTs+s4cU7RSOuHzE96a4h
         jDQQ==
X-Gm-Message-State: AO0yUKWwRU1GCGHYW2cEh2P3rsUEf3KrMM21QWD7S3CNvvXK8vp17HRo
        sK1snqvsk0nr1+hmtAQTenI=
X-Google-Smtp-Source: AK7set+3o0R1kci8Kx3+Z9Iczcx/9Jgkjedd+Jn+9MQIUKt+U2/bkyTAZRqN0ThDCc/xKJjH6xjO7Q==
X-Received: by 2002:a17:902:d482:b0:194:997d:7735 with SMTP id c2-20020a170902d48200b00194997d7735mr9105397plg.48.1675371383162;
        Thu, 02 Feb 2023 12:56:23 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902ee4400b001885d15e3c1sm117091plo.26.2023.02.02.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:56:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 12:56:22 -0800
In-Reply-To: <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:44:17
        +0100")
Message-ID: <xmqq5ycju6q1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Before [1] we'd force the "imap.host" to be set, even if the
> "imap.tunnel" was set, and then proceed to not use the "host" for
> establishing a connection, as we'd use the tunneling command.
>
> However, we'd still use the "imap.host" if it was set as the "host"
> field given to the credential helper, and in messages that were shared
> with the non-tunnel mode, until a preceding commit made these OpenSSL
> codepaths tunnel-only.
>
> Let's always give "host=tunnel" to the credential helper when in the
> "imap.tunnel" mode, and rephrase the relevant messages to indicate
> that we're tunneling. This changes the existing behavior, but that
> behavior was emergent and didn't make much sense. If we were using
> "imap.tunnel" the value in "imap.host" might be entirely unrelated to
> the host we're tunneling to. Let's not pretend to know more than we do
> in that case.
>
> 1. 34b5cd1fe9f (Don't force imap.host to be set when imap.tunnel is
>    set, 2008-04-22)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

I agree with the above flow of thought in principle, but I wonder if
"tunnel" is distinct enough to allow credential helpers to tell that
they are dealing with a "tunnel", and not a host whose name happens
to be "tunnel".  Would it help to use a token that can never be a
valid hostname instead, I wonder?

> @@ -1004,7 +1004,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
>  				if (!CAP(AUTH_CRAM_MD5)) {
>  					fprintf(stderr, "You specified "
>  						"CRAM-MD5 as authentication method, "
> -						"but %s doesn't support it.\n", srvc->host);
> +						"but tunnel doesn't support it.\n");

Do we need some article before "tunnel"?

>  			if (CAP(NOLOGIN)) {
> -				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
> -					srvc->user, srvc->host);
> +				fprintf(stderr, "Skipping account %s, server forbids LOGIN\n",
> +					srvc->user);
>  				goto bail;

OK.  We are talking to whatever "tunnel" is that was spawned to talk
somewhere we do not have a way to know, so trying to say <this user>
at <that host> is futile.  Makes sense.

> -	if (!server.host) {
> -		if (!server.tunnel) {
> -			fprintf(stderr, "no imap host specified\n");
> -			return 1;
> -		}
> -		server.host = "tunnel";
> +	if (!server.host && !server.tunnel) {
> +		fprintf(stderr, "no imap host specified\n");
> +		return 1;
>  	}

OK, this is a natural consequence that we no longer abuse
server.host in the tunneling case.  Makes sense.

Thanks.  Will queue.
