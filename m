Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DA81F404
	for <e@80x24.org>; Fri,  9 Mar 2018 22:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbeCIWy7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 17:54:59 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38946 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeCIWy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 17:54:58 -0500
Received: by mail-wm0-f68.google.com with SMTP id i3so6485062wmi.4
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cA8xHgDVxhZEeHJAAnppeF9U17cuWU36euzzjcpsMWA=;
        b=LIRN+JCja5x5hG/XvgqTwc/CgcY6BCDFxw6e0/bYiLhjnvXiufM08K0Cha41TRiAZr
         xO8kyuHURHTadWhYRdw1weSUqxXU9MhtD61GWdJEKVvqUPGAMhPcE8vymaT+bYByr8hj
         01vibhoL+JPuy1oY1HBwe95J54qUhaGgqSu9Aef73e8GtYADX4cl05r3bGDFmQOqRdP/
         8sr3kUW97rhLD01qYRNfipe82XPZS1fXh7ZtSwfHBx4aN0Bn6nnUXd/9KMLWTvYZkNdt
         AFlmNyK2YfkTMt7tSN4zJA68yHl4oNtdkE6/wtnlDllHYqPemOmagJdNvq9t3XR5A7+9
         AvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cA8xHgDVxhZEeHJAAnppeF9U17cuWU36euzzjcpsMWA=;
        b=jnawBv5b58GQIHBMTLP38rr9pmixHLtxfpvhOtUnzS2yNZLGrob63hgq7EuLdqkeeI
         sfNzzBiWacS4MBl+TQbKDWgljNeX1X7x1JJzt1i8MtYTnvCg4ESHo9WqAAy/0KpbpCn8
         LrGEjD/QTZuDNE+a+5N31UBXkEDJYQsUKK+89EIL1ZbTJNAfRnfeiUiWQJishEsbWUZ4
         t5BRREboUvyTVHzaeYBnxRkDNa0s3OFl/wQG/EqlWMG1/rayJN9d63a2MU0XtCQgo226
         aWTK9anlW9uM1ZfzJjvRJGEET6m5Egrr+WIyq5l0H9onSX14nUgu8HTq2LVcJws9e9oy
         B6Gw==
X-Gm-Message-State: AElRT7EXmwY6H58Z2NBnf+djg205VwjarR30p9Fj41NFZBfO5I3Wkfpp
        015JQ2S+8uFPYDd+F8blw7w=
X-Google-Smtp-Source: AG47ELvQ+/hIzDZB0jvlCCGX6umflQlmSnItDqZAQbTtG9y7V/cEIeiKxhUf//K/FV4P/X0xUySffw==
X-Received: by 10.28.139.142 with SMTP id n136mr312153wmd.101.1520636096940;
        Fri, 09 Mar 2018 14:54:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i127sm2380369wmf.33.2018.03.09.14.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 14:54:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH/RFC v3 02/12] pack-objects: turn type and in_pack_type to bitfields
References: <20180303024706.31465-1-pclouds@gmail.com>
        <20180308114232.10508-1-pclouds@gmail.com>
        <20180308114232.10508-3-pclouds@gmail.com>
Date:   Fri, 09 Mar 2018 14:54:53 -0800
In-Reply-To: <20180308114232.10508-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Mar 2018 18:42:22 +0700")
Message-ID: <xmqqk1uk5076.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
>  	entry->depth = 0;
>  
>  	oi.sizep = &entry->size;
> -	oi.typep = &entry->type;
> +	oi.typep = &type;
>  	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
>  		/*
>  		 * We failed to get the info from this pack for some reason;
> @@ -1580,6 +1586,10 @@ static void drop_reused_delta(struct object_entry *entry)
>  		 */
>  		entry->type = sha1_object_info(entry->idx.oid.hash,
>  					       &entry->size);

The comment immediately before this pre-context reads as such:

		/*
		 * We failed to get the info from this pack for some reason;
		 * fall back to sha1_object_info, which may find another copy.
		 * And if that fails, the error will be recorded in entry->type
		 * and dealt with in prepare_pack().
		 */

The rest of the code relies on the ability of entry->type to record
the error by storing an invalid (negative) type; otherwise, it cannot
detect an error where (1) the entry in _this_ pack was corrupt, and
(2) we wished to find another copy of the object elsewhere (which
would overwrite the negative entry->type we assign here), but we
didn't find any.

How should we propagate the error we found here down the control
flow in this new code?

> +	} else {
> +		if (type < 0)
> +			die("BUG: invalid type %d", type);
> +		entry->type = type;

The BUG() on this side is sensible, as packed_object_info()
shouldn't report success when it stored negative result in *oi.typep
anyway.

>  	unsigned char in_pack_header_size;
> +	unsigned type:TYPE_BITS;
> +	unsigned in_pack_type:TYPE_BITS; /* could be delta */

