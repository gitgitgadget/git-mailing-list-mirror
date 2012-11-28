From: Jeff King <peff@peff.net>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 20:17:50 -0500
Message-ID: <20121128011750.GA23498@sigill.intra.peff.net>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:18:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWHw-00076a-9K
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab2K1BRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:17:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58810 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460Ab2K1BRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:17:53 -0500
Received: (qmail 31854 invoked by uid 107); 28 Nov 2012 01:18:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 20:18:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 20:17:50 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210654>

On Tue, Nov 27, 2012 at 05:07:34PM -0800, Shawn O. Pearce wrote:

> On Tue, Nov 27, 2012 at 4:26 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Wed, Nov 28, 2012 at 1:12 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> >> Shawn Pearce <spearce@spearce.org>:
> >>> Well... if we added a fractional seconds to a commit, older versions
> >>> of Git will scream loudly and refuse to work with the new commit. That
> >>> would create a fork of Git.
> >>
> >> So much for that idea, I guess.
> >>
> >> Unless..I don't know how git's database representations work.  Are they
> >> version-stamped in any way?  If so, some slightly painful hackery would
> >> get around that problem.
> >
> > % git cat-file -p HEAD
> >
> > You'll see exactly how git stores commits. Changing anything in there
> > must be done carefully.
> 
> Apparently there is no room to change in these fields without breaking
> compatibility with all current versions of Git. So its not just done
> carefully... its deciding to make Git 2.0 that is not compatible with
> any Git 1.x release.

There is room for new headers, and older versions of git will ignore
them. You could add a new "committer-timestamp" field that elaborates on
the timestamp included on the committer line. Newer versions of git
would respect it, and older versions would fall back to using the
committer timestamp.

But I really wonder if anybody actually cares about adding sub-second
timestamp support, or if it is merely "because SVN has it".

-Peff
