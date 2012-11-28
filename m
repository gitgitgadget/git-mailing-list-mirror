From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 02:58:08 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121128075807.GA9912@thyrsus.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdcXQ-0005fY-1t
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab2K1H6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:58:14 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33165
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2K1H6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:58:14 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 884924065F; Wed, 28 Nov 2012 02:58:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210717>

Junio C Hamano <gitster@pobox.com>:
> Roundtrip conversions may benefit from sub-second timestamps, but
> personally I think negative timestamps are more interesting and of
> practical use. 

You mean, as in times before the Unix epoch 1970-01-01T00:00:00Z?  

Interesting.  I hadn't thought of that.  I've never seen a software
project under version control with bits that old, which is significant
because I've probably done more digging into ancient software than
anybody other than a specialist historian or two.

They would have to have been restrospective dates from the get-go.
SCCS wasn't built until 1972.

> And if we were to add "committer-timestamp" and friends to support
> negative timestamps anyway (because older tools will not support
> them), supporting sub-second part might be something we want to
> think about at the same time.

That seems eminently reasonable.

> We would however need to be extra careful.  How should we express
> half-second past Tue Nov 27 23:24:16 2012 (US/Pacific)?  Would we
> spell it 1354087456.5?  1354087456.500?  Would we require decimal
> representation of floating point numbers to be normalized in some
> way (e.g. minimum number of digits without losing precision)?  The
> same timestamp needs to be expressed the same way, or we will end up
> with different commit objects, which defeats the whole purpose of
> introducing subsecond timestamps to support round-trip conversions.
> 
> If we were to use a separate "subsecond" fields, another thing we
> need to be careful about is the order of these extra fields, exactly
> for the same reason.

I think minimum number of digits without losing precision is about the
only alternative that is future-proof - I was going to suggest it for
that reason.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
