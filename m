From: Sam Vilain <sam@vilain.net>
Subject: Re: Continue git clone after interruption
Date: Sat, 22 Aug 2009 17:50:59 +1200
Message-ID: <1250920259.3644.11.camel@maia.lan>
References: <1250509342.2885.13.camel@cf-48>
	 <200908200937.05412.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
	 <200908211207.38555.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
	 <1250896025.19039.7.camel@maia.lan>
	 <alpine.LFD.2.00.0908212324130.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 07:48:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MejSj-00011y-8R
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 07:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbZHVFsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 01:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbZHVFsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 01:48:16 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34296 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618AbZHVFsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 01:48:16 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 496F221C58B; Sat, 22 Aug 2009 17:48:14 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 376A721C58B;
	Sat, 22 Aug 2009 17:48:10 +1200 (NZST)
In-Reply-To: <alpine.LFD.2.00.0908212324130.6044@xanadu.home>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126796>

On Fri, 2009-08-21 at 23:37 -0400, Nicolas Pitre wrote:
> What did you think about the bundle slicing stuff?
> 
> If I didn't comment on it already, then I probably missed it and have no 
> idea.

I really tire of repeating myself for your sole benefit.  Please show
some consideration for other people in the conversation by trying to
listen.  Thank-you.

> > I think the first step here would be to allow thin pack generation to
> > accept a bounded range of commits, any of the objects within which may
> > be used as delta base candidates.  That way, these "top down" thin packs
> > can be generated.  Currently of course it just uses the --not and makes
> > "bottom up" thin packs.
> 
> The pack is still almost top-down.  It's only the missing delta base 
> that are in the other direction, refering to objects you have locally 
> and therefore older.

Ok, but right now there's no way to specify that you want a thin pack,
where the allowable base objects are *newer* than the commit range you
wish to include.

What I said in my other e-mail where I showed how well it works taking
a given bundle, and slicing it into a series of thin packs, was that it
seems to add a bit of extra size to the resultant packs - best I got for
slicing up the entire git.git run was about 20%.  If this can be
reduced to under 10% (say), then sending bundle slices would be quite
reasonable by default for the benefit of making large fetches
restartable, or even spreadable across multiple mirrors.

The object sorting stuff is something of a distraction; it's required
for download spreading but not for the case at hand now.

Sam
