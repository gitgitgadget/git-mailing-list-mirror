From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 12:11:47 +0900
Message-ID: <20141118031147.GA15358@glandium.org>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
 <20141118023112.GA14034@glandium.org>
 <20141118025131.GH4336@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 04:12:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqZD6-0005nh-2L
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 04:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaKRDMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 22:12:03 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:46331 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbaKRDMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 22:12:01 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XqZCl-00041H-Kb; Tue, 18 Nov 2014 12:11:47 +0900
Content-Disposition: inline
In-Reply-To: <20141118025131.GH4336@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 06:51:31PM -0800, Jonathan Nieder wrote:
> Mike Hommey wrote:
> > On Mon, Nov 17, 2014 at 05:40:28PM -0800, Jonathan Nieder wrote:
> 
> >> How did you get that "Not a blob" message?
> >
> > When trying to *create* a tree with a commit in it, so instead of giving
> > the mark for a blob to a filemodify command, giving a mark for a commit.
> > That is what fails with "Not a blob".
> 
> Ah, I see what you were trying now.  It's complaining that the data
> and mode don't match up.  See <mode> under 'filemodify' in the manual.
> 
> Something like
> 
> 	M 160000 :1 mycommit
> 
> should work fine, though that's a pretty ugly workaround for the
> inability to do
> 
> 	ls :1

Actually, for my use, that ugly workaround actually improves things for
me, avoiding to use blobs in some of the stuff I want to store :) How
did I miss that? Thanks a lot for the enlightenment.

> [...]
> >> I think a good fix would be to teach parse_ls a mode with no <path>
> >> parameter.  Something like this (untested; needs cleanup and tests):
> >
> > This would make both your commands output the same thing, right? It
> > wouldn't help my case :)
> 
> It's easily possible my patch has a typo somewhere, but the expected
> output format would be
> 
> 	commit 6066a7eac4b2bcdb86971783b583e4e408b32e81
> 
> That wouldn't help?

Oh, so `ls <dataref>` would print out what <dataref> is? That would
definitely help, although with the trick above, I probably wouldn't
actually need it anymore.

Mike
