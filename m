From: Jeff King <peff@peff.net>
Subject: Re: git push --quiet option does not seem to work
Date: Fri, 13 May 2016 18:33:37 -0400
Message-ID: <20160513223336.GA18287@sigill.intra.peff.net>
References: <CADKp0pwHKvfSDG_-4p5tUn0_QiUGKzmRj5RwphfA8sZ_7CVHqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris B <chris.blaszczynski@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 00:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1LeS-00074r-9d
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 00:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbcEMWdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 18:33:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:39447 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751498AbcEMWdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 18:33:40 -0400
Received: (qmail 21616 invoked by uid 102); 13 May 2016 22:33:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 18:33:39 -0400
Received: (qmail 22612 invoked by uid 107); 13 May 2016 22:33:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 18:33:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 18:33:37 -0400
Content-Disposition: inline
In-Reply-To: <CADKp0pwHKvfSDG_-4p5tUn0_QiUGKzmRj5RwphfA8sZ_7CVHqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294589>

On Fri, May 13, 2016 at 05:21:30PM -0400, Chris B wrote:

> Hi I am using 2.8.2.windows.1 and writing Powershell scripts doing
> some Git stuff.
> 
> I have to use the --quiet option for git because it constantly outputs
> progress to stderr.
> 
> However, it seems that --quiet does not actually work in git push. The
> output still goes to stderr.
> When there are changes committed to push it always outputs something
> to stderr. If there is nothing to push, then it actually is silent.

Can you be more specific? It seems to work for me:

  $ rm -rf dst.git &&
    git init --bare -q dst.git &&
    git push dst.git
  Counting objects: 6, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (3/3), done.
  Writing objects: 100% (6/6), 441 bytes | 0 bytes/s, done.
  Total 6 (delta 0), reused 0 (delta 0)
  To dst.git
   * [new branch]      master -> master

  $ rm -rf dst.git &&
    git init --bare -q dst.git &&
    git push -q dst.git
  [no output]

Are you seeing progress reporting, the status table, or something else?
Are you using a particular protocol that might invoke a git-remote-*
helper that doesn't respect the quiet flag?

-Peff
