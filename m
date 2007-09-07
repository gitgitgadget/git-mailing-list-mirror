From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Fri, 7 Sep 2007 00:48:41 -0400
Message-ID: <20070907044841.GX18160@spearce.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709061651550.28586@racer.site> <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 06:49:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVmB-00029q-7Q
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXIGEs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXIGEs6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:48:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58028 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbXIGEs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:48:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ITVlr-0001Rs-VD; Fri, 07 Sep 2007 00:48:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4174820FBAE; Fri,  7 Sep 2007 00:48:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57975>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 5 Sep 2007, Junio C Hamano wrote:
> >>  static int aggressive_window = -1;
> >> +static int gc_auto_threshold = 6700;
> >
> > Please don't do that.
> >
> > When you share objects with another git directory, git-gc --auto can get 
> > rid of the objects when some objects go away in the referenced repository.  
> 
> I thought the whole point of "gc --auto" was to have something
> that does not lose/prune any objects, even the ones that do not
> seem to be referenced from anywhere.  That is why invocations of
> "git gc --auto" do not say --prune as you saw the second patch,
> and the repack command "gc --auto" runs is "repack -d -l"
> instead of "repack -a -d -l", which means that it does run
> git-prune-packed after repacking but not git-prune.
> 
> Maybe I am missing something...

No, you aren't Junio.  `gc --auto` as you defined it is safe.
It won't delete objects from the database.  So it won't impact shared
repositories, or readers that are actively running in parallel with
the gc.  Both of which are important.

-- 
Shawn.
