From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 16:04:28 +0200
Message-ID: <81b0412b0706270704y58c9e05bh6ec10118d7ee406c@mail.gmail.com>
References: <87wsxpobf0.fsf@rho.meyering.net>
	 <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	 <87r6nxo8iq.fsf_-_@rho.meyering.net>
	 <81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com>
	 <87d4zho74h.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 16:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Y8H-00005R-LX
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 16:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbXF0OEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 10:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbXF0OEb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 10:04:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27537 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXF0OEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 10:04:30 -0400
Received: by ug-out-1314.google.com with SMTP id j3so328723ugf
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 07:04:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b9J9Bf5GeOCYgwa/rNo2AaSnWRE5FUl4oST7v6jE+x1S8IuREHWpi2+cJCsunM95bWUFDy2YJAWu9curXh8B3QMy6+4wqrhEiki2DUFbMqAZL4aDpkvXm/SBlDOgOSZSrJ0zq3HHM4pLBWd1yiXyhRpCHw5/ia2MKJoM/s6syr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8x5NzknGu4deHqnHf6rQ5I52/0zTgTQbBfQMA5hP/WJqUp6t2C/zWWvrtQH/hPKxb6LQd1CdtRjl9+xg25LG45gky15TyKfmICxdyaDiX4sV3YbCS6urH9Vz6ptE1Uk4zgHrNOpo6O+r1c0z3cV6HyoAasUoFoGRi4f7E8ixV8=
Received: by 10.78.123.4 with SMTP id v4mr293913huc.1182953068969;
        Wed, 27 Jun 2007 07:04:28 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 07:04:28 -0700 (PDT)
In-Reply-To: <87d4zho74h.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51045>

On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> wrote:
> > Check if this works in some exotic but common
> > environments (like MacOSX, Cygwin or HP-UX).
>
> What do you mean?
> I know that dup and fdopen work in those environments.

Exactly as you described? Are you sure fdopen on Cygwin
sets ENOMEM?

> >
> > Kinda stuffed in here. What's wrong with plain
>
> It's ok, but for the fact that when dup fails, all you get
> is the uninformative EINVAL from fdopen.

EBADF on Cygwin, 0 on Mingw32. Can't even imagine what msvc
(which actually isn't a developers tool, but very common) will return.

> > (Yes, I do think that "duplicate standard output" is useless,
> > except for debugging. Exactly as strerror is, but that is shorter).
>
> I like to include *something* in the diagnostic so that when someone
> sees it and reports it developers have an easier time finding where it
> comes from in the code.  Especially with something as unlikely (and hard
> to reproduce) as this, that might be useful.

Then put file name and the line number in!
