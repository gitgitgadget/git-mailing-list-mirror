From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 09:35:53 -0400
Message-ID: <118833cc0504200635408b5dd@mail.gmail.com>
References: <200504191250.10286.mason@suse.com>
	 <200504191708.23536.mason@suse.com>
	 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
	 <200504192049.21947.mason@suse.com>
	 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
	 <42660708.60109@zytor.com>
	 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
	 <2cfc403205042005116484231c@mail.gmail.com>
	 <20050420132446.GA10126@macavity>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 20 15:32:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOFIw-0003tq-Fo
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 15:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVDTNf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 09:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDTNf7
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 09:35:59 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:41439 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261618AbVDTNfx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 09:35:53 -0400
Received: by rproxy.gmail.com with SMTP id a41so107297rng
        for <git@vger.kernel.org>; Wed, 20 Apr 2005 06:35:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXPF4Np+51gTaykBB2anhiFUgsr/O6Y6pDwYYF4WwLaAXj0Prieh9s5lDDzeyzTCnUUh4odStHeJGKcle5zfZrBByM+SYpHPYF7DFYDk8/AlK4lUfAQmzmmejUGA3GiPmsI+1gTk8bLPjgXbLRKvImtF7yeCStsQYECSgZC8NyI=
Received: by 10.38.6.75 with SMTP id 75mr536458rnf;
        Wed, 20 Apr 2005 06:35:53 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Wed, 20 Apr 2005 06:35:53 -0700 (PDT)
To: Martin Uecker <muecker@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050420132446.GA10126@macavity>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/20/05, Martin Uecker <muecker@gmx.de> wrote:

> The storage method of the database of a collection of
> files in the underlying file system. Because of the
> random nature of the hashes this leads to a horrible
> amount of seeking for all operations which walk the
> logical structure of some tree stored in the database.
> 
> Why not store all objects linearized in one or more
> flat file?

I've been thinking along the same lines and it doesn't look too hard
to factor out the
"back end", i.e., provide methods to
read/write/stat/remove/mmap/whatever objects.
(Note the mmap there.  Apart from that, the backend could be an http connection
or worse.)

It will, however, seriously break rsync as transport for people who
commit to their trees.
Thus you need an alternative in place before you can present it as an
alternative.

Morten
