Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B561F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfBFWnj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:43:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 17:43:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so438945wmh.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5Rsm2A1LmCCc2J4FBDoyAYFKjxBPjvv+fnCRd3pIThg=;
        b=u09z+iHfQsXGAPcBD2iNU5deffaRTKAqgheg1MA9wkQnJ4a3T2/ZqazULXeMw5jHwK
         GqPBhB6ME5H0umKSZ3LUzT3+vfS6e5cJhnHuY0S9FGq9jOxtRvPlYcEIH+IbiDihRAT5
         Yp6UIlvVKm2kwo6sBNEs9767uoU22h+iE4cRpARdllxLUT6srIOamj047Pq96Fmuz+x1
         YLz7hS3BqHeUDs/Lb4F/D25RxKO56mJMyDWNyC7RWm615lLtHTliYRGUAp2GKg1YU9dz
         6uRQDJIlXbBDBpTNnZCSuLMQx+UqIeANDOWsyFTpnLIxaucnWiHcaQLeidN+tAyLZlpF
         THTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5Rsm2A1LmCCc2J4FBDoyAYFKjxBPjvv+fnCRd3pIThg=;
        b=dKDAxQBOKuEntU/hGgr0Pg4O6QyK6ffF/NV4ngnO4XQpSxPOqxZP05HTPH++jSS58i
         zZfxEepEzqxFdu//9+YnzuISYdMuJbCy5esx8Wtt5gOY556tr9EfgxjHX5HsSc1Kre+x
         BTWOnJ2eFZ6QNdG/OlXZbl/isusAfOWskqWe9n1GXeVqhKlSLMROXwL4MOOwOa/FZB9a
         tO68VFvl6kzInyavDILiIJpsdKFRyKlqgP5dEm48TiVvfpnH7LKmM69AVFO3o0igUkza
         lpbfwttq3SKbCL7Byz4wUqFWSgaJ82yirYURRZSjCJ9ws+mnw3tl8akaHsg0G8qRjN62
         EYYA==
X-Gm-Message-State: AHQUAubF4EkmxRYnDr6+Bjv4SnHbRAHbDFX3r0PgMHk9w3YyZLePOflN
        B8Il0pfNr/egWeJ/wsAqBlY=
X-Google-Smtp-Source: AHgI3IbxzRDomZUt2Qt0dZByrfaoFP9EW4t8whzhyOqf8PaofbclejT7NCXLZm2n5GPdlPeJLDRL7Q==
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr4716336wmc.54.1549493016857;
        Wed, 06 Feb 2019 14:43:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g67sm32812068wmd.38.2019.02.06.14.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:43:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, William Hubbs <williamh@gentoo.org>,
        chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org>
        <20190205195212.25550-3-avarab@gmail.com>
        <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
        <87k1iekkea.fsf@evledraar.gmail.com>
        <87h8dhl0zh.fsf@evledraar.gmail.com>
        <20190206182612.GA10231@sigill.intra.peff.net>
Date:   Wed, 06 Feb 2019 14:43:35 -0800
In-Reply-To: <20190206182612.GA10231@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 6 Feb 2019 13:26:12 -0500")
Message-ID: <xmqqo97opmg8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> An alternative view is that anybody who calls git_author_info() to
> create a commit _should_ be checking author_ident_sufficiently_given(),
> and it's a bug that they're not.
>
> I.e., should we be doing something like this (and probably some other
> spots, too):
>
> diff --git a/commit.c b/commit.c
> index a5333c7ac6..c99b311a48 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1419,8 +1419,11 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	}
>  
>  	/* Person/date information */
> -	if (!author)
> +	if (!author) {
>  		author = git_author_info(IDENT_STRICT);
> +		if (!author_ident_sufficiently_given())
> +			warning("your author ident was auto-detected, etc...");
> +	}
>  	strbuf_addf(&buffer, "author %s\n", author);
>  	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
>  	if (!encoding_is_utf8)
>
> I dunno. It seems pretty low priority, and nobody has even noticed after
> all these years. So I'm not sure if it's worth spending too much time on
> it.

That's quite tempting.  But I agree that this is something we can
leave for a later clean-up, as the topic to add the config variables
is pretty much orthogonal to it, and we are not making things that
much worse than the status quo.

Thanks.
