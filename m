Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CEEEAA7E
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 22:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjINWu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjINWu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 18:50:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6326B7
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:50:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7b957fd276so1835180276.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694731822; x=1695336622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxR6/0MpietubBatOGIlrE1XDFLFZkkWSQ0ZSP7Rtpg=;
        b=WBna0DinvXDjaJq2L6LP5OSc1gOtAb0SoUTYHUdhRXS44gX0iQgpoUkBsoR9jjcg8Z
         WATDaZXULjAEAf9zIZ3aNX4Vr+yX13sD67vIIrUji+3Rhs2YSN3g5mOWyN5ADMLftW26
         SFVnAB1kXivbFJL56IYCtNKPEyocUlCGrAYdA7BqaIbJYX4f1bt+SkY0roJBo0BMZyUF
         hUPgPJwnvJbt48B48AXsRhvCqAMCcA9q1SAb+i+vECRXRoBpR7+BYR/C0p8bkU9DHf6U
         cPpfABfWzcV75kgGcp573OetTFWZVT6ip3XKLPbjBuUo2nyz4OoLIPDKeIo4ZLI9xrSy
         2Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694731822; x=1695336622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxR6/0MpietubBatOGIlrE1XDFLFZkkWSQ0ZSP7Rtpg=;
        b=fU5r+NtWE3+p0ICKxQN00KpXGxhI/mX+2eC252WjftCSQKtaVdJvxOzijOQKAEw6am
         jUoc14A3gaePEDrzgm9mZwRRUaPLPABCJyDiVTGdaQny7Aqc+2jXuUE4QdFyAuc7wxSf
         sM35A0b9+mSv6KGPAhheq7aE/FzkGgnmdBiSmcAwENOX7p0RSrQz+mv3xWvbrxuiiA9J
         y+5oSDzps537BBo0TsNUFUjc9fNNUWecyxso/imuHrQFba8r+HaOWwVZ3aPtblXTPbnK
         sbn8vqCWtTWxSfBCWW38qapP5quoOHZQy+F4Cmzc1hIB3NV9Y/DRQ+bE7Fnr6g2vHLdH
         uvSw==
X-Gm-Message-State: AOJu0YzAhFcK5i5GH4qhDlftT7/SDouqO/nnygRpT86A0cxmWN33PVQg
        tO75r0nlfnlv4pdb/jQHXJ58ikWi8Yw=
X-Google-Smtp-Source: AGHT+IHAkzJX0NJ6reBBt0eNz835IBOQWsufxxYWKVqBV039eYFOScGEZuR+yr6fFUkIENaIQIELqLVrnpU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1816:b0:d0e:e780:81b3 with SMTP id
 cf22-20020a056902181600b00d0ee78081b3mr168867ybb.2.1694731822212; Thu, 14 Sep
 2023 15:50:22 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:50:21 -0700
In-Reply-To: <xmqqo7i6khxv.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
 <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com> <xmqqo7i6khxv.fsf@gitster.g>
Message-ID: <owlyjzssjro2.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2] completion: improve doc for complex aliases
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> The completion code can be told to use a particular completion for
>> aliases that shell out by using ': git <cmd> ;' as the first command of
>> the alias. This only works if <cmd> and the semicolon are separated by a
>> space, since if the space is missing __git_aliased_command returns (for
>> example) 'checkout;' instead of just 'checkout', and then
>> __git_complete_command fails to find a completion for 'checkout;'.
>>
>> The examples have that space but it's not clear if it's just for
>> style or if it's mandatory. Explicitly mention it.
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>
> Thanks.  I scanned the case statement in the loop in the function
> and thought "hmph, everybody says ': git <cmd> ;' but is 'git'
> really needed?"
>
> I had "git l3" alias that invokes "$HOM#/bin/git-l" command, like so:
>
>     [alias]
>             l3 = "!sh -c ': git log ; git l \"$@\"' -"
>
> but if I did 's/: git log/: log/' it still completes just fine.

Interesting! I searched for the 'git <cmd>' and got some hits in
"t9902-completion.sh" when running "git grep -nE 'git <cmd>'":

    t/t9902-completion.sh:2432:test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
    t/t9902-completion.sh:2441:test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val git <cmd> ... }' '
    t/t9902-completion.sh:2450:test_expect_success 'completion used <cmd> completion for alias: !f() { : git <cmd> ; ... }' '

When I did 's/: git log/: log/' in the test at line 2450, the test still
passed. Perhaps we should add this "git"-less version as another test
case?

> I wonder if this hack is worth adding, instead of (or in addition
> to) requiring the user to insert $IFS to please the "parser", we can
> honor the rather obvious wish of the user in a more direct way.
>
>
>
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
> index 19139ac121..e31d71955f 100644
> --- c/contrib/completion/git-completion.bash
> +++ w/contrib/completion/git-completion.bash
> @@ -1183,7 +1183,7 @@ __git_aliased_command ()
>  			:)	: skip null command ;;
>  			\'*)	: skip opening quote after sh -c ;;
>  			*)
> -				cur="$word"
> +				cur="${word%;}"
>  				break
>  			esac
>  		done

I think this is a good defensive technique. This obviously changes the
guidance that Phillipe gave in their patch (we no longer have to worry
about adding a space or not between "word" and ";", so there's no need
to mention this explicitly any more), but to me this seems like a better
experience for our users because it's one less thing they have to worry
about.
