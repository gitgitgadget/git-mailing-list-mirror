From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Thu, 28 Jan 2010 18:37:01 -0800
Message-ID: <20100129023701.GE20488@spearce.org>
References: <20100129012350.GD20488@spearce.org> <alpine.LFD.2.00.1001282125410.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 03:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NagjP-0008Qx-R6
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 03:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0A2ChG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 21:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182Ab0A2ChG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 21:37:06 -0500
Received: from mail-iw0-f172.google.com ([209.85.223.172]:53268 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab0A2ChF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 21:37:05 -0500
Received: by iwn2 with SMTP id 2so807633iwn.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 18:37:04 -0800 (PST)
Received: by 10.231.169.71 with SMTP id x7mr355981iby.18.1264732624351;
        Thu, 28 Jan 2010 18:37:04 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1488552iwn.11.2010.01.28.18.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 18:37:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001282125410.1681@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138296>

Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 28 Jan 2010, Shawn O. Pearce wrote:
> 
> > If a blob is larger than the configured big-file-threshold, instead
> > of reading it into a single buffer obtained from malloc, stream it
> > onto the end of the current pack file.  Streaming the larger objects
> > into the pack avoids the 4+ GiB memory footprint that occurs when
> > fast-import is processing 2+ GiB blobs.
> 
> Yeah.  I've had that item on my todo list for ages now.  This 
> big-file-threshold principle has to be applied to 'git add' too so a big 
> blob is stored in pack file form right away, and used to bypass delta 
> searching in 'git pack-objects', used to skip the diff machinery, and so 
> on.

Yea, there are a lot of places we should improve for bigger files.
gfi just happened to be the first one I got a bug report on from
a user...

-- 
Shawn.
