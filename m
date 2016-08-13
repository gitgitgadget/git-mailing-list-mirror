Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC95B2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 15:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbcHMPu4 convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Sat, 13 Aug 2016 11:50:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752648AbcHMPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 11:50:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D322C35291;
	Sat, 13 Aug 2016 11:50:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zn1Vm22/1puk
	9dL7VELiYkXu/08=; b=qimLPiX+05LNHRJ9ovHpxoWqn3zGIZZjGwmK312Hn9cp
	v9tWPhlyrJS5TT0ypA5EoLiD3ECfIElje3Q+TGdfFz7aE6tP9RqB++xEdFJu/ZW4
	iUP/5DS44mgvQsGoLklLGv4ku6ZrEpVxpmfhBgSMr3gkFYJm36Fo5cvnJX0USn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dAs6LJ
	vx33PvsdRXDzwAvqDoGtPTHzywQf4pqK64+iuUOBq3Fhde7CCJF4dldVcOTye4yG
	yQHXyahNCYL6Z0MFKbSEdfnq2FJb/Kmb/FfuSHAcE8mkkQ7FOKCi6FShxqA22OQT
	z/vmE5T3AGsK/NBEBUURvZvfE9sbrMz6ZmDnc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8C0F35290;
	Sat, 13 Aug 2016 11:50:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 044783528E;
	Sat, 13 Aug 2016 11:50:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.9.3
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
Date:	Sat, 13 Aug 2016 08:50:50 -0700
In-Reply-To: <alpine.DEB.2.20.1608131214070.4924@virtualbox> (Johannes
	Schindelin's message of "Sat, 13 Aug 2016 12:14:15 +0200 (CEST)")
Message-ID: <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B6F60DD4-616D-11E6-A75E-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> New Features
>
>   • Comes with Git 2.9.3.

For future reference, what time (in UTC) of the day is convenient
for you to see an upstream tarball?

>   • Sports a new --smudge option for git cat-file that lets it pass
>     blob contents through smudge filters configured for the specified
>     path.

Perhaps we want to upstream this, together with a new "--clean"
option for git hash-object?

And after writing all of the above, I noticed that hash-object by
default uses the clean machinery and that can be turned off by
giving the "--no-filters" option.  The reason why the option is not
called "--no-clean" is because it is not just about the clean filter
but is about using the entirety of convert_to_git() filter chain.

We probably should teach "hash-objects" to take "--filters" for
consistency.

And then your "git cat-file" patch can be upstreamed with the option
renamed to (or with an additional synonym) "--filters", which would
make things consistent.

Thanks.

