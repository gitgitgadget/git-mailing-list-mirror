Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E071F405
	for <e@80x24.org>; Thu,  9 Aug 2018 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeHIMgA (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 08:36:00 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:39349 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeHIMgA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 08:36:00 -0400
Received: from [192.168.2.201] ([92.22.29.155])
        by smtp.talktalk.net with SMTP
        id nhv2fl5froI6Lnhv3f1n7a; Thu, 09 Aug 2018 11:11:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533809509;
        bh=TlHnqc+JijNf/I2ZAwyHGhb8Dejh7RMpXYjYBu7t4wE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fq8mkzYd4LNhhAamQty7hXFqr6RPJtIzT/YpG+tgUxzEIlPzY89MzRjehm9JAN1ni
         0K8nRDyUNPuDfB1ojCQQ11C83AcZysICqGMLWOBlb54cbJJTquCHFt/l2LFWyV5b73
         1guBD4TECZM9pgWol4t+ud7Cw9gjPhElU/T6tML0=
X-Originating-IP: [92.22.29.155]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=yeAZMs3+wWQh+Rh+YWy7CA==:117
 a=yeAZMs3+wWQh+Rh+YWy7CA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8 a=gl3i53k67kA52s2FyAYA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net>
 <20180807093452.22524-3-phillip.wood@talktalk.net>
 <CAPig+cR-O07v98SmjhKkXodN=SoSK3ahp2t2zNJ54uo3-_Fq3Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <0d74e405-fa8f-ae5c-ed1d-be3220f2b2da@talktalk.net>
Date:   Thu, 9 Aug 2018 11:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cR-O07v98SmjhKkXodN=SoSK3ahp2t2zNJ54uo3-_Fq3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKBffv1sxmdbSNZPTgBNFil7U5uQRD8pniUeHqK5mG3T2h6VwpiGInmOo4IFv2k9zIyVUb960LQc9baIUTZhDG8Ekrj5q31uJxB2NNvk8GAN2kSdKiR+
 fRWT5iTHYo4OHD0IuSuLEu3re1aO8BPUghOPPNS/8j1YLtmbFEXZE5c2/fyLp+pP/U12/ehKcnRrsAuWoakir9Dxr4kOQZ22CufyCz7vT8tKJBqAYrJHV54N
 jglDZv/JX/x1td0/TmNn0o+LWznqNw4N2TzhstjvklyM4u7YymaVGFxDVHSD6VpSBzUKIwK3pU1E0m5j5HQqeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/18 10:39, Eric Sunshine wrote:
> On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> Single quotes should be escaped as \' not \\'. The bad quoting breaks
>> the interactive version of 'rebase --root' (which is used when there
>> is no '--onto' even if the user does not specify --interactive) for
>> authors that contain "'" as sq_dequote() called by read_author_ident()
>> errors out on the bad quoting.
>> [...]
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> @@ -636,42 +636,64 @@ static int write_author_script(const char *message)
>>  static int read_env_script(struct argv_array *env)
>>  {
>>         if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>>                 return -1;
> 
> Erm, again, not introduced by this patch, but this is leaking 'script'
> in the error path. You had plugged this leak in the previous round but
> that fix got lost when you reverted to this simpler approach. Not
> critical, though; the leak probably ought to be fixed by a separate
> patch anyhow (which doesn't necessarily need to be part of this
> series).

I'm hoping this will go away when I work on unifying the code to read
the author-script with am.

>> +       /* write_author_script() used to quote incorrectly */
>> +       sq_bug = quoting_is_broken(script.buf, script.len);
>>         for (p = script.buf; *p; p++)
>> -               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
>> +               if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
>> +                       strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
>> +               else if (skip_prefix(p, "'\\''", &p2))
>>                         strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> 
> The two strbuf_splice() invocations are identical, so an alternate way
> of expressing this would be:
> 
>      if ((sq_bug && skip_prefix(p, "'\\\\''", &p2)) ||
>         skip_prefix(p, "'\\''", &p2))
>         strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> 
> Not necessarily clearer, and certainly not worth a re-roll.
> 
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> @@ -1382,9 +1382,21 @@ test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
>>  test_expect_success 'valid author header after --root swap' '
>>         rebase_setup_and_clean author-header no-conflict-branch &&
>>         set_fake_editor &&
>> -       FAKE_LINES="2 1" git rebase -i --root &&
>> -       git cat-file commit HEAD^ >out &&
>> -       grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
>> +       git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
>> +       git cat-file commit HEAD | grep ^author >expected &&
>> +       FAKE_LINES="5 1" git rebase -i --root &&
>> +       git cat-file commit HEAD^ | grep ^author >actual &&
>> +       test_cmp expected actual
>> +'
> 
> It probably would have been clearer to change to this test to use
> test_cmp() instead of 'grep' in a separate patch since it's not
> directly related to the fixes in this patch, and then to do the
> "commit --amend" in this patch. However, probably not worth a re-roll.

In hindsight that would have been clearer, but hopefully this version
isn't too confusing

>> +test_expect_success 'valid author header when author contains single quote' '
>> +       rebase_setup_and_clean author-header no-conflict-branch &&
>> +       set_fake_editor &&
>> +       git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
>> +       git cat-file commit HEAD | grep ^author >expected &&
>> +       FAKE_LINES="2" git rebase -i HEAD~2 &&
>> +       git cat-file commit HEAD | grep ^author >actual &&
>> +       test_cmp expected actual
>>  '
> 
> This test is so similar to the one above that it is tempting to try to
> refactor the code so the tests can share implementation, however, the
> end result would probably be less readable, so they're probably fine
> as-is.

Yes, I think it could look messy

Thank you very much for all your help and comments on this series

Best Wishes

Phillip

