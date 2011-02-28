From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 12:44:06 -0800
Message-ID: <20110228204406.GA26052@spearce.org>
References: <1298924835-23413-1-git-send-email-spearce@spearce.org>
 <20110228203557.GA8189@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Mon Feb 28 21:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu9x1-0005E5-Pl
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335Ab1B1UoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:44:10 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56137 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab1B1UoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 15:44:09 -0500
Received: by iwn34 with SMTP id 34so3453565iwn.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 12:44:09 -0800 (PST)
Received: by 10.42.226.66 with SMTP id iv2mr5601296icb.195.1298925848720;
        Mon, 28 Feb 2011 12:44:08 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id gy41sm2657061ibb.23.2011.02.28.12.44.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 12:44:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110228203557.GA8189@pcpool00.mathematik.uni-freiburg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168140>

"Bernhard R. Link" <brl+ccmadness@pcpool00.mathematik.uni-freiburg.de> wrote:
> * Shawn O. Pearce <spearce@spearce.org> [110228 21:27]:
> > By using a hard upper limit that is below the rlimit of the current
> > process, it is not necessary to check for EMFILE on every single
> > fd-allocating system call.  Instead reserving 8 file descriptors
> > makes it safe to assume the system call won't fail due to being
> > over limit in the filedescriptor limit.
> 
> Isn't 8 quite a bit low for a reserve? Couldn't some libc stuff
> (especially nss modules perhaps activated by something) easily surpass
> that?

Originally I proposed 25 to Junio, but he scoffed and said that
was quite high. So I went with 8, 3 for std{in,out,err} and 5 as
a WAG for everything else.

Its arbitrary, 25 might be a better WAG than 8...

-- 
Shawn.
