From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: '.git file' alternative, native (cross-platform) workdir support.
Date: Fri, 29 Feb 2008 06:14:36 -0800 (PST)
Message-ID: <m3lk53kfy6.fsf@localhost.localdomain>
References: <47C7FA49.9010001@trolltech.com>
	<alpine.LSU.1.00.0802291248510.22527@racer.site>
	<47C80786.4070701@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 15:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV61A-0005bc-CL
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 15:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbYB2OOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 09:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbYB2OOn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 09:14:43 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:1165 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbYB2OOm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 09:14:42 -0500
Received: by ik-out-1112.google.com with SMTP id c28so2259497ika.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 06:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=p4wt2YCgk/rVWCnnDvanfQmGx1VGnGTLT/STCHlRimY=;
        b=FACx2SlDYkWSkV1BlcMri59ZkpZXRSX8RqQn0YUHIQjVQ2NSSpd2F9ghw68Nwv8Gs+HF2Jg6SpZrqVkoMFVr/cfLYDP1SxWLnJd217p6z3/pAs41GUMTxgyr1N6+L1nTgSfWQpl1L7dRy14tiArSu0WgAixsBo3gLwvQT/RIHzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=MMlmAe7PtUlAfrDqHLMw9R2Gq3ptcwtcR4i6RUGkSNxfakyrzN5oOqkzMTBeCxN7PveUwgousNFsVby9Q56k8giYi9L8ugSf+yZVyrrRP3KCvepUaLIqP6ttgXs3JucVf2SU12ZxKr49j9q6LsLg6NPz3CfhtoK8nvqUh5ajG00=
Received: by 10.78.138.14 with SMTP id l14mr10153617hud.20.1204294478543;
        Fri, 29 Feb 2008 06:14:38 -0800 (PST)
Received: from localhost.localdomain ( [83.8.217.18])
        by mx.google.com with ESMTPS id d25sm18327425nfh.33.2008.02.29.06.14.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 06:14:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1TEEXKd024018;
	Fri, 29 Feb 2008 15:14:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1TEEQVq024015;
	Fri, 29 Feb 2008 15:14:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47C80786.4070701@trolltech.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75537>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Johannes Schindelin said the following on 29.02.2008 13:54:
>> On Fri, 29 Feb 2008, Marius Storm-Olsen wrote:
>>>
>>> However, wouldn't simply redirecting everything into a real repo
>>> then create problems with shared index file and more? A problem
>>> which could be tacled by file suffixes or other methods, I'm
>>> sure, but which would require even more patches to achieve the
>>> goal.
>>
>> Not only would it requre these patches, but it would actually make
>> a _safe_ multiple-workdirs feature possible.
>> ATM the problem is that you can change a ref that is checked out
>> elsewhere, and if you are not a Git expert, it will just make your
>> life miserable.
>> However, if we do not pretend to have different repositories, but
>> actually use the _identical_ repository for multiple working
>> directories, we can make the mechanisms safe!
>> This is basically the reason why I do not like the current
>> new-workdir script (and the patch in my private tree where I taught
>> git-branch about it).
> 
> Sure, I'm aware of that. The initial goal was to make something which
> works as the current contrib/workdir/git-new-workdir, just
> cross-platform. Then we can take it from there, step by step, until we
> have something which works safely; instead of taking a single big leap.
> 
> I'm actually not sure that it's impossible to make it safe.
> My implementation works by redirecting files into the real
> repo. However, we can also detect when redirection is in effect, and
> do extra 'maintainance' things then, to avoid the bad effects.
> 
> For example, when setting up a workdir, we could duplicate
>          <real repo>/.git/refs/*
> into    <real repo>/.git/refs/workdir-<sha1>/*
> (<sha1> being the sha1 of the abs path to the workdir)
> and have the redirection mechanism redirect all git_path("refs/*") to
> the duplicated locations. That way, when pulling in the workdir, it
> wouldn't create havok with the real repo's refs. Then in the real
> repo, you can easily refer to the refs in from the workdir too, when
> you need to.

I have had yet another idea, namely of shadow / unionfs-alike, which I
have abandoned due to perceived difficulties in implementing it. But
perhaps this would be the best solution for multiple working
directories problem.

The idea is to add core.gitdir variable to the config, which would
point to "master" (main) GIT_DIR. 

When requesting any file from repository, be it .git/refs/HEAD,
.git/index, .git/refs/heads/master or any other file, git would first
try to find it in the current GIT_DIR, as existing heuristics find it,
and if not found try with GIT_DIR set to core.gitdir. When trying to
create any file, git would check if directories / path leading to file
in GIT_DIR exists, and if not create it under GIT_DIR set to
core.gitdir.

The only exception would be config file, where current GIT_DIR config
would be fourth layer, on top of system-wide config, global (per-user)
config and core.gitdir config.

What do you think of this idea?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
