From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 14:12:29 -0400
Message-ID: <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
	<CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
	<CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 19:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFTh5-0004VM-A8
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 19:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262Ab3CLSMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 14:12:31 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51130 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab3CLSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 14:12:29 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so120731pbc.36
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=c0RDISz/9DDcR18XBfCp/N/TEdKWDKcbPGM/h++x5k0=;
        b=N1Jn//eMYJaSwSkzctKrUTxpAuyJ3KCMz2iNpiqFNOyXssFfZp0GBjfRMcZNpC6UIS
         wvQnnflxYkxSBt4vfV0TM2lTS9g634tHlJZDoQmiMxmW++do2gg//6UktSPxLW5z+gmk
         hzaEEDhRclO0JTHeUYCfq2OaJwtU8M5B0mhEIAiI4HmeJbH1wtYsccwJI+G5eYTK3CM2
         u8D9X3QFZJGXb3clzeRK0CLQK0+nU8hPSRd4/31v7FwFSryFjBlCbW8HahmcRHnayYvs
         mxE/EVcg25s3mHg5sNoNd2vzRnzku0+7WGjkqDSt9F+Sahn/jYxRpGjhYhHXTuuUTORj
         fcgg==
X-Received: by 10.68.227.202 with SMTP id sc10mr38916418pbc.109.1363111949157;
 Tue, 12 Mar 2013 11:12:29 -0700 (PDT)
Received: by 10.68.49.65 with HTTP; Tue, 12 Mar 2013 11:12:29 -0700 (PDT)
In-Reply-To: <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217979>

On Tue, Nov 27, 2012 at 7:41 AM, Matt McClure <matthewlmcclure@gmail.com> wrote:
>
> On Tuesday, November 27, 2012, David Aguilar wrote:
>>
>> It seems that there is an edge case here that we are not
>> accounting for: unmodified worktree paths, when checked out
>> into the temporary directory, can be edited by the tool when
>> comparing against older commits.  These edits will be lost.
>
>
> Yes. That is exactly my desired use case. I want to make edits while I'm reviewing the diff.

I took a crack at implementing the change to make difftool -d use
symlinks more aggressively. I've tested it lightly, and it works for
the limited cases I've tried. This is my first foray into the Git
source code, so it's entirely possible that there are unintended side
effects and regressions if other features depend on the same code path
and make different assumptions.

https://github.com/matthewlmcclure/git/compare/difftool-directory-symlink-work-tree

Your thoughts on the change?

--
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
