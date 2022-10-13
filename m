Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB3C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiJMSlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJMSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 14:41:05 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B81BC62C
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:38:42 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id bm8-20020a0568081a8800b003544ba66e7bso1090304oib.18
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhoIxHkZEy+nBGZ3DWF/G4N9Zu65RdXJlOWqPJ02f7g=;
        b=Tg8RxzbyPQjNacB+3kYT4hu+EkrU0SzKjRH8yH0/s9tSoMigoOtBe6veoQd69g5xjw
         aLKGrWprXdqMDkBzURGU50ytNhsct33kSVmR1s0o+9FqBzVVetkyS0HHcmWwiWNdmz4n
         CxamrbuCUUYExJidFDRW7qLLDNB1gercGec4jeOqrgWFeJTthTQ5OnbkCL+UAwyvZQK8
         +O5pCT/w8gwGHx6tqEtNFjfflFbDvU7tXnIJXbaEZkkVFcXP4Jaz39NcVShT5SV+LCZC
         P8JQa76QrE9Ez2K0Y5aNBBhMhJ93mVLToTFl9Ul1XmZA04n2WEN913qC6jRtpjEQztst
         F4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhoIxHkZEy+nBGZ3DWF/G4N9Zu65RdXJlOWqPJ02f7g=;
        b=bUIVl0pDMT18JkGCWkUFa0g3leBhF4Z/Jt2uNZcne5vHddPCdt3mGComjLuPEnTfCi
         UnhSsvNr3GOMU28pcVipK6QDZyFmoQeJCO91aZ694fLaEIGlEAQg62I6zw5z59TwElVP
         cRcpdTBfYP2REtuizCioVC+rZD3b050FP428CdeEwPasCZvqnRo+XEh7C2UDr97KkttI
         BYI6honDdosLh23JzlSiyHyf0a9xYMMZQmXPdjBqA9APwirMBTXw+zcdBAune95uuShn
         i70t0Aa+l50UlRAH15ZK2mBk4TaMnuXYwEhdYI1uVYTLN7Cn4+YSBnJzCF0AYaPRBWB+
         fX3w==
X-Gm-Message-State: ACrzQf0SAxyEYCFFojSJbClMeJS2x8Y8dML5Ig95TB4kHr4Zc6vOH7wK
        Kjt+B3ssK8ZamExHouauyKixD5l6IBceYg==
X-Google-Smtp-Source: AMsMyM6390Jxw4+Pbpj6kaqTt97D2PkBiSOjMl8Zuc/d13at0geGbANWX9Bzki4SMbNWul5Onp7E9S+vDPPZKA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP
 id w6-20020a17090ac98600b00205f08ca82bmr974308pjt.1.1665684439078; Thu, 13
 Oct 2022 11:07:19 -0700 (PDT)
Date:   Thu, 13 Oct 2022 11:07:17 -0700
In-Reply-To: <6F557A7B-F670-4840-9616-FD54B189FBF0@anodized.com>
Mime-Version: 1.0
References: <59B6154A-ADD4-44CA-A0D1-9F64C4F34B65@anodized.com> <6F557A7B-F670-4840-9616-FD54B189FBF0@anodized.com>
Message-ID: <kl6l1qrb1tt6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: git: Expected output regression due to 0353c6881890db1302f0f1bdf85c6076eed61113
From:   Glen Choo <chooglen@google.com>
To:     Christopher Layne <clayne@anodized.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christopher!

Thanks for the report. Cc-ing Git mailing list; do keep the mailing list
in the loop in the future, it'll also let you get a response from
someone other than Junio (who is probably busy with post 2.38 work) or
me :)

I have responded in-line, but otherwise the email I am responding to is
intact.

Christopher Layne <clayne@anodized.com> writes:

>> On Oct 12, 2022, at 1359 PT, Christopher Layne <clayne@anodized.com> wrote:
>> 
>> This change causes a regression in expected output for the single remote case:
>> 
>> e.g.:
>> 
>> gclayne@dorian:~/git/cmake (master =) $ git fetch --all
>> From https://gitlab.kitware.com/cmake/cmake
>>   0a45aa7525..f6af01b53d  master     -> origin/master
>> 
>> vs:
>> 
>> clayne@i860:~/git/cmake (master=) $ git fetch --all
>> Fetching origin
>> From https://gitlab.kitware.com/cmake/cmake
>>   0a45aa7525..f6af01b53d  master     -> origin/master
>> 
>> There may be any manner of output parsers involved in automation or other scripts looking
>> for the remote to be emitted before the actual url portion and in fact it broke one of mine,
>> hence how I even stumbled upon this. Since the remote name is no longer emitted in the
>> single remote case it deviates from the expected output that's been present for years now
>> and is likely to trip up all manner of people and automation which may depend on it.

