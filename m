From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Fri, 26 Jun 2009 14:44:52 +0100
Message-ID: <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
	 <4A445959.6090403@op5.se>
	 <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
	 <4A44A9A9.6030008@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKBjj-0005HT-Kk
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 15:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbZFZNow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 09:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757157AbZFZNow
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 09:44:52 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:47721 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZFZNov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 09:44:51 -0400
Received: by ewy6 with SMTP id 6so3346056ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8h2ojlfj7klvZQeSvVtT6Yg/cgoYsgCpoVF1TSEuYFw=;
        b=iuFvAOQHxn83kRmHLWaV7HGERgCrkr9FaBYZa82qL9vXZy41zoQT1rvPXMimwvy7PC
         pDy7udRcxtIfsXXhzc5u6ersaPGTU7+DS5VDf8P1tDUNQOaq48D4PGZYVrZI9hsxXhjt
         RsIf1AmMASaOOdCgD83C+RfyeBg8O3zmmCNWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=usZaGxxcl0KMAC+F3upM/nxDEujBGsatkMI412Mf+BKCgvyXYsXy9xpcgo+DvSOY5j
         HDoI/DSnJ7v53YrMCD+FXIUZaRTOmHneXO4642W9SHw+760Sw3SBp4DyMC7UB/9ZpUeH
         pHamBmYvd/lC4Es1QU6Xohp7OdVuAsFlCCwtU=
Received: by 10.216.73.193 with SMTP id v43mr1180920wed.157.1246023892413; 
	Fri, 26 Jun 2009 06:44:52 -0700 (PDT)
In-Reply-To: <4A44A9A9.6030008@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122299>

On Fri, Jun 26, 2009 at 11:57 AM, Andreas Ericsson<ae@op5.se> wrote:
>>> Hin-Tak Leung wrote:
>>>>
>>>> (I'm not on list so please CC)

> Hmm. I've cloned many subversion repositories to git, and I've never
> seen the issues you're seeing. Perhaps because I always cloned the
> entire repository the first time, or because I normally do such things
> over a high-capacity connection, or because I just fire it up and
> forget about it until it's done.

It is not about the capacity/throughput of the connection, but the
latency (round-trip time) of many small transactions - and most of the
unnecessary...

> What happens if you ignore the already-cloned svn tree and just do
> a new import without trying to continue the old one? Not that I'll
> actually do anything about it, as I don't have any problems with it,
> but I'm curious even so ;-)

I did wonder about that - and so I just stopped my branch-tracking
fetch and start all over with svn init -T -t and -b then svn fetch
--all. The first few hundred revisions are very promising: it is
populating the git refs for tag and branch heads
as it goes up.

There are tutorials online about modifying git/config like I did to
adding branches, etc... maybe the example section of git-svn can be
updated with a couple of sentence on 'just throw it away and start
from the beginning if you change your mind from trunk-only to
complex-layout' .

OTOH, I think I would have liked to preserve the compressed object
store, and I think it is possible to graft an object store on an empty
init? The advantage is just that the disc space usage does not widely
fluctuate & no gc steps in the middle.

Thanks for the response anyhow - I just need to remember to blow
trunk-only away and start over next time I change my mind:-).
