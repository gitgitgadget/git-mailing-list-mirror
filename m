From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 9 May 2007 21:55:53 +0200
Message-ID: <8c5c35580705091255v2f85db3qcbf65904c278d17@mail.gmail.com>
References: <11787000032830-git-send-email-hjemli@gmail.com>
	 <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
	 <7v8xbxu6u0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 21:56:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsGX-0008I3-Cl
	for gcvg-git@gmane.org; Wed, 09 May 2007 21:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbXEITzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512AbXEITzz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 15:55:55 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:54585 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbXEITzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 15:55:54 -0400
Received: by nz-out-0506.google.com with SMTP id o1so327306nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 12:55:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/7J671NrfLwg2jM+JfNazHFeTfKlTYsHt3NBe6EvjfojFA0Pl57OA1aKSg0agVAgku0VkAjRBTFHukCXXe5ZE4tD7iEf57xdGLtAfPrQ4GRAjmmVzjub+M1Am+c3k4FskUnbA5leXztLVoYKqxunC63kBesGZkkehnGcK7WzZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XOUOLNw9g37OoIit9anWZ4fIgt8aX/wQnndvsngwPCBkeBNYtPNvgz5TLvsuCkltPLZR/Hbe0iE/nnJAehaNSv9nX/RCrN6RODN3O/k2QAiFAtA51fFVHiySSeLaU1bwrdNK2mBBk/29mgUknpZDws026VpUvW6b3UKDNY2Vycg=
Received: by 10.115.19.16 with SMTP id w16mr298610wai.1178740553192;
        Wed, 09 May 2007 12:55:53 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Wed, 9 May 2007 12:55:53 -0700 (PDT)
In-Reply-To: <7v8xbxu6u0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46773>

On 5/9/07, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > On 5/9/07, Junio C Hamano <junkio@cox.net> wrote:
> >> Lars Hjemli <hjemli@gmail.com> writes:
> >>
> >> > This teaches git-checkout to strip the prefix 'refs/heads/' from the
> >> > supplied <branch> argument
> >>
> >> Why is this necessary, may I ask?
> >>
> >
> > I'm playing around with a gui frontend, and there I use
> > git-for-each-ref to obtain possible arguments for git-checkout. That's
> > how I discovered the 'problem', and solved it by stripping
> > 'refs/heads/' in my frontend.
>
> Pathspec-less variant of "git checkout" takes two kinds of
> parameters and has two flavours in its behaviour:
>
>  (1) an exact branch name, in which case it switches to the
>      branch; otherwise
>
>  (2) any arbitrary commit object name, in whch case it checks
>      out and detaches HEAD.
>
> A tricky part is that an exact branch name is often a perfectly
> valid commit object name, so rule (1) trumps the rule (2).  You
> just discovered a way to have a detached HEAD at a commit that
> happens to be at an existing branch -- by naming that commit
> without using its exact branch name.

Ok. But if this is intended behaviour, maybe we would want do change
the detach-message in this case:

[~/src/git] next$ git checkout refs/heads/master
Note: moving to "refs/heads/master" which isn't a local branch

(sorry for stealing your time with this unimportant stuff, it just
surprised me that refs/heads/$branch wasn't treated as a local branch
name)

-- 
larsh
