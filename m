From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
	that are corrupted in a pack file
Date: Wed, 7 Jan 2009 22:04:13 -0800
Message-ID: <20090108060413.GA17728@spearce.org>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain> <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com> <20090108024325.GE10790@spearce.org> <7v4p0a8if2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>, kb@slide.com,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 07:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKo1m-0007mN-P9
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 07:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZAHGEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 01:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbZAHGEP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 01:04:15 -0500
Received: from george.spearce.org ([209.20.77.23]:40936 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZAHGEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 01:04:14 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id AEB6038210; Thu,  8 Jan 2009 06:04:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v4p0a8if2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > For those following along at home, Linus' 2.6 tree:
> >
> > $ ulimit -v `echo '150 * 1024'|bc -l`
> > $ git co 56d18e9932ebf4e8eca42d2ce509450e6c9c1666
> 
> Hmm, without any "wrap zlib to die on error" patch, this step already
> fails with:
> 
>     $ git checkout 56d18e9932ebf4e8eca42d2ce509450e6c9c1666
>     fatal: Out of memory? mmap failed: Cannot allocate memory
> 
> I guess that is because our test repositories are packed differently.
> I'll retry after repacking..

Yup.  I actually did something more like this to get the test
repository:

  git clone git://android.git.kernel.org/kernel/common.git
  git fetch git://kernel.org/pub/.../torvalds/linux-2.6.git master

The android kernel repository I had handy on my local system was
quite a bit away from Linus' so I wound up with two different but
sizable packs.  I thought android was closer to upstream, but its
apparently not.  I started from there because it was local and I
thought it would be a quick way to get a test environment, but
sadly it didn't even have the base 56d18e we were talking about.

-- 
Shawn.
