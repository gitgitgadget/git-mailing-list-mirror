From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 03:05:24 +0200
Message-ID: <85r6n1p7sb.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0707181004330.?= =?ISO-8859-1?Q?=04=0427?=
	=?ISO-8859-1?Q?353@woody.linux-?= =?ISO-8859-1?Q?foundation.org>?=
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
	=?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
	<85tzrxslms.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
	<85644dqoig.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICPtK-0007Ml-NU
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 03:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbXGVBFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 21:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXGVBFc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 21:05:32 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:55429 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622AbXGVBFb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 21:05:31 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id EC3DE24B2C9;
	Sun, 22 Jul 2007 03:05:27 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id C6AA0ABF89;
	Sun, 22 Jul 2007 03:05:26 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id F05B828ABA1;
	Sun, 22 Jul 2007 03:05:25 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DA0691D1E182; Sun, 22 Jul 2007 03:05:24 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 21 Jul 2007 17\:37\:51 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3722/Sun Jul 22 01:57:48 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53208>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Jul 2007, David Kastrup wrote:
>> 
>> I must be really bad at explaining things, or I am losing a fight
>> against preconceptions fixed beyond my imagination.
>
> I really dont' see the point. But hey, code talks. 

Yes, I am working on that.  It would have been nice if IS_DIR was not
already taken by trees, but one can't have everything.  So I need to
decide how to represent the node, and it would appear that I need to
angle for "file" after all.  Since it is really quite closer to a file
or symlink than to a tree or project.  Hm, perhaps a symlink might be
more expedient.  Make it have an empty reference, and it is unique.
And there will be fewer places in the code manipulating symlinks than
files.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
