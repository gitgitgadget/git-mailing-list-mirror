From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] git-status: show short sequencer state
Date: Mon, 29 Oct 2012 17:41:03 -0400
Message-ID: <20121029214103.GD20513@sigill.intra.peff.net>
References: <1351022574-27869-1-git-send-email-hordp@cisco.com>
 <1351022574-27869-2-git-send-email-hordp@cisco.com>
 <20121025092919.GG8390@sigill.intra.peff.net>
 <5089633C.8030307@cisco.com>
 <CABURp0o7b5aZV6jNM=DSweh-8zVgGppxVsXisAcoNk7TxHrdgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxKx-0003kU-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761506Ab2J2VlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:41:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43058 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761503Ab2J2VlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 17:41:05 -0400
Received: (qmail 23822 invoked by uid 107); 29 Oct 2012 21:41:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 17:41:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 17:41:03 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0o7b5aZV6jNM=DSweh-8zVgGppxVsXisAcoNk7TxHrdgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208644>

On Mon, Oct 29, 2012 at 02:05:14PM -0400, Phil Hord wrote:

> I'm currently splitting this out into a series and reconsidering some
> of it along the way.  I need some guidance.
> 
> I want to support these two modes:
> 
>   A.  'git status --short' with sequence tokens added:
>        ## conflicted
>        ## merge
>        ?? untracked-workdir-file
>        etc.
> 
>   B.  Same as (A) but without workdir status:
>        ## conflicted
>        ## merge
> 
> The user who wants 'A' would initiate it like this:
>     git status --sequencer
>   or
>     git status -S
> 
> How do I spell the options for 'B'?  I have come up with these three
> possibilities:
>     git --sequencer-only   # Another switch
>     git --sequencer=only   # An OPTARG parser
>     git -S -S           # like git-diff -C -C, an OPT_COUNTUP

Might it be easier to spell 'A' as:

  git status --short -S

and B as:

  git status -S

this is sort of like how "-b" works (except you cannot currently ask for
it separately, but arguably you could). If we have a proliferation of
such options, then we might need config to help turn them on all the
time (I'd guess people are probably already using aliases to do this).

-Peff
