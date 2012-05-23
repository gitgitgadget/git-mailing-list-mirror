From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Wed, 23 May 2012 20:59:29 +0200
Message-ID: <4FBD3391.7010905@kdbg.org>
References: <4FBAA33D.1080703@kdbg.org> <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 20:59:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXGmY-0000Sj-ST
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 20:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933846Ab2EWS7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 14:59:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:33743 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933834Ab2EWS7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 14:59:33 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 32ED013004E;
	Wed, 23 May 2012 20:59:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D964D19F5F6;
	Wed, 23 May 2012 20:59:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198317>

Am 23.05.2012 17:37, schrieb Martin von Zweigbergk:
> On Mon, May 21, 2012 at 1:19 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Replace the 'git merge' by a cherry-pick that picks the changes that the
>> merge introduces with respect to the first parent.
> 
> Just a reminder of what I said in [1] (the same thread that you referenced):
> 
> I think this will break "git rebase -p --onto g b f" on  the below history.
> 
>           .-e-.
>          /     \
>       .-c---d---f
>      /
> a---b---g

This still works. It is tested by t3411.3.

> Even if this wasn't the intended use case, git currently supports it
> and I would personally be a little surprised if no one has gotten used
> to it working. So should we at least check for this case and handle it
> with "git merge" as usual? Or stop supporting it and error out instead
> (and mention in release notes?)?

YESSS, drop it. It would allow us to remove all sorts of crufty
work-arounds for work-arounds. THIS IS NOT 'git sequencer'!

> Btw, with a history without "internal" merges, but where the merge
> commit was generated "backwards" so the first parent is not in the
> to-be-rebased history, am I correct in thinking that the "git
> cherry-pick -m 1" will fail? Do you think we should consider this case
> or do we consider that too broken to care about?

I think something odd will happen. If in doubt, I would suggest to
consider this such an odd case which rebase is not intended for ;-)
(garbage in - garbage out).

-- Hannes
