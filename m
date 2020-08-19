Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4EFC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC92072D
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHdzyPNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHSKUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgHSKUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 06:20:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D85C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 03:20:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so20919244wrm.12
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9CiqsFyx6u2urpILxxXoeXs1B6KcOzfLgRfvytxVmz8=;
        b=lHdzyPNODEeSNf6nqdCEYxfEFJBlnrDTtfZ/90erWX12lIYCrzRPbnKDVAT8r+U5pL
         Hf79whxB2Nq93+rSrm/zkEdAhR8WL4NE1ymYiAzW2HeSJmsRJ7yvFwzpI9uhIg+dN1xv
         2qY+iXIQlBBD8gW/pxCw1W6WgD9MnfsPahetLXQ/j5pn2MznC3ulH3GEnH73/Jj/E7U1
         VxljPBwZ0uJXTh8zGU7Tbu5pxX3RNMTnP9+O3U1+iE6QTnOfBja/1lywtuLrLUZwuhZ+
         5w377stcbo3f8peC9j1Ezjz5NrxpNH+BvNdQbvIboNm2X7u22zQsECHZGia81X0HoZYn
         mwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9CiqsFyx6u2urpILxxXoeXs1B6KcOzfLgRfvytxVmz8=;
        b=R7hVXZRETZrnno/bAbdIiD0DxqDV9evy6+UUBFG3NwoSlzup25spEQFQkjB/JDK6bc
         NziQpV3NUnz48wOfIb0knXo6rEXxBbsctNgtmrkFDu67ka9VoVfLaWu0X22/6gQVAG06
         4BUQhOi5RIUfMoz+CdcZsBt3FheuR4eFvIf+1yDdCWpnUZIvcr3Vz+BU4L5Ah9XLF/SA
         cRFPitXHosjJon47hdWDQHLZa213b+pcxVRsFhpyjh+V6aS+xWLibUjebXwRG3hw53yY
         hKFRLklALLFt63ws2YUn0YKtIHjWB6NyPkoCH48uRgUtuqMQYGUzED1vet05XPZOLE+2
         1wQg==
X-Gm-Message-State: AOAM532lXIvnntkgqBfTGft7zb5nSIH3V6xlERgNGmrxUDEP63Zay+2b
        UrhEGbDMWbL8qjIanTbsE2Y=
X-Google-Smtp-Source: ABdhPJxjC8fmNnaJduU1sR9II5je7i+C1NleChoLC4ODzPlROBlz2D89J7hBZxUjH4K2pzzhA86MNA==
X-Received: by 2002:adf:e506:: with SMTP id j6mr23665442wrm.287.1597832432672;
        Wed, 19 Aug 2020 03:20:32 -0700 (PDT)
Received: from [192.168.1.201] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.googlemail.com with ESMTPSA id n12sm42072399wrq.63.2020.08.19.03.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 03:20:31 -0700 (PDT)
Subject: Re: [PATCH v8 2/5] am: stop exporting GIT_COMMITTER_DATE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
 <20200817174004.92455-3-phillip.wood123@gmail.com>
 <xmqqtux113z6.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2ad142e6-5f2c-7e05-c8d3-ab6efcfc7058@gmail.com>
Date:   Wed, 19 Aug 2020 11:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqtux113z6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2020 20:12, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The implementation of --committer-date-is-author-date exports
>> GIT_COMMITTER_DATE to override the default committer date but does not
>> reset GIT_COMMITTER_DATE in the environment after creating the commit
>> so it is set in the environment of any hooks that get run. We're about
>> to add the same functionality to the sequencer and do not want to have
>> GIT_COMMITTER_DATE set when running hooks or exec commands so lets
>> update commit_tree_extended() to take an explicit committer so we
>> override the default date without setting GIT_COMMITTER_DATE in the
>> environment.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  builtin/am.c     | 28 +++++++++++++++++++++++-----
>>  builtin/commit.c |  4 ++--
>>  commit.c         | 11 +++++++----
>>  commit.h         |  7 +++----
>>  ident.c          | 24 ++++++++++++++----------
>>  sequencer.c      |  4 ++--
>>  6 files changed, 51 insertions(+), 27 deletions(-)
> 
> Nice.
> 
> Obviously this would affect the environment while am is running, and
> the change is observable by post-applypatch hook.  I am not sure if
> this change-in-behaviour would negatively affect people's hooks, but
> given the large end-user population we have, somebody somewhere will
> get hit.

