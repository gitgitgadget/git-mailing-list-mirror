Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AB31F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbcHBSpA (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:45:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750961AbcHBSo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:44:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E47D324C9;
	Tue,  2 Aug 2016 14:44:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=50BkfkD3O9KIUpwzhk37hszB3gw=; b=sENprV
	wXdlTR1GTgRVTJEG93x2WKj7B+vAo+Wkx8BQz45FRzBww/PO0j8Kww5/GkxF5xhv
	KGycq8mEXZbpOSGfueIYEcBT/nxnKrrdVdE9YqSBifgVp3+qtQxvc98CGM+4KVH1
	5zMcwQcUD0DlzNqBSIpz7Bg7o6bLTOzeOvwxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TvPZx7ySF36y3ANV3fFekGl8gaV6bXZH
	QK14kgLDCGbTd0WT7fb41FkXy5IQtrCMhBVr/WNPe0QdTk2sNrm769maOwxCwx0w
	UsC1e6Znl90cM8ALf/TwD27MvhsaLlyXXHKiPij1y/n7SjnH0asa9CDeJusiteXo
	vohCbCPBWjg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9728A324C7;
	Tue,  2 Aug 2016 14:44:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BC37324C6;
	Tue,  2 Aug 2016 14:44:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 07/13] bisect--helper: `bisect_reset` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cf1-89276881-65c0-4fc7-9e3e-ba74a6bd3057-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 11:44:54 -0700
In-Reply-To: <0102015640423cf1-89276881-65c0-4fc7-9e3e-ba74a6bd3057-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqqinvjdn89.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34FCDBBC-58E1-11E6-842C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +	if (!file_exists(git_path_bisect_head())) {
> +		struct argv_array argv = ARGV_ARRAY_INIT;
> +		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
> +		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +			error(_("Could not check out original HEAD '%s'. Try "
> +				"'git bisect reset <commit>'."), branch.buf);

Somebody seems to have a keen eye.  Looks much better with a space
after "Try" ;-)
