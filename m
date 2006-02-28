From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Tue, 28 Feb 2006 13:25:31 +1300
Message-ID: <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
	 <20060227184641.GA21684@hand.yhbt.net>
	 <20060227185557.GA32142@delft.aura.cs.cmu.edu>
	 <20060227192422.GB9518@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 01:25:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDsgW-00037A-HO
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 01:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWB1AZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 19:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWB1AZe
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 19:25:34 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:45189 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751804AbWB1AZd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 19:25:33 -0500
Received: by wproxy.gmail.com with SMTP id i28so973973wra
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 16:25:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sYCE4mtZNnySDUDpXi59pADUDFE9YkeFBupRHwE1iMprNA1rlI9NqeQABrX5pdu+63cnvNC1s9DxhGMvBxmsf2B5Q5MtOLIvQe9LRyoizCK+dbhc4QCpTNWfh8jrJLXVzLONDD4hXSJf4shDBAn3mRvmgZJAnYbNDQpL/39UI/I=
Received: by 10.54.100.13 with SMTP id x13mr44894wrb;
        Mon, 27 Feb 2006 16:24:40 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 27 Feb 2006 16:25:31 -0800 (PST)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20060227192422.GB9518@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16897>

On 2/28/06, Eric Wong <normalperson@yhbt.net> wrote:
> > If it is not supposed to be changed by the user, maybe it could be
> > stored as a tag.
> >
> > Or maybe another type of reference can be introduced. refs/remote/, for
> > branches we are tracking, but which should not be modified locally.
>
> Either of those could work for me.  Changing git-svn-HEAD to become a
> tag would probably be easier (not having to update other tools, such as
> git-fetch), but refs/remote may make more sense.

git-svn-HEAD "moves" so it's really a bad idea to have it as a tag.
Nothing within core git prevents it from moving, but I think that
porcelains will start breaking. Tags and heads are the same thing,
except that heads are expected to change (specifically, to move
forward), and tags are expected to stand still.

Something else is needed -- a convention to mark a head as 'readonly'
so that git-commit/cg-commit refuse to commit to it. cg-commit already
does that for any head matching the name of a branch.

cheers,


martin
