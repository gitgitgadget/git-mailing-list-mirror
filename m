From: Jeff King <peff@peff.net>
Subject: Re: git list files
Date: Sun, 13 Jan 2013 15:10:29 -0500
Message-ID: <20130113201027.GA4436@sigill.intra.peff.net>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
 <20130113175602.GD5973@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?0KHRgtC+0LnRh9C+INCh0LvQtdC/0YbQvtCy?= 
	<stoycho.sleptsov@gmail.com>, git@vger.kernel.org,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 21:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuTtN-0003Y8-EL
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 21:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3AMUKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 15:10:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60282 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab3AMUKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 15:10:32 -0500
Received: (qmail 11693 invoked by uid 107); 13 Jan 2013 20:11:48 -0000
Received: from mb92836d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.40.185)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jan 2013 15:11:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jan 2013 15:10:29 -0500
Content-Disposition: inline
In-Reply-To: <20130113175602.GD5973@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213399>

On Sun, Jan 13, 2013 at 09:56:02AM -0800, Jonathan Nieder wrote:

> > lets, say the equivalent of the $ls -d b* within git.git root directory
> > would look like:
> >
> > ----------------
> > 98746061 jrnieder 2010-08-12 17:11 Standardize-do-.-while-0-style   base85.c
> > c43cb386 pclouds  2012-10-26 22:53 Move-estimate_bisect_steps-to-li bisect.c
> > efc7df45 pclouds  2012-10-26 22:53 Move-print_commit_list-to-libgit bisect.h
> > 837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla blob.c
> > 837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla blob.h
> > ebcfa444 gitster  2012-07-23 20:56 Merge-branch-jn-block-sha1       block-sha1
> 
> You might like Peff's or Jakub's tree blame script.  The newest version
> I can find is
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/168323

As far as I recall, that script works. However, I have a pure-C
blame-tree implementation that is much faster, which may also be of
interest. I need to clean up and put a few finishing touches on it to
send it to the list, but it has been in production at GitHub for a few
months. You can find it here:

  git://github.com/peff/git jk/blame-tree

It's built on the regular diff traversal, just like the perl script you
linked, but doing it all in-process makes things fast.  I also added a
"--max-depth" parameter for diff, so you can do:

  git blame-tree --max-depth=1 -- Documentation

to recurse into the Documentation subdir, but not go into its
subdirectories. One of the things I need to clean up is that my counting
of --max-depth is different from that used by "git grep", and we would
probably want reconcile that.

-Peff
