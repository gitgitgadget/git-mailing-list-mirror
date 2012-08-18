From: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Problems with git fetch confusing foo and foo.git repos
Date: Sat, 18 Aug 2012 23:06:05 +0100
Message-ID: <1345327565.27428.75.camel@ted>
References: <1345299904.27428.50.camel@ted> <1345301383.27428.55.camel@ted>
	 <7vk3wwrlc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>,
	"saul.wold" <saul.wold@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 00:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2rA2-0003lo-AG
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 00:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab2HRWGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 18:06:21 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:64325 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab2HRWGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 18:06:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7IM6DRs020864;
	Sat, 18 Aug 2012 23:06:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 19304-06; Sat, 18 Aug 2012 23:06:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7IM6435020858
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Aug 2012 23:06:06 +0100
In-Reply-To: <7vk3wwrlc9.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203704>

On Sat, 2012-08-18 at 13:33 -0700, Junio C Hamano wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> 
> > I'd add that I think the commit made for the original problem[1] has
> > fixed this scenario since it now will prefer foo over foo.git also in
> > the fetch case even if the / is removed from the url.
> 
> OK.
> 
> As understand it, these "check various possibilities e.g. $name,
> $name.git $name/.git" were never meant to be a way to encourage
> users to have multiple repositories next to each other under
> confusing names in the first place.  It was merely to allow users to
> have one of them (some may prefer $name/ that is with working tree,
> so we allow $name/.git to be discovered, while some may want to have
> a bare repository at $name.git that is bare, so we also allow it to
> be discovered).  The recent tweak was to favor the case where the
> name asked explicitly by the user is matched first, and it does not
> fundamentally change the intent of the basic design in any way.
> 
> Thanks for confirming that the tweak works well for you.

I'm responsible for "generic" source fetching infrastructure and
unfortunately I haven't been able to prevent users ending up with
"repositories next to each other under confusing names" much as I might
like to. Users tend to manage to find all the corner cases in something
like this :)

> > My test machines
> > don't have that version yet though and I'm left with a problem where git
> > is older than 1.7.9.2. 
> 
> So what do you want to see happen next?

I was a bit confused earlier whether there was any remaining issue. With
the recent versions I've now confirmed there isn't and the bug is fixed
(which I really appreciate). Sorry for the noise.

My remaining question was whether there was any better way to work
around this in older versions of git. I've ended up implementing the
symlink solution I mentioned which whilst ugly, will hopefully put this
issue to rest for me.

(http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=a86bd422641ce083ba0cdb4efe2a4c307eb36f7e in case anyone cares)

Cheers,

Richard
