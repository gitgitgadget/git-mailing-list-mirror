Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345C120281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdF2SGt (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:06:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33647 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdF2SGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:06:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so12769727pgb.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MPRavnaOJGEsru3rEL4vCcsPNftTZ3OD3cKjNPakaxY=;
        b=bYzFI357okCz1OWsRFkDEwW3NAGfMAHe+2oWfLVJsMZFzgXXn7tveBacjF8d/RpvES
         xiH5Dfm3Oesv8wbFymuCCTviix1kPpZFQYyFsZpdI0O6huhfX0Cat/5rEqjCrznm7NGg
         +knroQk/J4tXbci0EuD8y1S+o0dlnx8iiSuMGs8A2jqaiW/3P/lrYjGr/J3WmE8fpNzr
         X2c3dXIwtDSLEFGLHIROj5oi/KcNIKoZxNLNx+nqZsAOG5oiSPNWfhmNe9akDI6bZTs2
         IsD2dj0/r4Uyp9N2qcda2uZr418sJiPFtQIyj0+6T7CBAZltZOZha5cN7Bnf4mupvso8
         LGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MPRavnaOJGEsru3rEL4vCcsPNftTZ3OD3cKjNPakaxY=;
        b=YPTuyWI8hJgybBcSgd720s2rmGGN6DmHfRFCyDYuquiQplRzG7xUkZceJ+CnUDG8aq
         cjawQ18yY0CyAMZ4f5dUBWeVGNtneUZawcYt8kOvhw8Gr2oShzLlA6eawg+zwdh5g2Z3
         k3K/RREMt48ZBijx4hkST1k7l/slq1IRgD6izNaWmeEiibDsTpjXePFnra3lxNpHd3WM
         cQYIDxF6i5Zs/QQnrG9LxRyS4J75FbZGaKGSAhJugwL6E1QMiFGhckppn7J55IbAkHCD
         w+CobJ7Uq9ZRbfvAC11DOMgVWW/KXguAP1uSKypY/Sfu+j3ZbyO71yM2fH0a6dWc+ORx
         ozmA==
X-Gm-Message-State: AKS2vOwQxMnWnYPPP5iUlHQJzSSDa78zXiEey+j0a/oeTZwHE41pI6XF
        F5o268SMYEzIVg==
X-Received: by 10.101.88.8 with SMTP id g8mr10516086pgr.137.1498759606679;
        Thu, 29 Jun 2017 11:06:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id d11sm80307pgu.64.2017.06.29.11.06.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:06:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629011334.11173-2-sbeller@google.com>
Date:   Thu, 29 Jun 2017 11:06:45 -0700
In-Reply-To: <20170629011334.11173-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 28 Jun 2017 18:13:33 -0700")
Message-ID: <xmqqvaneu0qy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When using the hashmap a common need is to have access to arbitrary data
> in the compare function. A couple of times we abuse the keydata field
> to pass in the data needed. This happens for example in patch-ids.c.

It is not "arbitrary data"; it is very important to streess that we
are not just passing random crud, but adding a mechansim to
tailor/curry the function in a way that is fixed throughout the
lifetime of a hashmap.

I haven't looked at the use of keydata in patch-ids.c and friends to
decide if that "abuse" claim is correct; if it were the case, should
we expect that a follow-up patch to clean up the existing mess by
using the new mechanism?  Or does fixing the "abuse" take another
mechanism that is different from this one?

> While at it improve the naming of the fields of all compare functions used
> by hashmaps by ensuring unused parameters are prefixed with 'unused_' and
> naming the parameters what they are (instead of 'unused' make it
> 'unused_keydata').
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

> diff --git a/hashmap.h b/hashmap.h
> index de6022a3a9..1c26bbad5b 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -33,11 +33,12 @@ struct hashmap_entry {
>  };
>  
>  typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
> -		const void *keydata);
> +		const void *keydata, const void *cbdata);

As I view the new "data" thing the C's (read: poor-man's) way to
cutomize the function, I would have tweaked the function signature
by giving the customization data at the front, i.e.

	fn(fndata, entry, entry_or_key, keydata);

as I think the way we wish to be able to express it in
a better language would have been something like:

	(partial_apply(fn, fndata))(entry, entry_or_key, keydata)

But what you did is OK, too.

> +extern void hashmap_init(struct hashmap *map,
> +			 hashmap_cmp_fn equals_function,
> +			 const void *data,
> +			 size_t initial_size);

And this does match my expectation ;-).
