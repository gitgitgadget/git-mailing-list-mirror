From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Thu, 3 Dec 2015 22:53:18 +0200
Message-ID: <20151203205318.GA10006@wheezy.local>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <20151203061505.GA4314@wheezy.local>
 <CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4asd-00063i-VV
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbbLCUx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:53:27 -0500
Received: from p3plsmtpa12-10.prod.phx3.secureserver.net ([68.178.252.239]:55291
	"EHLO p3plsmtpa12-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753704AbbLCUx0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 15:53:26 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-10.prod.phx3.secureserver.net with 
	id p8tH1r00L5B68XE018tQwy; Thu, 03 Dec 2015 13:53:25 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281971>

On Thu, Dec 03, 2015 at 09:07:07AM +0100, Duy Nguyen wrote:
> On Thu, Dec 3, 2015 at 7:15 AM, Max Kirillov <max@max630.net> wrote:
>> Using builtin defaults might be confusing for users -
>> editing the info/config.worktree they must keep in mind the
>> list of defaults (which they seem to don't know).
> 
> All per-worktree variables are marked so in config.txt

If I were user I would like the list to be more explicit.

>> Also, if
>> anybody wants to extend the default list (like myself, for
>> submodules), should they edit the info/config.worktree in
>> provided template of extend the builtin list? What was wrong
>> with the default in template?
> 
> Suppose you introduce a new
> per-worktree variable in the new git version. If it's in the builtin
> list, we don't have to update every repo's info/config,worktree.

But how do you see it? Let's, for example, git-N consider
some variable as per-repository, and user does have it their
.git/config. Then git-N+1 considers it as per-worktree. How
does it find the variable while opening some existing
worktree? Then, if user sets the variable in some worktree
using git-N+1, git-N will no longer be able to see the
correct variable value. Does this mean that any change in
builtin list should cause repository incompatibility?

With defaults written in the info/config.worktree file the
issue do not exist at all: you can open repository created
with a git version with some default list of per-worktree
veriables with a version with other default list. It all
would work.

If user decides to change the actual list of default
per-worktree variable it is always can be done explcitly,
with some provided convenience command for example.

-- 
Max
