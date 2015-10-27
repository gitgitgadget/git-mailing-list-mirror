From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: What's the ".git/gitdir" file?
Date: Tue, 27 Oct 2015 19:26:34 -0400
Message-ID: <CANoM8SWDHyS1P=o1FwZUnE4OVUhhFS+-dFfgPQPE-zeHtGAp3A@mail.gmail.com>
References: <87a8r4ary9.fsf@kyleam.com> <xmqqpozzncs0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kyle Meyer <kyle@kyleam.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrDdr-00089U-7p
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbbJ0X0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:26:54 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34204 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbJ0X0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:26:54 -0400
Received: by oies66 with SMTP id s66so129853309oie.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bsdFit1WPXJBRSbDbtcqmK0sGzZy2Sw3X1sF6qyIZ/o=;
        b=txJJHD17XlCxiEli9L10MVvnd5SC6RF42YKlHTp5bJx2CHNwvLXf32SzQ88HglRzX/
         lFlNfdl3b/pqVq4ejxGhEHGIH7DhvjvBv1xE2UluSVZmFM7nYFE+BV3owwt6it2m/Glm
         dNeTum5pk11LbJZyZUWK6+XE1RWW86Idt6ERP4KNdqLMc2700VvmmfFMYWkk/oCts4UG
         u6CYm/pWlQg26U/vJP0OJu4KgL9GOIABK7Z8QmcWVu5Hyj1n3tD1adRKHydE/kXhwziH
         PaL64oc+BME7yJMmHZcsHbYVJTbf+UZ5R9IcsApcsrFysqlESsZ+qYCx9FekgfDPoO+t
         bwjQ==
X-Received: by 10.202.68.215 with SMTP id r206mr9421849oia.59.1445988413387;
 Tue, 27 Oct 2015 16:26:53 -0700 (PDT)
Received: by 10.202.79.18 with HTTP; Tue, 27 Oct 2015 16:26:34 -0700 (PDT)
In-Reply-To: <xmqqpozzncs0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280314>

On Tue, Oct 27, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Kyle Meyer <kyle@kyleam.com> writes:
>
>> When a ".git" file points to another repo, a ".git/gitdir" file is
>> created in that repo.
>>
>> For example, running
>>
>>     $ mkdir repo-a repo-b
>>     $ cd repo-a
>>     $ git init
>>     $ cd ../repo-b
>>     $ echo "gitdir: ../repo-a/.git" > .git
>>     $ git status
>>
>> results in a file "repo-a/.git/gitdir" that contains
>>
>>     $ cat repo-a/.git/gitdir
>>     .git
>
> Sounds like a bug in the recently added "worktree" stuff.  Perhaps
> update_linked_gitdir() tweaked by 82fde87f (setup: update the right
> file in multiple checkouts, 2015-08-25) is misbehaving?

I noticed that as I was working on the worktree list command that my
linked worktree gitdir files were being clobbered to '.git'.  I
attributed it to my work, but now that you mention it, I think it has
happened with the 2.6.1 release as well.
