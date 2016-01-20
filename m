From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] git submodule: Teach add to accept --group
Date: Wed, 20 Jan 2016 15:57:46 -0800
Message-ID: <CAGZ79kaHLkQpaHOY2aqPgdNvWjmpbuMZSogqzPkkVHRUXyibYw@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-2-git-send-email-sbeller@google.com>
	<xmqq1t9c54qz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:57:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2dM-0002MG-8g
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 00:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbcATX5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 18:57:49 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38629 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbcATX5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 18:57:47 -0500
Received: by mail-ig0-f181.google.com with SMTP id mw1so23179556igb.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X41tWPf0wxsdmUxfe0j2mhEuUoMjQPNtkBffsuJRT/0=;
        b=mgNB+v1shBvmTbMOUMblgZpfPT8ewpOloBIYuC15qramCYiNx9+s/L5NHnCQvIlL/h
         MsnqwndaG8h+7tFs4jVdox51UiIc22v0OQ7b3VuS2mnxabYVOznZN0kQs37EYmVNrfvY
         IpepW29wjbUV8Urgm2wN8hUTq2eeyOjeJ5PIhale57BF3lbiR3o1u3AEEYNrJQ9FBNBl
         1imDGYv4VfRuViEPuPJK+Sqj5LHpI4ECcUv0o1GRSrquDSGCf02q4M53xlCTbUwUwIXu
         IN296wxe/fRnZQw15Fl47xYYb5EHM3fZsCkx12xxIDQ9OEmizmMXrNfQRSJwbFKmXn47
         G6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X41tWPf0wxsdmUxfe0j2mhEuUoMjQPNtkBffsuJRT/0=;
        b=XpEehgny0peFihCXhPtFVKBq76sbp7qk8/V/iO/i9/joW3zF5ITfXnXDpoA2Eiip+4
         XqCjyGmF5jdERSAq3LjQBoLWODJzO9BVt9CLq+hNfFAn0+PdR4NXGNNxNwFac+RKa0DE
         FZK5ACa8LZmqoS811wM5CO70E0TigsI25w8VepmJ8W5CFeCOvisw+TX+6CIFuDrrVI/S
         qlW2ri/0JekE5pRVEzC2HzWn/6Jx6JiAALFPAdggku3i9IiUwFKPEVwDQ8E1HeSTFC4f
         t77McV5MIg+Cl8t0WyXCuC4lAu2NM3JK7oK+N9ZIcYo9MeWSlUdkix4WMDdolRWN0g6a
         fzpQ==
X-Gm-Message-State: AG10YORFJc/gbnyknd44RC/+U4LmwP9nBv9x3tJEakiD7N6aguIqAvEmL5RfbXdxd5bPq5VKU/2e965SJt+4oJNV
X-Received: by 10.50.21.10 with SMTP id r10mr6335362ige.93.1453334267070; Wed,
 20 Jan 2016 15:57:47 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 20 Jan 2016 15:57:46 -0800 (PST)
In-Reply-To: <xmqq1t9c54qz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284486>

On Wed, Jan 20, 2016 at 1:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 6fce0dc..ab0f209 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -130,6 +130,7 @@ cmd_add()
>>  {
>>       # parse $args after "submodule ... add".
>>       reference_path=
>> +     submodule_groups=
>
> This can just be called $groups in the context of this script.  I do
> not foresee we would be planning to deal with other kinds of groups
> here.

ok, done.

>
>>       while test $# -ne 0
>>       do
>>               case "$1" in
>> @@ -165,6 +166,10 @@ cmd_add()
>>               --depth=*)
>>                       depth=$1
>>                       ;;
>> +             -g|--group)
>> +                     submodule_groups=${submodule_groups:+${submodule_groups};}"$2"
>> +                     shift
>> +                     ;;
>
> You would want to accept "--group=<name>" as well, just like
> existing --reference and --depth do.  It won't be much more code,
> and when you move to C (hence parse_options) you'd get it for free
> anyway.

I am not sure, if I will to move `add` to C any time soon. Sure I desire
less shell and more C[1], but I'd think my time could be spent better than
just converting scripts to C. Sometimes I have to though, such as in the
case of `init` as the the call out from C to shell is too ugly and the effort to
do that is not that much less.

>
>> @@ -292,6 +297,16 @@ Use -f if you really want to add it." >&2
>>
>>       git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
>>       git config -f .gitmodules submodule."$sm_name".url "$repo" &&
>> +     if test -n "$submodule_groups"
>> +     then
>> +             OIFS=$IFS
>> +             IFS=';'
>
> I do not quite understand the choice of ';' here.  If and only if
> you _must_ accept multi-word name that has spaces in between as a
> group name, the above construct may make sense, but I do not think
> we have such requirement.  Why not separate with $IFS letters just
> like any other normal list managed in shell scripts do?  Is there
> anything special about names of submodule groups?

Just prior to writing this patch, I spent a good amount of time understanding
the error message handling in the parts of the shell code, where the $IFS is
used, so my mind was deceived to imitate that.

I agree, we can just use a space as separator here.

Thanks,
Stefan

[1] Reason why I have such a disdain to shell is that I do not
understand nearly as
much as C. I am self-taught in both C and shell, so I do not claim to
be perfect.
However C is a small but powerful language. After reading "The C Programming
Language" by Kernighan and Ritchie I do not think I found a thing that
was really
unknown to me. However even plain posix-shell is complex enough, that there
is no such thing as a compact book to read to understand all its concepts IMHO.
