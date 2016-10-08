Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DC61F4F8
	for <e@80x24.org>; Sat,  8 Oct 2016 13:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbcJHNij (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 09:38:39 -0400
Received: from mout.web.de ([217.72.192.78]:62946 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbcJHNii (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 09:38:38 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lkh7Q-1bKcwV3FUS-00aVoY; Sat, 08 Oct 2016 15:38:31
 +0200
Subject: Re: [PATCH] remote.c: free previous results when looking for a ref
 match
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <20161007235857.20382-1-sbeller@google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e9f58e04-a534-6794-feac-f6a47ca8bb65@web.de>
Date:   Sat, 8 Oct 2016 15:38:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161007235857.20382-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zYd0V3uSjBoNWiysmS9yA9iFB8CKI253iXQ+NkuIxGIyKra9wZO
 Vn9f3bjieac6zvnWZjBqNVNsWX9N7WUFy3VnKqzY1N4gCaGCgmSBYrchxVfMUgTyenb2EvH
 fr+b0AB9I+ZFQxHBZWqgENV9z8f/sV8RAk0aO483cJo1X0N38Tjm7z6PgiW4aqb7ZwUClBT
 nxzqBBkiIfx9DEMddDcnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0jK9EmgMj5U=:ekSOzPwu5lwyL/U/O5VaVy
 Z7m4AVkLpT4/ZFfqrLS+iJo4U/Lmg+BmpUEVvOoFCrKfyeZ7ryQKzDugtS+gu1OWrMa5hmPye
 0VafVFqJoHd8z/VLbvkzHQbsc2J38QI69f9dA11aGeti/GDNDpLNvxk5SKrw+UZBMRJQo8c46
 kdhRwecHvXELudO4eVG1P9fY1NTRilgosftGSw4jmloKtkAQB6xfzU0QcmZvdjNWJDLRg7jYq
 DjbzRQtL3CmycyGi90LZ8BsXt28RCE9mPzGambjHv/YAk4pLfcxQv+mp6rmf8APLCq7WS4nTr
 8bcn2sXgK2ByzOnFdqcRjbAp68+jEtDGFVvTJgqFR+2vaDeiT86poCNm+JuED9OUZ19tNHGg0
 Xyo/ggHfyJA3XLVrVSuh6eHx3uMnyskRFTnZjEm8Fz6FKcdfEvlCmW93Fy/2eFoFWrFtX3HcT
 G2tsjmnsCfSyQlZBuOSTs+6mbTLGVvLfq5jVTWb3sFqE0zNZvG24AGf4dFcMa71BiycvwPMp1
 iyaZ+7bCRtARSHZUkoIW6yywfYP8PVyvJy3ndreaCjWVmCxCQ91KaStmeXc+YFCGsGUL4yGLy
 xtAnQTHlPJYoJ71ZyPlZoPM9v9IoWXBqT1A4eDrOAtCH3fElWs8IZD/N6Hs7SycRdFLqdwPo3
 aRTCB8xMf/F+UmdPXftPEYR5GgOqoLdYNCgat2FQHeR6Madfprt2fzitxC6SX8FXmD+yLaVBA
 dO6psQp1eVwSmb2MSCSFQ5ICbT1QetR9WrcPOUnDwpfoCIOcsyXGSwOA9bIi+x6p7yERiF527
 GbjGkog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.2016 um 01:58 schrieb Stefan Beller:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  remote.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index ad6c542..5f9afb4 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -833,6 +833,8 @@ static int match_name_with_pattern(const char *key, const char *name,
>  		strbuf_add(&sb, value, vstar - value);
>  		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
>  		strbuf_addstr(&sb, vstar + 1);
> +		if (*result)
> +			free(*result);

free(3) can handle NULL pointers; this check is not necessary.

Is it wise to release memory for callers?  I'd expect them to be 
responsible for that.  Some of them can pass uninitialized pointers; 
this is not allowed anymore after the change.

>  		*result = strbuf_detach(&sb, NULL);
>  	}
>  	return ret;
> @@ -1262,6 +1264,8 @@ static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref
>  		 */
>  		if (!send_mirror && !starts_with(ref->name, "refs/heads/"))
>  			return NULL;
> +		if (name)
> +			free(name);

Again, this check is not necessary.  If I read the code correctly the 
pointer could be uninitialized at that point, though, causing free(3) to 
crash.

>  		name = xstrdup(ref->name);
>  	}
>  	if (ret_pat)
>

