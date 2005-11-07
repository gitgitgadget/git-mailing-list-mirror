From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Mon, 7 Nov 2005 15:52:41 +1300
Message-ID: <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 07 03:54:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYx7z-0000OL-UB
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 03:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVKGCwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 21:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVKGCwm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 21:52:42 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:34338 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932360AbVKGCwl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 21:52:41 -0500
Received: by xproxy.gmail.com with SMTP id s15so287825wxc
        for <git@vger.kernel.org>; Sun, 06 Nov 2005 18:52:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OchRPJVYDEKWmplrRFVu6f7F/ZgEIPTfnEueKgkcjGFLwm2TRQbYt6rNLZp/nKHMGeZwLPq/w2Yr1vyOcNAg2okZg3ttygOOnmC6u8DH8f0hHZhFasR6LEUGPSO7Jh8/ZYlMT3WmVpMCo89rr/z8ygXL1MJ6hLoFB5RNiPbgl3A=
Received: by 10.64.201.14 with SMTP id y14mr4857237qbf;
        Sun, 06 Nov 2005 18:52:41 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Sun, 6 Nov 2005 18:52:41 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11250>

On 11/7/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Strange!
>
> I'm getting errors when cloning over http

More info on this.

git-fetch-pack (invoked by cg-fetch) bails out because it thinks it
got a 404 fetching one of the packs:

Getting pack 9cbe4a5eb777d4ee535f08feb471e812208ed3a5
 which contains 7004cdf821ab5ddcded7819dea34015b0e84cd9a
error: Unable to get pack file
http://locke.catalyst.net.nz/git/moodle.git//objects/pack/pack-9cbe4a5eb777d4ee535f08feb471e812208ed3a5.pack
The requested URL returned error: 404

However, the url is reachable via http (tested with curl and wget) and
Apache records the transaction as a 200 OK -- there's no 404 there!
(There are 404s, of course, for objects that are in the pack but not
for any pack). Trying to read http-fetch.c and http-pull.c to figure
out where we could get the return status wrong, but my C is just
nonexistant. Hints appreciated.

cheers,


martin
