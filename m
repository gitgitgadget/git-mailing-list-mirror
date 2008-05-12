From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Mon, 12 May 2008 19:56:54 +0200
Message-ID: <20080512175654.GB3128@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 19:57:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvcHU-0006cj-99
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbYELR47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYELR46
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:56:58 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:29802 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYELR45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:56:57 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo58) (RZmta 16.34)
	with ESMTP id p01d2dk4CH4uCE ; Mon, 12 May 2008 19:56:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 86A27277BD;
	Mon, 12 May 2008 19:56:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5DB8A56D28; Mon, 12 May 2008 19:56:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81887>

Junio C Hamano, Sun, Mar 02, 2008 17:59:13 +0100:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Sun, 2 Mar 2008, Alex Riesen wrote:
> >
> >> -			add_file_to_cache(path, verbose);
> >> +			if (add_file_to_cache(path, verbose))
> >> +				exit(1);
> >
> > Does it really, really _have_ to be exit(1)?  I mean, now you block even 
> > the faintest chance that we can libify libgit.a by overriding die_routine.
> 
> I think Alex did so not to break the existing scripts that rely on these
> dying, but it should have been exit(128) to really stay compatible.

I corrected the series to use die() again and rebased it off current
master (65ea3b8c). So it is more compatible with libification (does
not hinder it more than previos code) and keep the exit code.
