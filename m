From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: A few "linked checkout" niggles
Date: Thu, 16 Jul 2015 12:24:21 +0700
Message-ID: <CACsJy8CLYz7HqScS5Bxo47kTbrNj=qsaZnkKQ9ob4UVbjGG62Q@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 07:24:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFbfF-0004uf-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 07:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbbGPFYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 01:24:52 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34389 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbGPFYw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 01:24:52 -0400
Received: by igvi1 with SMTP id i1so5809614igv.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 22:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QtOXG2JFVIJikBrEQw7UWNqv8p9ZhNgJN4ZU5eGWsJs=;
        b=OqR+Nuh2539I+NXBHzod3DILEBDi92BtmIlGMIk5YTLGW2FLUZ6OKhv+jnSWeJXLiU
         vWavqu7NCTyP4lb6I+4BQV6H9mRaxiv6X7u5mVTk6Sn+XcEBdV02Q+iwZd1qkXufG14S
         wRHho1CFUh1sQb3zKOFyM6WkuyTeQVKH3s6CgO4dSuGKPvIoPVhSrWq7oiWVem/OjdIO
         vFJU6awSiH4ewkx9cg9chRwhj00gvhzWUm5wAVj5SgO5LUZJ2gkHgU+HF/2Ie8iEd6DL
         DpjntDzyqjLjxR7OJ07CmeWwHGdPl0xWGY1VDC0M05SPr4EzyMT1BUQfkksGlbFHQ6M0
         TVDA==
X-Received: by 10.50.142.69 with SMTP id ru5mr2024592igb.61.1437024291348;
 Wed, 15 Jul 2015 22:24:51 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 15 Jul 2015 22:24:21 -0700 (PDT)
In-Reply-To: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274006>

On Thu, Jul 16, 2015 at 6:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I've tried to set up a non-bare clone of git.git at ~/w/src and
> attached one of its branches to a separate work tree at ~/w/rerere
>
>  ~/w/src$ git worktree add ../rerere jc/rerere
>
> Then I tried the "multiple checkout not allowed".
>
>  ~/w/src$ git checkout jc/rerere
>  fatal: 'jc/rerere' is already checked out at '/home/gitster/w/rerere/.git'
>
> You see the first "niggle" above.  Do we need "/.git" at the end?
> That is hopefully merely cosmetic and I am guessing that we can
> unconditionally drop "/.git" from the end, but maybe there are
> subtle reasons why it may not be a good idea (e.g. introduces some
> ambiguities?)
>
> There is another, a more serious one.
>
>  ~/w/src$ git fetch ../git.git jc/rerere:jc/rerere
>
> This succeeds, without checking if there is a work tree that has it
> checked out.  I think the safety in "git fetch" that can be disabled
> by "--update-head-ok" option should be updated to reuse the same
> protection used by the updated "git checkout".
>
> Something to work on for 2.5.x maintenance track, aiming for 2.5.1.

To keep things clear, Eric if you want these they are yours :-) I'll
focus on the submodule support after i'm done with all my bug fix
patches.
-- 
Duy
