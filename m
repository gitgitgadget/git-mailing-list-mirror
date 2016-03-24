From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] submodule: fix recursive path printing from non root directory
Date: Thu, 24 Mar 2016 16:44:48 -0700
Message-ID: <CAGZ79kaDwEhGB7aVVWnZEOgPCm2_yAprroz6Fn37DvLC8vNbfw@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-2-git-send-email-sbeller@google.com>
	<CA+P7+xqbkK7GKf5=eFVYkBzmrjy9hOsWGTn0W31qWiT-0ZhuPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:44:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEvu-000339-IR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbcCXXov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:44:51 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35280 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcCXXot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:44:49 -0400
Received: by mail-ig0-f178.google.com with SMTP id cl4so3184859igb.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qXB8kSj8bmW9RduK1Hbc/cRc3to7LZMqXTC5U7vvz/U=;
        b=MhdX0W6RJxdYTyrKepuoOLUC51v96CdT5pQ4RMB3qDZrGuqfnii2HKtWz0l+q4lR1W
         5g4ETav9OoPrzql7MxO1p5BGl9/3TmyDwb0O1jc2e+1+QWl3CA5ebl1sHrHL46yD6aUF
         lrKRJ2jY+xA9NR0Jieo37Ecz8ij+BEmv9Y0OG8rVgR6HXzB/rLCo+/7HqNpQdMBjKZMh
         OqIhpW9Wpcwkt1yw3p2Vv9KWoKYEzDNKs7k2I0HkhWkqQazJnNxWFed05P1hKBM+KrEl
         XHkcBj7SggNdVewdH0py50iL9b+Ap6FpAIUEJfwN18w2MmSia6JWvjbok5qp5MJnlzkA
         eUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qXB8kSj8bmW9RduK1Hbc/cRc3to7LZMqXTC5U7vvz/U=;
        b=dO7sMfFXeF18H3LveswtPRd8l6VN8zSjlmOd7Bso0ATyWB2PMagbCs6kOs7vljL/eE
         CA2rjOrq5UaKKtB5VOIR/b7eR6Dq7FyYoowRFUmYaOOazuR4oA4XghaAwa62mJHNKnGC
         NC3pOuHEa6RfIUXhcXGYyo6Aixq8hgRB1Kp8I1RebPIeK7WIqksWbAxnPG7Pfjc8VBiD
         A68gHdew/qCudJxVJQXpv8Elpm99ppkRygOFYGtEj89roSucwvU0MJ++uZdmBKKZV8+A
         gvPwIeXnELLi4M+uA4s9yOmlEYf1zjhf/Huk3oe0Ys9SjoyhMA9T/DW27sZsMdGv8s7C
         ck/g==
X-Gm-Message-State: AD7BkJJdyauQU//7n3XmhCOIsW9wLlzfnGGzkYahB6L/rB78kTU5Q5X8l+WxM6vonmio1YEWg1A5ikOlAObdKXNX
X-Received: by 10.50.13.34 with SMTP id e2mr26318434igc.85.1458863088316; Thu,
 24 Mar 2016 16:44:48 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Thu, 24 Mar 2016 16:44:48 -0700 (PDT)
In-Reply-To: <CA+P7+xqbkK7GKf5=eFVYkBzmrjy9hOsWGTn0W31qWiT-0ZhuPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289830>

On Thu, Mar 24, 2016 at 4:38 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Mar 24, 2016 at 4:34 PM, Stefan Beller <sbeller@google.com> wrote:
>> Recursing into submodules currently works by just calling
>> (cd $submodule && eval <command>) for update, sync and status
>> command.
>>
>> Say you have the following setup
>>
>> repo/ # a superproject repository
>> repo/untracked/ # an untracked dir in repo/
>> repo/sub/ # a submodule
>> repo/sub/subsub # a submodule of a submodule
>>
>> When being in repo/untracked/ and invoking "git submodule status"
>> you would expect output like:
>>
>>     repo/untracked/$ git submodule status --recursive
>>      <sha1> ../sub (version)
>>      <sha1> ../sub/subsub (<version>)
>>
>> We need to take into account that we are in the untracked/ dir,
>> so we need to prepend ../ to the paths. By using relative_path
>> to compute the prefix, we'll have that output.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 43c68de..536ba68 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -825,7 +825,7 @@ Maybe you want to use 'update --init'?")"
>>                 if test -n "$recursive"
>>                 then
>>                         (
>> -                               prefix="$prefix$sm_path/"
>> +                               prefix="$(relative_path $prefix$sm_path)/"
>>                                 clear_local_git_env
>>                                 cd "$sm_path" &&
>>                                 eval cmd_update
>> @@ -1233,13 +1233,13 @@ cmd_sync()
>>                         then
>>                         (
>>                                 clear_local_git_env
>> +                               prefix=$(relative_path "$prefix$sm_path/")
>
> Not really sure why this got moved, but I don't think it hurts
> anything, though we will have prefix defined now regardless of if
> we're recursive or not. But I think that's correct.

"Because we need to move it before the cd". At least I thought so at
the time of writing. That is actually not the case.

At the time of writing this was intertangled with the next patch,
and we need to put the call to relative_path before the reassignment
of wt_prefix as relative_path depends on wt_prefix, which I put at the
same place as the cd in an initial version when coming up with that patch.

In case of a resend, consider this fixed.

>
>>                                 cd "$sm_path"
>>                                 remote=$(get_default_remote)
>>                                 git config remote."$remote".url "$sub_origin_url"
>>
>>                                 if test -n "$recursive"
>>                                 then
>> -                                       prefix="$prefix$sm_path/"
>>                                         eval cmd_sync
>>                                 fi
>>                         )
>> --
>> 2.8.0.rc4.10.g52f3f33
>>
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> Regards,
> Jake
