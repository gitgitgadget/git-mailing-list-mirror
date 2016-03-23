From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC_PATCHv4 5/7] submodule update: respect submodule.actionOnLabel
Date: Wed, 23 Mar 2016 16:21:48 -0700
Message-ID: <CAGZ79kaEmDFDf+1BZV1C5ETswbXmAUYk_OMsZf_ka6tJ=pfwcQ@mail.gmail.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-6-git-send-email-sbeller@google.com>
	<xmqq37rif870.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 00:21:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ais66-0006bh-A5
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbcCWXVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:21:50 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35835 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbcCWXVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 19:21:49 -0400
Received: by mail-io0-f173.google.com with SMTP id v187so39338231ioe.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ycCfPjf4HO5BK90bJ1jVS44Pggdnls5RROsRD4g4tKk=;
        b=oXjIRR0JzKEyww/NAXwxDW7xjMi9swPEJKHPockFl2k1tY/y8cIZJ5cs1B4w/yHT5L
         5ujBVoqzunuPs+mylzbNcUJ5hVIR+aMYTT9QsVRHlCKy3CXdWjQb2Iy+sELNJo0I0prJ
         OqyJpMc+KQAnoE7h3m4BxXhcJV3k9Tk9b0etnkGQaS4VrFcfgPe2seJNkgANBi45BDt9
         9ooVqXc9B5UG3lhnlHyOkaDOJZHfOENoyhEkmomFjk0y6ZStN7UJOqLipHW0GdhKl5ds
         ehSyREfmhHz3Pl/FWvMF0jHkuRdhSjeM8p9IQTHO3pnsTHTd4xfgDD9akWzniqZjK+F3
         lnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ycCfPjf4HO5BK90bJ1jVS44Pggdnls5RROsRD4g4tKk=;
        b=OH5bR9g4d57OXSq6g9y4wuqSbCf0SQ2ewA1uciGM26mNOsP1JBkzVgVNiZqZaYxSB2
         GcJT4ZGYO5W9ReGOq0kFtDG2yMDTt/xOuUVsyoKYpSP5pZe2R2ffWW6MqdMAVLSIYm0X
         5Qla6eUFaqCsN08L0zHcLl1jZ895BR/0IRDEbnQp2CvM6Hws2XKLADfvc3hAngzlCcHK
         NsGGJ20jU7kCOCdKqkzgw2KIrN6qSrENrHhAnVXZawO5N1aTCt7J/CuHUrTUea4JTkni
         +Xk49zZiWq83DVQMAT8P7Th/DEMidkcuTnlragrT2RwvSEiWQTXQJPUB12JbK7QA9Kmr
         XPRw==
X-Gm-Message-State: AD7BkJKHLftDojyR3dz2NxRIQNR/VY+ntjIYnemvRJ+pAyDdNjolc5c9V4fBRiQW/ssL84W/uXbQvO3TeQiWQgrG
X-Received: by 10.107.131.163 with SMTP id n35mr6813488ioi.110.1458775308284;
 Wed, 23 Mar 2016 16:21:48 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 23 Mar 2016 16:21:48 -0700 (PDT)
In-Reply-To: <xmqq37rif870.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289693>

On Tue, Mar 22, 2016 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This change introduces the 'submodule.actionOnLabel' variable
>> in a repository configuration. Generally speaking 'submodule.actionOnLabel'
>> restricts the action of a command when no submodules are selected via the
>> command line explicitely to those submodules, which are selected by
>> 'submodule.actionOnLabel'. It can occur multiple times and can specify
>> the path, the name or one of the labels of a submodule to select that
>> submodule.
>>
>> The introduction of 'submodule.actionOnLabel' starts with
>> 'git submodule update' in this patch and other commands will follow
>> in later patches.
>>
>> 'submodule.actionOnLabel' implies '--init' in 'git submodule update'.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>> TODO: generic documentation for submodule.actionOnLabel
>> TODO: documentation for submodule update
>
> TODO: a name that matches the concept better.

This is one of the hardest parts of the series so far. The last reviews
were mostly bike shedding about the name of the concept and I thought
we were settled to actionOnLabel as that fits best to what we want to do.

So let's revisit that. My current understanding of the design:

