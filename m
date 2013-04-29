From: John Keeping <john@keeping.me.uk>
Subject: Re: "git grep" parallelism question
Date: Mon, 29 Apr 2013 19:08:57 +0100
Message-ID: <20130429180857.GK472@serenity.lan>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
 <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
 <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
 <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
 <20130429161814.GJ472@serenity.lan>
 <877gjldxid.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsVm-0001HM-K6
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab3D2SJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:09:09 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:53603 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab3D2SJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:09:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 17C91606505;
	Mon, 29 Apr 2013 19:09:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Bc3RfvLc-jo; Mon, 29 Apr 2013 19:09:07 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 10E4960657C;
	Mon, 29 Apr 2013 19:08:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <877gjldxid.fsf@hexa.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222833>

On Mon, Apr 29, 2013 at 08:04:10PM +0200, Thomas Rast wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Mon, Apr 29, 2013 at 07:35:01PM +0530, Ramkumar Ramachandra wrote:
> >> On a related note, one place that IO parallelism can provide massive
> >> benefits is in executing shell scripts.  Accordingly, I always use the
> >> following commands to compile and test git respectively:
> >> 
> >>     make -j 8 CFLAGS="-g -O0 -Wall"
> >>     make -j 8 DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="-j 16" test
> >> 
> >> i.e. always use 8 threads when the task is known to be CPU intensive,
> >> and always use 16 threads when the task is known to be IO intensive.
> >
> > On this tangent, I recently added a TEST_OUTPUT_DIRECTORY line to my
> > config.mak which points into a tmpfs mount.  Keeping all of the test
> > repositories in RAM makes the tests significantly faster for me and
> > works nicely when you have the patches in jk/test-output (without those
> > patches the individual tests work but the reporting of aggregate results
> > doesn't).
> 
> But that's been possible for quite some time now, using --root, or am I
> missing something?

No, I was the one missing something (--root to be precise).  But with
TEST_OUTPUT_DIRECTORY you also get the result files in your temporary
location, not just the trash directory.
