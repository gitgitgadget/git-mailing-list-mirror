Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A441F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934405AbeF1ROg (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:14:36 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:50710 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeF1ROd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:14:33 -0400
Received: by mail-wm0-f54.google.com with SMTP id e16-v6so10513283wmd.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7dK+hEc4mfK8NBRylu+2Z9N3UCXZwKoqbEe9E1GjDm4=;
        b=nhGNvw1YRylqX3nZBY+3orwSDdm4Y77xZwzCwRqGD/ycDR1yVRMqq7Ai9IyYFgFvZB
         ltDjqNwnlROtaRGYTX8/DipGS6Z8m9UEIyFlHHgU9dM0jSccODiTVC6bVD+5acff7355
         vyNIVnpqripihySPgqNO3KuKg1UzjmqrK9toobZSnoSscJ7yclxJWgsRFD/h9I8Pi5BY
         I6HSeOw9v3HQlmaAeOd/Pgc3ykZT1oPLTjsUuLyf8X8L2xAjKQp9u1Dq+TrBDzCtPyH+
         cE80w/Jru7rk3G4DeKAamxDTLaap/0Dzujjpim4UtX9ASb/jucgqokOe2uyTG+4t3WoJ
         RO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7dK+hEc4mfK8NBRylu+2Z9N3UCXZwKoqbEe9E1GjDm4=;
        b=PGHhRDDau8me61oPepUaxxnQjW3Np95ak3Aoi3QFYi2Lh7y3YM5hG6bmz10WfHWtiu
         MD97g72CPpWIt9sgnX7C54P24lfe+ftcQUB504XNV45R0skSh9eeSou915+HmILVs08z
         MpgBN+EtrPuUFsMmXYC41G3ZhmZHy0M3duEeE58NY03FTHQnZkM6yM/WAd8lfOfHSmCm
         uZPTiw6v+HmuOlMBeRpqdl42hO3guOAqLOFqCAJlmdrFDQcuSVWwZOi9yRtgACn6wvPC
         4gxZC1q6G6jlDtteNoK6QxZGN3hNOy43tHWW8sI7WrpxSAzRL2GV4SRZmZ8jPN0KerJQ
         1NYQ==
X-Gm-Message-State: APt69E1pBBFPgvz9OEbNtgB0B/qPbILKiIu/5AeJLVbKEiFiY8U94Goh
        QXfmW8k8CRtph9E1wdNvYB4=
X-Google-Smtp-Source: AAOMgpfqs+44iHA2yd07ic7XIX7exXg7Ab0wfYa0cy8yQoNdUBo6yoTg6o/DZFMEVFOifKErHCsBoQ==
X-Received: by 2002:a1c:b80a:: with SMTP id i10-v6mr9328225wmf.123.1530206071929;
        Thu, 28 Jun 2018 10:14:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g4-v6sm7215452wrq.32.2018.06.28.10.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 10:14:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "peartben\@gmail.com" <peartben@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [PATCH v5 2/8] read-cache: make_cache_entry should take object_id struct
References: <20180620201557.77155-1-jamill@microsoft.com>
        <20180628135932.225288-1-jamill@microsoft.com>
        <20180628135932.225288-3-jamill@microsoft.com>
Date:   Thu, 28 Jun 2018 10:14:30 -0700
In-Reply-To: <20180628135932.225288-3-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 28 Jun 2018 14:00:07 +0000")
Message-ID: <xmqqin62ygsp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> The make_cache_entry function should take an object_id struct instead
> of sha.

The name of the hash is SHA-1, not sha ;-)

It is not worth a reroll, but I do not think "should" is a
particularly good thing to say in the title or justification in the
log message in this case.  It is more like you (or somebody else who
commented) _want_ to make it take an oid for _some_ reason.  "teach
make_cache_entry() to take object_id" is probably a better title
that admits that we do not explicitly say _why_ we are doing so,
than saying "it should", which equally is not explicit ;-)

> diff --git a/read-cache.c b/read-cache.c
> index fa8366ecab..9624ce1784 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -746,8 +746,10 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
>  }
>  
>  struct cache_entry *make_cache_entry(unsigned int mode,
> -		const unsigned char *sha1, const char *path, int stage,
> -		unsigned int refresh_options)
> +				     const struct object_id *oid,
> +				     const char *path,
> +				     int stage,
> +				     unsigned int refresh_options)
>  {
>  	int size, len;
>  	struct cache_entry *ce, *ret;
> @@ -761,7 +763,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>  	size = cache_entry_size(len);
>  	ce = xcalloc(1, size);
>  
> -	hashcpy(ce->oid.hash, sha1);
> +	hashcpy(ce->oid.hash, oid->hash);
>  	memcpy(ce->name, path, len);
>  	ce->ce_flags = create_ce_flags(stage);
>  	ce->ce_namelen = len;

The patch itself looks good.

Thanks.
