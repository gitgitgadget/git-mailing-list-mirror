From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 01:12:10 -0500
Message-ID: <20071127061210.GP14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com> <20071127014804.GJ14735@spearce.org> <alpine.LFD.0.99999.0711262346410.9605@xanadu.home> <56b7f5510711262159x2e1fd4fdw8e914cb4a22376a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 07:12:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwtgS-00068U-B8
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 07:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXK0GMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 01:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbXK0GMS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 01:12:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52320 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbXK0GMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 01:12:17 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iwtg6-00053I-As; Tue, 27 Nov 2007 01:12:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 84D8B20FBAE; Tue, 27 Nov 2007 01:12:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <56b7f5510711262159x2e1fd4fdw8e914cb4a22376a1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66169>

Dana How <danahow@gmail.com> wrote:
> On Nov 26, 2007 8:58 PM, Nicolas Pitre <nico@cam.org> wrote:
> >
> > It is a bit cumbersome indeed, but I'm afraid we're really stuck with it
> > since every object SHA1 depends on that format.
> 
> Yes,  now I remember: this was the same argument you used to
> convince me that losing the "new" (deprecated) loose format was OK.
> 
> However,  if we changed
> WRITE(DEFLATE(SHA1("$type $size\0$data")))
> (where SHA1(x) = x but has the side-effect of updating the SHA-1)
> to
> WRITE($pack_style_object_header)
> SHA1("$type $size\0")
> WRITE(DEFLATE(SHA1($data)))
> then the SHA-1 result is the same but we get the pack-style header,
> and blobs can be sucked straight into packs when not deltified.
> The SHA-1 result is still usable at the end to rename the temporary
> loose object file
> (and put it in the correct xx subdirectory).

Hah.  That's exactly what the "new" (deprecated) format was, and what
its code for creating such objects looked like in sha1_file.c. :-)
 
-- 
Shawn.
