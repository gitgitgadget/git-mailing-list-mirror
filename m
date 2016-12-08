Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B7620259
	for <e@80x24.org>; Thu,  8 Dec 2016 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbcLHTRj (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:17:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:60884 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbcLHTRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 14:17:38 -0500
Received: from [192.168.178.43] ([92.76.249.62]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEWxh-1cPkNm10DR-00Fhxc; Thu, 08
 Dec 2016 20:17:31 +0100
Subject: Re: [PATCH 4/5] Make sequencer abort safer
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20161207215133.13433-1-s-beyer@gmx.net>
 <20161207215133.13433-4-s-beyer@gmx.net>
 <alpine.DEB.2.20.1612081627290.23160@virtualbox>
 <xmqqr35itjor.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <c02708de-8b47-e490-4a1e-77f5727b1156@gmx.net>
Date:   Thu, 8 Dec 2016 20:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqr35itjor.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:RRLyO50ZDw4S7er6yXqFnUqBaKBxe65X6v7Cjte4h7MMDJIPiO6
 ZK6Zhhl8gpUPMP5tfHp3Q8BEOumaL6rAdSsmq0tXYfwd2Mmt5UwylAKZimsTrnVz3gfdG4c
 AlodUgJAHUdFWjGE7CkW7GzZeqIU7ZEMBTvJpz3NlaGPQNxOL1AyBgfx5qZtyP1+1M2+Q0h
 u12xx7t9e9n23DBtjZxLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G3o6gvBDVtA=:Vpm06GmWX6q9hVRfbRWhtS
 BRZOUF+qhTRDhviHah+Sm5NHkk7mdGHhhP8Xqkc1kEdaoC341LJAtZ313TIGdF4OkjXmf1dMz
 0pMq6aw6cevfnoCNTiuzr9ka/SjSJOOccGVKbdDsxsLxQEKHNMeLPy9+HNAW2zSgsnRqZktMA
 gEhCJ2CXOmNyh3zxXj2fbAGNzgvUSJXLJg9D/58FaKl/1RccVdesiTb8DofU7yhfpobHnLl8/
 Uv3bsCTvXrr3qhA9jfF1EoO7bBcgnUM6sn2LXOhoS73ObG1J6121K7E+6JsFzckNNqmN+Buht
 Ufaz6b4clJpj8Pu3SIyqdLin8CMOXWfAd7gWlPE/eDL24t/GjF3g+ECfr2BT9ZJYCEn3sReG5
 rhMJHXk5b9/V3wuvcI97GXjrAVGzafyqFd2MrXRM1vKLcjsPf9UFdavyL1D47Q5D3tL0yQmF8
 lhgCKBpUNXhh8/RImQYGbDKu5l6hemng6UUkHkEnrE2aYa8FtOHeA1JwjQcr2Q0zPxP367AJo
 KbYCn7/AZkkZaY/j0Ous5C/5YWj4sidpo8hsPkrBuTXimF/mh4X8lnprwt+pWJezbI7ubsoXg
 aYTbI+mmyOkDaM2K+Vvm/sVoU+f8U0fA9w1dRq3yUs9V9BJbZl0I1dOo6m43Rh+ZARyuT9jSp
 YuxGZRXdObUNxxA7xRP0Ge+7wPT/7B2yql0IeOuDIK7Wk1S9M+zy0gZlml3EeqMAewenmT8BO
 WIotltX/jtcEKws+1HXSzMTExqHVry+lgRTswQggB3QodP/5G8twQeJYtcuIsJ4+/6ojDpeq7
 Q+gZu2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm a little afraid of feeding Parkinson's law of triviality here, but... ;)

On 12/08/2016 06:27 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Wed, 7 Dec 2016, Stephan Beyer wrote:
>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 30b10ba14..c9b560ac1 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -27,6 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
>>>  static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
>>>  static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
>>>  static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
>>> +static GIT_PATH_FUNC(git_path_curr_file, "sequencer/current")
>>
>> Is it required by law to have a four-letter infix, or can we have a nicer
>> variable name (e.g. git_path_current_file)?
> 
> I agree with you that, as other git_path_*_file variables match the
> actual name on the filesystem, this one should too, together with
> the update_curr_file() function.

I totally agree with that (and I don't know why I used "curr", probably
just because it looked consistent and good...).

However:

> -static void update_curr_file()
> +static void update_current_file(void)

This function name could lead to the impression that there is some
current file (defined by a global state or whatever) that is updated.

So I'd rather rename the *file* to one of

 * sequencer/abort-safety (consistent to am, describes its purpose)
 * sequencer/safety (shorter, still describes the purpose)
 * sequencer/current-head (describes what it contains)
 * sequencer/last (a four-letter word, not totally unambiguous though)

> By the way, this step seems to be a fix to an existing problem, and
> the new test added in 3/5 seems to be a demonstration of the issue.
> If that is the case, shouldn't the new test initially expect failure
> and updated by this step to expect success?

That's usually a matter of taste that I sometimes also discuss with
colleagues in other projects... However, for the git test suite with its
"known breakage" behavior, your recommendation is surely the best way to
do it (aside from introducing the test and the fix in one commit... but
that does not show in the history that there actually was that breakage)

~Stephan
