From: Jeff King <peff@peff.net>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 04:33:23 -0400
Message-ID: <20160509083323.GB14299@sigill.intra.peff.net>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
 <878tzmrrfg.fsf@linux-m68k.org>
 <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
 <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
 <5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
 <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
 <CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 10:40:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azgdD-0003oH-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 10:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbcEIId1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 04:33:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:36172 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751167AbcEIId0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 04:33:26 -0400
Received: (qmail 24305 invoked by uid 102); 9 May 2016 08:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:33:26 -0400
Received: (qmail 17196 invoked by uid 107); 9 May 2016 08:33:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:33:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 04:33:23 -0400
Content-Disposition: inline
In-Reply-To: <CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293994>

On Mon, May 09, 2016 at 08:30:51AM +0200, demerphq wrote:

> > -       perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
> > +       test_seq_counter__=$1
> > +       while test "$test_seq_counter__" -le $2
> > +       do
> > +               echo "$test_seq_counter__"
> > +               test_seq_counter__=$((test_seq_counter__ + 1))
> > +       done
> >  }
> 
> Is that perl snippet ever called with non-numeric output?
> 
> perl -le 'print for $ARGV[0]..$ARGV[1]' -- A E
> A
> B
> C
> D
> E

I had that thought, too, but I think it would be an error to do so.
test_seq is supposed to be a replacement for "seq", which does not
understand non-numeric sequences.

A quick "git grep test_seq" seems to back that up.

-Peff
