From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 14:48:10 -0500
Message-ID: <20121121194810.GE16280@sigill.intra.peff.net>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
 <20121121041735.GE4634@elie.Belkin>
 <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGHc-0001PP-R2
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894Ab2KUTsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:48:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54460 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab2KUTsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:48:13 -0500
Received: (qmail 9645 invoked by uid 107); 21 Nov 2012 19:49:06 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 14:49:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 14:48:10 -0500
Content-Disposition: inline
In-Reply-To: <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210170>

On Tue, Nov 20, 2012 at 09:08:36PM -0800, Junio C Hamano wrote:

> With such a one-sided discussion, I've been having a hard time
> convincing myself if Felipe's effort is making the interface better,
> or just breaking it even more for existing remote helpers, only to
> fit his world model better.

Felipe responded in more detail, but I will just add the consensus we
came to earlier in the discussion: the series does make things better
for users of fast-export that use marks, but does not make things any
better for users of negative refs on the command line. However, I do not
think that it makes things worse for them, either (neither by changing
the behavior negatively, nor by making the code harder for a more
complete fix later).

So while fixing everybody might be nice, there is no need to hold up
progress for the marks case. Which, as he has noted, is probably the
sanest way to implement a remote-helper[1].

-Peff

[1] There are other possible use cases for fast-export which might
    benefit from negative refs working more sanely, but since they are
    in the minority and are not being made worse, I think the partial
    fix is OK.
