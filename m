Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C54F1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdFSRS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:18:58 -0400
Received: from mout.web.de ([212.227.17.11]:57053 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbdFSRS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:18:57 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls91n-1dnMxp2UEZ-013xxd; Mon, 19
 Jun 2017 19:18:42 +0200
Subject: Re: [PATCH v5 4/5] convert: move multiple file filter error handling
 to separate function
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
References: <20170601082203.50397-1-larsxschneider@gmail.com>
 <20170601082203.50397-5-larsxschneider@gmail.com>
 <be787e74-5f37-8429-9976-abdf8725737c@web.de>
 <28D2B758-7E5D-4EEA-A33D-57871960D5E1@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <cedddaed-829d-9bde-3399-5b4e85dcbe57@web.de>
Date:   Mon, 19 Jun 2017 19:18:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <28D2B758-7E5D-4EEA-A33D-57871960D5E1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lnLZOTdCTVPe+iY/0elB5Yld3sZbIEMaFoX3dxLFtiedK9wk+Hd
 bTM/qSlCMoEUT4uKmUT1cK0rmN0f2f3jxqSCiBsMtbXJ7jrI5n0KPlSPksjYp4Hs/S1Bc48
 vmBXobyC/9zPlUsC4+dqFoscSm1EhMcjVOSVrTPM0NkgNlKhgGjGFL0OACzEgcz3wzXG8Hx
 M/8AwUCeFISDNSXRsHJPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IFnWyv5CfDk=:5ALw0ukBd4YKiLaD45cC/6
 FvhvGgerbRQKyyB0Y4RqBrwIHRSVDRA+6m6u3J5aHu4apKbgl0IMEBfg2uMJ/c3QLQkv5OJ78
 MsMZ9te/Rc7eI3JHQbx/B3EkYKtEAtOPO0COIPgGFLPJzFdRzavHPjp2MR+MN+U8crGNuphcm
 GkUu8kyatPOuS3wSzsl18vv/aqhPi7lele8WZJcgD39V1nqtFkO8ZbZxX8fCXpVu1LT5Z2ZPw
 0Kjwnir4tYwCK/j/r5Sg2a123Q8vVZzF5YSmcHMCBFznpDrSoSSbDSqmPfvTTQqpvxsnl9Dap
 0iRQX8bNVb0SORHxHr9t1/q1l7bTrwyumOr2YgNJDjqQeH/KjJZaXOh+9PLmX33vNWsN/HSlk
 eIMchctq1B7sd+DEQ+xSP2Y4Xe5lK764UrzixoU7gAttQO6yzHFsddd2qPMlXTwHn8Qvq+zjE
 wAAj3zKUh6TMcS3qiThMjDq/5tXvJZQqBOIO8tstWFOHlxljP7zauiTSXR0YEEEI6pzeuGKur
 bm2bOvX5cQbCQUnNrWVTJhcYV+oIgS/9zBxaCNza5AsMZ3BE5YyvWcSna8ZzoMOM3cDbwSGVJ
 KyFkwnTwz1u1mWUf7UI8EkTzM93/ah5lTmEa0tsITFKStjXZY5M2+5o4nqV/tuf9CYvx9/obZ
 qFFWqB2b6saWkroYZzRyJPXCbBEaIg8SbNaUxmevitWyjdx2fGaS/ctv3SFQW0KuBwP0EhKWt
 WYd2r0hJwT8fTrt/WQ6R/+p24AkEumdr4k31lCIwSDi49yG+HiQsmhdznoVab+SSx6ghtE7SO
 AZ6KUNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-06-18 13:47, Lars Schneider wrote:
> 
>> On 18 Jun 2017, at 09:20, Torsten Bögershausen <tboegi@web.de> wrote:
>>
>>
>> On 2017-06-01 10:22, Lars Schneider wrote:
>>> This is useful for the subsequent patch 'convert: add "status=delayed" to
>>> filter process protocol'.
>>
>> May be
>> Collecting all filter error handling is useful for the subsequent patch
>> 'convert: add "status=delayed" to filter process protocol'.
> 
> I think I get your point. However, I feel "Collecting" is not the right word.
> 
> How about:
> "Refactoring filter error handling is useful..."?

OK


> 
>>>
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>> convert.c | 47 ++++++++++++++++++++++++++---------------------
>>> 1 file changed, 26 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/convert.c b/convert.c
>>> index f1e168bc30..a5e09bb0e8 100644
>>> --- a/convert.c
>>> +++ b/convert.c
>>> @@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>>> 	return err;
>>> }
>>>
>>> +static void handle_filter_error(const struct strbuf *filter_status,
>>> +				struct cmd2process *entry,
>>> +				const unsigned int wanted_capability) {
>>> +	if (!strcmp(filter_status->buf, "error")) {
>>> +		/* The filter signaled a problem with the file. */
>>> +	} else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
>>> +		/*
>>> +		 * The filter signaled a permanent problem. Don't try to filter
>>> +		 * files with the same command for the lifetime of the current
>>> +		 * Git process.
>>> +		 */
>>> +		 entry->supported_capabilities &= ~wanted_capability;
>>> +	} else {
>>> +		/*
>>> +		 * Something went wrong with the protocol filter.
>>> +		 * Force shutdown and restart if another blob requires filtering.
>>> +		 */
>>> +		error("external filter '%s' failed", entry->subprocess.cmd);
>>> +		subprocess_stop(&subprocess_map, &entry->subprocess);
>>> +		free(entry);
>>> +	}
>>> +}
>>> +
>>> static int apply_multi_file_filter(const char *path, const char *src, size_t len,
>>> 				   int fd, struct strbuf *dst, const char *cmd,
>>> 				   const unsigned int wanted_capability)
>>> @@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>>> done:
>>> 	sigchain_pop(SIGPIPE);
>>>
>>> -	if (err) {
>>> -		if (!strcmp(filter_status.buf, "error")) {
>>> -			/* The filter signaled a problem with the file. */
>>                Note1: Do we need a line with a single ";" here ?
> 
> The single ";" wouldn't hurt but I don't think it is helpful either.
> I can't find anything in the coding guidelines about this...

OK about that. I was thinking to remove the {}, and the we -need- the ";"

> 
> 
>>                Question: What should/will happen to the file ?
>>                Will Git complain later ? Retry later ?
> 
> The file is not filtered and Git does not try, again. 
> That might be OK for certain filters:
> If "filter.foo.required = false" then this would be OK. 
> If "filter.foo.required = true" then this would cause an error.

Does it make sense to add it as a comment ?
I know, everything is documented otherwise, but when looking at the source
 code only, the context may be useful, it may be not.

> 
> 
>>> -		} else if (!strcmp(filter_status.buf, "abort")) {
>>> -			/*
>>> -			 * The filter signaled a permanent problem. Don't try to filter
>>> -			 * files with the same command for the lifetime of the current
>>> -			 * Git process.
>>> -			 */
>>> -			 entry->supported_capabilities &= ~wanted_capability;
>>                         Hm, could this be clarified somewhat ?
>>                         Mapping "abort" to "permanent problem" makes sense as
>>                         such, but the only action that is done is to reset
>>                         a capablity.
> 
> I am not sure what you mean with "reset capability". We disable the capability here.
> That means Git will not use the capability for the active session.

Sorry, my wrong - reset is a bad word here.
"Git will not use the capability for the active session" is perfect!

> 
> 
>> 		/*
>> 		 * The filter signaled a missing capabilty. Don't try to filter
>> 		 * files with the same command for the lifetime of the current
>> 		 * Git process.
>> 		 */
> 
> I like the original version better because the capability is not "missing".
> There is "a permanent problem" and the filter wants to signal Git to not use
> this capability for the current session anymore.

Git and the filter are in a negotiation phase to find out which side is able
to do what.So I don't think there is a "problem" (in the sense that I understand
it) at all.

And back to the "abort":
I still think that the word feels to harsh...
"abort" in my understanding smells too much "a program is terminated".
If it is not too late, does it may sense to use something like "nack" ?


> 
> 
>>                 # And the there is a question why the answer is "abort" and not
>>                 # "unsupported"
> 
> Because the filter supports the capability. There is just some kind of failure that 
> that causes the capability to not work as expected. Again, depending on the filter
> "required" flag this is an error or not.
> 

May be I misunderstood the whole sequence, and abort is the right thing.
If yes, how about this ?

	} else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
		/*
		 * Don't try to filter files with this capability for lifetime
		 * of the current Git process.
		 */
		 entry->supported_capabilities &= ~wanted_capability;


