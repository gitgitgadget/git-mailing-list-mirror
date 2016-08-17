Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571BD2018E
	for <e@80x24.org>; Wed, 17 Aug 2016 21:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcHQVFj (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:05:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbcHQVFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:05:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9304436CE6;
	Wed, 17 Aug 2016 17:05:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=53gka/EfleUL8TRTjOOfEBqxSeo=; b=rDJXmh
	2CnIl5RTj/JuSV76HdfvlvqVr21J0PzHB3dkttWcZcvTdqp9v/erUMyCTWazymbz
	7LN/Vqh3tBWtiH5uVdLwJ2JFxQ+etmA5EP4bYnCezt2NtQMqcOGUPwmRlTzll61u
	/N9EIE0/2dXIDuqEe2LJ6JHX1rjeXK7eufIak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CsTs+v/OJdm3G306bMjXTDikcpScjMU+
	K2niE/YpUtROKsbE19KvjGLkfs9BqPiPC7K875RMzXecq0qOYMCEIp7AbkXpuPbI
	/Koete30b7wA3oniv5M+yBAT12pKIWPucwmXGcIxlwvsBZ9CrZow96R9c5F6omVE
	yZC1mpRlTaE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A42836CE5;
	Wed, 17 Aug 2016 17:05:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1347B36CE3;
	Wed, 17 Aug 2016 17:05:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, iveqy@iveqy.com
Subject: Re: [PATCH] push: change submodule default to check
References: <20160817204848.8983-1-sbeller@google.com>
Date:	Wed, 17 Aug 2016 14:05:35 -0700
In-Reply-To: <20160817204848.8983-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 17 Aug 2016 13:48:48 -0700")
Message-ID: <xmqqmvkb85sw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5864C3F6-64BE-11E6-BE6A-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> If working with submodules, there are more reports of missing submodules
> rather than the desire to push the superproject without the submodules
> to be pushed out.

I do not know how you are counting the "more reports" part of that
assertion, but it is very likely that it is biased by the current
default.  If you flip the default, you would see more reports that
say "I know I wasn't ready to push the submodule part out; don't bug
me".

IOW, those who want to have something different always sound louder,
because people who are satisified tend to stay silent.

> Flipping the default to check for submodules is safer
> than the current default of ignoring submodules while pushing.

That part of the assertion, on the other hand, is justifiable.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  
>  Probably too late for the 2.10 release as I'd propose to keep it in master for
>  quite a while before actually doing a release with this.

I think you meant 'next' not 'master'.  We have a few "let's keep it
in 'next' to see if people scream" topics there already--the more
the merrier? ;-)
