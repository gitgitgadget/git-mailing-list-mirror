From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: What's the difference between `git show branch:file | diff -u
	- file` vs `git diff branch file`?
Date: Thu, 25 Aug 2011 20:09:03 +0400
Message-ID: <1314288543.8665.5.camel@n900.home.ru>
References: <loom.20110823T091132-107@post.gmane.org>
	 <4E537AF0.9070604@drmicha.warpmail.net>
	 <1314096731.15017.2.camel@n900.home.ru>
	 <4E53C89A.9000604@drmicha.warpmail.net>
	 <7vk4a4rqvb.fsf@alter.siamese.dyndns.org>
	  <4E54088F.7050700@drmicha.warpmail.net>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 18:11:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwcWi-0006El-3m
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 18:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1HYQL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 12:11:26 -0400
Received: from static.231.38.47.78.clients.your-server.de ([78.47.38.231]:48706
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab1HYQL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 12:11:26 -0400
Received: from [83.149.8.5] (helo=[172.19.57.142])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <marat@slonopotamus.org>)
	id 1QwcSK-0007zC-O0; Thu, 25 Aug 2011 20:07:05 +0400
X-Mailer: Modest 3.90.7
In-Reply-To: <4E54088F.7050700@drmicha.warpmail.net>
Content-ID: <1314288542.8665.4.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180088>

On 08/24/2011 00:07:43 MSD, Michael J Gruber <git@drmicha.warpmail.net> wrote:

> Junio C Hamano venit, vidit, dixit 23.08.2011 19:15:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> > 
> > > Marat Radchenko venit, vidit, dixit 23.08.2011 12:52:
> > > > > Is that a very large tree or a very slow file system?
> > > > Tree is large (500k files), file system is irrelevant since all
> > > > time is spend on CPU.
> > > > 
> > > > > Do we enumerate all
> > > > > differing files and only then limit diff output by path??
> > > > 
> > > > Dunno, that's why I am asking why it is so slow.
> > > 
> > > Well, we have to read the full tree before diffing.
> > 
> > Not necessarily, especially when pathspec is given like the original
> > post, i.e. "git diff $tree_ish -- $path". We would need to open tree
> > objects that lead to the leaf of the $path and a blob, but other
> > objects won't be needed.
> 
> I meant: The way "git diff" is now, it does that.
> 
> > 
> > The default diff backend tries to come up with minimal changes by
> > spending extra cycles, so it is not so surprising if the file compared
> > is large-ish and/or has very many similar lines in itself (in which
> > case there are many potential matching line pairs between the preimage
> > and the postimage to be examined to produce a minimal diff).
> 
> But the file in this case is not that large, and "git diff" spends 30s!

So, is some more info required from me or gprof output given in initial report + following discussion are enough to conclude what code needs to be improved?
