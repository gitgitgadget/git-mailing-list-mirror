From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 20:26:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211262024520.7256@s15462909.onlinehome-server.info>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com> <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com> <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
 <20121121041735.GE4634@elie.Belkin> <7vfw43pmp7.fsf@alter.siamese.dyndns.org> <20121121194810.GE16280@sigill.intra.peff.net> <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com> <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info> <7vd2z0tfhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:16:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td62E-0001f1-SR
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab2KZVPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:15:55 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:60593 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753576Ab2KZVPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:15:55 -0500
Received: (qmail invoked by alias); 26 Nov 2012 19:26:22 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp039) with SMTP; 26 Nov 2012 20:26:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+//G9HVZy/oFkCJtY3ry6uWroMa5xk9yQS1fiQ4/
	Ve2Wv6PYJVfikH
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vd2z0tfhz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210496>

Hi Junio,

On Mon, 26 Nov 2012, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you changed your stance on the patch Sverre and I sent to fix this,
> > we could get a non-partial fix for this.
> 
> This is long time ago so I may be misremembering the details, but I
> thought the original patch was (ab)using object flags to mark "this was
> explicitly asked for, even though some other range operation may have
> marked it uninteresting".  Because it predated the introduction of the
> rev_cmdline_info mechanism to record what was mentioned on the command
> line separately from what objects are uninteresting (i.e. object flags),
> it may have been one convenient way to record this information, but it
> still looked unnecessarily ugly hack to me, in that it allocated scarce
> object flag bits to represent a narrow special case (iirc, only a
> freestanding "A" on the command line but not "A" spelled in "B..A", or
> something), making it more expensive to record other kinds of command
> line information in a way consistent with the approach chosen (we do not
> want to waste object flag bits in order to record "this was right hand
> side tip of the symmetric difference range" and such).

Good to know. I will find some time to look at rev_cmdline_info and patch
my patch.

> If you are calling "do not waste object flags to represent one
> special case among endless number of possibilities, as it will make
> it impossible to extend it" my stance, that hasn't changed.
> 
> We added rev_cmdline_info since then so that we can tell what refs
> were given from the command line in what way, and I thought that we
> applied a patch from Sverre that uses it instead of the object
> flags.  Am I misremembering things?

It does sound so familiar that I am intended to claim that you remember
things correctly.

Ciao,
Johannes
