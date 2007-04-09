From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Sun, 08 Apr 2007 20:18:23 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
References: <46197950.3080804@gmail.com>
 <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 02:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HahaW-0002LA-53
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 02:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbXDIASZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 20:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbXDIASZ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 20:18:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47273 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbXDIASY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 20:18:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG7008QUFINQKQ3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Apr 2007 20:18:23 -0400 (EDT)
In-reply-to: <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44023>

On Sun, 8 Apr 2007, Junio C Hamano wrote:

> Dana How <danahow@gmail.com> writes:
> 
> > +/*
> > + * Move this, the version in fast-import.c,
> > + * and index_pack.c:readjust_pack_header_and_sha1 into sha1_file.c ?
> > + */
> > +static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
> > +				char *pack_name, uint32_t object_count)
> > +{
> 
> Indeed that is a very good point.
> 
> I admit I did not notice we already had the duplication between
> fast-import.c and index-pack.c
> 
> Shawn, Nico, what do you think?  Wouldn't it be better to
> refactor them first, independent of Dana's series?

Probably, yes.  But probably not in sha1_file.c though.  This file is 
getting a bit large already, and it deals with pack reading only not 
pack writing.

I think another file with common pack writing functions could be 
created.  Pack index writing is another item that is currently 
duplicated in pack-objects and index-pack for example.


Nicolas
