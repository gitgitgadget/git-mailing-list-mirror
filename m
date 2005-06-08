From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Wed, 8 Jun 2005 10:54:16 +1000
Message-ID: <2cfc403205060717543891334f@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
	 <20050607094947.GC2676@pasky.ji.cz>
	 <2cfc403205060702594da21fb1@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jun 08 02:51:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfom9-0001qL-Ps
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 02:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVFHAyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 20:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVFHAyX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 20:54:23 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:6674 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262056AbVFHAyQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 20:54:16 -0400
Received: by rproxy.gmail.com with SMTP id i8so83610rne
        for <git@vger.kernel.org>; Tue, 07 Jun 2005 17:54:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XswM5kUrASN7GwMMr1mSdH6O1N3/qowT67MYiC2t+w6jMD+jsfWUix4FMZpvdIIr6TEWeL7F2Yx0d9z44xLoA5WiSwyuBRCZl2W5Q2lLvPRB49oxMGjxEHC9xW479QwUqp/dwEk1cBGkFZlCAFBYohrdWC6Z4bWVK6vKmylvkwA=
Received: by 10.38.92.63 with SMTP id p63mr3396156rnb;
        Tue, 07 Jun 2005 17:54:16 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 7 Jun 2005 17:54:16 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205060702594da21fb1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

| not sure why, but my first attempt to post this to the list didn't
seem to make it

| I've also modified my response slightly to suggest an alternate name for the
| --exclude-author swtich which may partly address pasky's concerns. amended
| response marked with ***

On 6/7/05, Petr Baudis <pasky@ucw.cz> wrote:
>
> I'd prefer just --wrt-author and --exclude-author to take an argument on
> their own.

The reason I don't want to do this is that it doesn't really make
sense in the context of the change to specify one author for
--wrt-author and another for --exclude-author. In normal use --author
defaults to GIT_AUTHOR_EMAIL or the locally derived user@host.domain.
The  intention is simply to override this default derivation.

*** That said, it might better if --exclude-author was called
something like --following-author --after-author or --stop-at-author,
since its meaning is to stop traversal rather than simply omit match
entries which is the meaning that a reasonable user might attach to
use of the word "exclude"

My preference is --following-author.

Thoughts anyone?

>
> (Note that I don't endorse this patch and the --wrt-author behaviour in
> particular seems strange. I don't have enough time to comment on it
> sensibly now, though. I'm just focusing on style here since I'd like to
> still be able to read git's source code few weeks from now on.)

The rationale for the change is as follows:

During parallel development, one is aware of ones own
changes...everyone else changes haven't happened yet as far as you are
concerned. Only when they appear in a future merge that incorporates
one's own changes do the other changes appear in your own workspace.

As far as you are concerned, these changes occurred after you made
your own - your changes were not dependent on those changes, only on
those that came before. So the linearisation reflects that perceived
ordering of changes.

--wrt-author helps to reconstruct the merge-history from the
perspective of each individual committer.

Let me know if this doesn't explain the rationale completely enough
for your understanding.

jon.