Generic properties in the data model:
 * Each submodule has a set of "things" attached to it. (A submodule
   can have none, one or many)
 * A "thing" can be attached to many submodules (That's why
   it was called groups in v1, and labels now)
 * The attachments of "things" to submodules can be viewed as a bipartite
   graph.
 * The attachment needs to work in a way, such that upstream
   can influence and redefine these attachments (e.g. .gitmodules file
   as part of the repo; another approach would be to have yet another file
   .gitlabels or such where you'd have a list of submodules belonging to a
   "thing")
 * If this feature is enabled, the user can select a set of submodules by
   selecting a set of "things" and all submodules connected to these things
   in the bipartite graph are selected. The expectation for a graph is to
   select a lot fewer "things" than submodules. By having this indirection
   via the graph, the selection of a subset of submodules is expected to
   be easier.

Properties I derived from discussion and the data model:
 * The user does not need to have a way of overwriting the bipartite graph,
   because they can specify submodules by these "things", by path or by name.
   (It would be convenient to do be able to overwrite these, but it is
not a strict
   requirement as the you can get any specification via a set of paths)

 * The user needs to make the explicit choice to use the new feature
   or not, as it has implications on the default behavior of submodule
   commands.

 * To make change of selection easy (which happens e.g. when switching
   branches or pulling in upstream changes), all submodules are initialized
   by default.

 * Once this feature is enabled a command doesn't apply to all initialized
   submodules by default any more, but the
   default set of submodules will be the selected set via the
   bipartite graph of "things".

(Originally I typed out some implementation specific thoughts, but they are
loaded with even more assumptions, so maybe we'd want to stay on this
high level first)

So any other naming proposals?

Thanks,
Stefan

