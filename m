From: Jeff King <peff@peff.net>
Subject: Re: patches in context format ?
Date: Mon, 12 Jan 2009 04:52:50 -0500
Message-ID: <20090112095250.GB3079@coredump.intra.peff.net>
References: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJUu-0003lB-Fw
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbZALJwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbZALJww
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:52:52 -0500
Received: from peff.net ([208.65.91.99]:37707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbZALJww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:52:52 -0500
Received: (qmail 30395 invoked by uid 107); 12 Jan 2009 09:52:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Jan 2009 04:52:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2009 04:52:50 -0500
Content-Disposition: inline
In-Reply-To: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105319>

On Mon, Jan 12, 2009 at 10:00:11AM +0100, Christian MICHON wrote:

> The current solution I have is to use the original patch command,
> stage modifications and add new files. I do not like this solution,
> because I have to work out the commit messages out of the mbox and I
> lose reproducibility. I'm basically maintaining a subset of shell
> scripts, the original patches and an artificial way (ugly) to get
> timestamps of modifications (for the commit dates).
> 
> Instead of this complicated procedure, I'd like to use "git apply" or
> "git am", provided I can get git to support "context output format" as
> input for patches ?

Maybe this is not the nicest solution if you are going to apply a lot of
these patches, but you can pick up where git-am fails, run patch, and
ask it to resume:

  $ git am mbox-with-context-diff
  Applying: a minor change
  error: No changes
  Patch failed at 0001.
  When you have resolved this problem run "git am --resolved".
  If you would prefer to skip this patch, instead run "git am --skip".
  To restore the original branch and stop patching run "git am --abort".

  $ patch <.git/rebase-apply/patch ;# or whatever
  $ git add -u
  $ git am -r
  Applying: a minor change

-Peff
