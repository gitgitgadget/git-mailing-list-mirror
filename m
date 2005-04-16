From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 15:24:50 -0700
Message-ID: <12c511ca050416152452a4c620@mail.gmail.com>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:21:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvf6-0006pj-NP
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDPWYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVDPWYw
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:24:52 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:49039 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261159AbVDPWYv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:24:51 -0400
Received: by zproxy.gmail.com with SMTP id 13so647418nzp
        for <git@vger.kernel.org>; Sat, 16 Apr 2005 15:24:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b70j6lEKKSjtRRVrqKjyBkjnyWZYUyRaqOil31uMI6/47gYX7LXS0HbXRZsVZBJFtHrGF+DkZwqRruaA2IpipwrL8tEzRjJQEd8wtZXrBIfFxpecvYbO+A8k2COT2U+Ra9/gEdVKVBUuhFBsY4GJWcwcROOLRazmywkzvjJplkc=
Received: by 10.36.67.3 with SMTP id p3mr272983nza;
        Sat, 16 Apr 2005 15:24:50 -0700 (PDT)
Received: by 10.36.60.3 with HTTP; Sat, 16 Apr 2005 15:24:50 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/16/05, Daniel Barkalow <barkalow@iabervon.org> wrote:
> +        buffer = read_sha1_file(sha1, type, &size);

You never free this buffer.

It would also be nice if you saved "tree" objects in some temporary file
and did not install them until after you had fetched all the blobs and
trees that this tree references.  Then if your connection is interrupted
you can just restart it.

Otherwise this looks really nice.  I was going to script something
similar using "wget" ... but that would have made zillions of seperate
connections.  Not so kind to the server.

-Tony
