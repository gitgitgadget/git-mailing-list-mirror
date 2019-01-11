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
	by dcvr.yhbt.net (Postfix) with ESMTP id 449091F803
	for <e@80x24.org>; Fri, 11 Jan 2019 01:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfAKBTw (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 20:19:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34075 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAKBTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 20:19:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so13525088wrw.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 17:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5j6qeTV5sjobtiA06UuLKNGGRPktd8ogk6gYM9oc0Vs=;
        b=NI/O/FvdpcQ4d9rYQEO7lts79yZLnpr2t/P0AHTnfMRZi2tXikuzJja9Hj01psboQB
         5FFtcoGmzhAqegUK3PpwvMcaeAEjwsbum1R+oaYRl7Qea3Nr98g03c2G4hVnOQiZXEl3
         U+sJdcmrCWch6pdbmvSllTMSIz51Law1gWUsSVxMqT31JElfJYAqWXUBUXIN3hgHB2Nd
         zAAjYOwengbsPZni7HUu/VIT28QEvsHVz/JH0QxeRp9gaJFwr5TKIjh2UYniRuH+hmkO
         X3M0jZienSiSsOxq3q/VnluMv73x63nP+a896KwmzdG4JKAoYay7oFV2BnXmtH7Y4MpT
         KCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5j6qeTV5sjobtiA06UuLKNGGRPktd8ogk6gYM9oc0Vs=;
        b=uhmcw+RV00t140T9sJmwPV1avEvJruNMCBFb5MLFsxZe3F/7tplMdykZWq+f8xo4pG
         V0sDw1x8/4EgQyxcC1i2WbL0zRPuzXbOzozSHHStOs2LBlxMrTj/XHgsLnobCuoVEzrx
         lK6vuOXuGI0jhhC6PCEzoi9sxksNhjW52iniy4Bqc7tVdjoEJpWNh4f3iZwHmYrv4Nwy
         zWrgKbc5Lr0wxdmoIpxoE6FUcxonLFwLakoQJOJ3ZnDYgiLd349MRsz04REEgPDzXFwi
         K5BBdxcNNvDM+U6VdHKAnSkKD8RMR5JxwnwwwMzezcvdWwH5EZwJuzoWu0yYSatgmqLS
         iHcw==
X-Gm-Message-State: AJcUukdCSovv1LVib68YjvNrhqem3lfbgC6vW9YOnFsBdm3zD+Hyw5EN
        UAsVJ9bsC0NUtQuuDyKYdCg=
X-Google-Smtp-Source: ALg8bN5mm/DqCXo6tc/W4FNowm9ZaxaE5GPDPcZ2Zsa8DSjXda4jlBnW8cm9Xraj9pBlNIuO9CiR5Q==
X-Received: by 2002:adf:f984:: with SMTP id f4mr11519692wrr.234.1547169589455;
        Thu, 10 Jan 2019 17:19:49 -0800 (PST)
Received: from szeder.dev (x4d0cf90e.dyn.telefonica.de. [77.12.249.14])
        by smtp.gmail.com with ESMTPSA id f2sm53465592wru.14.2019.01.10.17.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 17:19:43 -0800 (PST)
Date:   Fri, 11 Jan 2019 02:19:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 2/5] pack-redundant: new algorithm to find min packs
Message-ID: <20190111011941.GB840@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
 <20190110120142.22271-3-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110120142.22271-3-worldhello.net@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 08:01:39PM +0800, Jiang Xin wrote:
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index cf9a9aabd4..3655cc7dc6 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c

> @@ -446,49 +484,37 @@ static void minimize(struct pack_list **min)
>  		pl = pl->next;
>  	}
>  
> +	*min = unique;
> +
>  	/* return if there are no objects missing from the unique set */
>  	if (missing->size == 0) {
> -		*min = unique;
>  		free(missing);
>  		return;
>  	}
>  
> -	/* find the permutations which contain all missing objects */
> -	for (n = 1; n <= pack_list_size(non_unique) && !perm_ok; n++) {
> -		perm_all = perm = get_permutations(non_unique, n);
> -		while (perm) {
> -			if (is_superset(perm->pl, missing)) {
> -				new_perm = xmalloc(sizeof(struct pll));
> -				memcpy(new_perm, perm, sizeof(struct pll));
> -				new_perm->next = perm_ok;
> -				perm_ok = new_perm;
> -			}
> -			perm = perm->next;
> -		}
> -		if (perm_ok)
> -			break;
> -		pll_free(perm_all);
> -	}

Please make sure that all commits in the patch series can be build
cleanly without any warnings (with '-Werror' or preferably with 'make
DEVELOPER=1') and pass the test suite.  This is important, because
unbuildable commits will cause trouble later on, when e.g. 'git
bisect' happens to pick such a commit.

In this case, the removal of the above loop removes all callsites of
the static functions get_permutations(), is_superset(), and
pll_free(), resulting the following compiler error:

  builtin/pack-redundant.c: At top level:
  builtin/pack-redundant.c:289:13: error: ‘pll_free’ defined but not used [-Werror=unused-function]
   static void pll_free(struct pll *l)
               ^
  builtin/pack-redundant.c:309:21: error: ‘get_permutations’ defined but not used [-Werror=unused-function]
   static struct pll * get_permutations(struct pack_list *list, int n)
                       ^
  builtin/pack-redundant.c:343:12: error: ‘is_superset’ defined but not used [-Werror=unused-function]
   static int is_superset(struct pack_list *pl, struct llist *list)
              ^

I see that the last patch in this series removes those three
unused functions, but that patch should be squashed into this one to
keep Git buildable with '-Werror' or DEVELOPER=1.

Furthermore, after building this patch (without '-Werror'), several
tests in 't5323-pack-redundant.sh' fail.  To avoid the test failure I
think the fourth patch ensuring a consistent sort order should be
squashed in as well.


