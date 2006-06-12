From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 15:00:19 -0400
Message-ID: <9e4733910606121200m402af4a4qa162c6f79cbf7100@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
	 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
	 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
	 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
	 <Pine.LNX.4.64.0606120938490.5498@g5.osdl.org>
	 <9e4733910606120944p4deb170ejc2863846685917f6@mail.gmail.com>
	 <Pine.LNX.4.64.0606120958230.5498@g5.osdl.org>
	 <9e4733910606121106ta925b6er49fe68bf3c1031f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 21:00:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpreE-0004mL-Mm
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWFLTAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWFLTAX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:00:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:7483 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932072AbWFLTAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:00:21 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1702767nze
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 12:00:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSE16UvCp+qOJnxROI9NqArA2yD95dKTfRbCBCzuoIPjMjh2nupDnE+gUgB5b3rzrr1dFx50fG6YTDrIP539ZisYA1MFgV9L0cMGo8wPLNKzJXzM9WrxxbnbOjMQ2EQ/Y90GUzEvZ1JVFHefbpkaSPpiSA67c7WvZyrkXccDIqA=
Received: by 10.36.118.11 with SMTP id q11mr9232360nzc;
        Mon, 12 Jun 2006 12:00:20 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 12:00:19 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <9e4733910606121106ta925b6er49fe68bf3c1031f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21725>

On 6/12/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > Having that many files in a single directory (or two) is a total disaster.
> > That said, it works well enough if you don't create new files very often
> > (and _preferably_ don't look them up either, although that is effectively
> > helped by indexing). I _suspect_ that
>
> Posted to the svn list, they said that 220K files is normal. They told
> me to turn on the ext2 dir_index option. Cheking my system I see that
> none of partitions have it turned on so it must not be the default for
> FC5.
>
> I have to unmount the drive to convert existing directories. I can
> trying doing the file move trick while the process is running since
> new directories will use it.

I converted the ext3 directories to dir_index on the fly using the
move trick. Switching the directory index makes it look like it is
spending even more time in the kernel.

procs -----------memory---------- ---swap-- -----io---- --system--
-----cpu------
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id wa st
 1  0 636188  22380  19176 157200    0    0     0    52  436   415 13
40 48  0  0
 1  0 636188  22504  19176 157200    0    0     0     0  430   373 13
38 49  0  0
 1  0 636188  22628  19176 157064    0    0     0     0  433   380 12
39 49  0  0
 1  0 636188  22628  19184 157056    0    0     0    20  434   390 12
38 49  0  0
 1  0 636188  22628  19184 156920    0    0     0     0  431   376 11
40 49  0  0
 1  0 636188  22752  19192 156912    0    0     0    48  437   376 12
40 49  0  0
 1  0 636188  22876  19192 156912    0    0     0     0  430   386 11
40 49  0  0
 1  0 636188  22752  19192 156776    0    0     0     0  431   370 10
41 49  0  0
 1  0 636188  23016  19192 156776    0    0     8     0  422   500 22
40 37  2  0

The size of the svn directories went from 3.2MB to 4.4MB after they
were converted to ext3 indexed mode.

I'll get oprofile running when I do a reboot.

-- 
Jon Smirl
jonsmirl@gmail.com
