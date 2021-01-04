Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B33DC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 17:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA422482
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbhADRGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 12:06:42 -0500
Received: from mout.web.de ([212.227.15.3]:37397 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbhADRGm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 12:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609779876;
        bh=jPi8I73CZ0vn4y5ixvY2zCvmWmn8xAjRCs5J4ClqNl8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=n+D/TQbYxSj1GP/CguNzhYx4E1Q8rhXY7YBygIvgZHfhFoFdfc1Kx1S5hFNXW99PT
         N4h7OuOeCosj1aoA1ZxsvqeXYrLoquVlp/QmUWtDIWDuLwpkqKrfIZM+gti2/AuzfK
         6StFca9FpS/MLTpS5V8RQCn1H6+SmdcfSld8Xt7A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.159.90]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3Slc-1k5k8a1JEO-00r1Z0; Mon, 04
 Jan 2021 18:04:36 +0100
Subject: Re: [PATCH v2 1/5] mailmap: add a function to inspect the number of
 entries
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <abe4aab0-8c95-2ba4-fe21-81e020869418@web.de>
Date:   Mon, 4 Jan 2021 18:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210103211849.2691287-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eTUfVLLo2QIpQ08rz5lUL9OvHti9xBtSjAPD4jBsezRrQN8hTs0
 3eUz/cdbC0DMY/LXRSk8BaVWASUu1n5qoNbb6H1jQ6e5knRQ2J+vKgNCPZ4jYYEU58aAwWh
 qoVB3USB4bng0bbX+9L8zu/4pvfCEf3kLY4WgPyhrcltawNFw9vYBNu4BJEH2tki7czaPRA
 bEEG6E05krtob2F1Fu5QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogTp/AiK5OM=:o1tAwPzCpNk0M4CPxKNe2A
 j/GV27921y3w670ylZ9ukL7FEWhVQxoB8NbuLle54yVYZKj8yTx0gtYvRXuOlH507g2KhkKFt
 Z/TCY6D0dlltuPoWaRrJsK3YlwUlUfzy+nxG36Bx9jCXigUBHnPFS0PyxRsF+270ACYrrG1NZ
 zhw3b1fi63Mlxjpdcc5jR8YKaEFFNwD6QnSTXuZvqkL5ZblvhtgXN2XytDU69GTjvnxPi4NEJ
 XgK9Phd76bBAqC4c98tKhJGGcYtaDd9hXHw4lZokjf+RNUxc0kJmSWtvQcbZ0sUNmahetKvI7
 V9vHQP1oW3gY7ySNte2c3InnPuLsooOUrCf5ge+WgcKiCxhkwuJ7jXeWB0t7IcGm8JQrZh5DF
 pxiy5ZA5W37UTAxIYkXcr7R7G9saFvbyAPbQeXCm+to9BgiuJ3xFGTU13r18LhnVVdn9s0V3Q
 rLXNpDMHJ8H1vdrJVWovZ9ltTZURdPSnLW1IR/5UhF35TnR7DXC8rQevksbGJbIbcjjqEOJOS
 QdVl0snHEZ2FnEfXslHKAhpRgylDg1ZwaOX3G6EuWzws466s2hyTPi5alDPyj1ejQjtZFzil8
 bpAjKN78EJGdYWSYrgS0mKT1i3WCRwGZjKa3TO6Mzl1bxftO6i4zrA3tt8OCYmlzPmApVYvhO
 IauVmQJZaimzf+a17yhajTUsi18L+cRF9hN5gP/qx3o8goOUmmkznOq2RafdXD0AszMKEilD+
 qoJUydZa+k9T52qAQKfj0ml72SuVBr3c8I42DJlfp3CKm2OgPzL843oSG/pSSUHKGGkwhkxTD
 AciFnUZLOY6HbgPP0/sGf0nIBMxjeijCJ2fsWigLJ+CZHBw9tC5g2IbHvb7x8koc21SC7WqdO
 r2i18L5gZG7pPIMxKkxw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.01.21 um 22:18 schrieb brian m. carlson:
> We're soon going to change the type of our mailmap into an opaque struct
> so we can add features and improve performance.  When we do so, it won't
> be possible for users to inspect its internals to determine how many
> items are present, so let's introduce a function that lets users inquire
> how many objects are in the mailmap and use it where we want this
> information.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  mailmap.c | 5 +++++
>  mailmap.h | 1 +
>  pretty.c  | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mailmap.c b/mailmap.c
> index 962fd86d6d..c9a538f4e2 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -361,3 +361,8 @@ int map_user(struct string_list *map,
>  	debug_mm("map_user:  --\n");
>  	return 0;
>  }
> +
> +int mailmap_entries(struct string_list *map)
> +{
> +	return map->nr;
> +}
> diff --git a/mailmap.h b/mailmap.h
> index d0e65646cb..ff57b05a15 100644
> --- a/mailmap.h
> +++ b/mailmap.h
> @@ -5,6 +5,7 @@ struct string_list;
>
>  int read_mailmap(struct string_list *map, char **repo_abbrev);
>  void clear_mailmap(struct string_list *map);
> +int mailmap_entries(struct string_list *map);
>
>  int map_user(struct string_list *map,
>  			 const char **email, size_t *emaillen, const char **name, size_t *na=
melen);
> diff --git a/pretty.c b/pretty.c
> index 7a7708a0ea..43a0039870 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -681,7 +681,7 @@ static int mailmap_name(const char **email, size_t *=
email_len,
>  		mail_map =3D xcalloc(1, sizeof(*mail_map));
>  		read_mailmap(mail_map, NULL);
>  	}
> -	return mail_map->nr && map_user(mail_map, email, email_len, name, name=
_len);
> +	return mailmap_entries(mail_map) && map_user(mail_map, email, email_le=
n, name, name_len);

This seems to be the only caller of the new function.  It uses it to
avoid calling map_user() in case the mailmap is empty.  Since you're
doing performance measurements: How bad would it be to simply remove
that check?

Ren=C3=A9
