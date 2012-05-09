From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: do not accept non-blobs as new notes
Date: Wed, 9 May 2012 14:43:55 -0400
Message-ID: <20120509184355.GA13012@sigill.intra.peff.net>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <20120508160334.GA26838@sigill.intra.peff.net>
 <CACsJy8DHotHhF0ADDwjUZx5m8SGjXFuXV9fY=mfHmswyZxzeSQ@mail.gmail.com>
 <20120509173701.GB30487@sigill.intra.peff.net>
 <7v4nrptf5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 20:44:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSBrp-0007R6-1J
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 20:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab2EISn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 14:43:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab2EISn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 14:43:58 -0400
Received: (qmail 19198 invoked by uid 107); 9 May 2012 18:44:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 May 2012 14:44:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2012 14:43:55 -0400
Content-Disposition: inline
In-Reply-To: <7v4nrptf5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197490>

On Wed, May 09, 2012 at 10:52:56AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. I was thinking that we supported arbitrary sha1s as note values via
> > the command-line interface. But we don't; that is only the internal C
> > API, and it is quite difficult to do anything useful with non-blob notes
> > via the command-line interface. As you noticed, you can trick it into
> > doing so with "-C", but even "-c" has disastrous results (unless you
> > like dumping the binary tree object into your editor).
> 
> It is fair to restrict anything that involves an editor or end user
> interaction with the terminal output for sanity, and raw tree object data
> is on the other side of the border line that defines what is sane, so I
> wouldn't have much problem with a new restriction on the command line
> interface, except for "-C".  Advertising that we store arbitrary binary
> out of an existing blob as-is and then starting to refuse taking it sounds
> like a non-starter.

Fair enough. I was willing to accept the "-C $tree" case as collateral
damage under the assumption that nobody is using it. But you're right,
the real issue is restricting the "-c" case, as well as the "show" case
when reading notes. The right patch would restrict those and leave "-C"
alone.

-Peff
