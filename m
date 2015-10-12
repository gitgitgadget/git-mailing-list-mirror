From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Mon, 12 Oct 2015 16:31:18 -0700
Message-ID: <CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:31:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlmYu-00022X-7R
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 01:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbbJLXbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 19:31:20 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35566 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbJLXbT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 19:31:19 -0400
Received: by ykec126 with SMTP id c126so1117220yke.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=krvev6Fbcm6YID1ClJSr2w16uNtljAjwcsCUz4Wwt5Y=;
        b=oRbxB3ZHCTk0d4Hw7Xs93WvE0ZJE/y3D6QJNj8aFcKOsMP8PXrXKNHJ8A9hpFv30hM
         T8tgXYg/j0TeIpijLbUvsMEg6lx1rm+9sxdWK8qyN6tgGw6OKyWjX1ba5kfmCya4dIEB
         Mwf9irMpHZmpIQTiycxdBKp+neCuKsg+DtCY54PszhmAN+rpSp2He3MOGmNkEC7fopXr
         0cMYMJMQJJDMQb0ab/p1C0D/0p8No+EQeGbi36EbwyWP2IZ96wpUbYNy4w+cV6u0umKY
         2BLFwmvp4cnZ8dgzGBFjkzCSsWsxoKe6K0yw911hR3ecwZlVkmJvRqIOlVfx3ShTKiRI
         uO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=krvev6Fbcm6YID1ClJSr2w16uNtljAjwcsCUz4Wwt5Y=;
        b=W+WoQYof7oq1eC4EexGxd0JbXlbixBZ9xE+rtvLozTTZOARwZr8RIiyHi2riFsnF28
         DNY6V7K3zOSugZqMtssPCw+C+fSBkvhBU35wykxxzVuENNx5ILnmLC7L+WwOLj2Qvqte
         +nbIRV7MBEUbOH+3Dl9KnYk1UvqvhJnRkZNVFCtTa0VQO+UOsgfEQziZvrWfreNHCfqE
         27kQhywu11Oi8p1V7UVAiAqLqpormGHkAGiG2e9zhbWBpGbwpsHx8B4Zr+n8I5jhb+ou
         9Wn7AsDu17wbOvaCc7pFPCKXi7NuxYlbXs6V4wKRvm+5s5c31vIjaD9iCqU+ajdBhoSr
         9+xw==
X-Gm-Message-State: ALoCoQmX4KsGS9XzUg4+F69QgJFQ/lMpOfN4TMFSGOuxkLQyzhvVx9cfBIl9EH6jO73qL9T5QFV4
X-Received: by 10.129.124.8 with SMTP id x8mr22446468ywc.44.1444692678335;
 Mon, 12 Oct 2015 16:31:18 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 12 Oct 2015 16:31:18 -0700 (PDT)
In-Reply-To: <xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279472>

On Mon, Oct 12, 2015 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This allows to configure fetching in parallel without having the annoying
>> command line option.
>
> s/annoying//;
>
> I think this is a sane thing to do, but the name of the variable may
> want to be bikeshedded a bit.

That's actually what I thought about most for this patch. I expected
bikeshedding
as well in the workflow (passing around -1 for each unset option).

We should not include (threads/processes) as that is implementation detail,
and should not be exposed to the user (Looking at pack.threads)

There are some options using max_* for configuring parallel stuff
such as http.maxRequests.

There is core.preloadIndex to enable parallel index preload, but
that is boolean and not giving fine control to the user. We want to give
fine control to the user here I'd assume.

