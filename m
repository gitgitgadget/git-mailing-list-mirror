From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH/RFC 0/4] Add option to enable filters in git-svn
Date: Thu, 2 Jun 2016 21:13:46 +0000
Message-ID: <20160602211346.GA24915@dcvr.yhbt.net>
References: <20160531150749.24840-1-naufraghi@develer.com>
 <33130d8be1ad6edaa75a75c43901a2fa@develer.com>
 <20160531181241.GA28818@dcvr.yhbt.net>
 <cb49a08e3ec44f7d37603e5b1fe20a22@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matteo Bertini <naufraghi@develer.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:17:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ZwC-0003Iu-QF
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbcFBVNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:13:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59046 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383AbcFBVNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:13:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657A51FAB2;
	Thu,  2 Jun 2016 21:13:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cb49a08e3ec44f7d37603e5b1fe20a22@develer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296235>

Matteo Bertini <naufraghi@develer.com> wrote:
> Il 2016-05-31 20:12 Eric Wong ha scritto:
> >Matteo Bertini <naufraghi@develer.com> wrote:
> >>Sorry to all, but I missed a Checksum mismatch error, I'll have a
> >>look and submit an update.
> 
> I've had a look, the problem is a missing smudge filter.
> Unluckily the small svn revision range i was using was never updating
> a filtered file.
> 
> The code actually uses `cat-file --batch` to get the blobs,
> but the stored blob is not what SVN::TxDelta::apply need.
> What I need is the smudged blob, but cat-file does not supports it.
> 
> I can modify cat-file with a new option to call
> `convert_to_working_tree`,
> and have the filters applied, for example --use-filters, that expects an
> extra field, like $sha\t$path, in the stdin stream.
> 
> I don't like a lot putting an high level feature in a low level command,
> but --textconv seems very similar to this.
> 
> Opinions or other suggestions?

In the absense of other opinions or suggestions, I suggest you
try it and see what others think :)

I'm not that experienced at the C code of this project,
but I can try to follow along as best as I can.
