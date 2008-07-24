From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 20:50:56 +0700
Message-ID: <fcaeb9bf0807240650v6eab6ad4n63c39973b3b43658@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
	 <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807231753240.8986@racer>
	 <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
	 <alpine.DEB.1.00.0807241340490.8986@racer>
	 <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>
	 <alpine.DEB.1.00.0807241443230.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:52:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1Ed-00052l-Vm
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 15:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYGXNu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbYGXNu7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 09:50:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:17011 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYGXNu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 09:50:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1405896fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7Bmcf+UGut3an4j0rk9cgPaBrtDhi0+znfe/HVBrnp4=;
        b=mEF3feyCJCGOtTVFbRPJj0NXx78LDoEx9tYaRIK2DqgfU0F4B0Hl3oUDmOo1IVkgwg
         vgCPxk0Mw6LMS4RJj0vP2vuk7+pvzrv6n3h+E9wuuItfsnSV3Uc0kCuyY2pjP909jq8q
         MASxlj9IwQvIU2XAqweAoVXyVxZ012yJNVxBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GhGd6xKDIhkpwwbIgUNyHG53d8bSk2v5FdChhxs7psc9GXDI4DaWRBUgOKUhtNSRoD
         eIa41GOrq3s8WREXqq1d1v4O+hpZ1zJ7izcyRoBAHhY6y8oITsqDRimh06s45zhpm2Ax
         mOrYsiny2i59gEHyW53/6B8paWRXTiqimD6kg=
Received: by 10.86.29.19 with SMTP id c19mr894572fgc.28.1216907456469;
        Thu, 24 Jul 2008 06:50:56 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 06:50:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807241443230.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89881>

On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>
>
> > On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > >  > > No, I did mean the index.  This is an attribute of the index:
>  > >  > > either it is sparsely checked out or not.  You can even have
>  > >  > > multiple indices (switching between them by setting
>  > >  > > GIT_INDEX_FILE) which have different prefixes.
>  > >  >
>  > >  > I don't think so. It's a mask for workdir, right? If you save it it
>  > >  > index, you can switch index and the prefix as well, but workdir
>  > >  > only has several subtrees that do not fit any other prefix than the
>  > >  > original prefix.
>  > >
>  > >
>  > > Ah, you adroitly avoided addressing the issue that the user can change
>  > > the prefix without the index ever noticing.
>  >
>  > Forgive my ignorance. I still do not get why index must notice prefix
>  > change? The only reason I can think of is that we must make sure there
>  > won't be any user-modification in index outside the prefix. But that can
>  > be guarded from higher level (plumbings and porcelains) because index is
>  > allowed to have modification outside sparse prefix (auto-merged
>  > entries).
>
>
> Why do you want to guard it from the outside?  When the obvious fix is to
>  put together what belongs together?

OK. I am lost here. I do not know how putting sparse prefix and index
together could fix "it" (I think you meant the index guarding). But we
are in -rc period now, probably should not put too much time on this.
I will take time to think about this.

-- 
Duy
