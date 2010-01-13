From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: discussion: an option to fail git fetch if a pulled branch tip is not a fast forward of the existing remote tip?
Date: Thu, 14 Jan 2010 04:14:26 +1100
Message-ID: <230F8BFF-7F59-47DB-9E97-D8E081D2597B@gmail.com>
References: <2cfc40321001130354w626ec0fat7abdfaff9771c29f@mail.gmail.com> <201001131359.09613.trast@student.ethz.ch>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:05:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9T5-0002gS-5r
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab0AMUFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968Ab0AMUFX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:05:23 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43346 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab0AMUFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:05:22 -0500
Received: by pwj9 with SMTP id 9so3123654pwj.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:cc:x-mailer;
        bh=zb3537W/umA60xWuwnLyVXMB0cIb9ulxv3IyVAVtkEw=;
        b=RwSU3nabRbnBF1UNTm8HApGZTbckT9qRb1TTF6mWx30BIurOnYSbF+CtO+122qgo+3
         RyU5pLgmLtjEdhTUH/7jbIZpvdcrDmcLuVWOk6TKsFkHjsVeTe/S6JcdFyhGGowo+rTL
         8+YEoUdnc0aPvCdSGhVozpQZZvDKLVBIC+ZD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:cc:x-mailer;
        b=LXDP5fh1um61nMeMUDGDLyhCtjt2XpFTk59/LoewYvMiXlDz/27rmABNs/i22N8KXX
         0Lt/EyemtXjALHFU43AjxF0PFryK8FtV28UeVPCwvl7krXIBYiwFGeP/SDtvsPno1enK
         ytQ5nnM/qjodkHqvdjMMIeK89kzLReloD6sgE=
Received: by 10.142.6.32 with SMTP id 32mr3084075wff.90.1263412773998;
        Wed, 13 Jan 2010 11:59:33 -0800 (PST)
Received: from ?10.248.25.14? ([120.155.103.178])
        by mx.google.com with ESMTPS id 20sm518433pzk.9.2010.01.13.11.59.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 11:59:32 -0800 (PST)
In-Reply-To: <201001131359.09613.trast@student.ethz.ch>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136870>

Thomas,

Ah - thanks for your very helpful response!

jon.

On 13/01/2010, at 23:59, Thomas Rast <trast@student.ethz.ch> wrote:

> Jon Seymour wrote:
> [discussion of a case of branch rewriting, called "backtracking" here]
>> Now clearly the upstream developer should not have backtracked. That
>> said, it would have been nice if I could have easily configured my
>> porcelain to detect the backtracking condition. An option on git  
>> fetch
>> that implemented something similar to the git push check would have
>> made this easy to achieve.
>
> This is an instance of a non-fast-foward update, which is indicated by
> the little "+" in git-fetch's output.  E.g., fetching git.git a moment
> ago gave me
>
> From git://git.kernel.org/pub/scm/git/git
>   fbb9971..8efa5f6  maint      -> origin/maint
>   c0eb604..054d2fa  master     -> origin/master
>   e295b7f..e84eab0  next       -> origin/next
> + 10659b7...6a048fc pu         -> origin/pu  (forced update)
>
> which means that the 'pu' branch was a non-fast-forward update.
>
> If you do not want to rely on checking the results manually, you can
> edit the remote configuration.  Normally, it will look like
>
> [remote "origin"]
>        url = git://git.kernel.org/pub/scm/git/git.git
>        fetch = +refs/heads/*:refs/remotes/origin/*
>
> Note the "+" in the 'fetch' line, which means "allow non-fast-forward
> updates".  Removing the + (leaving the rest intact) results in
>
> From git://git.kernel.org/pub/scm/git/git
> ! [rejected]        pu         -> origin/pu  (non-fast-forward)
>
> You can then manually add lines _with_ the "+" for branches where you
> do want to allow non-ff updates, e.g., for git.git I might say
>
> [remote "origin"]
>        url = git://git.kernel.org/pub/scm/git/git.git
>        fetch = +refs/heads/pu:refs/remotes/origin/pu
>        fetch = refs/heads/*:refs/remotes/origin/*
>
> since only 'pu' will be rewritten regularly. ('next' gets the
> occasional treatment too, so that config would not be very
> futureproof.)
>
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
