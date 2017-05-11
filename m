Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F6C201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755856AbdEKVfu (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:35:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36179 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755040AbdEKVfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:35:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so3488259pfb.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CirP1zQPqpoZx0XQECSQRBDtOpCgFJJlgS2r40WIUfg=;
        b=pduHGX14IOAR8yfjHzkqYgqjxhwJduUsCFVEyuhRGril88y1wpue0PWl98+L5vNc1s
         KzatJqs6F+IR4d26jmHrCOti26PvZKD8rCHI/9zp+yLUkbPPBvBJISUzIn4ytK8syDhz
         v4HRTbNFBx4RMqlwtJT1bbMYCqlnmvP0XKq2jlT0FbvNo4cfJWUzWP4Ads0x0qojf4RD
         vdvRMAdGOnh3TkOULv9nOTcqLWsy9nML9ki9iMweEnL5SvXkPU20MT/79COiBjGPLQih
         A9Y4O19g3yVdYP0i6jD/r8UyXAuIO2HQTXx6/d4nu15voq7rBX3YmRveHHr+koWfzTdT
         BK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CirP1zQPqpoZx0XQECSQRBDtOpCgFJJlgS2r40WIUfg=;
        b=quAiNnv+zqxiuhij/s5FB13yDLvyJ7fxpqxEVb5anL+2nA71rFC3Z5+xqMZRgiZrHL
         M7fMzE4Oa2UQHJ5APMVnNplYKP6M0hOKRg+yhYuve9fZCR3/KQU/6blY9TyqS9f4ATmu
         HYW56uC/BnVsj+IAr2Jn3Rylgu2QmbOvsXOpSS+vdfOiqAmlxzHRbd5Z5v3aFgr8tp8y
         E1YkMQINvdA7RdVc4h7VhYE34UhMJN4Pgws3mKPpS8NSrCANdicnM8PQNLePA6+Y4B2K
         yfGMgQO7VurCCkJC0yOH2BI/JOw/NtqpOQdfArPyFKwKc55qSK9C3PxhayYQM3D6wsQQ
         qu0g==
X-Gm-Message-State: AODbwcAGNAGc4eUwyayBwKsD2OVVrS4L94l1gitSAfgu4fnfF2Tc5f6z
        rtI/x9EmxMdNnQ==
X-Received: by 10.98.139.21 with SMTP id j21mr649832pfe.5.1494538543735;
        Thu, 11 May 2017 14:35:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id c83sm1688512pfd.113.2017.05.11.14.35.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 14:35:42 -0700 (PDT)
Date:   Thu, 11 May 2017 14:35:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511213517.GA21723@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511211403.5252-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511211403.5252-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Thanks, peff. I've incorporated your suggestions - I don't feel very
> strongly about this, but I guess it's worthwhile to avoid the quadratic
> behavior if we can.
>
> Also incorporated Jonathan Nieder's suggestion about the placement of
> the last line. The relevant function is also factored out (following
> peff's suggestion).

Thanks.  The structure still seems more complicated than it needs to
be.  More details below.

[...]
> +++ b/fetch-pack.c
[...]
> @@ -592,13 +593,22 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
>  	}
>  }
>  
> +static void add_refs_to_oidset(struct oidset *oids, const struct ref *refs)
> +{
> +	for (; refs; refs = refs->next)
> +		oidset_insert(oids, &refs->old_oid);

Makes sense.

[...]
>  	/* Append unmatched requests to the list */
>  	for (i = 0; i < nr_sought; i++) {
>  		unsigned char sha1[20];
> +		int can_append = 0;
>  
>  		ref = sought[i];
>  		if (ref->match_status != REF_NOT_MATCHED)
> @@ -649,6 +661,21 @@ static void filter_refs(struct fetch_pack_args *args,
>  
>  		if ((allow_unadvertised_object_request &
>  		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
> +			can_append = 1;
> +		} else {
> +			if (!tip_oids_initialized) {
> +				/*
> +				 * Check all refs, including those already
> +				 * matched
> +				 */
> +				add_refs_to_oidset(&tip_oids, unmatched);
> +				add_refs_to_oidset(&tip_oids, newlist);
> +				tip_oids_initialized = 1;
> +			}
> +			can_append = oidset_contains(&tip_oids, &ref->old_oid);
> +		}
> +
> +		if (can_append) {

This structure could be simplified by putting the lazy-initializing
tip_oids lookup in a separate function.  For example:

	int tip_oids_contain(struct oidset *tip_oids,
		struct ref *unmatched, struct ref *newlist,
		const struct oid *id)
	{
		if (oidset_is_empty(tip_oids)) {
			add_refs_to_oidset(tip_oids, unmatched);
			add_refs_to_oidset(tip_oids, newlist);
		}
		return oidset_contains(tip_oids, id);
	}

That way, the caller could be kept simple (eliminating can_append
and the repeated if).

Thanks,
Jonathan
