From: Jeff King <peff@peff.net>
Subject: Re: tar on Mac does not like empty tar from git archive
Date: Mon, 8 Apr 2013 17:05:36 -0400
Message-ID: <20130408210536.GB9649@sigill.intra.peff.net>
References: <ABD0C67A-0B2B-4E32-AF49-93FBABC032A7@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJGN-0001DG-AY
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942Ab3DHVFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:05:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34268 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875Ab3DHVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:05:41 -0400
Received: (qmail 15342 invoked by uid 107); 8 Apr 2013 21:07:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:07:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:05:36 -0400
Content-Disposition: inline
In-Reply-To: <ABD0C67A-0B2B-4E32-AF49-93FBABC032A7@bjhargrave.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220515>

On Mon, Apr 08, 2013 at 02:36:05PM -0400, BJ Hargrave wrote:

> Git 1.8.2.1 includes commit bd54cf17 - archive: handle commits with an
> empty tree
> 
> Test 2 of t5004-archive-corner-cases, "tar archive of empty tree is
> empty", fails on Mac OS X 10.8.3 (with XCode 4.6.1) since the tar
> command exits with return code 1 on the generated  tar file.

Hmm. So I guess the question is: do we need to work around this in the
test for platforms that do not like empty tar files, or are the empty
tarfiles we are making wrong somehow?

> tar --version
> bsdtar 2.8.3 - libarchive 2.8.3
> 
> It appears that bsdtar does not like the empty tar files created by
> git archive. An empty tar file created by bsdtar is accepted.
> 
> tar cT /dev/null | tar t; echo $?
> 0

That makes me think the latter ("we are wrong"). I don't have my OS X
box handy; can you provide a sample empty tarfile that it creates?

-Peff
