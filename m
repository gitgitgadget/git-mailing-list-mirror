From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: why is merging with unstaged changes allowed when rebasing is
 not?
Date: Sun, 06 Mar 2011 20:38:37 -0600
Message-ID: <4D74452D.2010104@gmail.com>
References: <AANLkTi=dnyaPTX0Y43nbAGp46NtscKT3a2idxEhkreMm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 03:38:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwQLO-00062p-7w
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 03:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab1CGCil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 21:38:41 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46832 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1CGCil (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 21:38:41 -0500
Received: by yia27 with SMTP id 27so1459674yia.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 18:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jE+7Ie/K15GAabp0EGNfylF9VyOoJPdnsL++upXCUPs=;
        b=IBreb+03JjGPTqw/sVqVVQX5S75PAT7Tyj8PLUQzybGlP1tFahmUJJYQlil/K96Ztw
         V3hOucxWGRZeQ+275Gk++2e92Ut5jua7C3i8g2H3XXraO/z+xehSREFGkeP57LRWr4IA
         bbyt+J2g0+Bg7YKft8uZDR3nV27hcjTwQ34QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=sodfKoMRzrzel8gYs802oKLeiOyR8li8rR8ec36wpIYSiRTjfbRHTHKI5HmMpGuEj7
         RQ6TocpuBIKOySJYp93beXmkdKJbrxcl8otQpZbTPLiN4UXBmfn+0o0iDG2TtVEqtmi6
         39f7zL2k9TC4t7ek/+ANDyxDx6otNUuu47ldU=
Received: by 10.150.162.2 with SMTP id k2mr3932488ybe.10.1299465520653;
        Sun, 06 Mar 2011 18:38:40 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id d3sm1427198ybi.17.2011.03.06.18.38.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 18:38:40 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTi=dnyaPTX0Y43nbAGp46NtscKT3a2idxEhkreMm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168566>

On 3/4/2011 10:32 AM, Christian Halstrick wrote:
> Isn't it inconsistent that I can merge with unstaged changes in my
> work-tree but not rebase? I agree that both should fail if the
> operation would have to touch the file which has unstaged changes. But
> if not - why don't we allow the rebase? (Is it just because we
> technically do a "git reset --hard" during the rebase which fails on
> unstaged changes?). Here is how tried it out:
>
> git init
> touch a b
> git add a b
> git commit -m initial
> echo "a-master">>  a
> git commit -a -m "modified a on master"
> git checkout -b side HEAD~1
> touch c
> git add c
> git commit -m "added c on side"
> echo "b-side">>  b
> # git rebase master ->  would fail complaining about unstaged changes
> # git merge master ->   would not fail
>
> Even a 'git checkout master; git cherry-pick side' works well (but
> updates the wrong branch)
>
> Ciao
>    Chris

food for thought:

git-merge manpage: "Warning: Running git merge with uncommitted changes 
is discouraged: while possible, it leaves you in a state that is hard to 
back out of in the case of a conflict."

I would imagine that if its a bad idea for git-merge, its a really bad 
idea for git-rebase...

v/r,
neal
