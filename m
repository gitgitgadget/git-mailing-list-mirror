From: "Dan Chokola" <dan@chokola.com>
Subject: Re: Embedded Linux development with GIT
Date: Thu, 5 Jul 2007 02:06:13 -0400
Message-ID: <61e816970707042306n65e90e02lef1ce648be4225b@mail.gmail.com>
References: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sean Kelley" <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 08:06:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6KTt-0003Tm-Ba
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 08:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbXGEGGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 02:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbXGEGGO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 02:06:14 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:47381 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbXGEGGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 02:06:14 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1760433nze
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 23:06:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=RBrCRe6YPd3lCdJO61XxRa4OLkTG/qgPYddglsrYc74mwE6h7+xUYSeBECMlsstUWml6J09+pE08HxnvGdVun2Xeeb8h5/BRTXClD8GYODn3u7nKzCQMih384nnuS7lfwlmR7b/NSRrxVlLDwSVG9VcqA3rY4B83e1mPeK3ldzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DyMWsSsP/YocnEb8w6kfzO2CvHyMWckx0DPXYm8d9s2I2ehl8RatfIHTJG/jIPWm6X8COBVopb5ATqivZvq+IbGEL9iTVbzzW2HUDuGdXwXt/Xqd2XoKic/1T8Yw73farGhyfqwg5jhcpxVXCo4Ntr+MmwVwdRmW3cirksxXyzQ=
Received: by 10.114.89.1 with SMTP id m1mr7843735wab.1183615573042;
        Wed, 04 Jul 2007 23:06:13 -0700 (PDT)
Received: by 10.114.208.19 with HTTP; Wed, 4 Jul 2007 23:06:13 -0700 (PDT)
In-Reply-To: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b494360c1b241921
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51659>

On 7/5/07, Sean Kelley <svk.sweng@gmail.com> wrote:
> Hi,
>
> I have a situation where we have a local GIT repository that is based
> on v2.6.17.  We initially added the source tarball to an empty
> repository and then started applying changes to it.  Looking back,
> that might not have been the best idea 400 commits later.
>
> My goal is to eventually bring our repository closer to mainline
> revisions so as to make it easier to actually contribute back to the
> community.  So how can I fix my repository so as to give it visibility
> to Linus' kernel?
>
> Here is my initial thoughts:
>
> 1) Clone kernel.org kernel and it is Master
> 2) Create a local Head based on 2.6.17 and call it Local
> 3) Pull my existing heavily patched repository into the Local branch and merge
>
> Is it possible then to see our 400 odd commits then in the Local
> branch on top of 2.6.17 so that we can see not only our history but
> also the history that came before?  Then as Master advances we can see
> about backporting and bringing our code close enough to mainline
> kernel to actually be able to contribute back to the community and
> submit patches.  Is this realistic approach.  I am unsure of the GIT
> commands that I need to do this?
>
> Thanks,
>
> Sean

If I understand correctly, what you might want to do is keep your
current master branch, pull in the mainline kernel to a separate
branch, and rebase your master on the mainline branch.

git checkout master
git rebase mainline
will find the last common commit between two branches, then plop all
the mainline commits on top, then proceed to merge in your changes on
the master branch, one-by-one, stopping if there are any conflicts and
allowing you to resolve as they happen. Then your 400 commits will be
on top and you can rebase whenever and still see them on top.

-Dan "Puzzles" Chokola
