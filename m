From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Sun, 11 Nov 2012 20:20:27 +0530
Message-ID: <CALkWK0=zTCXki2c=ugRXE485ps2=OWag7mdzVJW93cnsypwkiA@mail.gmail.com>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
 <1351766630-4837-3-git-send-email-artagnon@gmail.com> <20121108205110.GB8376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 15:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYsJ-00036U-FC
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab2KKOuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:50:50 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60817 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab2KKOut (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:50:49 -0500
Received: by mail-wi0-f172.google.com with SMTP id hm6so1780831wib.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vldGxpvosoYxeapP/9RXvo9ltyyvoS5KqdKGh5CCzm8=;
        b=ELVkjPRkIovc+FKZI7Yd4NvUgz6UN/pkjONmWIy0SsKhAqL8MlFX5JUcIgZIteC8Oe
         xrYerczwM7v13yC95Lf0fQ23k2VPUmgGFzV27Cx3+6o7K8dKRXu/N5/Q4e1peL9zYn0n
         YyQmn8JEkeM1RMnNBnlAqXivrFuyspBQwhJ89DWHSU1z26sZEX+Ia2DywybqKj39Fw6L
         8l3U6EaYQ6W/czeos+Cok4C5PvgZ4h3vlShsm3+ccHBZqOswm4Qn4E3bUQ3fI4tFB4ln
         CsyYgEpND9iIlZ+dNfP/PB3HiVaxjIXyNtYAv9yASqPshzg3O6EfuZLAH7qR2iBbJgYJ
         IVPg==
Received: by 10.180.99.5 with SMTP id em5mr11072514wib.8.1352645448264; Sun,
 11 Nov 2012 06:50:48 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 06:50:27 -0800 (PST)
In-Reply-To: <20121108205110.GB8376@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209389>

Jeff King wrote:
> On Thu, Nov 01, 2012 at 04:13:49PM +0530, Ramkumar Ramachandra wrote:
>
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index 9650be2..6d00311 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -297,6 +297,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>       DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
>>       DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
>>
>> +     /* Set SUBMODULE_LOG if diff.submodule config var was set */
>> +     if (submodule_format_cfg && !strcmp(submodule_format_cfg, "log"))
>> +             DIFF_OPT_SET(&rev.diffopt, SUBMODULE_LOG);
>> +
>
> Yuck. Why is this parsing happening in cmd_diff?

Blame Jens- see this thread |
http://thread.gmane.org/gmane.comp.version-control.git/206816/focus=206815

> Then you can keep the parsing logic for "log" in diff.c. And you should
> factor it out into a function so that the command-line option and the
> config parser can share the same code. I know it's only one line now,
> but anybody who wants to add an option will have to update both places.
> See the parsing of diff.dirstat for an example.

Done.  I'll send out the new series shortly.

Ram
