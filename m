From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Fri, 26 Oct 2012 21:54:59 +0200
Message-ID: <CAC9WiBjiHLJggUzmmx4sPpXNNq=Kz0TOZAzmRShc1AZcPjGvig@mail.gmail.com>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
	<508ADFAE.1050800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:55:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRq0X-0007Y7-4y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966294Ab2JZTzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:55:40 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42398 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966287Ab2JZTy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:54:59 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3009482oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vi5s9zeTh+PjD/caTewNe7JceKtCxG8IPkoRtZr3J30=;
        b=QygE5zZmClaiYfbC/5O5UY7VVkNX7ssCHmurrm0fMUyu0a9vTk+8FzLDKVOvcvofa2
         3pKujoS+61v/5NOkahjfc6R4Z+rAxN++uVOQP02GBdi49EzVf0UI23mRUg1/TXULGxN8
         qpUHIiMEt8FCb9VNpahJvb535efXf5rWIgMiSTDTdGGEf5aapRqe/y1qc4Gi8UkzRdEN
         0j+9l0wdUt2FWlbENRascYXDQv770f304IjGiUCbDMU5zzP91a03rLgoB838fm+4J+QI
         ho5Z8TgHFgdTvDpyXMSKFiDhTnKpP7+UCtBfv81lLGT3T13FSjCB2/f9rb9VlrNWvuig
         LiFw==
Received: by 10.60.26.232 with SMTP id o8mr20179798oeg.7.1351281299395; Fri,
 26 Oct 2012 12:54:59 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Fri, 26 Oct 2012 12:54:59 -0700 (PDT)
In-Reply-To: <508ADFAE.1050800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208488>

Hi,

Thanks for answering

On Fri, Oct 26, 2012 at 9:08 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 26.10.2012 16:07, schrieb Francis Moreau:
>> I'm trying to use the --submodule switch with git-diff but doesnt
>> understand the following behaviour:
>>
>> $ git diff 2c9a257718d1803de720f95766ff256d33accad5 HEAD
>> diff --git a/configs b/configs
>> index 16c6a89..ce12289 160000
>> --- a/configs
>> +++ b/configs
>> @@ -1 +1 @@
>> -Subproject commit 16c6a89f245f0eed7fb0bce8e027c59fcf1d543e
>> +Subproject commit ce12289c5bfca7b2c423d9f1871c13ad1ba1dc32
>>
>> but adding the --submodule option gives:
>>
>> $ git diff --submodule=log 2c9a257718d1803de720f95766ff256d33accad5 HEAD
>> Submodule configs 16c6a89...ce12289 (commits not present)
>>
>> Could anybody enlight me ?
>
> The output "Submodule configs 16c6a89...ce12289 (commits not present)"
> contains same SHA-1s, only in their abbreviated form. That is the same
> information you get without the --submodule option, but in shorter
> format: it says the submodule moved from 16c6a89 to ce12289 in the
> given commit range of the superproject (and the "..." part tells us it
> wasn't a fast-forward). The "(commits not present)" part indicates that
> even though git diff would have wanted to show you what happened in the
> submodule between 16c6a89 and ce12289 by displaying the first line of
> each commit message, it couldn't because these commit(s) are not present
> in the submodule repo. If you do a "git log --oneline 16c6a89...ce12289"
> inside the submodule you'll get an "unknown revision" error for the same
> reason.

Well, no the commits are present in the submodule, that's what I tried
to show with the first 'git-diff' command I did in my previous post
(without the --submodule switch).

And to check again, this is the result of git log:

  $ cd configs
  $ git log --oneline 16c6a89...ce12289
  ce12289 test 2

[...]

> Does that make it clearer?

Unforunately not really.

Thanks.
-- 
Francis
