Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598361F453
	for <e@80x24.org>; Tue, 12 Feb 2019 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfBLK7e (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 05:59:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36792 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLK7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 05:59:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so2539770wmj.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IgjZElsQbAiLu1DUbFeev1eYailSh59E9OwoHRcMQ+E=;
        b=Wsrgwlu4nNo6JBoD91LIoSpAgAPq3tXHEvvly3Pi4TN9BbbBMGqNSCE5h30nWsNaWc
         YS20Db2jXZxUbXJye3ju1xZlvn7JRh15l4IVehdIsbCGaZJGyBeXt74JoI4H2vnfxNlq
         G4yX0QNWEkBDjY6wfUyf5n4RedvyYWnw1mpXM/XIDPy2pSTvVCzwJ1DVOcPK5PQOoq2l
         1QMgp7IjmrsrNVwuOcNRXR0yJa9dreh0gcQlv2fDmMS5QlJePPrQ+NZq/B7qJYkRy4Yu
         U5d17x7y4rexfReveIhBoDu5fPn1xHK3j8vlw5EY0uEUw6zpUP3QN8C5/6/HTcyzheE4
         qvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IgjZElsQbAiLu1DUbFeev1eYailSh59E9OwoHRcMQ+E=;
        b=L2nUftoX3QeZL3v2vgBcIR9yWVbJQo7F5WSuxSl8WOjhtdrr0icvjExwHZGiFgWggy
         9T/tw50VbwyfrVBuaACnNuiIHLUFShW4MVS1ymHpbWC6cOYavkH4J9afQfgu1N1/uDXl
         hmdHynAMLttCkiqTKiAQ+OjsmbLv084WyeWr38sVwoIeQX4XU55kq0XJD/KMzf2DhPxb
         G5/uASkdKxEQ4lJ4C7acs1S8fak1iCZh6F32opcK86NCUZ3B41E4AFZuj4BynFLYaTPH
         coWCZJ//cgBTBk9LEPjeYv+SrIInjSXHHcMLDx2vYgVGusZBaayswa4mDKZlvXsJNm0t
         Hbiw==
X-Gm-Message-State: AHQUAuaa0rGhzbCmUfY2TStYD9KiiXIy0tdGgmhRNYADlFaC890Z91ic
        7wF5VLMpKmTEynpbD/gB5B8=
X-Google-Smtp-Source: AHgI3IYOrCTcgyYXU5cCi+PiBCKBjQk5aNM+sfpztgDXp9M96JP6T/u3xapWYrOhI+a61MAX7mh6yg==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr2417442wmg.76.1549969171726;
        Tue, 12 Feb 2019 02:59:31 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id v6sm27881197wrd.88.2019.02.12.02.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 02:59:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 30/31] Git.pm: make hash size independent
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-31-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212012256.1005924-31-sandals@crustytoothpaste.net>
Date:   Tue, 12 Feb 2019 11:59:27 +0100
Message-ID: <87zhr1jmr4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, brian m. carlson wrote:

> The cat_blob function was matching on exactly 40 hex characters.  This
> won't work with SHA-256, which uses 64-character hex object IDs.  While
> it should be fine to simply match any number of hex characters since the
> output is space delimited, be extra safe by matching either exactly 40
> or exactly 64 hex characters.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  perl/Git.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index d856930b2e..62c472e0ce 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -980,7 +980,7 @@ sub cat_blob {
>  		return -1;
>  	}
>
> -	if ($description !~ /^[0-9a-fA-F]{40} \S+ (\d+)$/) {
> +	if ($description !~ /^[0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})? \S+ (\d+)$/) {
>  		carp "Unexpected result returned from git cat-file";
>  		return -1;
>  	}

The gitweb code doesn't load Git.pm now, but does anyone know a reason
for why we'd avoid any perl/* dependency in the gitweb code? If not the
regex here & in gitweb could be factored into e.g. a tiny Git::OID
library which would either just expose a $GIT::OID_REGEX, or something
like the sort of interface (might not be worth it) that I suggested in
my feedback to 31/31.
