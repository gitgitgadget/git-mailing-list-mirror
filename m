Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3D020802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdFVVyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:54:46 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35325 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdFVVyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:54:45 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so14566886pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38KohRqGLk1QATFgX70ZrFohh1w6zfzzDyOtmmnYNbY=;
        b=vChCsf+/o5wkW21SWywd7svGqO/39q4H5Oi8MurjaEfFUKZtfUZc/khgr87L+yhiEK
         JkEjHwklbJePck+34gmXMaDcO/4jeFrjXGS8i/IJ0bkEOuFGnA8mplkpYoWWukpMo96u
         xY4GQOE7SQe1Wzjj78YceAa5lip0+ASScnM2ujJgqTxXVzkvWDG5KK7tPwnIMB4906+O
         ASoAWYXo+AHcbnLe4RC62l6/8B6d1VYg1bPAu3YN5/f28ES0A/hjClKmsRoD0u22KV2o
         aaxRIneaFCJQytLZgAY7AufCgeNI9X59A4i28TfkxAnv6bOQAT8cU2wZ4Q8np3iTfMWX
         Wi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38KohRqGLk1QATFgX70ZrFohh1w6zfzzDyOtmmnYNbY=;
        b=YkKIX5vqRoYXz9AUu6239DtWfG0mxU+IO1+zhNBUV/5MMohvqeak/N8Q+efNraQHAl
         8oC8855PRfjHI8NgKGnC3miA4WBQZySjd8p3fVa6xLv8zjp7r8k+7UXtInCbRsra6O4c
         XQ6Y6g+b6TklDstRLC7Gdl3fBfe9B7pnVFE24ctYKR43/Kx+WvlshAzhvq/3nQlqHlMX
         9oEqRSpPhndcuMxfk4y40BGhsMHZCwSh9h79j9GCJSdzDGFlppLKjun1iHrh/S7mhIP1
         m/+wL55GfE+gpUmNn+2/Y+2ZIm9ZI9Isot6yxK6Fsh3mxbQBPRKCgmGuzPNaEQV6xRSW
         3GnQ==
X-Gm-Message-State: AKS2vOzmnhIPsRzByhwkl107TwlNefx/DzXutxkiMjlC1pbZESUmGh1B
        mICPgNqHyAoDUeo4
X-Received: by 10.99.140.7 with SMTP id m7mr3661285pgd.49.1498168484792;
        Thu, 22 Jun 2017 14:54:44 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:3100:42b2:b45a:528c])
        by smtp.gmail.com with ESMTPSA id k73sm6423377pge.13.2017.06.22.14.54.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 14:54:44 -0700 (PDT)
Date:   Thu, 22 Jun 2017 14:54:40 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] pack-objects: WIP add max-blob-size filtering
Message-ID: <20170622145440.7609fa8b@twelve2.svl.corp.google.com>
In-Reply-To: <20170622203615.34135-3-git@jeffhostetler.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
        <20170622203615.34135-3-git@jeffhostetler.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Jun 2017 20:36:14 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> +static signed long max_blob_size = -1;

FYI Junio suggested "blob-max-bytes" when he looked at my patch [1].

[1] https://public-inbox.org/git/xmqqmv9ryoym.fsf@gitster.mtv.corp.google.com/

[snip]

> +/*
> + * Filter blobs by pathname or size.
> + * Return 1 to mark the blob SEEN so that it will not be reported again.
> + * Return 0 to allow it to be presented again.
> + */
> +static int filter_blob(
> +	struct object *obj,
> +	const char *pathname,
> +	const char *entryname,
> +	void *data)
> +{
> +	assert(obj->type == OBJ_BLOB);
> +	assert((obj->flags & SEEN) == 0);
> +	assert((obj->flags & OBJECT_ADDED) == 0);
> +	assert(max_blob_size >= 0);
> +
> +	/*
> +	 * Always include blobs for special files of the form ".git*".
> +	 */
> +	if ((strncmp(entryname, ".git", 4) == 0) && entryname[4]) {
> +		if (obj->flags & BLOB_OMITTED) {
> +			/*
> +			 * TODO
> +			 * TODO Remove this blob from the omitted blob list.
> +			 * TODO
> +			 */
> +			obj->flags &= ~BLOB_OMITTED;
> +		}
> +		show_object(obj, pathname, data);
> +		return 1;
> +	}
> +
> +	/*
> +	 * We already know the blob is too big because it was previously
> +	 * omitted.  We still don't want it yet.  DO NOT mark it SEEN
> +	 * in case it is associated with a ".git*" path in another tree
> +	 * or commit.
> +	 */
> +	if (obj->flags & BLOB_OMITTED)
> +		return 0;
> +
> +	/*
> +	 * We only want blobs that are LESS THAN the maximum.
> +	 * This allows zero to mean NO BLOBS.

That is not what maximum means...

This is the reason why I originally called it "limit", but after some
reflection, I decided that it is no big deal to always send zero-sized
blobs. The client must be able to handle the presence of blobs anyway
(because it will receive the ".git" ones), and excluding all blobs
regardless of size does not remove the necessity of obtaining their
sizes, since we need those sizes to put in the omitted blob list.

> +	 */
> +	if (max_blob_size > 0) {
> +		unsigned long s;
> +		enum object_type t = sha1_object_info(obj->oid.hash, &s);
> +		assert(t == OBJ_BLOB);
> +		if (s < max_blob_size) {
> +			show_object(obj, pathname, data);
> +			return 1;
> +		}
> +	}
> +
> +	/*
> +	 * TODO
> +	 * TODO (Provisionally) add this blob to the omitted blob list.
> +	 * TODO

As for the omitted blob list itself, you can see from my patch [2] that I
used a hashmap, but the decorate.h functionality might work too (I
haven't looked into that in detail though).

[2] https://public-inbox.org/git/6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com/
