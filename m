Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA7C203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcGXIFg (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 04:05:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:60697 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbcGXIFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 04:05:31 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M1msU-1bCSPd2l4c-00th20; Sun, 24 Jul 2016 10:05:19
 +0200
Date:	Sun, 24 Jul 2016 10:05:16 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Andreas Schwab <schwab@linux-m68k.org>
cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] mailinfo: extract is_from_line from mailsplit
In-Reply-To: <m2poq3zdu3.fsf@linux-m68k.org>
Message-ID: <alpine.DEB.2.20.1607241003480.14111@virtualbox>
References: <20160722224739.GA22961@whir> <alpine.DEB.2.20.1607231056150.14111@virtualbox> <20160724031409.GA32480@starla> <20160724031518.GB32480@starla> <m2poq3zdu3.fsf@linux-m68k.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+5cCXSfG8SusQYTIrMORC4SLs/nxuK5dQneoGmBuBKh9i83iQ7r
 OrMw46myjSRW9EHMF2esnkdlKZg2JfOy++wWsKUwltV9U1k/WRB4umThcomOMWdzHVKGoVZ
 VZzbFwA7zGctrebr8vP0inUnglsPM89+nNbAP5GeM839GDwaB15K8QRUIyYE8xdOkOkTH4d
 I5BtmOGusjfXtwLwB+Bcw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2l6LdiaJ3RQ=:k331s/SrFx1LDseJ60gque
 II5ma5XsJWEjwEr8+1xJYiHOzJKrjayiU/5iIK+hYPV43yRKgrs7tx2+M953r9x0vKnuqzqp1
 96B8+/E+xIzpmeypyBcoZfx2EovvFTYGiI/WUy++5Z3r5riBVMDDMi+q4Mvwha1L104kIAhVF
 1fDwXjZRJkTLdd93c36l0IGCIWHmlHI6DYrwwkcsvnEO+xmqX4wsyFyaDrBYGDTkUvOVGxnp/
 M9trUhSZ+9mKA2t+380AUnl5/RNr5j1GUFq9fvZbIaVO4XPMo0J59wgfJM9HIli5V4vDt7GDd
 RtUat2PzQ8ODfHK3pyUbwpxCJL5WTYnrOxTWkPVDYswS0P0P4VR2TO9UTy90VN3RQFk1w1lBY
 2N3SaPVTqmlhNnWfnUfbdpvofjx2cQvldIOXn8pEgjcrAGyb1E8/BRfcD1wv9qu9exQGTymZ0
 l2IzZqgBiaUdc+1dO4IRg4zTQ5lqrp6ntZwbQ8nJwlE565bN6HOWGDKX4Oj3Gy8uHbSS3G6Fs
 DVGTp2hJSCXmOGLR7d98/lXgna1pxSY1nM1BV+AKlfkmuSXWLo0+CztNplrEKGez7jgoFd7bW
 497wpfo81NsnTi5sT4mqjM+4ImQGN2wn3deA0ZzmL7U7NgRuWd8TWStkRSfsl3BdbgN80F8Cp
 BSX84viztGm5wYts6XzcVQam7xWM3CKwjcfoprGqO8DWsvtQDqecpS3pS0CqO431jpUt+jeYs
 i55/ioTlIQ/iXvP1FwsHWK22fiU5PoD7HTW8UwEMWvEbveBJw+ter4yrxMYJ7hyygMeP3Ufrx
 iWdmwJ3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Andreas,

On Sun, 24 Jul 2016, Andreas Schwab wrote:

> Eric Wong <e@80x24.org> writes:
> 
> > diff --git a/mailinfo.c b/mailinfo.c
> > index 9f19ca1..0ebd953 100644
> > --- a/mailinfo.c
> > +++ b/mailinfo.c
> > @@ -1035,3 +1035,34 @@ void clear_mailinfo(struct mailinfo *mi)
> >  
> >  	strbuf_release(&mi->log_message);
> >  }
> > +
> > +int is_from_line(const char *line, int len)
> > +{
> > +	const char *colon;
> > +
> > +	if (len < 20 || memcmp("From ", line, 5))
> > +		return 0;
> > +
> > +	colon = line + len - 2;
> > +	line += 5;
> > +	for (;;) {
> > +		if (colon < line)
> > +			return 0;
> > +		if (*--colon == ':')
> > +			break;
> > +	}
> > +
> > +	if (!isdigit(colon[-4]) ||
> > +	    !isdigit(colon[-2]) ||
> > +	    !isdigit(colon[-1]) ||
> > +	    !isdigit(colon[ 1]) ||
> > +	    !isdigit(colon[ 2]))
> > +		return 0;
> > +
> > +	/* year */
> > +	if (strtol(colon+3, NULL, 10) <= 90)
> > +		return 0;
> > +
> > +	/* Ok, close enough */
> > +	return 1;
> > +}
> 
> Should this be made more strict, like by checking for a space before the
> year?

This patch only moves the function, so it would be inappropriate to change
it.

If you want to make it stricter, you will have to submit a separate patch.

Ciao,
Johannes
