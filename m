From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Sat, 10 Mar 2012 03:48:03 -0600
Message-ID: <20120310094803.GA1969@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
 <CA+gfSn8bh-tV+uduM7xsuwqXQW2a57yvVmRXjXjp9JaO779bUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 10:48:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6IuP-0007gV-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 10:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab2CJJsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 04:48:13 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65108 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab2CJJsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 04:48:11 -0500
Received: by iagz16 with SMTP id z16so3595853iag.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5rMVHhfCj9YZXfcxXHQoolbcmpefUpRBW7CHdN2VF24=;
        b=PasHAfiT0Fze34mmgnWEEvDnwu6Sso9N+qc5AcFotB3IBHGr08dnTnA9jkGw+5EHeX
         +uTsWLkrJ+AgTz87dumwmU5C76INLiDdwZoDGn6EXF7K2Rw1IcG4J2o/DGMFGf0bsusD
         GGJGfHxweUnQI15t7K1ZD/xf+W7hC7URwUJJvbdLO1uL1OTG9pCj8ypLYLhwGgtL4ADa
         CmGdTbF/iJG902cbp/4Exf6FZtq4OgbCcYksUrh3ckwoE7dDh811MuPbe6J0VfdxV5i8
         Nuf8sLzEwYvIqlbIQltgaHoNpx8jepNPfSGzNLfPJdPoFWuLokqX9HGNV2487XBN5Noi
         AWWw==
Received: by 10.42.174.71 with SMTP id u7mr6931700icz.44.1331372890958;
        Sat, 10 Mar 2012 01:48:10 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ub10sm3578045igb.7.2012.03.10.01.48.09
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 01:48:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+gfSn8bh-tV+uduM7xsuwqXQW2a57yvVmRXjXjp9JaO779bUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192777>

Jonathan Nieder wrote:
> Dmitry Ivankov wrote:

>>  One more quick thought. "force the root mode to S_IFDIR" part doesn't
>>  look obviously good for me. First, isn't it already ensured that the
>>  root is a directory?
[...]
> It was just a problematic and incomplete version of what your "be
> saner with temporary trees" does properly. 

To tie up this loose end: looks like David's patch was ok in this
respect and my worries unfounded.  What I was missing is that
store_tree() does nothing unless its tree argument is dirty, and the
temporary tree used to repesent <treeish> in "ls <treeish> <path>" is
never dirty.

Of course, the reminder of the "be saner" patch and the tree delta
discussion was still very useful.

Thanks for your thoughtfulness.
Jonathan
