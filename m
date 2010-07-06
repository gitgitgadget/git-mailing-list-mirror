From: Eric Niebler <eric@boostpro.com>
Subject: Re: help moving boost.org to git
Date: Tue, 06 Jul 2010 14:29:33 -0400
Message-ID: <4C33760D.9000404@boostpro.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org> 	<4C32668E.9040000@boostpro.com>	<AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com> 	<4C3275C0.8000406@boostpro.com>	<AANLkTikkKhvzsczKJwjsc0kmCmWQGAIUzc__Wr20Dbwd@mail.gmail.com> 	<4C336F3D.1010906@boostpro.com> <AANLkTikfTFw_UdV1ia58MbWxH4h8TJAr-Y5WPvlXCjeJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:29:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCu3-0006fQ-O2
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab0GFS3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:29:47 -0400
Received: from boostpro.com ([206.217.198.21]:38603 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753815Ab0GFS3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:29:47 -0400
Received: from [10.75.247.254] (unknown [166.198.188.124])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id D76DB14BCD8;
	Tue,  6 Jul 2010 19:29:42 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
In-Reply-To: <AANLkTikfTFw_UdV1ia58MbWxH4h8TJAr-Y5WPvlXCjeJ@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150385>

On 7/6/2010 2:13 PM, Avery Pennarun wrote:
<snip>
> Specifically, with a tool like git-subtree, it only really works if a
> particular subproject has always existed in the same subdir of your
> repo since it started.  If the subdir was ever renamed, or if some of
> the files were previously part of one subdir but then moved around,
> git-subtree doesn't (currently) know how to deal with that.

Bah! Yes, directories have moved around in our svn repro. :-( In
particular, we've had cases where libraries in boost began life as
sub-projects of a different library and then got spun off.

> git-filter-branch can do anything you want, but you have to teach it
> how, which is obviously even *more* error prone.

I can only imagine.

> Things are also a little messy if you have some kind of top-level
> directory with build infrastructure shared by all the subdirs.  Does
> the top-level Makefile have a list of the subdirs it needs to build?

Bah! Yes, the build, the docs and the test infrastructure all currently
share files across our submodules-to-be. Surely other projects have
encountered this problem before, right? (KDE, I'm looking in your
direction.)

> If so, there's no way to extract only a subset of true history that
> will still build correctly - it'll be looking for directories that you
> explicitly removed.  You could update the Makefiles programmatically
> in every single revision, but that's starting to get extremely
> messy... and your history stops representing what *real life* really
> looked like at the time.

I see what you mean.

> If your subdirs haven't been moving around (which sounds like that
> might be the case for you), and you don't have any top-level files
> that you care about, rewriting might turn out to be straightforward.
> You could also make the decision on a subdir-by-subdir basis, I guess.

More evidence that the fancy filter/branch/subtree/svn2git/whatever
utilities aren't going to get us where we'd like to be. A simple
conversion and grafts look like the only workable approach.

> Have fun,

Having heaps! Thanks,

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
