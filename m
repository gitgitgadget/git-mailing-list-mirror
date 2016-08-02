Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937222021F
	for <e@80x24.org>; Tue,  2 Aug 2016 21:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbcHBVvP (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 17:51:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754251AbcHBVvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 17:51:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7A7431D9D;
	Tue,  2 Aug 2016 17:45:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h3nRoc2xQ1meRVdOC4MTdeVmjSM=; b=bIIzv6
	sZzSmOjNHqZkTKNOZdrYC2mDP5ip6s8gqbPJUHoDbKQT08yvwhMZ7yD4LicjMwOT
	z1SloWqGR4Orh2mFAvVh6sd/fXjH4E8NnDSvpsbat5JNvHjTFK+vqN2ZSLOjW6iZ
	OaWVVE1KsAwOk1J8MKNf5dD8Eue6VdUenwj7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYnnaQwt7WcBruLbwZz6J7H1BhUkJJ88
	FdyhlQArkTu5EILMr184BihVyhlFL0/69IMOh0EVYngCLknzDObqy4hxz+J3hG9v
	Oi9louRCD3WddcjUMbJrpXg6l3fcaCusaPvIoQhL1jxNsIJITnhKAQ8AAxfW5g4x
	M8j0eGDWj08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EDD531D9C;
	Tue,  2 Aug 2016 17:45:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D50B31D9A;
	Tue,  2 Aug 2016 17:45:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
	jrnieder@gmail.com
Subject: Re: [PATCH 1/2] submodule documentation: add options to the subcommand
References: <20160802182152.20637-1-sbeller@google.com>
Date:	Tue, 02 Aug 2016 14:45:27 -0700
In-Reply-To: <20160802182152.20637-1-sbeller@google.com> (Stefan Beller's
	message of "Tue, 2 Aug 2016 11:21:51 -0700")
Message-ID: <xmqqtwf2c0aw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E001C1C-58FA-11E6-8599-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When reading up on a subcommand of `gi submodule`, it is convenient

s/gi /git /;

> to have its options nearby and not just at the top of the man page.
> Add the options to each subcommand.
>
> While at it, also document the `--checkout` option for `update`.

I do find the resulting per-subcommand description easier to read
with this change.

Perhaps we want to go one step further and change the SYNOPSIS so
that per-subcommand options are not described there at all?
I.e.e.g.

-    'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]...
+    'git submodule' [--quiet] update [<option>...]


> @@ -231,7 +231,7 @@ As an example, +git submodule foreach \'echo $path {backtick}git
>  rev-parse HEAD{backtick}'+ will show the path and currently checked out
>  commit for each submodule.
>  
> -sync::
> +sync [--recursive] [--] [<path>...]::
>  	Synchronizes submodules' remote URL configuration setting
>  	to the value specified in .gitmodules. It will only affect those
>  	submodules which already have a URL entry in .git/config (that is the
