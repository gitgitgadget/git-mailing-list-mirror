From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: git pull issues...
Date: Sat, 23 Apr 2005 20:39:17 -0400
Message-ID: <118833cc05042317391a441448@mail.gmail.com>
References: <118833cc050423142573729ce2@mail.gmail.com>
	 <20050423220049.GC13222@pasky.ji.cz>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:35:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPV50-0000Km-MY
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVDXAjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVDXAjU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:39:20 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:1693 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262204AbVDXAjR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 20:39:17 -0400
Received: by rproxy.gmail.com with SMTP id a41so728585rng
        for <git@vger.kernel.org>; Sat, 23 Apr 2005 17:39:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z9Dum0dV9KIvQf3HJ/aVGY8Mje2wAy+Zr9MXQnzVP21M6CimXCMq2ZLWtd362LUjUfHDJoJzT678x0N8llRJsWNrAd4fYCsW772rIUX/aYiSzA+CM/ZzxyBLRBnbIskNkin4tm0tbznsL4zLny2ctPa3qVBwuGEHE14wnJtX9yc=
Received: by 10.38.74.21 with SMTP id w21mr5042762rna;
        Sat, 23 Apr 2005 17:39:17 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sat, 23 Apr 2005 17:39:17 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050423220049.GC13222@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > 1. Multiple rsync call might connect to different servers (with
> > round-robin DNS).  The effect
> >    will be interesting.  One call, if possible, would be better.
> 
> If you can do it without overwriting HEAD, please go ahead and send me
> the patch. :-)

I'll have a go at it later, but something like this ought to work:

-d .rsync-git && die "previous pull failed -- cleanup"
mkdir .rsync-git || die "cannot create .rsync-git"
ln -s ../.git/objects .rsync-git/objects || die "cannot create symlink"
rsync ... --keep-dirlinks ...
...

Morten
