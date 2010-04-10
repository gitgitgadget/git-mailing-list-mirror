From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git rebase command and docs questions
Date: Sat, 10 Apr 2010 18:30:56 -0400
Message-ID: <s2l76c5b8581004101530h171f3c2dv6a2fc9d4225fbd4e@mail.gmail.com>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
	 <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
	 <7vhbnk1gc6.fsf@alter.siamese.dyndns.org>
	 <l2nfabb9a1e1004091423te78b692btd8bbb03785f94a16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jCi-0004Ab-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab0DJWa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 18:30:59 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:33314 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab0DJWa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 18:30:58 -0400
Received: by bwz25 with SMTP id 25so3299156bwz.28
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QpnkwOyuyK3bewNCBal50fJxwcMv4AVsCUII+RFx2Bs=;
        b=iTUAIhJMUWWLoMo8Er3TJHyt6zVHvzRJpwQOGS3P9Z8JgxuQT5hoT4w+iueWRHnktj
         X68gp/zSb2YZ8AvA8nz0LUK1/GD4hATiRG9jAt6g34Kl+D/NSU3pGzMvmhN4+HQGQe2f
         6Xr6VXB6g13Zb/IfTVHm3CmIjwYIUNJ/0cYYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qTdfq9+JwPliyUqpqu3QW0L/ci0kqH75u+relwKQMVWbQz3OaWc3tqLmwgE1k05uNj
         xnWYi+Ww5pzsZd1IZn01aKiIDq059dIXHqCwSovViezNHhgKf0i4we6o6YfkAFBrSvsW
         jk3BQsMmiOB2dz4xOupox7IoTh2m1C7ZiXWCc=
Received: by 10.204.97.202 with HTTP; Sat, 10 Apr 2010 15:30:56 -0700 (PDT)
In-Reply-To: <l2nfabb9a1e1004091423te78b692btd8bbb03785f94a16@mail.gmail.com>
Received: by 10.204.151.71 with SMTP id b7mr2231329bkw.114.1270938656655; Sat, 
	10 Apr 2010 15:30:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144604>

On Fri, Apr 9, 2010 at 5:23 PM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> Heya,
>
> On Fri, Apr 9, 2010 at 23:11, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Hmm, re*base* means "change the base to _this one_"; the above is mo=
re
>> like "replay these on master", which is often a useful operation but=
 is
>> different.
>
> Yes, I guess that's true.

I'm a bit confused. Isn't the rebase actually replaying the commits
one by one starting from new base instead of old one?
I believe it does apply diffs one by one, else there would be no
conflicts during rebase whatsoever.
Secondly, git complains about range not specified if you will try to
execute something like

git rebase --onto  master topic

when topic is not direct descendant of master.
Git will say "not a range".

So, That's why i make a conclusion that the real meaning of

git rebase --onto master next topic

is very close if not exactly matching the

git rebase --onto master next..topic

>
>> If you _had_ your "replay" command, the workflow for this would be:
>>
>> =C2=A0 =C2=A0$ git checkout -b maint-fixes origin/maint
>> =C2=A0 =C2=A0$ git replay origin..fixes
>
> True again.
>Yep therefore the interface
>
>> Before somebody else makes useless noises, "cherry-pick" could be a =
good
>> command in the existing UI set to do that kind of thing.
>
> I still think the UI for --onto is awkward. At the very least it shou=
ld be:
>
> git rebase --fork-at=3Dorigin origin/maint fixes
>
> Or something like that. Since currently you suddenly have to specify
> an argument to --onto that was previously positional. Does that make
> sense?
>
> Case 1:
> git rebase origin fixes
> git rebase <new_base> <tip>
>
> Case 2:
> git rebase --onto origin/maint origin fixes
> git rebase --onto=3D<new_base> <fork_point> <tip>
>
> I know that in the --onto case <new_base> is not an argument to
> --onto, but that's what it looks/feels like.

How is that possible that it is not an argument to --onto???

from docs:

SYNOPSIS

git rebase [-i | --interactive] [options] [--onto <newbase>]
        <upstream> [<branch>]
git rebase [-i | --interactive] [options] --onto <newbase>
        --root [<branch>]
git rebase --continue | --skip | --abort

When i'm executing
git rebase --onto master next topic

master is exactly the new base, new fork point for topic, which was
previously forked from next!

>Said differently, it's
> just _really weird_ that a new argument (for a different mode) shows
> up between two other arguments. It should either be at the beginning,
> or at the end, but in the middle is just awkward, no?
>
> So another solution might be to change the position of the
> <fork_point> in the --onto case.
>
> --
> Cheers,
>
> Sverre Rabbelier
>
