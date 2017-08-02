Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B00A20899
	for <e@80x24.org>; Wed,  2 Aug 2017 23:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbdHBXWe (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 19:22:34 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36408 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdHBXWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 19:22:33 -0400
Received: by mail-lf0-f50.google.com with SMTP id o85so25992966lff.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X+wyd61nTpLuzzg8TohRncVNPTsEpsrC7SazjqMviFo=;
        b=THMarS86gQcLYHX0FTF68vDXxwwLMq+HhBjmrb3rhr/kVBel2M0A0YQCUOSMDHnX2v
         L7NZPgkvt7A5IU/p7+5zH7IR8UgchboG/Eoz7TR1xcJnAzpkZRQgTwUDTIpYEhNfu/b/
         9Rax5Jqp82Y/XRZClOhFaw+Dwc87PbVYlzV02gLZFBJqUyCkuKvlv33lGwkdf23WhKvb
         Nm8JyI0tFP2lrqZ9rH/kT5oB0MzKFOIXArdwwH6wbD9NVrwG1EttLNA8NniLJd69zRfs
         aYa93XNV/zddtcLVe6QZUF8um9PohVAGHo5lM0W2jeG080MswAzStOUdVBbaanqBm0iQ
         Hliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X+wyd61nTpLuzzg8TohRncVNPTsEpsrC7SazjqMviFo=;
        b=oOn88tikHTjxEdvGdrZLAktG5ado6dDZpzPw8O410966qeUm5/iTDfwL5xCMtH1r3r
         XIu/B1j5JEIY6M4YVgRtsMkYtqk87yx+GKLbPCapdMEf1jsgbntRnPYzJ6ypDgTzzSi/
         WceuSipcRZjyszxe8u6jFsJ6n7Djbx4cV75WMQ2diCYJDkE0DL1ZiJwBHXdmSdpi3q8d
         2fIRPeWmKy/9vEqKlM6+e7enqNHvVwzK1Wc+Fgdk223aFqg450LWdvs7OGty++AhYfW8
         wCArHgsEJAAVRmxpRT6t4pwK3rr93AnmcHQnL6izXlbBGWdqHxbi1XMh5evjb9Lcv/fr
         z/eg==
X-Gm-Message-State: AIVw111UBE8aLj3DCvuHTXihv062PNvMTcDBtY41S+Jk4DmYYKhhiEWJ
        1J3rLsLi4awB6cPbeMD/zK240InYXXqG
X-Received: by 10.25.92.9 with SMTP id q9mr8242864lfb.117.1501716151839; Wed,
 02 Aug 2017 16:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 2 Aug 2017 16:22:31 -0700 (PDT)
In-Reply-To: <xmqq8tj1r3n8.fsf@gitster.mtv.corp.google.com>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
 <20170802223018.h2uabdpmtz3gw27g@sigill.intra.peff.net> <xmqq8tj1r3n8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Aug 2017 16:22:31 -0700
Message-ID: <CAGZ79kYLAGHBfNsyHgkcHX1-7cBH0eTL-PcYS=eRE80BzBJJJg@mail.gmail.com>
Subject: Re: [PATCH 4/4] revision: do not fallback to default when
 rev_input_given is set
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> If revs->def is set (as it is in "git log") and there are no
>> pending objects after parsing the user's input, then we show
>> whatever is in "def". But if the user _did_ ask for some
>> input that just happened to be empty (e.g., "--glob" that
>> does not match anything), showing the default revision is
>> confusing. We should just show nothing, as that is what the
>> user's request yielded.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> The "!got_rev_arg" that's already in the conditional is interesting. I
>> wondered if it could be subsumed by the rev_input_given flag. But
>> digging in the history, I think it's mostly about doing reflog walks.
>> Usually if we see a rev arg it will result either in an object added to
>> the pending queue, or a fatal error. But empty reflogs are the
>> exception. And since my other nearby series adds a separate check for
>> "are we doing an empty reflog walk", I don't think it makes sense to
>> tangle this up the new flag I'm adding here.
>
> OK, I'll have to stare at possible merge conflicts to see if I like
> this or some other design decision ;-)
>
> This shows one of the reasons why I want consumers of revision
> machinery not to be futzing these internal implementation detail
> bits in the revs structure, by the way.

cc'd Johannes to see this example and discussion.

>
>>  revision.c     | 2 +-
>>  t/t4202-log.sh | 6 ++++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 08d5806b8..ba2b166cd 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2316,7 +2316,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>               opt->tweak(revs, opt);
>>       if (revs->show_merge)
>>               prepare_show_merge(revs);
>> -     if (revs->def && !revs->pending.nr && !got_rev_arg) {
>> +     if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
>>               struct object_id oid;
>>               struct object *object;
>>               struct object_context oc;
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 3f3531f0a..36d120c96 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -1523,6 +1523,12 @@ test_expect_success 'log diagnoses bogus HEAD' '
>>       test_i18ngrep broken stderr
>>  '
>>
>> +test_expect_success 'log does not default to HEAD when rev input is given' '
>> +     >expect &&
>> +     git log --branches=does-not-exist >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>>  test_expect_success 'set up --source tests' '
>>       git checkout --orphan source-a &&
>>       test_commit one &&
