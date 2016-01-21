From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] submodule update: Initialize all group-selected
 submodules by default
Date: Wed, 20 Jan 2016 17:44:25 -0800
Message-ID: <CAGZ79kYJJ+JxgLBqD1Y_UWACUd7yJGnU+rnwEnU6X041deftjQ@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-4-git-send-email-sbeller@google.com>
	<xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:44:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM4IZ-000094-4K
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 02:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcAUBo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 20:44:28 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35169 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcAUBo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 20:44:26 -0500
Received: by mail-io0-f178.google.com with SMTP id 77so39409411ioc.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 17:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q7mojkXMnxQrPSXx/IC4Cjso9JdvyPH2/5oU6nlijs0=;
        b=hE9VUZPNqMe72Vm9ioH4HgRoCC8QpbIGiTtK3kMhRue6PGaCIfUVn1leyY/E0p+oq2
         I3/RGUNCYnKw2eOOdp+OTqHSX6iB17tiQwAt5iXED4xGZbXvFCAR4NnL1CsWBVhJl/1l
         TMwHH6yoXkQd35j5zjBvvwPBsEByDFZYQwEQw+B5hG5AIJmjHgxYqNUdKtp0On3UilMA
         n8CpqiERCOIPoviO4yKpbPTCF1y9mAMpQu7dPJsrTXjYSj0eGQFnLpaqMbWAm5tnX3wJ
         cRQuovPx5Z8o7cc6Quh2j7+M0+5d0SjgbhCWpOL9LNiP9TquCyyOTu+xPSZfX8ofDzTv
         v7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q7mojkXMnxQrPSXx/IC4Cjso9JdvyPH2/5oU6nlijs0=;
        b=LoCqVuaHkYsvuE6oyltd5m2H/D4Cb2DZI7MCJHS+F03rzN6tDG+ELZujWlFz5GYN+g
         GffyYl6jKiLygosryeD7N4hVXCNZtNG8HYs6XfRF4SyetV7UCfQeuLgNRv2njB45corV
         XNrc3C0Lb66TGOdGgckGNZLs0AD4Q1i4bSMcSLgp0t/duDLvnkhusdKCVU8VQ+MYmKWI
         8Vu14SY1h+s7yLeg1qVINR6rQoPbKftMouU8rx1DqX5kHj7zZUGX1jFg8ZZFL4AYgkl3
         9uKztB8TyvMGiSFDh12MNvoY13cfIJcQGUZQ8NS0ZRuAXF9+YLUvb5yzr2tPD/3VrSXX
         GEmw==
X-Gm-Message-State: ALoCoQnkZhsvC2mPlv1oyKwqdxmjdde3YW2VMvbaaMLp8IJKc/KXtUkCELDYrcOFaMFZVFaloU+0ntnjYSTh7P88dMhJUdHMzHv7p8NmdFGyfRQtYNOIRZ4=
X-Received: by 10.107.137.68 with SMTP id l65mr40986811iod.110.1453340665791;
 Wed, 20 Jan 2016 17:44:25 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 20 Jan 2016 17:44:25 -0800 (PST)
In-Reply-To: <xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284495>

On Wed, Jan 20, 2016 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> All submodules which are selected via submodule groups
>> ("submodule.groups") are initialized if they were not initialized
>> before updating the submodules.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/submodule--helper.c | 30 +++++++++++++++++++++++++++++-
>>  t/t7400-submodule-basic.sh  | 26 ++++++++++++++++++++++++++
>>  2 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 4684f16..def382e 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -577,6 +577,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>
>>  struct submodule_update_clone {
>>       /* states */
>> +     struct string_list *submodule_groups;
>
> Again, do we need a field named submodule_groups in a struct whose
> name already makes it clear this is about submodule?
>
> More importantly.
>
> If this were used to implement "there are various groups defined,
> and the user tells us that submodules in this and that groups are to
> be automatically initialized", then naming the field with a name
> that is more specific than just "groups" makes tons of sense, but
> even in such a case, the best adjective to clarify what kind of
> "group" this field is about is not "this is a submodule group".
>
> The answer I would give to a question "what kind of group this field
> is about?" would be "this is an auto-init group", so I'd have that
> 'auto-init' ness somewhere in its name.

So you mean something like `autoinit` would maybe already suffice.
Which leads to another question if we want to extend the concept of
these submodule groups a little bit, such that we also allow
direct names in there, in .git/config we may have the configuration

    [submodule]
        groups = <groupname-as-annotated-in-.gitmodules>
        groups = <explicit-submodule>

such that `git clone --group=default --group=mySingleSubmodule ....` would work.

Of course then the --group option would need to be named differently
in git clone
and probably the submodule.groups should also be named differently.

However:
At this point in time we only care about auto-initing submodules
to get submodules somewhat easier to handle when having lots of them.
Maybe we also want to add other features to these "groups" concept, e.g.
all submodules of one groups should have the "(force-)checkout" update strategy.
If the submodule consists of binaries only, this would make lots of sense to me.

So it is not yet clear to me if we want to extend the grouping feature
later on for
other things, which is why I named it by its concept. A group can be used for
different purposes, where as "all submodules having the same auto-init-tag can
be treated the same using one update strategy" just adds to user confusion,
hence I'd think telling the user about groups is the right thing to do?

>
>> @@ -633,6 +634,7 @@ static int update_clone_get_next_task(struct child_process *cp,
>>               const char *update_module = NULL;
>>               char *url = NULL;
>>               int needs_cloning = 0;
>> +             int in_submodule_groups = 0;
>
> Likewise.  The significance of the membership in this group is
> totally unclear from this variable name.  I read this boolean to be
> keeping track of "is this submodule to be auto initialized"?

In that part of the code it makes sense to rename it to auto_init, I'd guess.
