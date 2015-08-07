From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 7 Aug 2015 13:54:00 -0700
Message-ID: <CAGZ79kZEXuP_vZpO33X3BxKrNeRU5SjoU9dnk__ZzQR+rn7LUw@mail.gmail.com>
References: <55C3BA5C.3030404@web.de>
	<1438897123-16997-1-git-send-email-sbeller@google.com>
	<xmqqsi7uyigm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:54:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNoeb-00085O-HR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 22:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946136AbbHGUyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 16:54:08 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36009 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbbHGUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 16:54:06 -0400
Received: by ykeo23 with SMTP id o23so98105779yke.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7kP4QVaIGTP6z0LW2ro3myDZbVzH/OTE+aM5YHEvulk=;
        b=D7qKwqZyG81UjMk2ar0vzcOwqJi4I6DCDrq6gSGkimrEeDmX7h2rwoA228dyv/U7vw
         VPuj30eFSeKZWyylkz7q2Mz1u4mZVQcCUnLm60zJn1wltg2R0Q+BA7JObjICShtpcUR4
         L14jqEsV2l2g+oTj5uGkcozK2xRPfdM2N7QsauscjuMoIaXlg4au1pW0xaEroLJqZARx
         8pD1fDIhAGqD+X0ya8ryGWl+nCHIxPOMNxAchfFh6yhqsml3j819tLiouJefckzbtigK
         ygxCwSIGQhMu0MUJYjRbeuyKmxZoaq/kmLd4u7PIC07fYl+OZ0zFexMAh9mK2U/mYhWP
         TnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7kP4QVaIGTP6z0LW2ro3myDZbVzH/OTE+aM5YHEvulk=;
        b=d2og/ai5VPvUrXnWXo46vjgNbq0fQZ2F+9Arp7Ug3zWnGMC46tAyT2yN3kCYs9m5hx
         XBthFizcqqgMqXe9ipjSHVuHh+bHk+WLl95ZLs9s2DKFTbKpmrB+4FUlIeqGqWRDeGdk
         IrMigSWsF+LycnRtcBuWFsUN/daOrwXyI2C3h0PVxjOHH41YLNnl0WQhtytuXt+r/eCC
         5TG3hTvmP3u5PI5xDGD+FA/FynfeBN8ntrNk4LqUYQYeB2/5Tu6hYoVGujoN54UCTKqh
         Yiv/jr/m90Mn4LnvdIk0uvs+TKph9mcuJmNrpeUDikUBICbI/G5mWaQ7pt5UzQ+1Fnzg
         E/jg==
X-Gm-Message-State: ALoCoQkRXLbHapFaHD076uSsXgUlv51IB+TFoFM4f7xM4/WkNUfVpJN9FoOp3Efig2xIKJlnpW+c
X-Received: by 10.170.212.65 with SMTP id d62mr9895866ykf.115.1438980840303;
 Fri, 07 Aug 2015 13:54:00 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 7 Aug 2015 13:54:00 -0700 (PDT)
In-Reply-To: <xmqqsi7uyigm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275488>

On Fri, Aug 7, 2015 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This incorporates the changes from Jens fixup! commit
>> (which addresses all issues he pointed out).
>>
>> I agree this looks much cleaner. :)
>
> The only thing I found somewhat questionable is where to call
> gitmodules_config() from.  I think it is OK to do this at the
> beginning of module_name(), at least for now, simply because the
> other function module_list() does not need to.
>
> When you rewrite sufficiently large parts of the scripted Porcelain
> into C so that different pieces translated from the shell functions
> directly call into each other, that may have to change, though.  I
> do not think gitmodules_config() is designed to be called more than
> once, and I expect module_name() would be called many times inside a
> loop.

I want to structure the each part rewritten as a reusable core part
and a wrapper which just sets up the environment (option parsing,
reading the index, configs).

In this patch you only see the latter part, the wrapper, because the
core part only consists of one line

    name = submodule_name_for_path(<input>);

so I did not want to wrap that into its own function. But when rewriting
piece of shell code, which originally called into module_name, I'd rather
use the one liner instead. (This doesn't quite follow the literal translation
strategy, but I think it may be appropriate here).

