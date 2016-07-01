Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1129B2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcGASTV (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:19:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751863AbcGASTU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:19:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0268329C4D;
	Fri,  1 Jul 2016 14:18:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2lNW5CegsYb9z6An6pUCiwfF/q8=; b=BryyBn
	WnZoDzhFatPR6t6DUjEXMp2GFNomlE/+EpPPvQrURrXvWH0+ND7kC+dh7y1ojCA8
	TowAiftOGrZSCIDF/15e+ya0qTf+j2FVKjRXrerF/+3v8t9KSHzh6GKgV9JWGoQa
	xxjO8KwWmy8G8l2zmIsML/StZqum0c7JiuScc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SucLpti0cSQ91BhOyDRKP8FzJfsKIfxq
	vpPZR/E1npIQoh3FKNWztTi1hfvzxXUXCptss7v8GiNkW/0eZCvPk4zeuKh10VrJ
	LSPkKcj7ScceO4ZYNK2AK6FF4rh/7kJiPYbYHxlYIga7FEPpxKjxSKgMbQThmBgg
	pzxrFRe3FeQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBAE629C4C;
	Fri,  1 Jul 2016 14:18:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7856629C48;
	Fri,  1 Jul 2016 14:18:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
Date:	Fri, 01 Jul 2016 11:18:18 -0700
In-Reply-To: <CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 30 Jun 2016 17:45:52 +0200")
Message-ID: <xmqq4m89z0gl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30B45824-3FB8-11E6-A45C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Makes sense. But then if opt->ignore_case is false and regflags
> happens to have REG_ICASE set, should we clear it as well?

I think .ignore_case is set iff '-i' is given, and .regflags has
REG_ICASE only if '-i' is given and the user said she does not want
literal string match (i.e. no '-F').

So... can .regflags have REG_ICASE when .ignore_case is false?
