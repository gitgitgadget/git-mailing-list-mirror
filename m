From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is used
Date: Fri, 5 Jul 2013 21:13:42 +0200
Message-ID: <CALWbr2y52fHae=svf6vct1gRR-o1ocG_iF3yppHDipx1jjuODg@mail.gmail.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
	<20130704103440.GH9161@serenity.lan>
	<CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
	<20130704111901.GI9161@serenity.lan>
	<CAGHpTBJzwuPw6u=DKUkik5w=hQoCF3F_4wqjuU3UJ528gfcdpA@mail.gmail.com>
	<CALWbr2zAt4a6vkQy8PhP-dH5eZ9_5VMzbiWqSEKE_1V5rsfh+A@mail.gmail.com>
	<CAGHpTBJhwzLdxiTynx-eBWj7wUwe4e6HPAB4g0jDHTeVF2rfeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git <git@vger.kernel.org>
To: Orgad Shaneh <orgads@gmail.com>, Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 21:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvBRz-0002hy-HE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 21:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3GETNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 15:13:43 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:64646 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3GETNn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 15:13:43 -0400
Received: by mail-qc0-f179.google.com with SMTP id e11so1408314qcx.10
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aAr8SZT4D/8e1r0oaONBeKRBTwfcmodN18NcaF2yeEU=;
        b=qb6v7QmXtMXFnFbhnh5wYTDtIqst8K0ksreO78u6eR8CEK6l4JQZpNmjxhCQGpcCmH
         uf44i13zcxQPT6qWZG9xEVB3RB/5wmA1f3+PMoHZpmVmmxRhGKwzJh8neq0m39W0AoTJ
         PetTFHgNCIUqt3NEKcYoPY8p4LDifqNWIDtIHbR1d9HUI35c/mN6BqlPMs5N2oqYte0Q
         DcVsIV+ujyD17gzQF5BycSMXETr5H/hMIuHegrH6Y5cVPjKJ/cHmfblQ2dl4tAASCNNq
         EXAs1FSnsIjXx3HiOdXzEo22H9nHqnhEFS6Gv9igeShJRD+z0pNZX/Uvg++bKVPgCPRc
         +TSg==
X-Received: by 10.49.5.133 with SMTP id s5mr6568194qes.96.1373051622407; Fri,
 05 Jul 2013 12:13:42 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Fri, 5 Jul 2013 12:13:42 -0700 (PDT)
In-Reply-To: <CAGHpTBJhwzLdxiTynx-eBWj7wUwe4e6HPAB4g0jDHTeVF2rfeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229679>

On Thu, Jul 4, 2013 at 2:46 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> On Thu, Jul 4, 2013 at 3:42 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>>> Your problem is that your hook script is not checking $2 so it is
>>>> overwriting the message even when you do not want to do so.
>>>
>>> No, it isn't. Not by git-gui at least. Check /tmp/hook.log with the
>>> hook I provided...
>>
>> So what you mean is that the hook is not executed with the correct parameters?
>> Could you please provide the output of the /tmp/hook.log file (I can't
>> reproduce right now) ?
>
> It only runs for "New commit" (possibly with merge or squash as
> arguments). In my case the log is:
> .git/PREPARE_COMMIT_MSG
> .git/PREPARE_COMMIT_MSG
> .git/PREPARE_COMMIT_MSG
> ...
>
> Not running the hook for amend is another problem.
>
> What I referred to was that handling the hook's result is done without
> checking if the state has changed while it was running, like Fredrik
> has already pointed out.

Yep, I've had a quick look at that, and clearly the problem seems to
come from git-gui.
I have absolutely no knowledge of TCL so I won't be able to help.
Indeed, from what I've seen it looks like prepare-commit-message hook
is not called in amend case.

I cc'ed Pat Thoyts as he's the maintainer of git-gui.

Sorry for not being able to help any further on this one.

Antoine,
