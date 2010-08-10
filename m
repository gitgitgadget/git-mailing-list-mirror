From: Chris Mear <chrismear@gmail.com>
Subject: Re: workflow for working on feature branches and incrementally 
	incorporating "master" changes
Date: Tue, 10 Aug 2010 23:05:16 +0100
Message-ID: <AANLkTi=vscGSErrV_6xBqmryc1hFqi4bjmyOTVgTLNsS@mail.gmail.com>
References: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 00:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiwyC-0003TE-H2
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 00:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828Ab0HJWFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 18:05:30 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35933 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719Ab0HJWFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 18:05:17 -0400
Received: by qyk7 with SMTP id 7so7936759qyk.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=i4ViNIorUpclby5jqq7ANdvhaTzu7AEBhxo2AaxqGPQ=;
        b=XXlqIvjtaMr5XwAIDHLZ+clFuKWOQeCpB23BBcjc2pk65fiQO2v33zv9ClkVjojNMQ
         +4F7rWfercgXLupnj3CP2byzZATC3Vd5KMgRBdSTYD4FznSfxpcwHfd//m5wzZJAvJ7z
         vUUQyi/4d4nAiQoDTxLOKHCIEYj9mwzw36Yi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UCaaGbSqWosOOJbHwiuYEZ5JOdm3TuZri4yWVcYik/eYWeElQsiRsiJMdnUMdxvRjn
         UANKgD6ugd5WyM3MhD4cAzowTt74ElI3+CE5LIZHdRwcHOvckgqym4PmiyyasvfTjsLd
         f/x4xZhxXBFbx57G0HrXjFt7+pwtyirKW78Dw=
Received: by 10.224.37.78 with SMTP id w14mr9909236qad.75.1281477916769; Tue, 
	10 Aug 2010 15:05:16 -0700 (PDT)
Received: by 10.229.188.4 with HTTP; Tue, 10 Aug 2010 15:05:16 -0700 (PDT)
In-Reply-To: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153163>

On 10 August 2010 21:20, Bradley Wagner <bradley.wagner@hannonhill.com> wrote:
> If you're working on a feature branch by yourself, what is a good
> workflow for keeping the branch in up-to-date with "master" as you're
> developing on the feature branch or is this unnecessary? Should you
> just wait until you want to officially integrate the feature branch
> into the "master"?
>
> We were doing:
>
> commit to local feature branch
> push to remote feature branch
> ... repeat....
> rebase from master (occasionally)
> push to remote
>
> but at this point the branches have diverged.
>
> We're coming at this from SVN, so we might just be thinking about this
> the wrong way.

Git's rebase feature is a *very* nice, clean way to keep a feature
branch up to date with the master branch. But, as you've seen,
rebasing can make things a bit confusing you need to push that feature
branch to other people.

I've found that a good rule of thumb is to never rewrite (i.e. rebase)
branches that have already been shared with others. Of course there's
nothing impossible or fundamentally bad about pushing rewritten
branches like this. But, unless people are expecting it to happen and
know how to deal with it when they pull, it can cause confusion,
particularly on teams that are just getting acquainted with Git.

Instead, if a feature branch is going to be shared with others, and
it's going to be long-lived, then we keep it up-to-date by merging
from master every now and again, rather than rebasing.

On the other hand, if I'm working on a feature branch by myself, and I
haven't shared it with anyone yet, I frequently rebase against master
to keep things clean. I also use interactive rebase a lot to tidy up
commits. But as soon as I've shared my branch with the team, I no
longer do any rebasing/rewriting.

If there are Git wizards on your team, it is true that they may find
this an inflexible way of working. But I've found it to be a good
compromise between ease of pulling and maintaining a clean commit
history.

Chris
