Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C1BC4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 16:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiKXQXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXQXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 11:23:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DC9E954
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:23:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i12so3214769wrb.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rzDA+AXBdF4dfvVDCDhTAMY4vntX5ChbfT1QVXto/s=;
        b=UL1CbVuekvjNjrzmHQuxkAy0SMzwjbsQpkndyM8v/Qn0E3CbrAJmU0oJ1Dke+Lis7e
         A4mBlQWIB9dMLg40ClAKXWQftVH8NMd+6Yzwca/D/n7UpDeHItTdoO2L6QXiXrTalT03
         U/lMNl+ZleJ7AD98cppf1A163u3tPl7NJiusK5jU+MRQJTVohDWQJpaIWA5Sx91p/d9M
         A/Lb8gZ+i2+EdB1ZOTDuygbTC3/bs6G5OPG8SFKj7qq7LtfB2V6KBffXHGpHNiYCAjnS
         Hj7OHQlD/iWu24MKpY+CcUGxomHYBnQ0mYFZCnxYl0G6AEYCkyiA1RAxSgfTDanRe4Ff
         qk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rzDA+AXBdF4dfvVDCDhTAMY4vntX5ChbfT1QVXto/s=;
        b=oUQSmAMwmj7HvQ71IhZkvsyQj/3WX6BPuW4h2OEJfzmHcY7vaiMBICJvLuU/eKltOM
         aW9I2lKa34U70wp3qoAopSlgcaQosCBmHl5b/935oOUIznSsh26oYOfYdUU3xGzX5v/N
         QBEBDjoyBvPKVBQMnGUwnJTwxMdwS5RvTOBwPPVQ8aW0yg6o8wi1zNNTXJTAdbmq8NOk
         zZoN6RwRYJCV/LAvcdFjtNilV1pl2RYfv4Wt5o8znlgZcgBtNGpO3HFTOkL9hHbPxTPk
         6Ept/LAafo7pYhtbjBDDs4Ou+rHHfVmPRFRND0acnSsOuQiOmF9xJUrgzfh15yms8BP3
         OqXw==
X-Gm-Message-State: ANoB5plKmv6IsUTcHiTsNzY0+yhwhta06xd74HWkxas8o2ZDD0WwQ4hx
        Fo70cgxSqi0oZnzAv8Z/IjY=
X-Google-Smtp-Source: AA0mqf7XracjMf4JX/Ydb/fKEjZCwvIoHQeGMJMOCRWxxBHIiphj6JwhgmA3qh3n08jULPWaHCVAdA==
X-Received: by 2002:adf:dd4c:0:b0:241:c075:30db with SMTP id u12-20020adfdd4c000000b00241c07530dbmr10892242wrm.159.1669306990005;
        Thu, 24 Nov 2022 08:23:10 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b00236883f2f5csm1715459wrn.94.2022.11.24.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 08:23:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyEyA-000Edl-1R;
        Thu, 24 Nov 2022 17:20:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 2/4] ci: show error message of "p4 -V"
Date:   Thu, 24 Nov 2022 17:10:12 +0100
References: <20221124090545.4790-1-worldhello.net@gmail.com>
 <20221124153934.12470-3-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221124153934.12470-3-worldhello.net@gmail.com>
Message-ID: <221124.86wn7knx1x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When installing p4 as a dependency, we used to pipe output of "p4 -V" to
> validate the installation, but this would hide potential errors of p4.
> E.g.: A broken p4 installation fails to run.
>
> Add some instructions to show errors of command "p4 -V", so we can see
> why the command output doesn't match.
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/install-dependencies.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index f639263a62..291e49bdde 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -83,9 +83,9 @@ esac
>  if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
>  then
>  	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> -	p4d -V | grep Rev.
> +	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
>  	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> -	p4 -V | grep Rev.
> +	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
>  else
>  	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
>  fi

I think it makes sense to detect this, but the specific remedy makes no
sense to me.

I.e. as your CL's CI output shows the reason we want this is because you
had a p4d (and p4?) that segfaulted. I can reproduce that locally as:

	wget --quiet https://cdist2.perforce.com/perforce/r16.2/bin.linux26x86_64/p4d -O p4d; chmod +x p4d; ./p4d
	Segmentation fault

But we had the initial command piped into Rev, so we wouldn't show that,
just

	$ wget --quiet https://cdist2.perforce.com/perforce/r16.2/bin.linux26x86_64/p4d -O p4d; chmod +x p4d; ./p4d | grep Rev; echo $?
	1

So we want to show that it segfaults, but how it is useful once that
command fails to pretend that it's a "bad version?" The issue is that
the command can't show the version at all.

	$ { echo >&2 "p4d: bad version"; ./p4d -V; exit 1; }
	p4d: bad version
	Segmentation fault
	exit

I think this should just be a plain:

	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
        p4d -V
        echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
	p4 -V

As we're already under "set -e" (in ci/lib.sh).

I.e. I don't see why we need to work at making the output less verbose,
and then if we fail run the command again.

If we really want to make it less verbose and avoid hiding segfault
messages perhaps we could filter out the stuff we don't care about?:
	
	$ ./p4d -V | sed -ne '/[Cc]opyright/d; /[Ll]icense/d; /http/d; /product/d; p'
	Perforce - The Fast Software Configuration Management System.
	Version of OpenSSL Libraries: OpenSSL 1.1.1q  5 Jul 2022
	Version of OpenLDAP Libraries: 2.4.59
	Version of Cyrus SASL Libraries: 2.1.27
	Using the 'SmartHeap' memory manager.
	Rev. P4D/LINUX26X86_64/2021.1/2313999 (2022/07/15).
	
But I don't see the point of that effort, we won't look at these trace
logs unless something fails, so just including the raw output seems most
sensible.