Yes I did think about that but decided it was probably better to fix it.
At the moment the pre-applypatch gets GIT_COMMITTER_DATE set to the date
of the last commit which does not make much sense. If anyone does need
the committer date in the post-applypatch hook they can look at HEAD. We
should perhaps mention that in the release notes

>> diff --git a/ident.c b/ident.c
>> index e666ee4e59..7cbf223350 100644
>> --- a/ident.c
>> +++ b/ident.c
>> @@ -361,11 +361,15 @@ N_("\n"
>>  const char *fmt_ident(const char *name, const char *email,
>>  		      enum want_ident whose_ident, const char *date_str, int flag)
>>  {
>> -	static struct strbuf ident = STRBUF_INIT;
>> +	static int index;
>> +	static struct strbuf ident_pool[2] = { STRBUF_INIT, STRBUF_INIT };
>>  	int strict = (flag & IDENT_STRICT);
>>  	int want_date = !(flag & IDENT_NO_DATE);
>>  	int want_name = !(flag & IDENT_NO_NAME);
>>  
>> +	struct strbuf *ident = &ident_pool[index];
>> +	index = (index + 1) % ARRAY_SIZE(ident_pool);
> 
> 2-element rotating buffer because we happen to care at most two
> idents at the same time, author's and committer's?
> 
> How many callers of fmt_ident() do we have these days?  I wonder if
> we can introduce a new API that lets/forces the caller to prepare a
> strbuf and migrate the current callers of this function to it, of if
> it is too large a churn for the purpose of this series.

After this series is applied there are the following callers

blame.c:207: ident = fmt_ident("Not Committed Yet", "not.committed.yet",
builtin/am.c:1591: author = fmt_ident(state->author_name,
state->author_email,
builtin/am.c:1597: committer = fmt_ident(state->committer_name,
builtin/commit.c:638: strbuf_addstr(author_ident, fmt_ident(name, email,
WANT_AUTHOR_IDENT, date,
ident.c:466: return fmt_ident(name, email, whose_ident, NULL,
ident.c:476: return fmt_ident(getenv("GIT_AUTHOR_NAME"),
ident.c:489: return fmt_ident(getenv("GIT_COMMITTER_NAME"),
sequencer.c:1461: committer = fmt_ident(opts->committer_name,
sequencer.c:1481: author = fmt_ident(name, email, WANT_AUTHOR_IDENT, NULL,

In blame.c we'd have to add an strbuf to pass in,

The caller in builtin/commit.c would obviously be easy to convert as it
is stuffing the result into an strbuf already.

For am and the sequencer fmt_ident() is in a function which is called
from a loop and it is convenient not to have to worry about passing an
strbuf around or allocating and freeing it on each function call

The callers in ident (fmt_name(), git_author_info() and
git_committer_info()) return the string so they would need their own
strbuf or have to be changed so the caller passed one in. There are
quite a few callers of those functions and they seem to either
immediately call split_ident_line() or duplicate the returned string
(mostly the latter).

So it would be a bit of work to do it but not an enormous amount
(assuming we don't change the signature of git_author_info() etc in
ident.c, although given the pattern of callers it might be worth doing
that if they are mostly duplicating the returned string anyway)

I'm going to be off line for 10-14 days from the beginning of next week,
I could take a look at it after that, or we could leave it for a future
improvement - what do you think?

Best Wishes

Phillip


> 
> Thanks.
> 

