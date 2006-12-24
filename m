From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sun, 24 Dec 2006 10:36:16 +0100
Message-ID: <38b2ab8a0612240136r559376d4s14af3123f762a45d@mail.gmail.com>
References: <20061223073317.GA9837@spearce.org>
	 <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com>
	 <20061224090508.GF7443@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 10:36:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyPmH-0001fH-As
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 10:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbWLXJgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 04:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbWLXJgR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 04:36:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:40487 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbWLXJgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 04:36:16 -0500
Received: by wx-out-0506.google.com with SMTP id h27so3252556wxd
        for <git@vger.kernel.org>; Sun, 24 Dec 2006 01:36:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sPXCXp+DQnCocHz5Gs71qsx3lmHxcw//9lUN5N1P51QpP7XSBYfYGlMgkJEY76tE18X8nv5+9dMmAznXDWBsntCG5NNK7oRIZ/VXeyQcLvXVRwBczKFWdVsJu9pKDxb0EqqYpoNJpRmGExf249mNmq5Kh0WenZdwrcBPgMXjhig=
Received: by 10.90.104.14 with SMTP id b14mr10183024agc.1166952976038;
        Sun, 24 Dec 2006 01:36:16 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Sun, 24 Dec 2006 01:36:16 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20061224090508.GF7443@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35351>

On 12/24/06, Shawn Pearce <spearce@spearce.org> wrote:
> Francis Moreau <francis.moro@gmail.com> wrote:
> > On 12/23/06, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >This 17 patch series implements my much discussed, but never produced
> > [snip]
> > >
> > >This series also permits accessing packfiles up to 4 GiB in size,
> > >even on systems which permit only 2 GiB of virtual memory within
> > >a single process (e.g. Windows and some older UNIXes).  Of course
> >
> > Just out of curiosity, do you mean that there are some OS running on
> > 32 bits machines which allow 4GiB size of virtual memory within a
> > single process ? If so, could you give an example of such OS ?
>
> No.  What I meant was the Git packfile/index format currently
> supports up to 4 GiB of data in a single packfile.  But *no*
> OS using 32 bit virtual address space would permit us to access
> that packfile prior to this series as we would have *no* memory
> left for a stack, let alone for parsing commits, etc., as *all*
> of the address space would have been dedicated to the packfile.
>

ok.

> However with this series even a 32 bit OS which only permits
> processes to have at most 2 GiB of address space (2 GiB split
> between kernel space and userspace) can access packfiles up
> to 4 GiB in size.  That seems to be the split most OSes wind
> up using, if they didn't push it out to 3.2 GiB like Linux
> and Solaris have done.
>

Does it still needed for 64 bit OS ?

if not, can the overhead (if there is a significant one) implied by
your rework be avoid for such cases ?

> This series is a good change because Git can now really make
> full use of the space allowed by a single packfile.  :-)
>

Yes I agree with you.

-- 
Francis
