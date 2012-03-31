From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 31 Mar 2012 10:19:54 -0500
Message-ID: <4F77209A.8050607@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bo Chen <chen@chenirvine.org>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 17:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE06A-00040V-EC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 17:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab2CaPUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 11:20:01 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37122 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760057Ab2CaPUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 11:20:00 -0400
Received: by obbtb18 with SMTP id tb18so255474obb.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7Yg3DEBl5Wm1AIFF7xkipPio07RnnPDyzoQKP3JwC5s=;
        b=Qr80JFMQeb2vBOA6+g5OOYFxhVz8zXF+g0tYWL2o2T8nM/8Cu2meYPoD0wvNpWUtvp
         EzyXdL2EqBvFGrzcmOvdbaDMIcvmAxm4w/u0/j34LAn7CNhyrY/Wc4r659Sii4B6yOSq
         Dgur/xcjtG6zM2pu/ZOsypd9VnmcQtPEyH4MaEbTyhRPImgRhSED5f/bjvkVKjaYqc+i
         yo1pRqAc6OEV/WweFNBGEwHY8PKDQKjQKdzSjbBxoNUsMaf80gIn/AhVmNTcQX0Tb6zZ
         giJQES+FKn27Dlto67uK6jsKsEO9/AxP51PCbn8zfU4QY0K/nKclJQJMo7nB0eORWchy
         xwDA==
Received: by 10.182.74.8 with SMTP id p8mr3164886obv.41.1333207199928;
        Sat, 31 Mar 2012 08:19:59 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c6sm9794709oec.13.2012.03.31.08.19.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 08:19:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20120330203430.GB20376@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194454>

On 3/30/2012 3:34 PM, Jeff King wrote:
> On Fri, Mar 30, 2012 at 03:51:20PM -0400, Bo Chen wrote:
>
>> The sub-problems of "delta for large file" problem.
>>
>> 1 large file
>>
> Note that there are other problem areas with big files that can be
> worked on, too. For example, some people want to store 100 gigabytes
> in a repository.

I take it that you have in mind a 100G set of files comprised entirely
of big-files that cannot be logically separated into smaller submodules?

My understanding is that a main strategy for "big files" is to separate
your big-files logically into their own submodule(s) to keep them from
bogging down the not-big-file repo(s).

Is one of the goals of big-file-support to make submodule strategizing 
unconcerned about big-file groupings and only concerned about 
logical-file groupings?  Big-file groupings are not necessarily logical 
file groupings, but perhaps a technical file grouping subset of a 
logical file grouping that is necessitated by big-file performance 
considerations.  IOW, is the goal of big-file-support to make big-files 
"just work" so that users don't have to think about graphics files, 
binaries, etc, and just treat them like everything else?  Obviously, a 
100G database file will always be a 'big-file' for the foreseeable 
future, but a 0.5G graphics file is not a "big file" generally speaking 
(as opposed to git-speaking).

> Because git is distributed, that means 100G in the repo database,
> and 100G in the working directory, for a total of 200G.

I take it that you are implying that the 100G object-store size is due
to the notion that binary files cannot-be/are-not compressed well?

> People in this situation may want to be able to store part of the
> repository database in a network-accessible location, trading some
> of the convenience of being fully distributed for the space savings.
> So another project could be designing a network-based alternate
> object storage system.
>
I take it you are implying a local area network with users git repos on 
workstations?

In regards to "network-based alternate objects" that are in fact on the 
internet they would need to first be cloned onto the local area network. 
  Or are you imagining this would work for internet "network-based 
alternate objects"?

Some setups login to a linux server and have all their repos there.  The 
"alternate objects" does not need to network-based in that case.  It is 
"local", but local does not mean 20 people cloning the alternate objects 
to their workstations.  It means one copy of alternate objects, and 
twenty repos referencing that one copy.

v/r,
neal
