From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Fri, 8 Jun 2007 07:46:26 +1200
Message-ID: <46a038f90706071246y7dd14f55t199b8ed4e7617b68@mail.gmail.com>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
	 <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
	 <46676D44.7070703@vilain.net>
	 <alpine.LFD.0.99.0706062314410.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, "Dana How" <danahow@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 21:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwNwJ-0003Pl-T8
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 21:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934614AbXFGTq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 15:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934206AbXFGTq1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 15:46:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:34571 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934614AbXFGTq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 15:46:26 -0400
Received: by wx-out-0506.google.com with SMTP id t15so512227wxc
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 12:46:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gmOI5zns1WUcabI0rusC650HlayqaT4Pol7JH8DPV/5ZoHsvEpEMY34Igk6bWEkZe1IztTlO2wqVP0vV9HRzQlM5qMlHI9ElPrWHjJ6hXDjUJK23q4s0IEWxHjSe2Ghibme7ktoWRHvXItOFBUkDR+dmQqTnAO1gsCQ1N0Aoxrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OdwgfE2f15dfGpe0WIC+VSQv1vxCb1H2nafl/fYjU6LVnnpdWEvBu5KfZsWmiek8F8POq1p/tgcFo20Y7QJ3Q/OJX6ASOLVUEqPQV3C4ZQQ7U3s/f6EuJb17GXQzxMv7tIi1QQBvF9rep0DD9JLaq34IAhGZVs8/V5/DgThGmhY=
Received: by 10.90.83.14 with SMTP id g14mr2094644agb.1181245586033;
        Thu, 07 Jun 2007 12:46:26 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Thu, 7 Jun 2007 12:46:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0706062314410.12885@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49382>

On 6/7/07, Nicolas Pitre <nico@cam.org> wrote:
> Run git-repack without -a from some hook.  You can even launch it in the
> background.

I posted an RFC patch a while ago doing exactly that, and Linus shot
it down, indicating we should instead print a message suggesting
repack to the user.

Relevant thread around
http://www.gelato.unsw.edu.au/archives/git/0606/22977.html

> Or what am I missing?

I don't think people were comfortable at the time with concurrent
repacks -- though the semantics are safe if we don't hit any bug. My
guess is that noone wants to risk the .001% chances of data corruption
for this nice-to-have.

It was also probably a bad idea in my patch that it said -a -- it should just be

  git repack -l -q &

[And I generally agree with the concerns about possibly broken
semantics, unexpected user actions and racing repacks. One of the main
reasons I've never advocated SVN is that the early stories of data
corruption using BDB backends made me very very very wary of it.
Perhaps because I lot months of work in the past to disk corruption in
a cvs repo, and have a good mental picture of the nervous breakdown
that followed.]

cheers,


m
