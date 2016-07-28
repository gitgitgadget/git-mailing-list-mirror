Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177141F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938AbcG1QMi (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:12:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758901AbcG1QMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:12:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D4B52EF4B;
	Thu, 28 Jul 2016 12:12:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=75FFjMq9u9NPRCCEbGEYYBpDmjk=; b=ibZadi
	zxCAdI6NSrg1KqVL/+BY6ZhLWaQlD8S0JegvD8hfQ1u2LCCKPIzVIVEmIjlQYgpf
	0BgRlezF6/0pGu5eeq1HrksO586F3Vh6mbKMOLiqCQf+zJSbuhymc/DeR0kgIf6m
	ME462Jyy+kdbAo3++F8F3UeGeAaEGS39gH78g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a5CReZS5W/kfXRGFSEw4CGZgKymlyCiR
	pL6+gMb00+26oL8/bIIFllaH1MYYd/+uTEdM3qePSfmqiaeUYqYEYXqCiBA5qvwh
	HcxD/0FVTKZjZV7m6ndONIOVVYr/qFs2/uMkN19OYBli0/oe8wn4xeeJnTHV1y2D
	CJBzdQ1rPp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3592F2EF4A;
	Thu, 28 Jul 2016 12:12:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACC2D2EF49;
	Thu, 28 Jul 2016 12:12:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] i18n: config: unfold error messages marked for translation
References: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt>
	<1469711643-10367-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Thu, 28 Jul 2016 09:12:33 -0700
In-Reply-To: <1469711643-10367-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 28 Jul 2016 13:14:03 +0000")
Message-ID: <xmqqwpk5spvy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18DAAC40-54DE-11E6-9848-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Unfold the message into several templates for each known origin_type.
> That would result in better translation at the expense of code
> verbosity.

Looks good now, except one minor nit I'll tweak out while queuing.

>  	if (cf->die_on_error)
> -		die(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
> +		die("%s", error_msg);
>  	else
> -		return error(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
> +		error_return =  error("%s", error_msg);

s/ =  / = /;

Thanks.
