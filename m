From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Sat, 31 Aug 2013 14:33:52 -0500
Message-ID: <CAMP44s1hhoPbeBsmN8NL_VtCz3bO-jg1sPP7hovL1kPBhbrXFQ@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
	<xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqvm-0001su-6F
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab3HaTdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:33:54 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:37803 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab3HaTdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:33:53 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so2496592lab.17
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7YmM/8u5ajfyPxv9AZBgghA6Ucou4qtpfoOurDZ9UMo=;
        b=gWYedNvXH7o1UkaOAnmhbQX6gX79y8645W6CAr9nxAWk2ggrILWTRE2E7dg5v4TC7X
         xveFofosz7L7KVOpA1DKn6hOo42RxA9vAnXhdz58u2WO76vA9qqZNzRurSe8TzjDcxn8
         a1FMPT+Pux7kwgC6lMpT917um1E+FdlvUT4DF9310fOZPbqHMO6lqdm4XqWAs6d/z/yD
         lDq2oLwnU7OsN2fFgRPQ7au/U96m43fwfyAKPL+ajtxexgINqgS2AGGNqd81qsv24WG1
         syws8ZjyGv6FEl0MSDej94vJ4suJ8H7tCPQKXPJrqAl4UPgPuTBZ/aAq/QfBnTLUMDbo
         dbSw==
X-Received: by 10.112.52.225 with SMTP id w1mr2475594lbo.31.1377977632201;
 Sat, 31 Aug 2013 12:33:52 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 12:33:52 -0700 (PDT)
In-Reply-To: <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233545>

On Fri, Aug 30, 2013 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> People often find "git log --branches" etc. that includes _all_
> branches is cumbersome to use when they want to grab most but except
> some.  The same applies to --tags, --all and --glob.

This idea looks very familiar, from the wording of this commit message
it seems you came with the idea out of nowhere. Did you?

> Teach the revision machinery to remember patterns, and then upon the
> next such a globbing option, exclude those that match the pattern.
>
> With this, I can view only my integration branches (e.g. maint,
> master, etc.) without topic branches, which are named after two
> letters from primary authors' names, slash and topic name.
>
>     git rev-list --no-walk --exclude=??/* --branches |
>     git name-rev --refs refs/heads/* --stdin

My patch does the trick with:

--branches --except --glob='heads/??/*'

-- 
Felipe Contreras
