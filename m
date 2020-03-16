Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF408C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 06:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BBB20575
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 06:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QGnzpkVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgCPGRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:17:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54026 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgCPGRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 02:17:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B833B3AB2;
        Mon, 16 Mar 2020 02:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1xwgyZ4tTHqGnzA19QqQDTmwsKg=; b=QGnzpk
        VDqgD3cUwsmVIf/q93Y0pSmt5QMwrRmfeJp4uvXX4o3YwuF8TgR6hKn5kJLfl110
        xk6jRp/uJqaZ/9aq6R4pA6roEUGN6Gye8fdfJci50KqQkIor0EDQnuB0P/PNYlGV
        hpbvggpn5WxXMMEZJG4+kSd7nVk63fEOqdD5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RKjBHXV9D5rJ9qUf5M/+SjshIFXrToJv
        0bjWLftY2mDG/G6/9dIl+rqJu3cMrrlnIi2d4fpezr8fE7Lipr/+VRC1fPydWsig
        +Mkr9t6SuBv97AMFmGKn8Y2TC6t9eHPqoEDt58X8Mt+5SOwEfX5ylDoJD4jYkQO2
        e/iBjmwTnTI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32B61B3AB1;
        Mon, 16 Mar 2020 02:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DF61B3AAC;
        Mon, 16 Mar 2020 02:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
References: <cover.1584329834.git.matheus.bernardino@usp.br>
        <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
Date:   Sun, 15 Mar 2020 23:17:02 -0700
In-Reply-To: <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Mon, 16 Mar 2020 00:47:27 -0300")
Message-ID: <xmqq1rpsako1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1888D0A-674D-11EA-881F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Note: I choosed to use "st_*", as naming, for simplicity, and to keep
> the code lines small. But should we use a more verbose "oidst_*" format,
> instead, to avoid confusions with "struct stat"?
> ...
> @@ -334,8 +334,8 @@ struct dir_struct {
>  
>  	/* Enable untracked file cache if set */
>  	struct untracked_cache *untracked;
> -	struct oid_stat ss_info_exclude;
> -	struct oid_stat ss_excludes_file;
> +	struct oid_stat st_info_exclude;
> +	struct oid_stat st_excludes_file;
>  	unsigned unmanaged_exclude_files;
>  };

I tend to agree with you that using prefix "st_" for anything other
than "struct stat" proper would be confusing.  If "ss" used to stand
for "sha1 stat", I would expect "oid stat" to abbreviate to "os", at
least.

I also am wondering if we can do without any prefix, i.e. just call
them "info_exclude" and "excludes_file", because the field names are
private to each struct and there is no strong reason to have a
common prefix among fields in a single struct.  Rather, it is more
important for the fields of the same type in a single struct to have
distinct names so that the reader can easily tell them apart and the
reason for their use is straight-forward to understand, and the two
names without any prefix convey their distinction pretty well, I
would think.

It is not like we adopt a convention to name our variables with
abbreviated typenames embedded in the variable names.  We shouldn't
be doing that for field names, either, but it smells that the "give
them prefix ss_ because they are of type sha1_stat" pretty much has
origin in such school.

Thanks.
