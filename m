From: Chris Mason <mason@suse.com>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 16:52:57 -0400
Message-ID: <200506261652.59373.mason@suse.com>
References: <20050624.212009.92584730.davem@davemloft.net> <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org> <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 22:46:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dme1V-0001H0-Lx
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 22:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFZUxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 16:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFZUxL
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 16:53:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:19154 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261453AbVFZUxH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 16:53:07 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0291B19A7F;
	Sun, 26 Jun 2005 22:53:07 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 26 June 2005 12:41, Linus Torvalds wrote:
> On Fri, 24 Jun 2005, Linus Torvalds wrote:
> > yeah, it clearly needs some refining to be useful, but I think you can
> > kind of see how it would work.
>
> Ok, here's how it works.
>
>  - Pick a starting commit (or a hundred)
>
>  - Pick an ending commit (or a hundred)
>
>  - generate the list of objects in between them
>
> 	git-rev-list --object end ^start > object-list
>
>  - Pack that list of objects into an "object pack":
>
> 	git-pack-objects out < object-list

Without having read the code, the big thing that hurt performance in my early 
packed file work was compressing the whole packed file instead of individual 
sub-objects.  It takes more room to compress each object, but when I 
compressed the whole thing read performance was quite bad.

-chris
