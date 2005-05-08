From: James Purser <purserj@ksit.dynalias.com>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 08 May 2005 21:20:04 +1000
Message-ID: <1115551204.3085.0.camel@kryten>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
	 <427DE086.40307@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 13:13:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUjhn-0006TD-8W
	for gcvg-git@gmane.org; Sun, 08 May 2005 13:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVEHLTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 07:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVEHLTM
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 07:19:12 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:23943 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262844AbVEHLS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 07:18:59 -0400
Received: from localhost.localdomain (kryten [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j48BK9BB019953;
	Sun, 8 May 2005 21:20:10 +1000
Received: (from purserj@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j48BK467019952;
	Sun, 8 May 2005 21:20:04 +1000
X-Authentication-Warning: localhost.localdomain: purserj set sender to purserj@ksit.dynalias.com using -f
To: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <427DE086.40307@tls.msk.ru>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-08 at 19:48, Michael Tokarev wrote:
> Thomas Glanzmann wrote:
> > [PATCH] Really *do* nothing in while loop
> > 
> > Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> > 
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -335,7 +335,7 @@
> >  	stream.next_in = hdr;
> >  	stream.avail_in = hdrlen;
> >  	while (deflate(&stream, 0) == Z_OK)
> > -		/* nothing */
> > +		/* nothing */;
> >  
> >  	/* Then the data itself.. */
> >  	stream.next_in = buf;
> 
> Well, the lack of semicolon is wrong really (and funny).
> 
> But is the whole while loop needed at all?  deflate()
> consumes as much input as it can, producing as much output
> as it can.  So without the loop, and without updating the
> buffer pointers ({next,avail}_{in,out}) it will do just
> fine without the loop, and will return something != Z_OK
> on next iteration.  If this is to mean to flush output,
> it should be deflate(&stream, Z_FLUSH) or something.
> 
> /mjt
> 
> P.S.  What's git@vger.kernel.org for ?
Its the mailing list for git development.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
James Purser
http://ksit.dynalias.com

