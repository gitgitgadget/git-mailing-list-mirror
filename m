From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Usability improvement request: git show revision -- file
Date: Thu, 31 Mar 2011 09:50:02 +0200
Message-ID: <4D94322A.8030409@drmicha.warpmail.net>
References: <AANLkTi=JPVXD7Je7Rz9yhKHnJo+K2rs5WnwTY22c3h6L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 09:53:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5ChL-0005AV-V7
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 09:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144Ab1CaHxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 03:53:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45978 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757133Ab1CaHxf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 03:53:35 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7CE4120CE9;
	Thu, 31 Mar 2011 03:53:34 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 03:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=r+6DLKMZUpJuDPMD1vgGftr0NOw=; b=tcGC3kh52Fw9UuJ0GQVsVjeYfU3pKsY7dLAZa3vSeVWxSXOv/Bqq5Ny2aw7Q8ZgQD2gRzyjQ8HsAj7waAoV/z6STyr7EHXXVbe5/1+c4If4OoZRFRpYJWC19wc3OViJ3EbBsGQPsXHIm5WnPn/qkpfsL80ISRj8BOpCwIiygay8=
X-Sasl-enc: R4Ym+ONeTClOLflYIXcTy3Nll7uqAw/0rvYrCluWihTt 1301558014
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F22FD400E4A;
	Thu, 31 Mar 2011 03:53:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTi=JPVXD7Je7Rz9yhKHnJo+K2rs5WnwTY22c3h6L@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170459>

Piotr Krukowiecki venit, vidit, dixit 31.03.2011 08:45:
> Hi,
> 
> if there's existing way to do this please tell me.
> 
> There's this file "src/subdir/file". I'm in the "src" directory and want to
> see the "file" at specific revision.
> 
> Knowing about git show I'd expect something like this to work:
> 
>    $ git show master -- subdir/file
> 
> But it shows nothing (no output, no warning).

...because you are asking git to show the commit master, filtered by
subdir/file, and if that file is not changed there, the commit is not
selected. If it is changed there, it shows you only the diff affecting
that file. (We might want to change this to filter the diff only.)

> Following also does not
> work as expected:
> 
>    $ git show master:subdir/file
>    fatal: Path 'src/subdir/file' exists, but not 'subdir/file'.
>    Did you mean 'master:src/subdir/file'?

But git is really understanding about your situation, isn't it? ;)

> 
> Of course following works:
> 
>    $ git show master:src/subdir/file
> 
> but it's not very convenient to have to specify full path, and it's not what
> you would expect given that most other commands accept "-- relativepath"
> syntax.

It's not the command in this case, but the "commit:pathspec" syntax, and
for every command which understands it, it is relative to root (i.e.
expects a full path). But we do have a syntax for relative:

git show master:./subdir/file

Cheers,
Michael
