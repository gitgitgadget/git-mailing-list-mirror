From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 12:29:40 -0400
Message-ID: <20160526162940.GB18210@sigill.intra.peff.net>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160522112019.26516-2-pclouds@gmail.com>
 <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
 <574706A1.8040606@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:29:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yAO-0005s6-Bl
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbcEZQ3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:29:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:44653 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750745AbcEZQ3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:29:43 -0400
Received: (qmail 4876 invoked by uid 102); 26 May 2016 16:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:29:42 -0400
Received: (qmail 19940 invoked by uid 107); 26 May 2016 16:29:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:29:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 12:29:40 -0400
Content-Disposition: inline
In-Reply-To: <574706A1.8040606@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295663>

On Thu, May 26, 2016 at 10:22:25AM -0400, Marc Branchaud wrote:

> Why do we need any kind of "->" at all?  How about simply (with an update to
> "old-branch" for comparison to probably-more-common output):
> 
> From github.com:pclouds/git
>    cafed0c..badfeed  pclouds/old-branch
>  * [new branch]      pclouds/2nd-index
>  * [new branch]      pclouds/3nd-index
>  * [new branch]      pclouds/file-watcher

That covers the common case of:

  refs/heads/*:refs/remotes/pclouds/*

but sometimes the remote and local names are not the same, and the
mapping is interesting. Like:

  $ git fetch origin refs/pull/*/head:refs/remotes/pr/*
  ...
   * [new ref]         refs/pull/77/head -> pr/77

Or even:

  $ git fetch origin refs/pull/77/head refs/pull/78/head
  From ...
   * branch            refs/pull/77/head -> FETCH_HEAD
   * branch            refs/pull/78/head -> FETCH_HEAD

So I think we need a scheme that can show the interesting mappings, but
collapses to something simple for the common case.

-Peff
