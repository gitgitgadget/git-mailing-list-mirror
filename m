From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 11:45:44 -0700 (PDT)
Message-ID: <m3fxbpneqe.fsf@localhost.localdomain>
References: <1250509342.2885.13.camel@cf-48>
	<alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
	<vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48>
	<alpine.LFD.2.00.0908181246470.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 20:45:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdTgw-0008Gu-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 20:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbZHRSpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 14:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbZHRSpq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 14:45:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:30350 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZHRSpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 14:45:45 -0400
Received: by ey-out-2122.google.com with SMTP id 22so818111eye.37
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Qh7BJF2hLqwXs5y+il0wT62NIkFkkA7vXHWxWQTOj/c=;
        b=QZ3eFxNYnYZuvUjtZdw8dXqt2DkyshROKIoTIeB7fiySwIbyWFSWSu2FHJ+UQmhE2l
         70XU++ItFaZ8TcT5g+rZBPLcf1ZP1bgFFme926tkGhdhk0COVYs6TcsPHW8uoq5wIhS7
         p8AjXkGaLBVapdMc6MI+tXxlAiZZ4THegBjcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BVXBxu6CSJUCM6ZaKqaDQTFALn7U7/hPPvBTY8mx6hk9llLXeX2TmAEkcOl+g9uu17
         VCJEmOT+uz9xq/lHVSsj2izsqxCSjy0NgyJJpsAUmnx/ZMVmhj/NgN2JYuWscjol4x6D
         gwYhSBKPzbjfSr5jgXHeFdf8HlpAwkyF1d6SI=
Received: by 10.210.138.19 with SMTP id l19mr8638330ebd.74.1250621145698;
        Tue, 18 Aug 2009 11:45:45 -0700 (PDT)
Received: from localhost.localdomain (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id 28sm721587eye.15.2009.08.18.11.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 11:45:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7IIjI8A027573;
	Tue, 18 Aug 2009 20:45:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7IIiwFb027568;
	Tue, 18 Aug 2009 20:44:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.0908181246470.6044@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126437>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 18 Aug 2009, Tomasz Kontusz wrote:
> 
> > Ok, so it looks like it's not implementable without some kind of cache
> > server-side, so the server would know what the pack it was sending
> > looked like.
> > But here's my idea: make server send objects in different order (the
> > newest commit + whatever it points to first, then next one,then
> > another...). Then it would be possible to look at what we got, tell
> > server we have nothing, and want [the newest commit that was not
> > complete]. I know the reason why it is sorted the way it is, but I think
> > that the way data is stored after clone is clients problem, so the
> > client should reorganize packs the way it wants.
> 
> That won't buy you much.  You should realize that a pack is made of:
> 
> 1) Commit objects.  Yes they're all put together at the front of the pack,
>    but they roughly are the equivalent of:
> 
> 	git log --pretty=raw | gzip | wc -c
> 
>    For the Linux repo as of now that is around 32 MB.

For my clone of Git repository this gives 3.8 MB
 
> 2) Tree and blob objects.  Those are the bulk of the content for the top 
>    commit.  The top commit is usually not delta compressed because we 
>    want fast access to the top commit, and that is used as the base for 
>    further delta compression for older commits.  So the very first 
>    commit is whole at the front of the pack right after the commit 
>    objects.  you can estimate the size of this data with:
> 
> 	git archive --format=tar HEAD | gzip | wc -c
> 
>    On the same Linux repo this is currently 75 MB.

On the same Git repository this gives 2.5 MB

> 
> 3) Delta objects.  Those are making the rest of the pack, plus a couple 
>    tree/blob objects that were not found in the top commit and are 
>    different enough from any object in that top commit not to be 
>    represented as deltas.  Still, the majority of objects for all the 
>    remaining commits are delta objects.

You forgot that delta chains are bound by pack.depth limit, which
defaults to 50.  You would have then additional full objects.

The single packfile for this (just gc'ed) Git repository is 37 MB.
Much more than 3.8 MB + 2.5 MB = 6.3 MB.

[cut]

There is another way which we can go to implement resumable clone.
Let's git first try to clone whole repository (single pack; BTW what
happens if this pack is larger than file size limit for given
filesystem?).  If it fails, client ask first for first half of of
repository (half as in bisect, but it is server that has to calculate
it).  If it downloads, it will ask server for the rest of repository.
If it fails, it would reduce size in half again, and ask about 1/4 of
repository in packfile first.

The only extension required is for server to support additional
capability, which enable for client to ask for appropriate 1/2^n part
of repository (approximately), or 1/2^n between have and want.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
