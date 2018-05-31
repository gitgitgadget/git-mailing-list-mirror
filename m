Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54C51F42D
	for <e@80x24.org>; Thu, 31 May 2018 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755960AbeEaSoG (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 14:44:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35879 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755877AbeEaSoF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 14:44:05 -0400
Received: by mail-yw0-f194.google.com with SMTP id v68-v6so7498737ywd.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RnpgRQ7cVUth54TGoMXpKLzW6hApXFTW2QwadtImd/U=;
        b=n5l85wrxXG6WTdtfSrVyEoyByD6iofr831YAqumPQ7JvOmtEooIPtohSp2WYiqwxuQ
         lcGCRdabaHpI/7N35wFGdSzmCrcofc7ClUoxjouL2bxS4Bdw/RCerrSo5fyXfpeMRZKr
         avQmZFc3o7DHMcsPq9viob7B1SPnksKtqaTaTuIsKBhr1O16gzHBVJAtCMAJznHi9Iy1
         GhMFE/XJg8jpyvF+JxfJjgbbaM/UGRRI1FPQKVDNHw3GR1XYP3FlGeTKE5RNtP5hc6Vt
         dX0iZepvkqhB38xb9QVojRF3Sm/usym3G3mHI2uump+29cK9zQy+vOUQvG30Y+rc+uXL
         FJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RnpgRQ7cVUth54TGoMXpKLzW6hApXFTW2QwadtImd/U=;
        b=MELutpU9n2eK0JNduC/LnuQJWHS1OWa6PjmnAWan1yjho9O4ufDOm+zjSR+QSOLs1P
         +kS4Un+xHkOfy9YO+omSa+RJ2UWu/ElFoxzoug65f+NQ7SmI5+GwGRjokTaRGDfiqVK3
         /lFO4ufFqB9CgjEAhlhYyNEHG/GBFycfEFSkjvvahq6WgXeZKOMpdhVyHZDqiiL778Wa
         Ed3E80tCPxVRQAEqFSbbuMNHgUHBlPZQv6XBhbvzoU7uxmTouowBE1+U5lJfFeMj9ghk
         rNTy3g4QM7RSMhBG9TmBCzocGHqKKDylFZXm22++3F8eOwHBjAJJEgP8TA2YsOsNs6wh
         2OWQ==
X-Gm-Message-State: ALKqPwchUexhjkF6ac+MH8wvd0nZqfSX1ZsntdNpjpoR+jHAxJCN4fCJ
        4p4QsjvrVc6HBpAWY95VsxV7FcA097WjtJAbVy6l6G1etXw=
X-Google-Smtp-Source: ADUXVKIa8J/i2fdLXPjbzb/oCqwS5CebehbqR5Jwws0Q6saXzId84U8DIU+7nRf/+/b3cu3ErHjhMnlVg1FUrF4FuH4=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr4405767ywa.340.1527792244936;
 Thu, 31 May 2018 11:44:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 11:44:04 -0700 (PDT)
In-Reply-To: <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
References: <20180531110130.18839-1-alban.gruin@gmail.com> <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 11:44:04 -0700
Message-ID: <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 10:48 AM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
> Hi Alban, it's great to see you working on this
>
> On 31/05/18 12:01, Alban Gruin wrote:
>> This series rewrites append_todo_help() from shell to C. This is part
>> of the effort to rewrite interactive rebase in C.
>>
>> The first commit rewrites append_todo_help() in C (the C version
>> covers a bit more than the old shell version), adds some parameters to
>> rebase--helper, etc.
>
> I've had a read of the first patch and I think it looks fine, my only
> comment would be that the help for '--edit-todo' is a bit misleading at
> the moment as currently it's just a flag to tell rebase-helper that the
> todo list is being edited rather than actually implementing the
> functionality to edit the list (but hopefully that will follow in the
> future).

Would you have better suggestions for the name of the flag?
Of the top of my head:
  --write-edit-todo
  --hint-todo-edit
  --include-todo-edit-hint
not sure I like these names, though they seem to reflect the
nature of that flag a little bit better.

>> The second one strips newlines from append_todo_help() messages, which
>> require to update the translations. This change was advised to me by
>> Stefan Beller, but Johannes Schindelin voiced concerns. I don=E2=80=99t =
really
>> have a strong opinion about it, so feel free to give yours.
>
> I'm not sure I understand what the point of this patch is, if the
> newlines are unnecessary then I'd just omit them from the first patch -
> am I missing something?
>

The new lines are part of the output and are currently in the part to
be translated:
For example from the German translation file:

#: git-rebase--interactive.sh:171
msgid ""
"\n"
"Do not remove any line. Use 'drop' explicitly to remove a commit.\n"
msgstr ""
"\n"
"Keine Zeile entfernen. Benutzen Sie 'drop', um explizit einen Commit zu\n"
"entfernen.\n"

After patch 2 is applied, the translators only see
"Do not remove any line. Use 'drop' explicitly to remove a commit."
as a need to translate, and the two additional new lines (one in front
and one after the string) are just put in place autormatically.

Usually we do not want to play sentence lego, but this is a whole
sentence for translation; it is rather about formatting the output for
the terminal, adding new lines to separate some messages.

I thought this patch would just show goodwill towards translators
that do not need to replicate the formatting exactly.

If you feel strongly, I'd rather see Alban drop this second patch and
move on instead of waiting for our argument to settle. ( I do not feel
strongly about it, but put it out as a suggestion as that seemed like
it would lead to a better end state for the project).

Thanks,
Stefan
