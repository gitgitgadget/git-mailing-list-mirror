Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3864C201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbdBTMoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:44:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:52751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753005AbdBTMoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:44:05 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP0LT-1cl2Eu2d6N-006OIm; Mon, 20
 Feb 2017 13:43:39 +0100
Date:   Mon, 20 Feb 2017 13:43:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/5] hashmap: allow memihash computation to be
 continued
In-Reply-To: <xmqq7f4onjrs.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702201342020.3496@virtualbox>
References: <cover.1487071883.git.johannes.schindelin@gmx.de> <bd4893f86c4484fc36480848bf2d0905d961e022.1487071883.git.johannes.schindelin@gmx.de> <xmqq7f4onjrs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cVR2eZ2sYJ89CaOi6FL5uqRF6cOBK4XGV8zizBOvL7jy3SYDWtI
 5yJEbwxYRzH12GjPZ3hrMgYz1Oj3a+1sGQIvYwbGt9DY+JvQGepfc3wmkGVa7wGRt1ve9Rf
 LfqisNbG+00yj2AO5EBCvPo6M10899mlPZprL9TafCdtJhuvKcsGXhQeOY+U5Nm8izXWyIn
 ywIeeOjsaD1cOdMnodXWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1fGGvzMtu8o=:4ZmxboIiV7AmCuA2OnVrsT
 4xKHohaRpRYUztWa92c+RJ6VV4sNphW8Gh063O2lES9xBCt3Ga0JHBJ2M/OImP8uhOJejptgw
 ndaksp1SnOVslUxwgB+03NNVjHSVg39GCdPDaFozbmXtt1xVm4F0Hik+w24RWUwezgTkwmtXk
 FyFDqDTrqct3XhzS9mahOjVeuSWa7nTjzM3urauXUY4d9R/ilQJ6d1lrR1c0HbTvyARdgcLMU
 io01h7SnVca1jLQbjTkhNrMqKG8yMMK3keyQhf02TOEK3QsnZy7wh7pn7D8xSM7hLGMwaE9O2
 gCGNDhdfHz9iq9/MITukE3hrDgvkJAvc5Hp6wn+oRem/fJb/I++DibvtifTHWWoVfXs0KnYNO
 Hh8sqzBxgXangv38Zu8QCU0ezT/LkuX9r79S2qUdngogN5EZvV5uLX3QhDqPWVa3taFZgV5pY
 VhJB0lxTMex8Y1ZehpHTBx9/NQSnMWg84+tZBfnDimE1MYRXPWERRLbseL+prfCJgoBYTCZNO
 xNGXUMCCw08N8vpwujkjIlh0S1z04YlI6q2miXhCbhXhlosodo77LNbvtBsh2m+j2st1z4t2R
 Y+d93+vii1CxdvRM1zeWCzVE6sf4oE9EoaToOW+OT00fnlJpeyUtlmYZNx05LNM556ELexw9U
 zZA9fl2zaAJj2ccLT1h/QMfIEngepbtw6kh+Tx5zt+cdwNpHv1Bp4JDUdKetWhqKQRpsHsq/b
 dLptDZ5FGt0LNkulkqi8p/Z1QW5UcmciAEFAjRXdRaHaXi2boQR9UmLny4vP4T+5EOGWuT/Pe
 eng39hN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 17 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/hashmap.c b/hashmap.c
> > index b10b642229c..061b7d61da6 100644
> > --- a/hashmap.c
> > +++ b/hashmap.c
> > @@ -50,6 +50,20 @@ unsigned int memihash(const void *buf, size_t len)
> >  	return hash;
> >  }
> >  
> > +/* Incoporate another chunk of data into a memihash computation. */
> > +unsigned int memihash_continue(unsigned int hash,
> > +			       const void *buf, size_t len)
> > +{
> > +	const unsigned char *p = buf;
> > +	while (len--) {
> > +		unsigned int c = *p++;
> > +		if (c >= 'a' && c <= 'z')
> > +			c -= 'a' - 'A';
> > +		hash = (hash * FNV32_PRIME) ^ c;
> > +	}
> > +	return hash;
> > +}
> 
> This makes me wonder if we want to reduce the duplication (primarily
> to avoid risking the loop body to go out of sync) by doing:
> 
> 	unsigned int memihash(const void *buf, size_t len)
> 	{
> 		return memihash_continue(buf, len, FNV32_BASE);
> 	}                
> 
> If an extra call level really matters, its "inline" equivalent in
> the header would probably be good.

Well, the hashing is supposed to be as fast as possible, so I would like
to avoid that extra call level. However, the end result is not so pretty
because FNV32_BASE needs to be made public (OTOH it removes more lines
than it adds):

-- snipsnap --
diff --git a/hashmap.c b/hashmap.c
index 061b7d61da6..470a0832688 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -4,7 +4,6 @@
 #include "cache.h"
 #include "hashmap.h"
 
-#define FNV32_BASE ((unsigned int) 0x811c9dc5)
 #define FNV32_PRIME ((unsigned int) 0x01000193)
 
 unsigned int strhash(const char *str)
@@ -37,19 +36,6 @@ unsigned int memhash(const void *buf, size_t len)
 	return hash;
 }
 
-unsigned int memihash(const void *buf, size_t len)
-{
-	unsigned int hash = FNV32_BASE;
-	unsigned char *ucbuf = (unsigned char *) buf;
-	while (len--) {
-		unsigned int c = *ucbuf++;
-		if (c >= 'a' && c <= 'z')
-			c -= 'a' - 'A';
-		hash = (hash * FNV32_PRIME) ^ c;
-	}
-	return hash;
-}
-
 /* Incoporate another chunk of data into a memihash computation. */
 unsigned int memihash_continue(unsigned int hash,
 			       const void *buf, size_t len)
diff --git a/hashmap.h b/hashmap.h
index 78e14dfde71..a1a8fd7dc54 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -8,12 +8,17 @@
 
 /* FNV-1 functions */
 
+#define FNV32_BASE ((unsigned int) 0x811c9dc5)
+
 extern unsigned int strhash(const char *buf);
 extern unsigned int strihash(const char *buf);
 extern unsigned int memhash(const void *buf, size_t len);
-extern unsigned int memihash(const void *buf, size_t len);
 extern unsigned int memihash_continue(unsigned int hash_seed,
 				      const void *buf, size_t len);
+static inline unsigned int memihash(const void *buf, size_t len)
+{
+	return memihash_continue(FNV32_BASE, buf, len);
+}
 
 static inline unsigned int sha1hash(const unsigned char *sha1)
 {
