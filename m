Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 15670 invoked by uid 107); 21 Feb 2010 19:32:51 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 14:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab0BUTc2 (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 14:32:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab0BUTc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 14:32:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE8BA9C8B6;
	Sun, 21 Feb 2010 14:32:25 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oQq9+or7dC345J2UaJeN7otqSrs=; b=Fl2tmh
	oXnyPgn2attOm+bUFm8vZ7DTSo6Q50UNIsidF7i3itQD/EpWDkBaMslCOWJFQjPs
	U++pmow3Jr2PnXAVM35cJfiGEGK3QaVimfXwRy3WKVaBgzY6eVssW6t1QMwqin6a
	RQ5BwsQwqTnij8ezCdmWtKTQfZbZ1JvnxMA0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pRofPSWK+bLg0viZLTdwNwn0snT3Mb9g
	k4XLOBJOkFdiFm34KY126/Lui3SQ/BtSEelGNg8d9xflqWjI0GH5NTU+ySlh1afs
	YdofbrYatuhCsvM39e03UNiURRMDNRuBi3E5I4W71ysYwNIl/WP8ctwuaiSttzBK
	570caxl9OlU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C2589C8B2;
	Sun, 21 Feb 2010 14:32:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A0B99C8B1; Sun, 21 Feb
 2010 14:32:11 -0500 (EST)
To:	Dmitry Potapov <dpotapov@gmail.com>
Cc:	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
References: <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Sun, 21 Feb 2010 11:32:10 -0800
In-Reply-To: <20100221072142.GA5829@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Sun\, 21 Feb 2010 10\:21\:42 +0300")
Message-ID: <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: D33231F4-1F1F-11DF-9482-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dmitry Potapov <dpotapov@gmail.com> writes:

> file size = 1Kb; Hashing 100000 files
> Before:
> 0.63user 0.86system 0:01.49elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+100428minor)pagefaults 0swaps
> After:
> 0.54user 0.53system 0:01.07elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+421minor)pagefaults 0swaps
>
> As you can see, in all tests the read() version performed better than
> mmap() though the difference decreases with increase of the file size.
> While for 1Kb files, the speed up is 39% (based on the elapsed time),
> it is mere 1% for 1Mb file size.

Sounds good.  Summarizing your numbers,

       1Kb 39.25%
       2Kb 27.27%
       4Kb 17.06%
       8Kb 11.21%
      16Kb 7.00%
      32Kb 4.81%
      64Kb 3.31%
     128Kb 2.29%
     256Kb 3.51%
     512Kb 2.92%
    1024Kb 1.14%

32*1024 sounds like a better cut-off to me.  After that, doubling the size
does not get comparable gain, and numbers get unstable (notice the glitch
around 256kB).
