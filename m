From: Jeff King <peff@peff.net>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Tue, 28 Apr 2015 01:55:06 -0400
Message-ID: <20150428055506.GJ24580@peff.net>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Olivier ROLAND <cyrus-dev@edla.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 07:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmyUF-0007WL-T4
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 07:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbD1FzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 01:55:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:50980 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750970AbbD1FzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 01:55:09 -0400
Received: (qmail 19319 invoked by uid 102); 28 Apr 2015 05:55:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:55:09 -0500
Received: (qmail 11842 invoked by uid 107); 28 Apr 2015 05:55:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:55:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 01:55:06 -0400
Content-Disposition: inline
In-Reply-To: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267899>

On Sun, Apr 26, 2015 at 11:25:52AM +0200, Olivier ROLAND wrote:

> OSX 10.10.3 git 2.3.6 HFS+ case-sensitive
> 
> How to reproduce :
> Step 1 : git clone https://github.com/begeric/FastParsers.git
> Step 2 : cd FastParsers/
> Step 3 : git filter-branch --env-filter 'if [ 0 = 1 ]; then echo 0; fi' -- --all
> 
> Result on OSX :
> Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
> Ref 'refs/heads/experiment' was rewritten
> Ref 'refs/remotes/origin/experiment' was rewritten
> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
> Ref 'refs/remotes/origin/master' was rewritten
> 
> Result on Debian :
> Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
> WARNING: Ref 'refs/heads/experiment' is unchanged
> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
> WARNING: Ref 'refs/remotes/origin/master' is unchanged
> 
> Do you have any thoughts on this ?

Weird. Did you build both versions of git from source (that is, there's
no question that the OS X one is a hacked-up Apple git or something)?

Presumably it's some incompatibility in the shells used. What does:

  head -1 "$(git --exec-path)/git-filter-branch"

say about the shell in use on each system? Does running that shell with
"--version" report anything useful?

-Peff