Maybe also the more fundamental question needs to be answered,
if we want to stay in the "fetch." prefix. We could also make it a
submodule specifc thing (submodule.jobs), but that would collide
with submodule.<name>.<foo> maybe? (Originally I wanted to
postpone this patch until I have parallelized git submodule update,
so a "fetch." prefix may not be good, as we want these 2 operations
to use the same config option I'd guess)





>
>> This moved the responsibility to determine how many parallel processes
>> to start from builtin/fetch to submodule.c as we need a way to communicate
>> "The user did not specify the number of parallel processes in the command
>> line options" in the builtin fetch. The submodule code takes care of
>> the precedence (CLI > config > default)
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/config.txt |  6 ++++++
>>  builtin/fetch.c          |  2 +-
>>  submodule.c              | 14 ++++++++++++++
>>  3 files changed, 21 insertions(+), 1 deletion(-)
>>
>>  I just monkey tested the code and it worked once! The problem with testing
>>  this parallelizing option is that the expected behavior doesn't change
>>  except for being faster. And I don't want to add timing tests to the test
>>  suite because they are unreliable.
>>
>>  Any idea how to test this properly?
>
> I agree that a test in t/ would catch bugs in the functionality.  If
> your parallel implementation is somehow broken in the future and
> stops functioning correctly, fetching all submodules with a single
> task and fetching them with N tasks will produce different results
> ;-).
>
> But it would not help you much in seeing if the parallelism is
> really taking place.  Adding t/perf/ tests to show how much benefit
> you are getting may be of more value.
>
> The parallel_process API could learn a new "verbose" feature that it
> by itself shows some messages like
>
>     "processing the 'frotz' job with N tasks"
>     "M tasks finished (N still running)"

I know what to fill in for M and N, 'frotz' is a bit unclear to me.
Would you imagine that to be passed in as a hardcoded string?
git fetch --recurse-submodules would pass in "Fetching submodules",
but <foo> wuld pass in actual "frotz", or would you assume that to be
computed from the task data somehow?

>
> in the output stream from strategic places.  For example, the first
> message will come at the end of pp_init(), and the second message
> will be appended at the end of buffered output of a task that has
> just been finished.  Once you have something like that, you could
> check for them in a test in t/.
>
> Just a thought.

I like that thought. :)

>
>>
>>  This applies on top of sb/submodule-parallel-fetch
>>
>>  Thanks,
>>  Stefan
>>
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 315f271..1172db0 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1140,6 +1140,12 @@ fetch.recurseSubmodules::
>>       when its superproject retrieves a commit that updates the submodule's
>>       reference.
>>
>> +fetch.recurseSubmoduleParallelism
>> +     This is used to determine how many submodules can be fetched in
>> +     parallel. Specifying a positive integer allows up to that number
>> +     of submodules being fetched in parallel. Specifying 0 the number
>> +     of cpus will be taken as the maximum number.
>> +
>>  fetch.fsckObjects::
>>       If it is set to true, git-fetch-pack will check all fetched
>>       objects. It will abort in the case of a malformed object or a
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index f28eac6..b1399dc 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
>>  static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>>  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>>  static int tags = TAGS_DEFAULT, unshallow, update_shallow;
>> -static int max_children = 1;
>> +static int max_children = -1;
>>  static const char *depth;
>>  static const char *upload_pack;
>>  static struct strbuf default_rla = STRBUF_INIT;
>> diff --git a/submodule.c b/submodule.c
>> index c21b265..c85d3ef 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -15,6 +15,7 @@
>>  #include "thread-utils.h"
>>
>>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>> +static int config_fetch_parallel_submodules = -1;
>>  static struct string_list changed_submodule_paths;
>>  static int initialized_fetch_ref_tips;
>>  static struct sha1_array ref_tips_before_fetch;
>> @@ -179,6 +180,14 @@ int submodule_config(const char *var, const char *value, void *cb)
>>       else if (!strcmp(var, "fetch.recursesubmodules")) {
>>               config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
>>               return 0;
>> +     } else if (!strcmp(var, "fetch.recursesubmoduleparallelism")) {
>> +             char *end;
>> +             int ret;
>> +             config_fetch_parallel_submodules = strtol(value, &end, 0);
>> +             ret = (*end == '\0');
>> +             if (!ret)
>> +                     warning("value for fetch.recurseSubmoduleParallelism not recognized");
>> +             return ret;
>>       }
>>       return 0;
>>  }
>> @@ -759,6 +768,11 @@ int fetch_populated_submodules(const struct argv_array *options,
>>       argv_array_push(&spf.args, "--recurse-submodules-default");
>>       /* default value, "--submodule-prefix" and its value are added later */
>>
>> +     if (max_parallel_jobs < 0)
>> +             max_parallel_jobs = config_fetch_parallel_submodules;
>> +     if (max_parallel_jobs < 0)
>> +             max_parallel_jobs = 1;
>> +
>>       calculate_changed_submodule_paths();
>>       run_processes_parallel(max_parallel_jobs,
>>                              get_next_submodule,
