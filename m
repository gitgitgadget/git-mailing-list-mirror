From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] contrib: teach completion about git-worktree options
 and arguments
Date: Fri, 21 Aug 2015 17:59:15 -0400
Message-ID: <CAPig+cQ9Rema_n1xBJQNSv9i75sGT=RWu1AheWJFTBMa89DyFA@mail.gmail.com>
References: <1437684550-21884-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cQhh7YCiirp4a1+R0bWh46JoFgVOVUCNidTWXK8uNL2Mg@mail.gmail.com>
	<xmqq37zc7e2o.fsf@gitster.dls.corp.google.com>
	<20150821224918.Horde.edB9u314lsP17FLUzwFsQA1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSuLJ-0004oW-3m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 23:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbHUV7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 17:59:16 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36275 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbbHUV7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 17:59:16 -0400
Received: by ykfw73 with SMTP id w73so84318184ykf.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Lgp/vztvA1Y6e/PVshEptDGBYHfMFBRWeZL8fWt/uXE=;
        b=qEx6a/MN++kb1eiwU/0BmW36dvUKxWSaA8NsNeM/lV1HedJHLJ4yf2ILXTuLnOTyVp
         Jh7Ws6MwoQTM8xLpGZV4J5bsjvVpUIzpmBZFM1j2ksBfWpQwv3UY/Hu+xWfrPOnCvCuu
         +NSyYmTTDte5RDBD/NPY5cVLL9oJR59+5oBASXZMXLI9PeI43HowfZql1dpNfvMBrZ/b
         0K7ko4roLQI0KtjPGfIcx/Lu7eYOCmuv1fp59GpAylk2JtxJqQnRY/rKlRLFAl/AG8Td
         G7owLABjiefmB8nprEzt9v9ZP7c6UAK+x6NsEzUpRvBPIBVadJduacesi9E3C0W47iN+
         AxDA==
X-Received: by 10.170.172.84 with SMTP id o81mr15099591ykd.69.1440194355421;
 Fri, 21 Aug 2015 14:59:15 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 21 Aug 2015 14:59:15 -0700 (PDT)
In-Reply-To: <20150821224918.Horde.edB9u314lsP17FLUzwFsQA1@webmail.informatik.kit.edu>
X-Google-Sender-Auth: xVQINY_Elo_9DA58_Cs3reiWmHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276337>

On Fri, Aug 21, 2015 at 4:49 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Quoting Junio C Hamano <gitster@pobox.com>:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> On Thu, Jul 23, 2015 at 4:49 PM, Eric Sunshine <sunshine@sunshineco=
=2Ecom>
>>> wrote:
>>>> Complete subcommands 'add' and 'prune', as well as their respectiv=
e
>>>> options --force, --detach, --dry-run, --verbose, and --expire. Als=
o
>>>> complete 'refname' in "git worktree add [-b <newbranch>] <path>
>>>> <refname>".
>>>
>>> Ping[1]?
>>
>> Ping indeed?
>
> Yeah, right, sorry.  Non-subscribed occasional gmane-reader here amid=
st
> job hunting, so thanks for the ping.  And the re-ping...

Thanks for the review.

>>>> +_git_worktree ()
>>>> +{
>>>> +       local subcommands=3D'add prune'
>>>> +       local subcommand=3D"$(__git_find_on_cmdline "$subcommands"=
)"
>>>> +       local c=3D2 n=3D0 refpos=3D2
>
> A more descriptive variable name for 'n' would be great.

Indeed. I was planning on resubmitting with better variable names
(even if I didn't get any feedback)...

>>>> +       if [ -z "$subcommand" ]; then
>>>> +               __gitcomp "$subcommands"
>>>> +       else
>>>> +               case "$subcommand,$cur" in
>>>> +               add,--*)
>>>> +                       __gitcomp "--force --detach"
>
> We usually don't offer '--force', because that option must be
> handled with care.

As a person who never uses git-completion (or git-prompt), I wasn't
aware of that, so thanks for the heads-up. I only installed completion
(and prompt) when I decided to work on this (and I don't think I've
used tab-completion since then).

>>>> +                       ;;
>>>> +               add,*)
>>>> +                       while [ $c -lt $cword ]; do
>>>> +                               case "${words[c]}" in
>>>> +                               --*) ;;
>>>> +                               -[bB]) ((refpos++)) ;;
>>>> +                               *) ((n++)) ;;
>>>> +                               esac
>>>> +                               ((c++))
>>>> +                       done
>>>> +                       if [ $n -eq $refpos ]; then
>
> I suppose here you wanted to calculate where (i.e. at which word on
> the command line) we should offer refs and fall back to bash builtin
> filename completion otherwise.  It works well in the common cases,
> but:
>
>   - it doesn't offer refs after -b or -B

That was intentional since this is a new branch name, so it didn't
seem sensible to offer completion of existing refs. On the other hand,
it doesn't make much since to offer pathname completion either, but I
didn't see a better alternative. On reflection, I suppose ref
completion can make sense if the new branch name is going to be
similar to an existing one.

>   - it gets fooled by options to the git command, e.g. 'git
>     --git-dir=3D.git worktree add <TAB>' offers refs instead of files=
,
>     'git --git-dir=3D.git worktree add ../some/path <TAB>' offers
>     refs, etc.

This shortcoming could be addressed by computing relative to the
subcommand-index as your version does, correct?

I don't have enough background with the (git-specific) completion
facility to be able to judge if this patch and approach has merit and
ought to be pursued further, or if it would be better to drop in favor
of (some version of) your patch. I don't care strongly, and am fine
with dropping this patch if it's approach is suboptimal.

>>>> +                               __gitcomp_nl "$(__git_refs)"
>>>> +                       fi
>>>> +                       ;;
>>>> +               prune,--*)
>>>> +                       __gitcomp "--dry-run --verbose --expire"
>>>> +                       ;;
>>>> +               esac
>>>> +       fi
>>>> +}
>>>> +
