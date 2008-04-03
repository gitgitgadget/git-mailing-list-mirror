From: Jeff King <peff@peff.net>
Subject: Re: merge conflict diff
Date: Thu, 3 Apr 2008 10:26:49 -0400
Message-ID: <20080403142649.GA16699@coredump.intra.peff.net>
References: <b9fd99020804030713n3c1a2602t847e8a132f8ccd06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremy Ramer <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 16:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQPh-0006W3-0s
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbYDCO0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 10:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYDCO0x
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:26:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258AbYDCO0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 10:26:53 -0400
Received: (qmail 25479 invoked by uid 111); 3 Apr 2008 14:26:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Apr 2008 10:26:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Apr 2008 10:26:49 -0400
Content-Disposition: inline
In-Reply-To: <b9fd99020804030713n3c1a2602t847e8a132f8ccd06@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78757>

On Thu, Apr 03, 2008 at 08:13:04AM -0600, Jeremy Ramer wrote:

> I am trying to figure out how to quickly diff two source files that
> led to a merge conflict.  When a conflict occurs the command
> [...]
> So far I am thinking of
> # git checkout-index --stage=2 --temp foo
> # git checkout-index --stage=3 --temp foo
> # git diff .merge_x1 .merge_x2

The special ref syntax :<n>:file refers to the blob in stage <n> of the
index. So you can see them with:

  git show :2:foo
  git show :3:foo

Or diff them with:

  git diff :2:foo :3:foo

You may also want to look at the git-mergetool script, which uses both
versions (along with the ancestor) as the arguments to many common merge
resolution programs.

-Peff
