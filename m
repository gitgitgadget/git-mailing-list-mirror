Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E3A20248
	for <e@80x24.org>; Sun, 24 Mar 2019 14:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfCXOzJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 10:55:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42156 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXOzI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 10:55:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id j89so5371052edb.9
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VUDglkvLxoapu1ZH+lcnQ/vz+S8PqMp5J19/rJ3+J/E=;
        b=ML303c3ZRlh39udGAxBd64d06Jk9tiVWvEAlZYKaThIIaORDQyYM6IJK5IC1V5a7zd
         OVHIkFM8ceaKH4oMAPamdikHqCrpgdTJfesNpYxj/yjy4WSgIkZgt+iK/I7PyUJk6BSz
         5ewJg1sub2dTQKr470OT1+H++yIp1lcPxOoWkcGllMKa2gbKAaws00CFQXCk08lQlppQ
         FTMKIbng9IiSziyFfZZZjsXHi+4McHkwOgMpbq3nvKqWlr2rMrKWAu4GtO801LiFiatI
         jtRWLEWQe8v7Bb3fkHdkye5sYUbOw36qI0MYZklFalAAShhNYD47jhKBISdBiywoGp88
         6iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VUDglkvLxoapu1ZH+lcnQ/vz+S8PqMp5J19/rJ3+J/E=;
        b=FbteVHqfHCdDaoYre4v6AALQwiOfti6TV2YJ7hTOB8wIZuyF0vqEbP0uAnH+OUsAVw
         rxrG2KtSMtz7kl4mOs2gLQC42WUJprbq1ou3ssHmZYrYM+vlSZAP4/xSMXdQCrkPzq0Y
         NY5xIK5fLhlKPw4LY+TA7vobxCxs0TiFwK2mmPl4zmtCjQ4RcS5mThnrMHnXJWlIycz6
         zUoeBqEdG9SXb5ErZpSEm62fvE9KpOD2FhiU5hoTAFosvXGM8n1v/a7B+Qy7vwqqZkyX
         7cMkzxnx1MacScKusrqDCOTBn6fX4c1Fn2bZInTbYkW1X7DCAOTc/7KBxpRXrYUoPUC8
         ffqw==
X-Gm-Message-State: APjAAAUH+qBn9qTAyD3vT0b/W1KNJ87ACT2YadfuE7FMYDTbVZRORp/k
        c4AhrNpVS6q7AKISKger/bYyZ1/R
X-Google-Smtp-Source: APXvYqwEkSLYeZMibuXBtFmKWYkYiQExEnReTkN9voxcB0e8nek0ePiXNVSsLPB5X831NlrsfZgRkw==
X-Received: by 2002:a50:ca87:: with SMTP id x7mr13213455edh.165.1553439306434;
        Sun, 24 Mar 2019 07:55:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l90sm3648888edl.6.2019.03.24.07.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 07:55:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org, Santiago Torres <santiago@nyu.edu>
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net> <8736nhdvi3.fsf@evledraar.gmail.com> <87lg17muca.fsf@fifthhorseman.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87lg17muca.fsf@fifthhorseman.net>
Date:   Sun, 24 Mar 2019 15:55:04 +0100
Message-ID: <878sx4cofr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 22 2019, Daniel Kahn Gillmor wrote:

> On Wed 2019-03-20 23:35:48 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
>> But e.g. if you've signed a v1.00 in foo.git, but also maintain bar.git
>> and have a v2.00 there, I can be fooled in foo.git with your proposed
>> change by having the v2.00 bar.git tag pushed to it (just, with the
>> proposed change, not the other way around).
>
> Presumably the tool looking for the "most interesting new tag" already
> has some sort of pattern that it looks for in a tag name (to avoid
> accidentally ingesting some development-specific, non-release tag).
>
> So yes, this is true for upstreams which issue signed release tags on
> multiple projects named with the generic form v1.2.3, but it is *not*
> true of projects which name their tags the way that (for example)
> GnuPG's upstream does (e.g. gnupg-2.2.14 and libgpg-error-1.36).
>
> In that case, and the matching pattern itself will exclude tags from
> other repositories.
>
>> It *does* help with the "pass of an old tag [from the same repository]"
>> problem, which I'd expect would realistically be the only threat model
>> that matters (forcing a downgrade to an old buggy version), whereas some
>> entirely different project is likely going to be next fed to some
>> project-specific build infrastructure and then won't even build.
>
> I agree that a cross-project tag substitution attack is more exotic than
> an in-project downgrade or freeze attack, but i'm not inclined to wager
> on it never being exploitable.  Why take that gamble?

FWIW I wasn't arguing that this was a good thing ("just a point of
clarification..."), just walking through and elaborating an exploitable
case you mentioned so we're all on the same page as to what the current
problem(s) are.

>> I wonder if there's a more general fix to be found here that'll have
>> nothing to do with GPG or signed tags per-se. A lot of people have this
>> "given tags in the repo, what's the latest one?" problem. I think
>> they'll mostly use the --sort option now, maybe some variant of that
>> which for each <older>/<newer> tag in the chain also checked:
>>
>>     git merge-base --is-ancestor <older> <newer>
>>
>> That would serve as a check for such rouge tags, even if none of them
>> were signed, and a "they must be signed" option could be added, along
>> with "start walking from here".
>
> I agree that this is a common tag verification use case, and i've seen
> probably a dozen different attempts to do it which all fail in some
> curious ways if you assume that the repository being pulled from is
> malicious.
>
> I like the idea you're describing here, and would be happy to see some
> reasonable, easy-to-use git subcommand that says something like "find
> the most interesting tag that derives from the current HEAD".  for some
> version of "interesting", of course :) It would probably be a good start
> to have "interesting" mean:
>
>  * the tag name matches some particular pattern
>
>  * the tag is cryptographically signed by at least one member of a
>    specific curated keyring
>
>  * the tag is the "most recent" or "farthest descendant" (these are
>    subtly different, i'm not sure which one makes more sense)
>
> Anyway, the fact that there isn't an obvious perfect answer for how to
> do this shouldn't stop git from offering a reasonable, well-vetted,
> *good* answer.  Because the current situation just means that every
> project that cares about verifying signed tags makes up their own
> approach, and i would happily bet that most of them get it wrong in some
> corner case.
>
> And if there's a tool that does a sensible verification of some workflow
> that we think is reasonable, that tool will also help to encourgae
> projects to adopt that reasonable workflow.  This is a good thing!
>
>        --dkg
