From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] submodule-parallel-fetch: make some file local symbols
 static
Date: Thu, 1 Oct 2015 19:43:46 +0100
Message-ID: <560D7EE2.8060403@ramsayjones.plus.com>
References: <560D20E2.4060601@ramsayjones.plus.com>
 <CAGZ79kZzLtK7+rHRG_misaa9=fWF+oyeryBa+kbD3F+EB=3LMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 20:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhipe-0001Er-HT
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbbJASnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 14:43:50 -0400
Received: from avasout07.plus.net ([84.93.230.235]:52962 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbbJASnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 14:43:50 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout07 with smtp
	id Pujl1r0062FXpih01ujm1n; Thu, 01 Oct 2015 19:43:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=WuZyreSN4SEoYiQLqSAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <CAGZ79kZzLtK7+rHRG_misaa9=fWF+oyeryBa+kbD3F+EB=3LMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278900>



On 01/10/15 18:05, Stefan Beller wrote:
> On Thu, Oct 1, 2015 at 5:02 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
[snip]

>> diff --git a/run-command.c b/run-command.c
>> index 341b23b..347d22e 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -865,7 +865,7 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
>>         return finish_command(cmd);
>>  }
>>
>> -struct parallel_processes {
>> +static struct parallel_processes {
> 
> will pickup in a reroll

Thanks

> 
>>         void *data;
>>
>>         int max_processes;
>> diff --git a/submodule.c b/submodule.c
>> index bd6e208..638efb5 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -622,8 +622,8 @@ struct submodule_parallel_fetch {
>>  };
>>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
>>
>> -int get_next_submodule(void *data, struct child_process *cp,
>> -                      struct strbuf *err);
>> +static int get_next_submodule(void *data, struct child_process *cp,
>> +                             struct strbuf *err);
> 
> I thought I had this in yesterdays reroll (v6). Oh you're referring to
> the version
> from the 28th (I forgot to label them v5 I suppose).

Ah! I thought I'd seen it on the list. (I thought I was going crazy) ;-)
Sorry, my fault. I just assumed that today's pu branch would have your
latest patches - I didn't actually check that.

Note that the first hunk, above, is actually new (I hadn't noticed it
before).

> 
> I will also get rid of the forward declaration.

Thanks!

ATB,
Ramsay Jones

> 
>>
>>  static int fetch_start_failure(void *data, struct child_process *cp,
>>                                struct strbuf *err)
>> @@ -682,8 +682,8 @@ out:
>>         return spf.result;
>>  }
>>
>> -int get_next_submodule(void *data, struct child_process *cp,
>> -                      struct strbuf *err)
>> +static int get_next_submodule(void *data, struct child_process *cp,
>> +                             struct strbuf *err)
>>  {
>>         int ret = 0;
>>         struct submodule_parallel_fetch *spf = data;
>> --
