Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B221FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbcLFXyZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:54:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:57314 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbcLFXyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:54:24 -0500
Received: from [192.168.178.43] ([188.108.240.182]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6SE3-1cbrIl2BVz-00yR09; Wed, 07
 Dec 2016 00:54:20 +0100
Subject: Re: [PATCH v15 19/27] bisect--helper: `bisect_state` & `bisect_head`
 shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b54-0ac61448-98b1-4c7d-bfdd-47af95f52153-000000@eu-west-1.amazonses.com>
 <0cc22155-2b3f-b69c-9ed4-2b1c55e40eee@gmx.net>
 <CAFZEwPPTnfOYsL8OB5x5n9cm2s+chMwg=xo459kVnFV9bB+5Hw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <14b9ba3a-4568-2e4b-0b1a-f0ee75a7c677@gmx.net>
Date:   Wed, 7 Dec 2016 00:54:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPPTnfOYsL8OB5x5n9cm2s+chMwg=xo459kVnFV9bB+5Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gp3sKYWk/XJGcHbyhQqR1Xhcz9BI5Md8+2yyywV1aBJK/pbeGTN
 jEG04qQAdgzNmsy53V1A2O0/1Nbg634tUCA4qoEF7CPmDgT5+p19thMBI/MoznsPXIOO4KF
 eoJqWYXAj7spW0SIJo0Sf3PX9w909/6rdQbNYNBSwrnJtPpZWK0d70JF67Q86R93uoFHi1O
 xMEZQ/+zCcAA9mOpZQ2hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6YFfztfbUmw=:8l8ddzF9YbuvySd+KalTdS
 v+b78/s46anFnmPGQWn6lhenAMyNjxkKLnArrP+1l0TA0Q1K0upawIWZUoQ00PkzNHcj7kyxa
 aKe9MtZ870mtMePxxKsPaCIMGEqi6PgZ/0lyoGHUUdoiKNIwzqxy4Ta7y28Lud+YvuzKb5TjF
 ZwsGHk/g4+H0XW93KQ44M0cjagC/sKXVZf9U38dTzMTydqOoeuDvJ08MGv3L1alPWCQj7JfQT
 3giXk0qv5Me1o3S9S1sedVJWPPYRKNsl8vAdLjVVklWzDII5sbU5kEoUIdNmvtEg5wkY6PYD5
 VZgr7JxzxQZnJTNLz5WAkqk1OzFWwgXcNszfnAgHZHdfQtR8I36OD09oyuMpXgt/Y6LNRhCAF
 1NBOyBXRLZaTJBpX877Uq6wNQAw75K+ypKoev6DEGOvhxqQ2TqkC9do4leBbFO0XD3mmit4kw
 zWJvDmxscL7nNQ7FBEQ6xQdt4ohSuL5Ey2BwlJS80GvAWwi2YvMj6lC5FRnxViOcEvwkeVU20
 LeOm2rV7c9lysfDPT+k8GDnIt+h225wuZb6Wca49FzyQtyQmBaenZDfZtG1o3WEqdKqn5GSHN
 GDq6FsdyzMPliMM+zjnoDy0CzPB6Nmt4ghbQNghTS3L0JCWKlrw3bJn9Ij8Z8vWAT1N0SNBHn
 lTZ7KhZUCwlLeLLXP7Dvhk4jFvJ5u3BqWGRC5/wQD3TrpTZiAWnMH0k3U7tt0+SmjC7SI39a6
 UAxJi4cfz+W4+MQHI65Zq3xqJuf7pleEAoBQc55KPxJiK85MLE6lWpiJ6pe3ljCSy50tG6DBc
 3MB4jF/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 12/06/2016 11:40 PM, Pranit Bauva wrote:
> On Tue, Nov 22, 2016 at 5:42 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>>> +static int bisect_state(struct bisect_terms *terms, const char **argv,
>>> +                     int argc)
>>> +{
>>> +     const char *state = argv[0];
>>> +
>>> +     get_terms(terms);
>>> +     if (check_and_set_terms(terms, state))
>>> +             return -1;
>>> +
>>> +     if (!argc)
>>> +             die(_("Please call `--bisect-state` with at least one argument"));
>>
>> I think this check should move to cmd_bisect__helper. There are also the
>> other argument number checks.
> 
> Not really. After the whole conversion, the cmdmode will cease to
> exists while bisect_state will be called directly, thus it is
> important to check it here.

Okay, that's a point.
In that case, you should probably use "return error()" again and the
message (mentioning "--bisect-state") does not make sense when
--bisect-state ceases to exist.

>>> +
>>> +     if (argc == 1 && one_of(state, terms->term_good,
>>> +         terms->term_bad, "skip", NULL)) {
>>> +             const char *bisected_head = xstrdup(bisect_head());
>>> +             const char *hex[1];
>>
>> Maybe:
>>                 const char *hex;
>>
>>> +             unsigned char sha1[20];
>>> +
>>> +             if (get_sha1(bisected_head, sha1))
>>> +                     die(_("Bad rev input: %s"), bisected_head);
>>
>> And instead of...
>>
>>> +             if (bisect_write(state, sha1_to_hex(sha1), terms, 0))
>>> +                     return -1;
>>> +
>>> +             *hex = xstrdup(sha1_to_hex(sha1));
>>> +             if (check_expected_revs(hex, 1))
>>> +                     return -1;
>>
>> ... simply:
>>
>>                 hex = xstrdup(sha1_to_hex(sha1));
>>                 if (set_state(terms, state, hex)) {
>>                         free(hex);
>>                         return -1;
>>                 }
>>                 free(hex);
>>
>> where:
> 
> Yes I am planning to convert all places with hex rather than the sha1
> but not yet, maybe in an another patch series because currently a lot
> of things revolve around sha1 and changing its behaviour wouldn't
> really be a part of a porting patch series.

I was not suggesting a change of behavior, I was suggesting a simple
helper function set_state() to get rid of code duplication above and
some lines below:

>> ... And replace this:
>>
>>> +                     const char **hex_string = (const char **) &hex.items[i].string;
>>> +                     if(bisect_write(state, *hex_string, terms, 0)) {
>>> +                             string_list_clear(&hex, 0);
>>> +                             return -1;
>>> +                     }
>>> +                     if (check_expected_revs(hex_string, 1)) {
>>> +                             string_list_clear(&hex, 0);
>>> +                             return -1;
>>> +                     }
>>
>> by:
>>
>>                         const char *hex_str = hex.items[i].string;
>>                         if (set_state(terms, state, hex_string)) {
>>                                 string_list_clear(&hex, 0);
>>                                 return -1;
>>                         }

See?

>>> @@ -184,8 +137,8 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>>>                       state="$TERM_GOOD"
>>>               fi
>>>
>>> -             # We have to use a subshell because "bisect_state" can exit.
>>> -             ( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
>>> +             # We have to use a subshell because "--bisect-state" can exit.
>>> +             ( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )
>>
>> The new comment is funny, but you don't need a subshell here any
>> longer.
> 
> True, but right now I didn't want to modify that part of the source
> code to remove the comment. I will remove the comment all together
> when I port bisect_run()
For most of the patches, I was commenting on the current state, not on
the big picture.

Still I think that it is better to remove the comment and the subshell
instead of making the comment weird ("yes the builtin can exit, but why
do we need a subshell?" vs "yes the shell function calls exit, so we
need a subshell because we do not want to exit this shell script")

~Stephan
