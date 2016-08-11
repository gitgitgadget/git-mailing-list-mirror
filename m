Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF59B20193
	for <e@80x24.org>; Thu, 11 Aug 2016 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbcHKTkS (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 15:40:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752057AbcHKTkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2016 15:40:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E16DE33670;
	Thu, 11 Aug 2016 15:34:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SpTnvV5SBII9
	Gpzl49UpW2QFSAc=; b=MQ+ZcX+KM7ncfQGkMqfKqgnXCJLYOSIxHT3nhWG2sDH5
	4gT/EiS4KWMrTGh4TbgDWKQF8a/NFvX/m7tyR5JdRoAkK6hWKL3mzEBF+i1qKMS3
	5QKGVkaSPtx3KF4T4FJqKs3RWAqEsmpzIm3iJOCpP8KaFNp+nA3+O+k5ARwMvek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q8Qd77
	kH0Omim+sP1DeDE3kXcYWVqFnDZ3JYcuXQEAktNclfGsGGIe6Ip5JG5zUdTDfs3u
	E8Oax3/YCfliYnZvVLqNXtiQfPN+JTmMYaeMpGHnM+lT4NiBhoCGBt6AjFtp2gZS
	5KQpay7PcbgsDJ0mXf8qPUUzM6x91l/7rbid8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7CC53366F;
	Thu, 11 Aug 2016 15:34:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 533D43366E;
	Thu, 11 Aug 2016 15:34:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: t0027 racy?
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
	<20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
	<20160808203224.GA28431@tb-raspi> <20160809065110.GB17777@peff.net>
	<20160809113337.GA1143@tb-raspi>
	<20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
	<20160809125958.GA1501@tb-raspi>
	<20160809132744.kjzmkgt2qiugeolj@sigill.intra.peff.net>
	<20160809212802.GA4132@tb-raspi>
	<alpine.DEB.2.20.1608101423160.4924@virtualbox>
	<20160811185812.GA18434@tb-raspi>
Date:	Thu, 11 Aug 2016 12:34:44 -0700
In-Reply-To: <20160811185812.GA18434@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Thu, 11 Aug 2016 18:58:12 +0000")
Message-ID: <xmqqa8gj14mj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9052D8C-5FFA-11E6-A1F5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Good ideas, I will work on a series that fixes bugs first, and then we
> can see if there is room for optimization.
>
> What do you think about this as a starting point, more things will
> follow.
> I like to here comments about the commit msg first ;-)

Throughout t0027 there is no mention on what NNO stands for.  Are
they about operations that result in un-normalized index entries?

> commit 3754404d3d1ea4a0cbbed4986cc4ac1b5fe6b66e
> Author: Torsten Bögershausen <tboegi@web.de>
> Date:   Thu Aug 11 18:47:29 2016 +0200
>
>     t0027: Correct raciness in NNO test
>     
>     When a non-reversible CRLF conversion is done in "git add",
>     a warning is printed on stderr.
>     
>     The commit_chk_wrnNNO() function  in t0027 was written to test this,
>     but did the wrong thing: Instead of looking at the warning
>     from "git add", it looked at the warning from "git commit".
>     
>     Correct this and replace the commit for each and every file with a commit
>     of all files in one go.
>     
>     The function commit_chk_wrnNNO() will to be renamed in a separate commit.
>     Thanks to Jeff King <peff@peff.net> for analizing t0027.
>     Reporyed-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Reporyed?  

An obligatory "comments-about-the-commit-msg";-)
