From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Tue, 1 May 2007 21:59:34 +0200
Message-ID: <e5bfff550705011259w567a98dj6d0a68b0fbe90994@mail.gmail.com>
References: <20070429220832.5832.251.stgit@yoghurt>
	 <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com>
	 <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com>
	 <20070501185615.GA32727@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiyVw-0004dV-8H
	for gcvg-git@gmane.org; Tue, 01 May 2007 21:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbXEAT7i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 15:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbXEAT7i
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 15:59:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:38909 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbXEAT7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 15:59:35 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2007621wra
        for <git@vger.kernel.org>; Tue, 01 May 2007 12:59:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tItxjjj2zb9vXVIZXOhF3A9U7EIFcro4NAzMfwxDl454+f3ptE+FIKDLohiRJUcpp6BxpnycUA6TftKhexnZ4x/Iio8r0houUGl4i+kHW9CzSU1ZdbRlWayO4EIkD4qm7U2XkNL5dkkUA2PE6BnLKO6N+8sbVoVIRs3Mdpsx/TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gdpc/bqdkTACD+EB0kTO95gl2ejEiGaN7ymFVQ+TB31zVHO3EcjP7g846me0gYTBQOI2EXd+MhpDwnxXlNExBogMMHuF0NcPHuDMtL6UlV48uARPE9gEp8aDGYoHPqcgMdDgON9mRt4el+dHYwfYsOv3EKDdms4YnJsyJI3yvt4=
Received: by 10.114.156.1 with SMTP id d1mr2488525wae.1178049574843;
        Tue, 01 May 2007 12:59:34 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Tue, 1 May 2007 12:59:34 -0700 (PDT)
In-Reply-To: <20070501185615.GA32727@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45975>

On 5/1/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-01 11:10:47 +0200, Marco Costalba wrote:
>
> > The only StGit data read directly are patches sha's; qgit walks
> > recursively all the files called "top" under directory tree
> >
> >           <git dir>/patches/<current branch>
> >
> > to get sha list of each applied and unapplied patch in one go. This
> > is much faster then calling "stg id <patch name>" for all the
> > patches.
>
> Hmm. These are on my kill list too. :-)
>
> The patch tops are already recorded in
> refs/patches/<branch>/<patchname> to keep them from being garbage
> collected, so these top files are redundant. But it isn't _that_ bad,
> so if removing them would break qgit, I guess I could try to restrain
> myself. At least all the other metadata is fair game. :-)
>
> (But if I were you, I'd look for the patches under patches/refs
> anyway; they _have_ to be there to survive garbage collection, so no
> amount of stgit refactoring will break qgit.)
>

Well, I did. ;-)

Actually I pushed a patch few hours  ago to read patches sha under refs=
/patches.

The problem is that the patch (for now) is pushed only for the new
development version of qgit, not the stable one and, worse, all the
currently released versions will break if you remove  <git
dir>/patches/ directory.

So please, if possible deprecate  <git dir>/patches/ directory but do
not remove for a while, so to let users to upgrade gracefully.

Thanks
Marco
