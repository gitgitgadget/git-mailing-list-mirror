From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 5 Dec 2010 11:09:19 -0600
Message-ID: <20101205170919.GA7913@burratino>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
 <20101205021837.GA24614@burratino>
 <AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 18:09:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPI5w-0002hm-Mp
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab0LERJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 12:09:41 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:39145 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab0LERJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 12:09:41 -0500
Received: by gxk19 with SMTP id 19so6131699gxk.11
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=d4s2T/TvTc01PftvSsb0d2PR9rBccB7dfBVMC0QlkdE=;
        b=qaWBetIIqM2fBj1kX/AbQg55UffQXHYso25Gk57aUrcU2zxXHJPdILem86e7fTHiro
         Uoiu2rstb1FSYx6LuKEZ3HG5hfRxpcalRJjd279/WPkfA70KNn8sK8xI286e9Bn01v/B
         WAGUgbwwkcPRsHVCyWbrN59MMMb9njax1Y1Js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ohFLuu4w3mu20GFtbiP+96cX4m8ydEIBMFLwkHAlluduLxHc11e0Purskf3ePz3+MD
         Jlx0x3+iF/MirJUUjPV01mCJA29w+7z5AnPEvEp6HQlVk2MEJcHWYoNrQqipJb597muK
         b3dxhCp9F6sApkTPCU6MlDbetJPA/4BAiM1vk=
Received: by 10.150.134.2 with SMTP id h2mr5720763ybd.132.1291568980425;
        Sun, 05 Dec 2010 09:09:40 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id y11sm2491188yhc.8.2010.12.05.09.09.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 09:09:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162952>

Thiago Farina wrote:

> I think it's a good procedure for someone more familiar with this
> functions to do this. Perhaps, you or Junio?

If you are not familiar enough with the functions to document them
(perhaps with help from the list) then yes, renaming them is a bad
idea.  I am not inclined to do it because I like the current name.

The ideal patch is a great sort of present: first a bug report, then
the resolution to that bug.  When the patch proper goes awry, at least
there is the bug report.  I think you are trying to convey a bug but
you haven't explained it.  Maybe it is

 - "The reduce_heads function being used in various contexts, where it
   is not obvious what it means.  If you add commit_list to the name,
   then <such and such> becomes obvious.  So I suggest renaming."	or

 - "In my program, I have my _own_ reduce_heads function with
   different meaning so I cannot easily copy the commit_list functions
   to use them.  Please make it easier by putting commit_list functions
   in a well defined namespace."	or

 - "Some code is manipulating commit_lists directly and violating
   their invariants.  Please make it easier to build a cheat-sheet
   listing commit_list functions, to translate from
   bad-field-manipulation-ese to using-the-right-functions-ese."	or

 - "At my office there is a style guide indicating that each function
   should live in a module with some other functions and be named to
   indicate so (like perf, with its sched__* etc functions).  The idea
   is that code with a simple high-level structure tends to be easier
   to understand and we need to understand the code we use.  Can we
   start changing the code to fit this style guide, so there is less
   resistance to using it at my office?"

In a way, these are straw men; sorry about that.  The answer to each
would be different.  FWIW from my pov the answer to _none_ of these
would be "sure, let's rename the functions", for different reasons in
each case.

I do not think this is an atypical example at all.  I would have
prefered not to spend time on patches that require guessing what
problem is being solved.
