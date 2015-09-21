From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Mon, 21 Sep 2015 17:22:20 -0400
Message-ID: <CAPig+cRnVzRoyKOzPSJZd4JK_hB+_CBn0kjg4yYv=wWb-5vf7w@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441633928-18035-1-git-send-email-bernat@primeranks.net>
	<CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
	<xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
	<CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
	<xmqq6133a6tf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 23:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze8l4-0005zW-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 23:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbbIUVgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 17:36:13 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36255 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355AbbIUVgM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 17:36:12 -0400
X-Greylist: delayed 831 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2015 17:36:12 EDT
Received: by vkgp185 with SMTP id p185so7626075vkg.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=pRInCUV6tlVLX1VfvlbXCAoplNMJFKOo1hxDgOWT3GM=;
        b=KdMMKPOiBHcMbyTMYVc9IN9SWetf/nAh+egvne1KKLQcewEgcXZyIBXM+pqYTCMb7t
         dIeXiNnWEGzjJ9eCFdaQ/+bdjuj0s44B6O5EihVtzBd28OuqTmide5kbzKQumiA1RQbY
         eTo/80+22qoJWrWx1Qa7Ou+xxgSTn4q9+7x6Hu5JcRQV1QMEg6SwXS3VhYjwPMGXTlAs
         dyWTbAy0+1PQt+/1IuQHdj+yz1RFQvAyz4NbLD7gWN+k/3dO6oJDp0aBiO0cdhEI6MAw
         1L4Xx0SEEgODlyC73Ic9jwvflssWD479G3Qcefif38EMJNr+G3FN7I/yqZQib1E+dKbg
         9xrw==
X-Received: by 10.31.151.84 with SMTP id z81mr14221185vkd.14.1442870540673;
 Mon, 21 Sep 2015 14:22:20 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 14:22:20 -0700 (PDT)
In-Reply-To: <xmqq6133a6tf.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: XHOt-uh37I5eapaJKKA0hGyAKi4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278332>

On Mon, Sep 21, 2015 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Tue, Sep 8, 2015 at 1:32 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>> On Mon, Sep 7, 2015 at 9:52 AM, G=C3=A1bor Bern=C3=A1t <bernat@pri=
meranks.net> wrote:
>>>>...
>>>>>  # Rewrite the commits
>>>>> +report_progress ()
>>>>> +{
>>>>> +if test -n "$progress"
>>>>> +then
>>>>
>>>> Indent code within the function...
>>>
>>>>> +printf "\rRewrite $commit ($git_filter_branch__commit_count/$com=
mits)$progress"
>>>>
>>>> The "\r" causes this status line to be overwritten each time throu=
gh,
>>>> and since the processed commit count always increases, we know tha=
t
>>>> the original (without ETA) will never leave junk at the end of the
>>>> line. However, with estimated seconds also being displayed, does t=
his
>>>> still hold?
>>>
>>> Good point.
>>> Perhaps like this squashed in?
>>>
>>> -printf "\rRewrite $commit ($git_filter_branch__commit_count/$commi=
ts)$progress"
>>> + printf "\rRewrite $commit
>>> ($git_filter_branch__commit_count/$commits)$progress "
>>
>> Yes, for an expedient "fix", this is what I had in mind, although I
>> would also have added an equal number of backspaces (\b) following t=
he
>> spaces, as a minor aesthetic improvement.
>
> This topic seems to have stalled.  I do not want to discard topics
> because that means all the effort we spent to review and polish the
> patch so far gets wasted, but we cannot leave unfinished topics
> linger for too long.
>
> For now, I'll queue this SQUASH??? on top as a minimum fix (renaming
> of variables and other things noticed during the review may be worth
> doing, but they are not as grave as the issues this fixes, which are
> show stoppers).

Looks like a reasonable squash for moving this topic forward. Thanks.

> I do not think our in-core progress code does that (and we do not
> use ESC[0K either), so I'll leave it out of the minimum fix.
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 565144a..71102d5 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -277,9 +277,8 @@ test $commits -eq 0 && die "Found nothing to rewr=
ite"
>  # Rewrite the commits
>  report_progress ()
>  {
> -if test -n "$progress"
> -then
> -       if test $git_filter_branch__commit_count -gt $next_sample_at
> +       if test -n "$progress" &&
> +               test $git_filter_branch__commit_count -gt $next_sampl=
e_at
>         then
>                 now_timestamp=3D$(date +%s)
>                 elapsed_seconds=3D$(($now_timestamp - $start_timestam=
p))
> @@ -292,8 +291,7 @@ then
>                 fi
>                 progress=3D" ($elapsed_seconds seconds passed, remain=
ing $remaining_second predicted)"
>         fi
> -fi
> -printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits=
)$progress"
> +       printf "\rRewrite $commit ($git_filter_branch__commit_count/$=
commits)$progress    "
>  }
>
>  git_filter_branch__commit_count=3D0
> --
> 2.6.0-rc2-220-gd6fe230
