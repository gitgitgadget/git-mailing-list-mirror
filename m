Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26741290E
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63261D52
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 21:59:28 -0700 (PDT)
Received: (qmail 27608 invoked by uid 109); 4 Nov 2023 04:59:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Nov 2023 04:59:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30324 invoked by uid 111); 4 Nov 2023 04:59:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Nov 2023 00:59:31 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 4 Nov 2023 00:59:26 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [PATCH] t: avoid perl's pack/unpack "Q" specifier
Message-ID: <20231104045926.GA1492014@coredump.intra.peff.net>
References: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com>
 <007101da0e65$13e3c170$3bab4450$@nexbridge.com>
 <20231103155220.GA1470570@coredump.intra.peff.net>
 <007c01da0e6f$014e2c30$03ea8490$@nexbridge.com>
 <20231103162019.GB1470570@coredump.intra.peff.net>
 <xmqq5y2ii91p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y2ii91p.fsf@gitster.g>

On Sat, Nov 04, 2023 at 10:47:30AM +0900, Junio C Hamano wrote:

> > +sub unpack_quad {
> > +	my $bytes = shift;
> > +	my ($n1, $n2) = unpack("NN", $bytes);
> > +	die "quad value exceeds 32 bits" if $n1;
> > +	return $n2;
> > +};
> 
> Is this an unnecessary ';' at the end?

Oops, yes. I'm not sure how that snuck in there. (It is not breaking
anything, but if you were to remove it while applying, I would be very
happy).

-Peff
