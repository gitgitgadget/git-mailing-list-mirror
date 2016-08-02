Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32691F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbcHBSrk (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:47:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753049AbcHBSri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:47:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7523E33721;
	Tue,  2 Aug 2016 14:46:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JCU/4J/8ZCtYU1jVejxq5JzlF/c=; b=NcmO2w
	XDHZ+EJSPR7OlsByZ47nyRbtd4yC4BC3Sr0oxSLTLA7mu27+3qxyTFR2DhttnNA7
	IgiBFENwTcI2fEEDTFI7P5cxkTJ81TRiGSWIl8lBQDhoYTbSNM6E7WXDqi/kOwy/
	MdcaN669P4t60lTz7qxuHfKt3Pl1V+snz/xk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bH0umR9FUpLixsxGMw2Uv3HNLPYZ2Fz2
	J1Th3J9ZDpBMgeENbaoqzcL+22+fiPwy+tZyOdqnKOoom8A2zNZm2U29xPAhn4or
	/CxpBhAefjQ7+Q5LFP37rAfNhoKmlSoEati5e5tDxtS/V5yVH34/rbNIgz7xOEui
	5KxBu7wE1U4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E4B433720;
	Tue,  2 Aug 2016 14:46:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E41DF3371F;
	Tue,  2 Aug 2016 14:46:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 08/13] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423ce7-b633a4e8-1a15-4770-ba6c-4331b2c1d941-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 11:46:07 -0700
In-Reply-To: <0102015640423ce7-b633a4e8-1a15-4770-ba6c-4331b2c1d941-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqqeg67dn68.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60FCF210-58E1-11E6-B49A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +	for (i = 0; i < rev_nr; i++) {
> +		if (!is_expected_rev(revs[i])) {
> +			remove_path(git_path_bisect_ancestors_ok());
> +			remove_path(git_path_bisect_expected_rev());
> +			return 0;

Same comment on the use of this helper function applies here, too.
