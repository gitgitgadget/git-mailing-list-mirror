Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BEC1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbcHLRNs (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 13:13:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752461AbcHLRNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:13:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0EEA3446A;
	Fri, 12 Aug 2016 13:13:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z46fSxP0TZjVgablQX7cFXH6YK8=; b=PYpMaI
	RTNZloAhzlN0m377pp2yvLK7K2jYmde609gC7ie1vp7N4j8xxzqVZm62eWJ6FLLD
	JLL+q+0pfI+0wG3nrMWbf9K65hPJzGzzFp95B311D/aaxpFgy6WIUglQt/gRj3PR
	2xRbHt7ks02B6mW3aym1k/Oj4W0OzJVhhyUSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDxVBiPpdYzb2rJLgPxI7hJla1+Nfa9K
	3alP8SnhDeC9Av0LgZJsxbZuQuzhwFdVNboE2eY7fvqXHYSPMDn0FLAYSNbG4CRh
	iQ4H7OosdxrbAUjngC8jGamA91cpFPxTnwdmygmE85slGDIfvXXT4ahPPGpWgjTT
	qvxGaDeUKBM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B940F34469;
	Fri, 12 Aug 2016 13:13:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B3C734468;
	Fri, 12 Aug 2016 13:13:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jakub =?utf-8?Q?Nar=C4=99?= =?utf-8?Q?bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
	<20160810130411.12419-1-larsxschneider@gmail.com>
	<20160810130411.12419-15-larsxschneider@gmail.com>
	<CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com>
	<20160812163809.3wdkuqegxfjam2yn@sigill.intra.peff.net>
	<CAGZ79kaRKROUganF838w29rCkJ592sZvu+q9fo+h4a4sPeDXMQ@mail.gmail.com>
	<52049A60-6CEB-40E5-A013-409CFC20252F@gmail.com>
Date:	Fri, 12 Aug 2016 10:13:43 -0700
In-Reply-To: <52049A60-6CEB-40E5-A013-409CFC20252F@gmail.com> (Lars
	Schneider's message of "Fri, 12 Aug 2016 19:08:51 +0200")
Message-ID: <xmqqinv5ykoo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20DC4768-60B0-11E6-8E6D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> If we do the success first and then error out halfway, we
>> still have to clean up, so I do not see how this impacts
>> implementation?
>
> That is true. The reasoning is that an error in between is somewhat
> less expected. Therefore additional work is OK.
>
> An error upfront is much more likely because it is also a mechanism
> for the filter to reject certain files. If the filter is configured
> as "required=false" then this reject would actually be OK.

Unless the reasoning is "an error in between is so rare that we are
OK if the protocol misbehaves and the receiving end omits error
handing", I am not so sure how "therefore additional work is OK" is
a reasonable conclusion.