>
> So in general
>
>         $ git submodule $subcmd .
>
> may be the way to say "do $subcmd to all submodules", and
>
>         $ git submodule $subcmd
>
> may have been "operate on nothing" (or may have been "operate on
> everything"), but with this feature,
>
>         $ git submodule $subcmd
>
> will by default operate on submodules that match the criteria the
> new configuration variable specifies?
>
> I suspect that copying this from .gitmodules to .git/config will
> have security implications and will not be done?  What is the
> expected way for projects to suggest which set of submodules are the
> good ones to work on by default using this mechanism?
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/submodule--helper.c |  22 ++++++++-
>>  t/t7400-submodule-basic.sh  | 115 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 136 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index a69b1f4..93760ec 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -573,6 +573,8 @@ struct submodule_update_clone {
>>       int current;
>>       struct module_list list;
>>       unsigned warn_if_uninitialized : 1;
>> +     /* patterns to initialize */
>> +     struct string_list *initialize;
>>
>>       /* update parameter passed via commandline */
>>       struct submodule_update_strategy update;
>> @@ -590,7 +592,7 @@ struct submodule_update_clone {
>>       /* If we want to stop as fast as possible and return an error */
>>       unsigned quickstop : 1;
>>  };
>> -#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>> +#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, NULL, \
>>       SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
>>       STRING_LIST_INIT_DUP, 0}
>>
>> @@ -644,6 +646,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>>       strbuf_reset(&sb);
>>       strbuf_addf(&sb, "submodule.%s.url", sub->name);
>>       git_config_get_string(sb.buf, &url);
>> +     if (suc->initialize) {
>> +             if (!url) {
>> +                     init_submodule(sub->path, suc->prefix, suc->quiet);
>> +                     url = xstrdup(sub->url);
>> +             }
>> +             if (!submodule_applicable_by_labels(suc->initialize, sub)
>> +                 && !suc->warn_if_uninitialized)
>> +                     goto cleanup;
>> +     }
>>       if (!url) {
>>               /*
>>                * Only mention uninitialized submodules when their
>> @@ -745,6 +756,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>>       const char *update = NULL;
>>       int max_jobs = -1;
>>       struct string_list_item *item;
>> +     const struct string_list *list;
>>       struct pathspec pathspec;
>>       struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
>>
>> @@ -793,6 +805,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>>       gitmodules_config();
>>       git_config(submodule_config, NULL);
>>
>> +     list = git_config_get_value_multi("submodule.actionOnLabel");
>> +     if (list) {
>> +             suc.initialize = xmalloc(sizeof(*suc.initialize));
>> +             string_list_init(suc.initialize, 1);
>> +             for_each_string_list_item(item, list)
>> +                     string_list_insert(suc.initialize, item->string);
>> +     }
>> +
>>       if (max_jobs < 0)
>>               max_jobs = parallel_submodules();
>>
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index fc948fd..dc45551 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -1032,4 +1032,119 @@ test_expect_success 'submodule add records multiple labels' '
>>       test_cmp expected actual
>>  '
>>
>> +cat <<EOF > expected
>> +submodule
>> +-submodule2
>> +EOF
>> +
>> +test_expect_success 'update initializes all modules when action-on-label configured' '
>> +     test_when_finished "rm -rf super super_clone" &&
>> +     mkdir super &&
>> +     pwd=$(pwd) &&
>> +     (
>> +             cd super &&
>> +             git init &&
>> +             git submodule add --label labelA file://"$pwd"/example2 submodule &&
>> +             git submodule add file://"$pwd"/example2 submodule2 &&
>> +             git commit -a -m "add two modules, one is labled"
>> +     ) &&
>> +     git clone super super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git config submodule.actionOnLabel \*labelA &&
>> +             git submodule update &&
>> +             git submodule status |cut -c1,42-52 | tr -d " " >../actual
>> +     ) &&
>> +     test_cmp actual expected
>> +'
>> +
>> +test_expect_success 'submodule update applies to action-on-label selection' '
>> +     test_when_finished "rm -rf super super_clone" &&
>> +     mkdir super &&
>> +     oldSubmoduleHead=$(cd example2 && git rev-parse HEAD) &&
>> +     pwd=$(pwd) &&
>> +     (
>> +             cd super &&
>> +             git init &&
>> +             git submodule add --label labelA file://"$pwd"/example2 submodule1 &&
>> +             git submodule add --label labelA file://"$pwd"/example2 submodule2 &&
>> +             git submodule add --label labelA file://"$pwd"/example2 submodule3 &&
>> +             git commit -a -m "add two modules, both are labled"
>> +     ) &&
>> +     git clone super super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git config submodule.actionOnLabel \*labelA &&
>> +             git submodule update
>> +     ) &&
>> +     (
>> +             cd example2 &&
>> +             touch anotherfile &&
>> +             git add anotherfile &&
>> +             git commit -m "advance example2" &&
>> +             git checkout -b branchName
>> +     ) &&
>> +     newSubmoduleHead=$(cd example2 && git rev-parse HEAD) &&
>> +     (
>> +             cd super &&
>> +             git submodule add --label labelA file://"$pwd"/example2 submodule4 &&
>> +             git commit -a -m "add another labeled module" &&
>> +             git config -f .gitmodules submodule.submodule2.label labelB &&
>> +             git config -f .gitmodules --unset submodule.submodule3.label &&
>> +             git commit -a -m "unlabel 2 and 3 upstream" &&
>> +             git submodule foreach git pull origin branchName &&
>> +             git commit -a -m "update all submodules" &&
>> +             git submodule status |cut -c1-52 >../actual
>> +     ) &&
>> +     cat <<EOF >expected &&
>> + $newSubmoduleHead submodule1
>> + $newSubmoduleHead submodule2
>> + $newSubmoduleHead submodule3
>> + $newSubmoduleHead submodule4
>> +EOF
>> +     test_cmp actual expected &&
>> +     (
>> +             cd super_clone &&
>> +             git pull &&
>> +             git submodule update &&
>> +             git submodule status |cut -c1-52 >../actual
>> +     ) &&
>> +     cat <<EOF >expected &&
>> + $newSubmoduleHead submodule1
>> ++$oldSubmoduleHead submodule2
>> ++$oldSubmoduleHead submodule3
>> + $newSubmoduleHead submodule4
>> +EOF
>> +     test_cmp actual expected
>> +'
>> +
>> +cat <<EOF > expected
>> +submodule1
>> +submodule2
>> +-submodule3
>> +EOF
>> +
>> +test_expect_success 'Change labels in .git/config' '
>> +     test_when_finished "rm -rf super super_clone" &&
>> +     mkdir super &&
>> +     pwd=$(pwd) &&
>> +     (
>> +             cd super &&
>> +             git init &&
>> +             git submodule add --label labelA file://"$pwd"/example2 submodule1 &&
>> +             git submodule add file://"$pwd"/example2 submodule2 &&
>> +             git submodule add file://"$pwd"/example2 submodule3 &&
>> +             git commit -a -m "add two modules, one is labled"
>> +     ) &&
>> +     git clone super super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git config submodule.actionOnLabel \*labelA &&
>> +             git config submodule.submodule2.label labelA
>> +             git submodule update &&
>> +             git submodule status |cut -c1,42-52 | tr -d " " >../actual
>> +     ) &&
>> +     test_cmp actual expected
>> +'
>> +
>>  test_done
