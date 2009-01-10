From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: collapsing commits with rebase
Date: Sat, 10 Jan 2009 21:04:57 +1030
Message-ID: <93c3eada0901100234w37724281q424698f452b0148b@mail.gmail.com>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
	 <alpine.DEB.1.00.0901080144270.30769@pacific.mpi-cbg.de>
	 <93c3eada0901071759u2496835dy134d92613bf4244b@mail.gmail.com>
	 <alpine.DEB.1.00.0901081205120.30769@pacific.mpi-cbg.de>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 11:36:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbCg-0003sa-AS
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbZAJKe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbZAJKe7
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:34:59 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:44485 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbZAJKe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:34:58 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9335313rvb.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EJUZcNmeuC1EvQmDcx6aHeyL8Nb1anU6F8D92iRbwRw=;
        b=CDqsu8ycwMIwkXWhPF5LuqVP1EN5NShwnNwTgzMO5SReBpRc3WGzmbqCkt+nEgGilR
         8m0orAb75LZymGX1reOIZtWUHFWOxDvNXaJF6nAHriO61fmACc2N5Qidw9E0Uj5N2T7Y
         l4XcmVZ9nSkD0E9zydLqakuKj/KtsUnEI821I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=WKT1zQuCPgLFTaBk/iG8Dd4Nakj9SF6vqizr+8DmCa1dwx+YBjG7AyxQG3XNiwWLI4
         zoEpaob0pv55ERsMtWk12SKOtqeaF8PKhlLiTxPr6AIMrWHVx/6OmkEevdg8rAYtW0Pa
         0y+UevGYCDWpaARwSySBk6sZvxwrNttbUXVEU=
Received: by 10.141.115.6 with SMTP id s6mr13254108rvm.235.1231583697574;
        Sat, 10 Jan 2009 02:34:57 -0800 (PST)
Received: by 10.140.136.16 with HTTP; Sat, 10 Jan 2009 02:34:57 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901081205120.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105088>

On 1/8/09, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Thu, 8 Jan 2009, Geoff Russell wrote:
>
>  > On Thu, Jan 8, 2009 at 11:15 AM, Johannes Schindelin
>  > <Johannes.Schindelin@gmx.de> wrote:
>  >
>
> > > Alternatively, something like this should work for you:
>  > >
>  > >        $ git checkout A
>  > >        $ git read-tree -u -m D
>  > >        $ git commit -m "My message"
>  > >        $ git cherry-pick E
>  > >        $ git cherry-pick F
>  >
>  > Plan B is looking good, because I'd generally like the commit message to
>  > be the concatenation of the messages for B,C and D.
>
>
> Replace the commit call by this:
>
>         $ for commit in B C D
>           do
>                 git cat-file commit $commit | sed '1,/^$/d'
>                 # possibly add an empty line between the commit messages,
>                 # git commit will strip away empty lines at the end.
>           done |
>           git commit -F -
>
>  Hth,
>  Dscho

That makes sense, many thanks.

Cheers,
Geoff.
