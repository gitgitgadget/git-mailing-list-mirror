From: Jeff King <peff@peff.net>
Subject: Re: bug report, v1.7.12.1 -- Documentation/git-bundle.xml:130:
 parser error
Date: Sun, 30 Sep 2012 14:02:09 -0400
Message-ID: <20120930180209.GA13596@sigill.intra.peff.net>
References: <20120930030819.b5195ee0.hesco@yourmessagedelivered.com>
 <7vipawge11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: hesco@yourmessagedelivered.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 20:03:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TINrB-0004QF-Ko
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 20:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab2I3SCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 14:02:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36230 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab2I3SCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 14:02:15 -0400
Received: (qmail 12143 invoked by uid 107); 30 Sep 2012 18:02:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 30 Sep 2012 14:02:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Sep 2012 14:02:09 -0400
Content-Disposition: inline
In-Reply-To: <7vipawge11.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206691>

On Sun, Sep 30, 2012 at 12:34:18AM -0700, Junio C Hamano wrote:

> I suspect that a tilde inside literal `` environment is mishandled
> in your versions of the documentation toolchain.  Either you would
> need to upgrade some tool in the toolchain, or we would need patches
> to the source that would look like:
> 
> 	-such as `master~1` cannot be packaged,...
>         +such as `master{tilde}1` cannot be packaged,...
> 
> to work around this problem if the version of the problematic tool
> you are using is widespread.

That would not work, as commit 6cf378f turned off no-inline-literal, and
modern asciidoc would not expand that "{tilde}" at all. My guess is that
Hugh is using a version of asciidoc older than 8.4.1, which was the
first version to understand inline literals.

This came up already once before:

  http://thread.gmane.org/gmane.comp.version-control.git/198733

where the culprit was older third-party RPMs on RHEL5. It can be worked
around by upgrading asciidoc, or using "make quick-install-doc" to pull
the pre-built versions.

-Peff