The commit in question (which you've identified correctly) is 0353c68818
(fetch: do not run a redundant fetch from submodule, 2022-05-16). "git
describe" tells me that this has been with us since 2.36, so it is not a
recent regression at least.

This commit changes "git fetch --all" so that if a single remote would
be fetched, we call fetch_one() (which does not print "Fetching
remote....") instead of fetch_multiple() (which prints the message you
expect).

In [1], Junio spotted that we performed exactly this 'optimization' when
a remote group expands to only one remote. So, in a sense, this commit
makes "git fetch" more self consistent between "--all" and remote
groups, but this more consistent behavior seems undesired by at least
one bug reporter.

[1] https://lore.kernel.org/git/xmqqwnel1eqb.fsf@gitster.g/

>
> Note: it also implicitly makes the output "quiet" in the single remote case:
>
> Original approach:
>
> clayne@i860:/tmp/git-test/cmake (master<) $ git fetch --all
> Fetching origin
>
> clayne@i860:/tmp/git-test/cmake (master<) $ git fetch --all --quiet
> clayne@i860:/tmp/git-test/cmake (master<) $ 
>
> New approach:
>
> clayne@dorian:~/git/cmake (master <) $ git fetch --all
> clayne@dorian:~/git/cmake (master <) $ 
>
> clayne@dorian:~/git/cmake (master <) $ git remote add origin2 -f https://gitlab.kitware.com/cmake/cmake.git
> Updating origin2
> From https://gitlab.kitware.com/cmake/cmake
>  * [new branch]            master     -> origin2/master
>  * [new branch]            release    -> origin2/release
>
> clayne@dorian:~/git/cmake (master <) $ git fetch --all
> Fetching origin
> Fetching origin2
> clayne@dorian:~/git/cmake (master <) $ git fetch --all --quiet
> clayne@dorian:~/git/cmake (master <) $ 

This is the same behavior reported above; the input isn't becoming
quiet, only that "--quiet" suppresses that same message that is no
longer being output.

> The output is now inconsistent and unpredictable because it depends on the amount of remotes
> present for a given repo. If there is a single remote, "Fetching %s" is absent. If there are
> multiple remotes it behaves as normal. This breaks parsers and since there is no official
> spec on the output, other than the man page, people have come to rely on parsing the output
> as a means of determining progress/status for their own automation involving git.

> multiple remotes it behaves as normal. This breaks parsers and since there is no official
> spec on the output, other than the man page, people have come to rely on parsing the output

I'm not sure whether to treat a change like this as a regression. I
suspect that the lack of an official spec is by design, as it signals to
end users that this is not behavior that has been promised and is prone
to change. I personally don't think we should start promising that the
"git fetch" output will be well-structured and will not change either,
because the output is meant to be read by humans, who tend to be much
more forgiving than scripts.

All said, I do empathize with your use case. This isn't just "your
change in the output format broke my script", but "information that used
to be there isn't there any more, so I can't even update my script". A
reasonable compromise might be to log "Fetching %s" when fetching a
single remote in "git fetch --verbose", e.g.

  diff --git a/builtin/fetch.c b/builtin/fetch.c
  index a0fca93bb6..7f811e115c 100644
  --- a/builtin/fetch.c
  +++ b/builtin/fetch.c
  @@ -2085,6 +2085,10 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
    if (server_options.nr)
      gtransport->server_options = &server_options;

  +
  +	if (verbosity >= 1)
  +		printf(_("Fetching %s\n"), remote->name);
  +
    sigchain_push_common(unlock_pack_on_signal);
    atexit(unlock_pack_atexit);
    sigchain_push(SIGPIPE, SIG_IGN);

I could see this as a reasonable QoL improvement for some humans. This
is _still_ only meant for humans, and doesn't change my opinion that
this is unpromised behavior.

If you are looking for promised, well-behaved output, you're welcome to
propose something like "git status --porcelain" for "git fetch", where
the output format is well-documented and stable.

>
> -cl
