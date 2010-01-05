From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule working directory in git gui and gitk
Date: Wed, 06 Jan 2010 07:37:18 +0900
Message-ID: <20100106073718.6117@nanako3.lavabit.com>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de> <20100105142727.GA83546@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 23:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSI2d-0004Ey-Fd
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 23:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab0AEWiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754391Ab0AEWiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 17:38:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50410 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab0AEWiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 17:38:07 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 1C8E616F4E0;
	Tue,  5 Jan 2010 16:38:05 -0600 (CST)
Received: from 6529.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id PKPBTU2FC8XE; Tue, 05 Jan 2010 16:38:05 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=e8nnJCJ4MmO1N1Vu4DyHIHtmcr4FX9JN6RCWYPutouljYjWL+axVDK7QnUbPpdWhlYzMYcU4Bxwh/iAjVhwSd/MkuG80unTZuBTmxPzjf/86vpfIk0+qrwMrvkTUNvm5uDbYW7SnFnrS/7dI3DBGsIXLbgI0ilP/HQ4XTIKp/4Q=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <20100105142727.GA83546@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136214>

Quoting Heiko Voigt <hvoigt@hvoigt.net>

> On Tue, Jan 05, 2010 at 10:46:11AM +0100, Johannes Schindelin wrote:
>> On Tue, 5 Jan 2010, Jens Lehmann wrote:
>> > Yes. This synchronization could be either obsoleted by only using
>> > .gitmodules or automated.
>> 
>> I start to wonder whether the insistence that .gitmodules' settings must 
>> be overrideable makes any sense in practice.
>
> I just read this and felt the need to comment.
>
> Yes, it definitely makes sense in practise to have it overrideable
> otherwise we loose the distributed nature of git for submodules.
>
> Imagine you fork a project and you want to work with others on a change
> that involves chaning a subproject. If you can not override .gitmodules
> you can only work on the central repository.
>
> I am actually working like this in practise. I have a private clone of
> all the subprojects msysgit has and commit/push locally first. Once I
> sense the change is going to be useful for a wider audience I send it
> upstream. This would be more uncomfortable if it is not overideable.
>
> But I know what you mean by the general confusion about manual updates.
> So how about an approach like this:
>
> * clone will initialise all submodules in .git/config from .gitmodules
>
> * if a change in .gitmodules happens git scans .git/config for that
>   entry and in case nothing is there it syncronises the new one and
>   notifies the user.
>
> * if a change in .gitmodules happens and the entry before was the same
>   in .git/config we also automatically update that entry there.
>
> * In every other case we just leave .git/config alone.
>
> Did I miss anything? I think you should get the idea and that it could
> get rid of the confusion caused by manual .gitmodule updates.
>
> cheers Heiko
>
> P.S.: Additionally (for my use case) we could add a "hint mechanism"
> which allows git to "guess" a new submodules address. For example in
> case I have all my local clones on "git@my.server.net:<modulename>.git".
> Now when a new submodule gets seen in .gitmodules it will infer the
> address from the hint configuration and not take the original one from
> upstream.

Thanks for sharing your thoughts. I find this discussion very interesting.

I found this other discussion in the design area enlightening.

http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621

It was before I started using git heavily and I don't see many people who were in the discussion yet in the current thread, but I think it is worth reading.

P.S. A happy new year to everybody!

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
