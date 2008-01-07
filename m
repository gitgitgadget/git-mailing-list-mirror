From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 7 Jan 2008 22:07:35 +0100
Message-ID: <20080107210735.GC19728@pvv.org>
References: <20080107102327.GA12427@pvv.org> <7vr6gtzaeq.fsf@gitster.siamese.dyndns.org> <320075ff0801071208u1900bf76q2f0dc9cb0dc4318b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:08:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzCZ-0000uO-8V
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbYAGVHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbYAGVHj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:07:39 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:60731 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYAGVHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:07:39 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1JBzC3-0000dB-Rt; Mon, 07 Jan 2008 22:07:35 +0100
Content-Disposition: inline
In-Reply-To: <320075ff0801071208u1900bf76q2f0dc9cb0dc4318b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69809>

On Mon, Jan 07, 2008 at 08:08:38PM +0000, Nigel Magnay wrote:
> Do you currently use svn?

Currently we use CVS. It hurts a bit.

> This feels like the common technique of using svn:externals, where
> product1 has
> foo repo/foo/trunk
> os-abstraction-lib repo/os-abstraction-lib/trunk
> 
> product2 has
> os-abstraction-lib repo/os-abstraction-lib/trunk
> log-merger repos/log-merger/trunk
> 
> Where git (if I understand submodules correctly) can't do the above,
> because the links are to SHA1s rather than tags or names, so in svn
> terms it'd be something like
> os-abstraction-lib repo/os-abstraction-lib/trunk@xxx
> log-merger repos/log-merger/trunk@yyy
> 
> At first I thought the option (4) you suggest (Manually push all
> sub-modules to some new branch before pushing the  super-module) was
> going to be a pain - but actually I came to the conclusion it was
> actually better. In our svn world, commits to shared libraries (can)
> cause all hell to break loose - it'd actually be an advantage to have
> to promote changes into the supermodules (the products in our case).

With the way we envision using git, I don't think this is a
problem. Each supermodule decides what version of the shared library
it wants to use, and since git does not point to tags/branches in
submodules but to sha1s, there is nothing you can do to a submodule
that will cause any problems in a supermodule unless the supermodule
decides to use a new version.

I think we'd be perfectly happy to use detached HEADs in all
submodules, but there is no way to get that to work currently with
push and fetch, so I'm looking for some alternative.

- Finn Arne
