Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBA71F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcHAVlo (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:41:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751090AbcHAVlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:41:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 406C932AFD;
	Mon,  1 Aug 2016 17:35:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hQmIDXeNkWwFrFlVVUJAzuz59bs=; b=e2xqjf
	bDjqom6qMEyu1cRXfJcIDzflkkXN/l3xSfOT7Jxo/94YzkK3JG3QU+iv6cWcnvGs
	k0WRYOSN+D+IEI3dq0rLA/ZIHGVZnD3LkV5xzRlJfFf7g9HoG4QbbYET/T8Ajo5U
	oow48Kvh+yb/qGRCE2pMUpDbHsukIN8IAson0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bRkNL5sDgfUwcVmER9/KisNauE0KkvGC
	Rv+Z9p96HWEVDQsYia5BZGeA7HEeoBFC99QneGLy+rIM7pk6eDHR5X+dOp/KlenI
	lmx71IzZtPUdihX7ch2hwN1Zsx1shMYbZKu7A9anLe3zqd3Xn4EQIFpajwdHUeIK
	CJHAaV0RT54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CEA532AFC;
	Mon,  1 Aug 2016 17:35:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EB5032AFB;
	Mon,  1 Aug 2016 17:35:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Giuffrida <michaelpg@chromium.org>
Cc:	git@vger.kernel.org
Subject: Re: git grep -P is multiline for negative lookahead/behind
References: <CACi5S_0QGEgnijGyaBeZxOSobdwfA+d-wa-jrHs64Va097mnRQ@mail.gmail.com>
Date:	Mon, 01 Aug 2016 14:35:33 -0700
In-Reply-To: <CACi5S_0QGEgnijGyaBeZxOSobdwfA+d-wa-jrHs64Va097mnRQ@mail.gmail.com>
	(Michael Giuffrida's message of "Mon, 1 Aug 2016 02:09:07 -0700")
Message-ID: <xmqqr3a8goka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1D0237E-582F-11E6-92F8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Giuffrida <michaelpg@chromium.org> writes:

> Is this expected behavior, and if so, why/where is this documented?

I do not think "git grep" was designed to do multi-line anything,
with or without lookahead.  If you imagine that the implementation
attempts its matches line-by-line, does that explain the observed
symptom?
