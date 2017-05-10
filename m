Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4584820188
	for <e@80x24.org>; Wed, 10 May 2017 23:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbdEJXWf (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 19:22:35 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35064 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdEJXWe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 19:22:34 -0400
Received: by mail-pg0-f44.google.com with SMTP id o3so5008217pgn.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UlEy6HzCjhRiY7mRal/d3I3dEIlJxu50eYhZxsMNZ6g=;
        b=ZrXygXKBxIRw/EAg1lkor0/OCiV6463t/0N/AgXe8MJfN9x0ckLcmlzLRWk+T/5YES
         JK0pCPSK/TA+fzWBABi7abEyFOPjB+8Y6ch49dJ1Wr4bua1PLFv3gL1kr1uosF3m0J/1
         nra0aB6H+QIpx18M4Aa8xFx+77c81Y2SvokvM4bVzNSw+A2tLZMFCszX6i1v7hAstR5S
         FE6WjoMg0myn5JhY+8efGgNY4U+lywwkWR/6pWy04uX3eRix/XhWkIYCxap7ZkY8vLWb
         ZByplzbgIpMJneyRW3d1aaJgU+P9fckEBMyV3kenOB4S6tmGJ6j28nG3UfDQPyEfC+rz
         ockg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlEy6HzCjhRiY7mRal/d3I3dEIlJxu50eYhZxsMNZ6g=;
        b=LxxVCxtr/OJXxkfqjSyPi4CQxllbxVcRDOEV2QtTpw1BdYA9yMasFiA+ryiWqM0ar3
         5+hMwuAc0p0tTSigWL4/EUXVA2E1B+HrV0em0VCo32onKJCCInzeL8Vg2MQcZeLdhCRO
         1sfRPX19b2EkVqkRfnLN7kt61uJPWMAeSh4N/kPrr2VRIrf5BLUOJEfbKx6PRZxYrX0s
         Dp/0VSY/1bRjk1ggnUG2wJrs1Llnotna/ZlmHG394a5xUa2pPJEPEzW5pcmNb8ZqO08A
         /Xf5ws7Q2qtxNMZkeqP4woJ22dcmXBjaRqjt5vH4djPcZi3NAYP25jPt3MJfNicZlpeB
         o4eA==
X-Gm-Message-State: AODbwcBO+q0hGf4P0t0Kq3JVUiR3ZIBVFOpnjHOuxc3mu4eNxjYdkvfC
        Y6HEdikd7SDEFl2yhAU=
X-Received: by 10.98.80.66 with SMTP id e63mr8938972pfb.180.1494458553765;
        Wed, 10 May 2017 16:22:33 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id m89sm347842pfg.22.2017.05.10.16.22.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 16:22:33 -0700 (PDT)
Date:   Wed, 10 May 2017 16:22:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, spearce@spearce.org
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510232231.GC28740@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510221157.8971-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> fetch-pack, when fetching a literal SHA-1 from a server that is not
> configured with uploadpack.allowtipsha1inwant (or similar), always
> returns an error message of the form "Server does not allow request for
> unadvertised object %s". However, it is sometimes the case that such
> object is advertised. This situation would occur, for example, if a user
> or a script was provided a SHA-1 instead of a branch or tag name for
> fetching, and wanted to invoke "git fetch" or "git fetch-pack" using
> that SHA-1.

Yay, thanks again.

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -598,6 +598,7 @@ static void filter_refs(struct fetch_pack_args *args,
>  {
>  	struct ref *newlist = NULL;
>  	struct ref **newtail = &newlist;
> +	struct ref *unmatched = NULL;
>  	struct ref *ref, *next;
>  	int i;
>  
> @@ -631,13 +632,15 @@ static void filter_refs(struct fetch_pack_args *args,
>  			ref->next = NULL;
>  			newtail = &ref->next;
>  		} else {
> -			free(ref);
> +			ref->next = unmatched;
> +			unmatched = ref;

Interesting.  Makes sense.

[...]
>  	/* Append unmatched requests to the list */
>  	for (i = 0; i < nr_sought; i++) {
>  		unsigned char sha1[20];
> +		int can_append = 0;

Can this be simplified by factoring out a function?  I.e. something
like

	if ((... ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)
	    || find_oid_among_refs(unmatched, oid)
	    || find_oid_among_refs(newlist, oid)) {
		ref->match_status = REF_MATCHED;
		...
	} else {
		ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
	}

[...]
> @@ -657,6 +679,11 @@ static void filter_refs(struct fetch_pack_args *args,
>  		}
>  	}
>  	*refs = newlist;
> +
> +	for (ref = unmatched; ref; ref = next) {
> +		next = ref->next;
> +		free(ref);
> +	}
>  }

optional nit: keeping the "*refs =" line as the last line of the
function would make it easier to see the contract at a glance.  (That
said, a doc comment at the top would make it even clearer.)

> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -547,6 +547,41 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '

Yay, thanks much for these.

[...]
> +test_expect_success 'fetch-pack can fetch a raw sha1 overlapping a named ref' '

Ha, you read my mind. :)

Except for the search-ref-list-for-oid function needing to be factored out,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
