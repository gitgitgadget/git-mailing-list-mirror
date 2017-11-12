Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF085201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 19:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdKLTnp (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 14:43:45 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:48261 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdKLTno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 14:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Px6/13Dw8RmWlXkk6wSYXIwENcLVNEgZregYWMzmen4=; b=Tn+N6EAEhNaFwrIUpsQ/9kNQ26
        EHE/pf6cxkLq84Vq7HGI420iS+5ThZaZcfEBqk6zvIepfSwokLOWfh/Zo2EHGWKqt2UT1UwTrt+vo
        htOmhZmSU9LlBe/IWPBdihkVSLhFjtcWkPmmYtp+hcn59HBhr9lIXiLOaiXcxp+aV5uYNH4suliSS
        P8M0ZToKLy5Fq7+kdDhdHFo094xIPkwXnQfpp6PYM1/nMlr7Al9zfsmXrFSBVPIZrFU/DiFng26vJ
        kUKSNX8yH1s/j7rQkxvKOJrcmKQc327MdwflNKGsNH0tfhkV9CNl3SDvzWKXw0SleUzjz1kcTsjz4
        Z5BJvMJQ==;
Received: from [127.0.0.1] (port=36039 helo=208.91.198.76)
        by cp-27.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eDyAR-002xrR-JR; Sun, 12 Nov 2017 19:43:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 19:43:43 +0000
From:   hsed@unimetic.com
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] config: added --expiry-date type support
In-Reply-To: <a05a8e8020ec31cfd9a0271ce2a00034@unimetic.com>
References: <0102015fb02bb5be-02c77f83-5a20-4ca1-8bab-5e9519cbd758-000000@eu-west-1.amazonses.com>
 <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
 <a05a8e8020ec31cfd9a0271ce2a00034@unimetic.com>
Message-ID: <97a9b315c7d187b4f0897f93a8d5f6c3@unimetic.com>
X-Sender: hsed@unimetic.com
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-12 14:55, Jeff King wrote:
> Hi, and welcome to the list. Thanks for working on this (for those of
> you on the list, this was one of the tasks at the hackathon this
> weekend).

It was a pleasure meeting everyone and a great experience!

> 
> Kevin already mentioned a few things about the commit message, which I
> agree with.

Sorry about that and the commit message formatting,
now that my mail is being received by git@vger I will try sending 
patches
with the required text, etc.

> 
> It's great that there are new tests. We'll probably need some
> documentation, too (especially users will need to know what the output
> format means).
> 

True, looking at the repo I found a document here[0]
Should I try editing this to add the new option?

>> @@ -80,6 +81,7 @@ static struct option builtin_config_options[] = {
>>  	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
>>  	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), 
>> TYPE_BOOL_OR_INT),
>>  	OPT_BIT(0, "path", &types, N_("value is a path (file or directory 
>> name)"), TYPE_PATH),
>> +	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), 
>> TYPE_EXPIRY_DATE),
>>  	OPT_GROUP(N_("Other")),
>>  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL 
>> byte")),
>>  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names 
>> only")),
> 
> We seem to use both "expire" and "expiry" throughout the code and in
> user-facing bits (e.g., "gc.reflogExpire" and "gc.logExpiry"). I don't
> have a real preference for one versus the other. I just mention it 
> since
> whatever we choose here will be locked in to the interface forever.
> 

I am not sure why do we need to use the 'expir(e/y)' keyword?
I think the parse_expiry_date() function still worked for past dates
is that intended?

Would having it as just '--date' suffice or do you plan to
have --date-type which will be different from expiry dates?

Anyways, I will use whatever keyword you think is more suitable. Please 
let me know.

