From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 15:49:32 -0600
Message-ID: <CAMJd5ARLCk_WQTbyLciv0LnrMa_J0YstNsrq-hLYM5DXiO0hLA@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
 <20121108155607.GD15560@sigill.intra.peff.net> <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
 <20121108203332.GQ15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 22:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWZzE-00017Z-1h
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 22:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151Ab2KHVtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 16:49:55 -0500
Received: from mx71.nozonenet.com ([204.14.89.24]:44755 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756531Ab2KHVty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 16:49:54 -0500
Received: (qmail 15110 invoked by uid 399); 8 Nov 2012 16:49:53 -0500
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 8 Nov 2012 16:49:53 -0500
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so4990616iea.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 13:49:52 -0800 (PST)
Received: by 10.42.57.10 with SMTP id b10mr8447836ich.54.1352411392629; Thu,
 08 Nov 2012 13:49:52 -0800 (PST)
Received: by 10.64.28.231 with HTTP; Thu, 8 Nov 2012 13:49:32 -0800 (PST)
In-Reply-To: <20121108203332.GQ15560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209192>

I'm using RHEL4. Looks like perf is only available with RHEL6.

heads: 308
tags: 9614

Looking up the tags that way took a very long time by the way. "git
tag | wc -l" was much quicker. I've already pruned a lot of tags to
get to this number as well. The original repository had ~37k tags
since we used to tag every commit with CVS.

All my tags are packed so cat-file doesn't work:
fatal: git cat-file refs/tags/some-tag: bad file

On Thu, Nov 8, 2012 at 2:33 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 08, 2012 at 11:20:29AM -0600, Uri Moszkowicz wrote:
>
>> I tried the patch but it doesn't appear to have helped :( Clone time
>> with it was ~32m.
>
> That sounds ridiculously long.
>
>> Do you all by any chance have a tool to obfuscate a repository?
>> Probably I still wouldn't be permitted to distribute it but might make
>> the option slightly more palatable. Anything else that I can do to
>> help debug this problem?
>
> I don't have anything already written. What platform are you on? If it's
> Linux, can you try using "perf" to record where the time is going?
>
> How many refs do you have? What does:
>
>   echo "heads: $(git for-each-ref refs/heads | wc -l)"
>   echo " tags: $(git for-each-ref refs/tags | wc -l)"
>
> report? How long does it take to look up a tag, like:
>
>   time git cat-file tag refs/tags/some-tag
>
> ?
>
> -Peff