>
> Other than that, this is a trivial refactoring (i.e. a new helper
> function added to submodule.c can be used from an existing
> open-coded logic in the same file, and then the same helper function
> gains a new callsite in submodule--helper.c) that makes things
> easier to read.
>
> Thanks.
>
>>  builtin/submodule--helper.c | 22 ++++++++++++++++++++++
>>  git-submodule.sh            | 32 +++++++-------------------------
>>  submodule.c                 | 19 ++++++++++++++-----
>>  submodule.h                 |  1 +
>>  4 files changed, 44 insertions(+), 30 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index cb18ddf..bc37b74 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -5,6 +5,8 @@
>>  #include "pathspec.h"
>>  #include "dir.h"
>>  #include "utf8.h"
>> +#include "submodule.h"
>> +#include "string-list.h"
>>
>>  static char *ps_matched;
>>  static const struct cache_entry **ce_entries;
>> @@ -98,6 +100,23 @@ static int module_list(int argc, const char **argv, const char *prefix)
>>       return 0;
>>  }
>>
>> +static int module_name(int argc, const char **argv, const char *prefix)
>> +{
>> +     const char *name;
>> +
>> +     if (argc != 1)
>> +             usage("git submodule--helper module_name <path>\n");
>> +
>> +     gitmodules_config();
>> +     name = submodule_name_for_path(argv[0]);
>> +
>> +     if (!name)
>> +             die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
>> +
>> +     printf("%s\n", name);
>> +     return 0;
>> +}
>> +
>>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>>  {
>>       if (argc < 2)
>> @@ -106,6 +125,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>>       if (!strcmp(argv[1], "module_list"))
>>               return module_list(argc - 1, argv + 1, prefix);
>>
>> +     if (!strcmp(argv[1], "module_name"))
>> +             return module_name(argc - 2, argv + 2, prefix);
>> +
>>  usage:
>>       usage("git submodule--helper module_list\n");
>>  }
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index af9ecef..e6ff38d 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -178,24 +178,6 @@ get_submodule_config () {
>>       printf '%s' "${value:-$default}"
>>  }
>>
>> -
>> -#
>> -# Map submodule path to submodule name
>> -#
>> -# $1 = path
>> -#
>> -module_name()
>> -{
>> -     # Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
>> -     sm_path="$1"
>> -     re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>> -     name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>> -             sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
>> -     test -z "$name" &&
>> -     die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
>> -     printf '%s\n' "$name"
>> -}
>> -
>>  #
>>  # Clone a submodule
>>  #
>> @@ -498,7 +480,7 @@ cmd_foreach()
>>               then
>>                       displaypath=$(relative_path "$sm_path")
>>                       say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
>> -                     name=$(module_name "$sm_path")
>> +                     name=$(git submodule--helper module_name "$sm_path")
>>                       (
>>                               prefix="$prefix$sm_path/"
>>                               clear_local_git_env
>> @@ -554,7 +536,7 @@ cmd_init()
>>       while read mode sha1 stage sm_path
>>       do
>>               die_if_unmatched "$mode"
>> -             name=$(module_name "$sm_path") || exit
>> +             name=$(git submodule--helper module_name "$sm_path") || exit
>>
>>               displaypath=$(relative_path "$sm_path")
>>
>> @@ -636,7 +618,7 @@ cmd_deinit()
>>       while read mode sha1 stage sm_path
>>       do
>>               die_if_unmatched "$mode"
>> -             name=$(module_name "$sm_path") || exit
>> +             name=$(git submodule--helper module_name "$sm_path") || exit
>>
>>               displaypath=$(relative_path "$sm_path")
>>
>> @@ -758,7 +740,7 @@ cmd_update()
>>                       echo >&2 "Skipping unmerged submodule $prefix$sm_path"
>>                       continue
>>               fi
>> -             name=$(module_name "$sm_path") || exit
>> +             name=$(git submodule--helper module_name "$sm_path") || exit
>>               url=$(git config submodule."$name".url)
>>               branch=$(get_submodule_config "$name" branch master)
>>               if ! test -z "$update"
>> @@ -1022,7 +1004,7 @@ cmd_summary() {
>>                       # Respect the ignore setting for --for-status.
>>                       if test -n "$for_status"
>>                       then
>> -                             name=$(module_name "$sm_path")
>> +                             name=$(git submodule--helper module_name "$sm_path")
>>                               ignore_config=$(get_submodule_config "$name" ignore none)
>>                               test $status != A && test $ignore_config = all && continue
>>                       fi
>> @@ -1184,7 +1166,7 @@ cmd_status()
>>       while read mode sha1 stage sm_path
>>       do
>>               die_if_unmatched "$mode"
>> -             name=$(module_name "$sm_path") || exit
>> +             name=$(git submodule--helper module_name "$sm_path") || exit
>>               url=$(git config submodule."$name".url)
>>               displaypath=$(relative_path "$prefix$sm_path")
>>               if test "$stage" = U
>> @@ -1261,7 +1243,7 @@ cmd_sync()
>>       while read mode sha1 stage sm_path
>>       do
>>               die_if_unmatched "$mode"
>> -             name=$(module_name "$sm_path")
>> +             name=$(git submodule--helper module_name "$sm_path")
>>               url=$(git config -f .gitmodules --get submodule."$name".url)
>>
>>               # Possibly a url relative to parent
>> diff --git a/submodule.c b/submodule.c
>> index 15e90d1..78d7616 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -686,6 +686,16 @@ static void calculate_changed_submodule_paths(void)
>>       initialized_fetch_ref_tips = 0;
>>  }
>>
>> +const char *submodule_name_for_path(const char *path)
>> +{
>> +     struct string_list_item *item;
>> +     item = unsorted_string_list_lookup(&config_name_for_path, path);
>> +     if (!item)
>> +             return NULL;
>> +
>> +     return item->util;
>> +}
>> +
>>  int fetch_populated_submodules(const struct argv_array *options,
>>                              const char *prefix, int command_line_option,
>>                              int quiet)
>> @@ -693,7 +703,6 @@ int fetch_populated_submodules(const struct argv_array *options,
>>       int i, result = 0;
>>       struct child_process cp = CHILD_PROCESS_INIT;
>>       struct argv_array argv = ARGV_ARRAY_INIT;
>> -     struct string_list_item *name_for_path;
>>       const char *work_tree = get_git_work_tree();
>>       if (!work_tree)
>>               goto out;
>> @@ -723,10 +732,10 @@ int fetch_populated_submodules(const struct argv_array *options,
>>               if (!S_ISGITLINK(ce->ce_mode))
>>                       continue;
>>
>> -             name = ce->name;
>> -             name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
>> -             if (name_for_path)
>> -                     name = name_for_path->util;
>> +             name = submodule_name_for_path(ce->name);
>> +             if (!name)
>> +                     /* Not in .gitmodules, try the default name == path */
>> +                     name = ce->name;
>>
>>               default_argv = "yes";
>>               if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
>> diff --git a/submodule.h b/submodule.h
>> index 7beec48..fc7f8a6 100644
>> --- a/submodule.h
>> +++ b/submodule.h
>> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>>               struct string_list *needs_pushing);
>>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>> +const char *submodule_name_for_path(const char *path);
>>
>>  #endif