>> @@ -159,6 +161,12 @@ static int format_config(struct strbuf *buf, 
>> const char *key_, const char *value
>>  				return -1;
>>  			strbuf_addstr(buf, v);
>>  			free((char *)v);
>> +		} else if (types == TYPE_EXPIRY_DATE) {
>> +			timestamp_t *t = malloc(sizeof(*t));
>> +			if(git_config_expiry_date(&t, key_, value_) < 0)
>> +				return -1;
>> +			strbuf_addf(buf, "%"PRItime, *t);
>> +			free((timestamp_t *)t);
>>  		} else if (value_) {
> 
> Since we only need the timestamp variable within this block, we don't
> need to use a pointer. We can just do something like:
> 
>   } else if (types == TYPE_EXPIRY_DATE) {
> 	timestamp_t t;
> 	if (git_config_expiry_date(&t, key_, value_) < 0)
> 		return -1;
> 	strbuf_addf(buf, "%"PRItime", t);
>   }
> 
> Note that your new git_config_expiry_date would want to take just a
> regular pointer, rather than a pointer-to-pointer. I suspect you picked
> that up from git_config_pathname(). It needs the double pointer because
> it's storing a string (which is itself a pointer), but we don't need
> that here.

Yes, I got it from the pathname function, I'll change this to just 
pointer.

> 
>> diff --git a/config.c b/config.c
>> index 903abf9533b18..caa2fd5fb6915 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -990,6 +990,15 @@ int git_config_pathname(const char **dest, const 
>> char *var, const char *value)
>>  	return 0;
>>  }
>> 
>> +int git_config_expiry_date(timestamp_t **timestamp, const char *var, 
>> const char *value)
>> +{
>> +	if (!value)
>> +		return config_error_nonbool(var);
>> +	if (!!parse_expiry_date(value, *timestamp))
>> +		die(_("failed to parse date_string in: '%s'"), value);
>> +	return 0;
>> +}
> 
> I was surprised that we don't already have a function that does this,
> since we parse expiry config elsewhere. We do, but it's just local to
> builtin/reflog.c. So perhaps as a preparatory step we should add this
> function and convert reflog.c to use it, dropping its custom
> parse_expire_cfg_value().

Ok, I will make these changes in reflog.c.

> 
> What's the purpose of the "!!" before parse_expiry_date()? The usual
> idiom for that to normalize a non-zero value into "1", but we don't 
> care
> here. I think just:
> 
>   if (parse_expiry_date(value, timestamp))
> 	die(...);
> 
> would be sufficient.

No real purpose, I saw it in prev code but I guess that had a different
purpose (as you mentioned) I'll change that.

>> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
>> index 364a537000bbb..59a35be89e511 100755
>> --- a/t/t1300-repo-config.sh
>> +++ b/t/t1300-repo-config.sh
>> @@ -901,6 +901,31 @@ test_expect_success 'get --path barfs on boolean 
>> variable' '
>>  	test_must_fail git config --get --path path.bool
>>  '
>> 
>> +test_expect_success 'get --expiry-date' '
>> +	cat >.git/config <<-\EOF &&
>> +	[date]
>> +	valid1 = "Fri Jun 4 15:46:55 2010"
>> +	valid2 = "2017/11/11 11:11:11PM"
>> +	valid3 = "2017/11/10 09:08:07 PM"
>> +	valid4 = "never"
>> +	invalid1 = "abc"
>> +	EOF
>> +	cat >expect <<-\EOF &&
>> +	1275666415
>> +	1510441871
>> +	1510348087
>> +	0
>> +	EOF
>> +	{
>> +		git config --expiry-date date.valid1 &&
>> +		git config --expiry-date date.valid2 &&
>> +		git config --expiry-date date.valid3 &&
>> +		git config --expiry-date date.valid4
>> +	} >actual &&
>> +	test_cmp expect actual &&
>> +	test_must_fail git config --expiry-date date.invalid1
>> +'
> 
> This looks good to me. It would be nice if we could test a relative
> value (which after all is what we'd expect to see in such a variable).
> But there's no way to do it in a robust way, since it will always be
> racy with the current timestamp.
> 
> We do have routines that let you make dates relative to a specific 
> time,
> but they're accessible only from t/helper/test-date, not git itself.
> 
> I don't think it's that big a deal, though. We're not testing the time
> code here (which is tested elsewhere with test-date), but just that 
> we're
> passing the dates through to be parsed.
> 
> -Peff


Is there a way to incorporate that? I will try calling 
t/helper/test-date
within a test but it would probably need to have some parts fixed like 
seconds
and/or minutes to prevent the race condition.


Kind Regards,
Haaris

[0]: https://github.com/git/git/blob/master/Documentation/git-config.txt
