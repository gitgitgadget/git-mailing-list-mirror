From: Frans Englich <fenglich@fastmail.fm>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be reported as binaries
Date: Thu, 2 Jul 2009 10:14:06 +0200
Message-ID: <200907021014.06540.fenglich@fastmail.fm>
References: <200907011208.35397.fenglich@fastmail.fm> <20090702053534.GA13255@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 02 10:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMHYG-00087W-8v
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 10:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbZGBIVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 04:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZGBIVj
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 04:21:39 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37619 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482AbZGBIVh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 04:21:37 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 71F0D389374;
	Thu,  2 Jul 2009 04:10:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 02 Jul 2009 04:10:50 -0400
X-Sasl-enc: zo/vuhlOzMqnsQM8T/O+fFtyEeOxWXWlIFCnSfDd2mIR 1246522245
Received: from localhost (unknown [62.70.27.104])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CD5121D69;
	Thu,  2 Jul 2009 04:10:45 -0400 (EDT)
User-Agent: KMail/1.9.10
In-Reply-To: <20090702053534.GA13255@sigio.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122629>

On Thursday 02 July 2009 07:35:34 Jeff King wrote:
> On Wed, Jul 01, 2009 at 12:08:35PM +0200, Frans Englich wrote:
> > Applying -diff Unset to a file using .gittattributes causes "git diff"
> > to state that the file is a binary even though it isn't, or have been
> > instructed to be treated as one. See attached script for reproducing.
>
> I think you are a little confused by the syntax. Each line of the
> gitattributes file has a filename pattern and a set of attributes. Each
> attribute is either set, unset, set to a value, or unspecified. For your
> example (file.txt and the "diff" attribute), they look like:

Perhaps that should be considered another bug; that invalid syntax is 
accepted, instead of being communicated to the user.

[...]
> So as far as I can see, git is behaving exactly as it is supposed to.
> Maybe you can be more specific about what effect you were trying to
> achieve by setting gitattributes in the first place?

To exclude it in diffs, such as from `git show`. Take the case where you have 
a grammar file for a parser and generate a source file from it(or any similar 
scenario); the diff for the generated source file is not of interest and is 
just noisy when read as part of a patch. This applies to all kinds of 
generated files. However, this doesn't mean that the file should be treated 
as a binary, and what practicalities that implies.

If -diff affects whether a file is treated as a binary, as opposed whether 
it's diff'ed, it would imo make sense to call it -binary.


Cheers,

		Frans
