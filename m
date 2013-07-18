From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 19:29:25 -0400
Message-ID: <201307182329.r6INTP7A022917@freeze.ariadne.com>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	<878v16kfqy.fsf@linux-k42r.v.cablecom.net>
	<7v38rd6l3j.fsf@alter.siamese.dyndns.org> <51E7E05E.4000201@gmail.com>
	<7v4nbr4v7m.fsf@alter.siamese.dyndns.org>
	<201307182032.r6IKWtWC016218@freeze.ariadne.com>
	<CAPc5daVVDCHqjyDV3zYVV33EFYjea7ge84+CE=M=QXagxnHd-A@mail.gmail.com>
	<201307182246.r6IMkDiW021930@freeze.ariadne.com> <7vhafr1mhy.fsf@alter.siamese.dyndns.org>
Cc: n1xim.email@gmail.com, trast@inf.ethz.ch, git@vger.kernel.org,
	fonseca@diku.dk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 01:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzxdd-0007bn-J2
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934499Ab3GRX33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 19:29:29 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:46967
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933481Ab3GRX33 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 19:29:29 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id 1nYp1m0030vyq2s58zVULu; Thu, 18 Jul 2013 23:29:28 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id 1zVT1m00Y1KKtkw3RzVTzo; Thu, 18 Jul 2013 23:29:28 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r6INTQN2022918;
	Thu, 18 Jul 2013 19:29:26 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r6INTP7A022917;
	Thu, 18 Jul 2013 19:29:25 -0400
In-reply-to: <7vhafr1mhy.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1374190168;
	bh=6oxfM4D5rHnXs1vV2hOrPheKo3PhgGDilCp/WqxEBmI=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=kT/Cz/yZxkOpHTnrx5q7UdA5xo5EhwbfhA1jK542x0amKaTzM1i37U+c9waoSs+SX
	 hsK9ReoSZYa+ko285X3/ftcgNxEVDwriFh1zYGOVAlaIqPOwHXBbL5SONUcwFv2ZY2
	 6RlRPbmXzIYk25OJlgB2kcjzSq9czzLb54bUct0auutC1Q0BxS9xVJqkDeMWvLSqKS
	 E8o5fI1MV3NFs9T7iRfNZt5k3022e3XPLUv7xpIxw+ygjoE0kPphM/Wvcr8LzMd0bY
	 yxfx9TU7++GRiomUJ9llH4ZkdQ/ugAA9DOtzkkKi5R3fKqPFdALri11VLyQHEnvf8O
	 J5c4/KD0NC1eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230765>

> From: Junio C Hamano <gitster@pobox.com>

> > +test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
> > +	git init &&
> > +	echo Test. >test-file &&
> > +	git add test-file &&
> > +	git commit -m Message. <&-
> > +'
> > +
> 
> Yup.  I wonder how it would fail without the fix, though ;-)

Eh, what?  You could run it and see.  The test script system will just
say "not ok" for this test.  If you execute those commands from a
shell, you see:

 $ git init
Initialized empty Git repository in /common/not-replicated/worley/temp/1/.git/
 $ echo Test. >test-file
 $ git add test-file
 $ git commit -m Message. <&-
error: unable to create temporary sha1 filename : No such file or directory

error: Error building trees
 $ 

Dale
