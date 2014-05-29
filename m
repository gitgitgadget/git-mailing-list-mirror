From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Git chokes on large file
Date: Thu, 29 May 2014 15:12:02 -0400
Message-ID: <201405291912.s4TJC2Wr028094@hobgoblin.ariadne.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com> <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com> <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
 <201405281847.s4SIlW5K027160@hobgoblin.ariadne.com> <alpine.DEB.2.02.1405281200570.32611@nftneq.ynat.uz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 21:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq5kH-0001xd-HD
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 21:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbaE2TMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 15:12:06 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:34632
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932078AbaE2TME (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2014 15:12:04 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id 7ud31o00416LCl05FvC30H; Thu, 29 May 2014 19:12:03 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id 7vC31o0091KKtkw3SvC3mj; Thu, 29 May 2014 19:12:03 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s4TJC213028095
	for <git@vger.kernel.org>; Thu, 29 May 2014 15:12:02 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s4TJC2Wr028094;
	Thu, 29 May 2014 15:12:02 -0400
In-reply-to: <alpine.DEB.2.02.1405281200570.32611@nftneq.ynat.uz>
	(david@lang.hm)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401390723;
	bh=BOnx1QIUcCpHgi45fOGRZ6+HClBYQo3SJ1RryP5Wwy8=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=S+hgV075UvW5NED3h+dDOfY1e1oH7buHVzamGkigaJu1MSemvlvvjxMLRo2phzq8U
	 9yBdAmmRoHQwOpHkoanqL0nzW7oCiPZ0+dS+yAXy+dtZUrNT0T6trCsOoQUCXnlpg+
	 uFmszvpvWloyKH6I/3AqPFzLqAd157BGGNYjWeu1voe2hpauH8fhBcbLBMTTtp6T//
	 IDxc9YskdtK6G8sId8ZP1nJDv/L3NqooxsivMVi5BfsiJzi6OIxTRr9Ac0dxAzf/NC
	 wyXL8Yl/Rby0ZkXuIEiAmXEoWD3eRuaZ8B6eQZ8teMJ+4NF9CcvQMYsVLyoFCa2La3
	 fdgGsykSXE/7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250401>

> From: David Lang <david@lang.hm>

> well, as others noted, the problem is actually caused by doing the diffs, and 
> that is something that is a very common thing to do with source code.

To some degree, my attitude comes from When I Was A Boy, when you got
16k for both your bytecode and your data, so you never kept more than
one line of a file in memory unless you had to.

Regardless of that, the problem with "git fsck" is not due to doing
diffs, and "git commit" by default does diffs even if you don't ask
for them, so the observed problems cannot be subsumed under the label
"you asked for a diff of a file that can't be diffed".

> And I would assume that files of several MB would be able to fit in
> memory (again, this was assumed to be for development, and compilers
> take a lot of ram to run, so having enough ram to hold any
> individual source file while the compiler is _not_ using ram doesn't
> seem likely to be a problem)

At least the first versions of GCC only kept one function (and the
global symbol table) in memory at once, so you could compile a source
file that was larger than the available memory.

In any case, if Git is no longer limited to handling source files, it
needs to be updated so it can handle large files.

Dale
