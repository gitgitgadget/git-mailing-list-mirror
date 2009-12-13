From: Jeff King <peff@peff.net>
Subject: Re: strange error while pushing
Date: Sun, 13 Dec 2009 18:02:14 -0500
Message-ID: <20091213230214.GA27365@sigill.intra.peff.net>
References: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 14 00:02:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJxSJ-000336-Mh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 00:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbZLMXCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 18:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbZLMXCT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 18:02:19 -0500
Received: from peff.net ([208.65.91.99]:42161 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbZLMXCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 18:02:18 -0500
Received: (qmail 29851 invoked by uid 107); 13 Dec 2009 23:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Dec 2009 18:06:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Dec 2009 18:02:14 -0500
Content-Disposition: inline
In-Reply-To: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135157>

On Sun, Dec 13, 2009 at 11:41:49PM +0100, Erik Faye-Lund wrote:

> I was going to push some stuff I'm working on to my repo at
> repo.or.cz, and just got the following error:
> 
> $ GIT_TRACE=1 git push kusma work/daemon-win32:work/daemon-win32-process
> trace: built-in: git 'push' 'kusma'
> 'work/daemon-win32:work/daemon-win32-process'
> trace: run_command: 'ssh' 'repo.or.cz' 'git-receive-pack
> '\''/srv/git/git/kusma.git'\'''
> trace: run_command: 'pack-objects' '--all-progress-implied' '--revs'
> '--stdout' '--thin'
> trace: built-in: git 'pack-objects' '--all-progress-implied' '--revs'
> '--stdout' '--thin'

I notice your pack-objects is being called with the new
--all-progress-implied, and then you get a usage error with
pack-objects:

> usage: git pack-objects [{ -q | --progress | --all-progress }]
>         [--max-pack-size=N] [--local] [--incremental]
>         [--window=N] [--window-memory=N] [--depth=N]
>         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
>         [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog]
>         [--stdout | base-name] [--include-tag]
>         [--keep-unreachable | --unpack-unreachable]
>         [<ref-list | <object-list]

Is it possible you have a new git accidentally calling an old version of
pack-objects?

-Peff
