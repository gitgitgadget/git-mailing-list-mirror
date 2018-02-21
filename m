Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E011F404
	for <e@80x24.org>; Wed, 21 Feb 2018 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934748AbeBURdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 12:33:37 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46312 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbeBURdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 12:33:36 -0500
Received: by mail-wr0-f194.google.com with SMTP id 34so6727461wre.13
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=je0/nJmrba/uqgKobV+AKht2quBBx0DE0/T2++agfLM=;
        b=ObsnyEMVLXJlwsHC15q6svuAUN9d1A4e+qwc7cBNhsXcuky5JjSdQuoHYL+k3ljRBL
         RPVO9qIWwFPH6rftIwLx+jFpNaBjwkCil7CfrN6dHCd4CvDac1LZkq1dl60TFBG2IkSB
         ZxwEgrPLuM4HaTQYr5u/qYy2Pi/IrK1jDrtsrlN8L3U5XQIZUsG3GZjB3YvCcEAMex0l
         cDDtFW7mkyleNeOBMBEPkOYfuFd0rnzf5ay/CY0lvDv80VXD2azOdidTcJ0VvpdfCXuC
         HEia4yteXjKlfGqaYyJ5A/PhUjBlmrNAIOCzm1A4IVtWjDKbvfCh3Ayox1yTDYuO5TrQ
         udZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=je0/nJmrba/uqgKobV+AKht2quBBx0DE0/T2++agfLM=;
        b=FAIpmvMwXdSDYekMfDUO1C71UZIXMpqCb4omF3W8WYMO7LmWL4Ms60VPfgPuaQPpbY
         6eYGS09Jc9rPKZmgLy8gtNUeCBylDmHBSpDdZ2fCH2o7p64ZKMOw2uxpQys0QGP7WtvE
         Pi3Sw9/yMl1Pp7ExjRO+0NgDFSrf1KGhH1xRpI3DA1KrfiuMUEvsxb70JT3bqBS+A7Id
         5XlbIzP90FuY2PD4GOvdLCYclKgFpyUvJjUEY1GIpD6pLJDLaqJBXogGaHP7/Ds7+1sm
         CTftR97OkhICgpkz/xOPBuZVLQ9L9uKwUjGbjw1tuPsNoyh42qN6s8W8WIbVzl9N38/u
         fKfg==
X-Gm-Message-State: APf1xPDJ4bBWA/gboxtcm3wEhEEAU6+ArjOjwNe06oKYaCNqlMDnKabQ
        uOekI7g6rCAsGkj5EI/cFMs=
X-Google-Smtp-Source: AH8x224zALsd4zzoI57aTzgmNXoEN9fWWfSrnFWf+yV5MUUiOL6u5T2ka8tS552ZABq8foEDHI31DA==
X-Received: by 10.28.63.81 with SMTP id m78mr2963839wma.102.1519234414981;
        Wed, 21 Feb 2018 09:33:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p14sm27732211wrg.42.2018.02.21.09.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 09:33:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ref-filter: get rid of duplicate code
References: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
Date:   Wed, 21 Feb 2018 09:33:33 -0800
In-Reply-To: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Wed, 21 Feb 2018 06:59:00 +0000")
Message-ID: <xmqqtvuaz1qq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Make one function from 2 duplicate pieces and invoke it twice.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)

Nice code reduction, removing 2 instances of 11-line section and
replacing with a 17-line function ;-)

This looks related to your earlier changes for "cat-file --batch"
but I do not recall seeing this refactoring.  It seems to be done
correctly.

Good spotting.

> diff --git a/ref-filter.c b/ref-filter.c
> index f9e25aea7a97e..83ffd84affe52 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1354,15 +1354,31 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>  	return show_ref(&atom->u.refname, ref->refname);
>  }
>  
> +static void get_object(struct ref_array_item *ref, const struct object_id *oid,
> +		       int deref, struct object **obj)
> +{
> +	int eaten;
> +	unsigned long size;
> +	void *buf = get_obj(oid, obj, &size, &eaten);
> +	if (!buf)
> +		die(_("missing object %s for %s"),
> +		    oid_to_hex(oid), ref->refname);
> +	if (!*obj)
> +		die(_("parse_object_buffer failed on %s for %s"),
> +		    oid_to_hex(oid), ref->refname);
> +
> +	grab_values(ref->value, deref, *obj, buf, size);
> +	if (!eaten)
> +		free(buf);
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
>  static void populate_value(struct ref_array_item *ref)
>  {
> -	void *buf;
>  	struct object *obj;
> -	int eaten, i;
> -	unsigned long size;
> +	int i;
>  	const struct object_id *tagged;
>  
>  	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
> @@ -1483,17 +1499,7 @@ static void populate_value(struct ref_array_item *ref)
>  	return;
>  
>   need_obj:
> -	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
> -	if (!buf)
> -		die(_("missing object %s for %s"),
> -		    oid_to_hex(&ref->objectname), ref->refname);
> -	if (!obj)
> -		die(_("parse_object_buffer failed on %s for %s"),
> -		    oid_to_hex(&ref->objectname), ref->refname);
> -
> -	grab_values(ref->value, 0, obj, buf, size);
> -	if (!eaten)
> -		free(buf);
> +	get_object(ref, &ref->objectname, 0, &obj);
>  
>  	/*
>  	 * If there is no atom that wants to know about tagged
> @@ -1514,16 +1520,7 @@ static void populate_value(struct ref_array_item *ref)
>  	 * is not consistent with what deref_tag() does
>  	 * which peels the onion to the core.
>  	 */
> -	buf = get_obj(tagged, &obj, &size, &eaten);
> -	if (!buf)
> -		die(_("missing object %s for %s"),
> -		    oid_to_hex(tagged), ref->refname);
> -	if (!obj)
> -		die(_("parse_object_buffer failed on %s for %s"),
> -		    oid_to_hex(tagged), ref->refname);
> -	grab_values(ref->value, 1, obj, buf, size);
> -	if (!eaten)
> -		free(buf);
> +	get_object(ref, tagged, 1, &obj);
>  }
>  
>  /*
>
> --
> https://github.com/git/git/pull/460
