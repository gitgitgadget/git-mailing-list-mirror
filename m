From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: generate a diff against a specific tag in a remote branch
Date: Thu, 11 Mar 2010 11:44:23 +0100
Message-ID: <81b0412b1003110244s6f682293l79e0815cb6903aad@mail.gmail.com>
References: <74fd948d1003110144l382f7542qed4e80ea0fab6fde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 11:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpfsW-0001iq-EP
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 11:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855Ab0CKKo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 05:44:26 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59295 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab0CKKoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 05:44:25 -0500
Received: by bwz1 with SMTP id 1so5837972bwz.21
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 02:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QhTsduR19yT250wiENCUMMDAXkKP7Q4GmSodMlQhRqs=;
        b=uCMP0WHTj5JYFkDO62pJtIN9GH7CPVVNgZjltUvMC7/RNDVQ8cM78FpCNu0ZZgwXgL
         9AK+r1HEfCCV2fvD+7M8IjTaj2x5UmFczdWI9o8enP2H+4GSxrD4KFnmGN8FUP0fK7WO
         Xdp4o8EY/I0UN9UVe3HPWH1I1awT5m1gSpMfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LLJigP2yekL7vTdcF44g0jFjfuj9SrZCN7IHkWaPMf25Ii8B0TOhmvAZ76ShPr/yqD
         qqFDE7KOga29xmCxloMdK4fCfiBeau3M07edO8ZHAHhQlnfmtu7IGE8Ye1cxLFPAlQO3
         EeHNrWi9AtKr71RxIhF/4MkRhXaVrjD38s108=
Received: by 10.204.24.78 with SMTP id u14mr1009803bkb.122.1268304264015; Thu, 
	11 Mar 2010 02:44:24 -0800 (PST)
In-Reply-To: <74fd948d1003110144l382f7542qed4e80ea0fab6fde@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141948>

On Thu, Mar 11, 2010 at 10:44, Pedro Ribeiro <pedrib@gmail.com> wrote:
> I currently have a copy of the kernel TuxOnIce git tree, and the
> latest tag is 2.6.33.
>
> I also have added linus tree as a remote branch
> (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git).
>
> What I want to do is to make a patch of the TuxOnIce changes to apply
> to the linus' 2.6.33. The problem is that the linus tree keeps
> advacing, obviously, and is now at 2.6.34-rc1.
>
> So what I've been trying to do is to make a diff against the 2.6.33
> tag of linus' tree. Is this possible?

Probably. Try rebasing your TuxOnIce branch on the tag:

  $ git checkout -b temporary TuxOnIce
  $ git rebase v2.6.33

If it works out (you may have to correct some conflicts) during rebase,
the branch "temporary" can be used to generate a set of patches to
add TuxOnIce to a vanill 2.6.33 (by using git format-patch, for example).
