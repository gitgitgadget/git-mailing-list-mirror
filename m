From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: dangling blob which is not dangling at all
Date: Wed, 1 Aug 2007 08:32:09 +0200
Message-ID: <20070801063209.GA13511@raptus.dandreoli.com>
References: <20070801013450.GA16498@raptus.dandreoli.com> <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 08:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG7kn-0004mQ-TY
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 08:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbXHAGcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 02:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbXHAGcO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 02:32:14 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:44215 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbXHAGcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 02:32:13 -0400
Received: by mu-out-0910.google.com with SMTP id i10so155898mue
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 23:32:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SsC1BouVw/CYtQDpHmtcYccNSnpCyqeyixHUABrimeradIGU7Nv38OdxcQ756g8YV8RgXcMIztZh43BLGjU2gC9r0XKXFkJjC3gRmds+2uMWuVvN0xbrCG0hYgCDJDnv1N8QIXF03/UK2jnYaWGkQPofJb/5Osg5IVTS90qycPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=U9Flg+J/w6QZAAwQzCkReSEMuowVNo7/iZjlxdFfuA9Gm6QBbICmGrcPM1guAQz6SrVWNsiaxmxu5WGclJ+LOCDPWWHJYXNsv3vNI/SvX7f9TMUSSlIccoHzTs4sLRwW0yX7uJHkDt3Nbwyksgtx9/JwWTs1sP0Eq4xHg1bvhfg=
Received: by 10.86.100.7 with SMTP id x7mr288200fgb.1185949928633;
        Tue, 31 Jul 2007 23:32:08 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id e32sm737388fke.2007.07.31.23.32.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 23:32:07 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id E5FCE28C8A6; Wed,  1 Aug 2007 08:32:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54412>

On Tue, Jul 31, 2007 at 07:22:14PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 1 Aug 2007, Domenico Andreoli wrote:
> > 
> > $ git fsck --no-reflogs
> > dangling blob e5d444e61b834c34710ce8fb5cb176e20e5894e1
> >
> > $ git-ls-tree 70b58535361eb633d44d4f1275af3421ca6a5ed7
> > ...
> > 100644 blob e5d444e61b834c34710ce8fb5cb176e20e5894e1    link_stream.c
> 
> Have you done clones with stupid protocols (rsync and/or http)?

I do not remember having used any dump transport on this repository but
I recall having tried git-repack with the intent of git gc.

> So try "git fsck --full", and see if that changes the picture.

This did not change anything.

> The easiest fixup is likely to just do "git gc", which which do a nice 
> repack, and get rid of loose objects that are duplicates of stuff 
> that is also in a pack-file.

This fixed things and also warned about two heads referring to pruned
commits, which may be those two commits I removed by hand (I hope).

Cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
