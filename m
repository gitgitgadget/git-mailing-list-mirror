From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Wed, 22 Jul 2015 23:32:49 -0700
Message-ID: <CA+P7+xrNiK168rXX3SwwmQFPR6i4iA0nhFdfHKL7wqwtwvnEPA@mail.gmail.com>
References: <20150723012343.GA21000@peff.net> <20150723044007.GA3651@gmail.com>
 <20150723051445.GA24029@peff.net> <20150723054816.GA1917@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIA4S-0004y1-U3
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 08:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbGWGdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 02:33:13 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35037 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbGWGdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 02:33:09 -0400
Received: by igr7 with SMTP id 7so86345845igr.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/ZlYF4kAhNS5Zk01j25h9+sZUhGUgLZ0YV/Ti/b4dTI=;
        b=mRnmdC+cZcfZzPqz3rnFeqiyBTH/XoPXh2ntDSAWbZbeu3F9aqRHgT267maic+hwWT
         hUE+fNkkjR+FhHJV1yg2Kjqb2YngyKCRZLI2ejCzO/bnM2UF05MJu4yRUuleZsk7PU+w
         dd7NKgCFec5uazMdk8bHw7vaG9MBt0cL0JCCdnMofUPCqE+UeKbXGOK7tsotzPeGu9RS
         INyDPGupxkLBRqd3AxmgeeJavht1bsD03HrP968IHXALZmdZOfIPQjqkD8DtIrzf3Ssu
         kThT7EIbcqk968xFnOXJlOhF1Uf/QcaJMr+46FVIojzb4bO6LZAVhP2Z2B9TyWnZqrkr
         D9sw==
X-Received: by 10.50.88.6 with SMTP id bc6mr11748219igb.24.1437633188504; Wed,
 22 Jul 2015 23:33:08 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 22 Jul 2015 23:32:49 -0700 (PDT)
In-Reply-To: <20150723054816.GA1917@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274482>

On Wed, Jul 22, 2015 at 10:48 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 22, 2015 at 10:14:45PM -0700, Jeff King wrote:
>
>> Script writers should not care here, because they should not be parsing
>> the output of the porcelain "log" command in the first place. It already
>> has many gotchas (e.g., log.date, log.abbrevCommit).
>>
>> I am sympathetic, though. There are some things that git-log can do that
>> rev-list cannot, so people end up using it in scripts. I think you can
>> avoid it with a "rev-list | diff-tree" pipeline, though I'm not 100%
>> sure if that covers all cases. But I would much rather see a solution
>> along the lines of making the plumbing cover more cases, rather than
>> trying to make the porcelain behave in a script.
>
> Ah, I see in a nearby thread that you just recently fixed a problem with
> git-subtree and log.date, so I see now why you are so interested. :)
>
> And I was also reminded by that usage of why rev-list is annoying in
> scripts: even with "--format", it insists on writing the "commit ..."
> header. I wonder if we could fix that...
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Agreed. Fix the plumbing instead and document how/why to use it
instead of the porcelain. We might do better to help clearly document
which commands are porcelain and which are plumbing maybe by
referencing which plumbings to use in place of various porcelain
commands. I know, for example, that git status already does this.

Regards,
Jake
