From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 11/11] branch: add '--points-at' option
Date: Wed, 29 Jul 2015 21:14:29 +0530
Message-ID: <CAOLa=ZTf6QVm-eXYNAk3Tof8DUeP2eZEAcVEGzkDysYwSkE1VA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-2-git-send-email-Karthik.188@gmail.com> <CA+P7+xp6FKDw26Qudi+kHi+CQ-rB1BFwOQdk65VyyAwTRW=vGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTXe-0004Oe-0l
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbbG2PpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:45:04 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36515 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbG2Po7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:44:59 -0400
Received: by oibn4 with SMTP id n4so7162943oib.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gsOXZoUBLQs1myPjRrAwagmAkKq3e0RREre9F9RgG94=;
        b=CLvbdTrp1+Bvf9dPrZ4k0Bul2Ffi9h4HaSADpjuzJVME+pBZLpQIowT3fLL3xjZX7k
         r28MiG+uLO1s/HNynclgFN6NbxY+OXHCHoQ2iDO/zWwsRsQBvO2Jlf+RLJR+4ZuBmlME
         iBVLVOud0KEzEq46daUuTPGjFWMwZ7v59XU943BGGlEqywz6sPfDAdYe41zIfQdTUNGC
         Tn59u4jBu2mpG7F6sXw3vOzzAiuGr1zU5UFJ08tvzUYJny/ISxU8ayLvM2SNgxG1OxTX
         MG+zhiMZ5i6PEWLXYCGP9jKNf0Tql/GwYn7O378P4B0QJVgfvV7837JPxZjgUUrJPnj8
         COPg==
X-Received: by 10.202.200.151 with SMTP id y145mr39031354oif.111.1438184698511;
 Wed, 29 Jul 2015 08:44:58 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 08:44:29 -0700 (PDT)
In-Reply-To: <CA+P7+xp6FKDw26Qudi+kHi+CQ-rB1BFwOQdk65VyyAwTRW=vGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274898>

On Tue, Jul 28, 2015 at 1:16 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 12:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add the '--points-at' option provided by 'ref-filter'. The option lets
>> the user to list only branches which points at the given object.
>>
>> Add documentation and tests for the same.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-branch.txt | 6 +++++-
>>  builtin/branch.c             | 7 ++++++-
>>  t/t3203-branch-output.sh     | 9 +++++++++
>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 897cd81..efa23a5 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -11,7 +11,8 @@ SYNOPSIS
>>  'git branch' [--color[=<when>] | --no-color] [-r | -a]
>>         [--list] [-v [--abbrev=<length> | --no-abbrev]]
>>         [--column[=<options>] | --no-column]
>> -       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]
>> +       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
>> +       [--points-at <object>] [<pattern>...]
>>  'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
>>  'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>>  'git branch' --unset-upstream [<branchname>]
>> @@ -237,6 +238,9 @@ start-point is either a local or remote-tracking branch.
>>         for-each-ref`. Sort order defaults to sorting based on branch
>>         type.
>>
>> +--points-at <object>::
>> +       Only list tags of the given object.
>> +
>
> s/tags/branches/ ?? Since this is for the branch version, I think this
> is just a copy-paste oversight.
>
>>  Examples
>>  --------
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 75d8bfd..d25f43b 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
>>         N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
>>         N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
>>         N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
>> +       N_("git branch [<options>] [-r | -a] [--points-at]"),
>>         NULL
>>  };
>>
>> @@ -647,6 +648,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>                 OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
>>                 OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
>>                              N_("field name to sort on"), &parse_opt_ref_sorting),
>> +               {
>> +                       OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
>> +                       N_("print only tags of the object"), 0, parse_opt_object_name
>> +               },
>
> Same as above. s/tags/branches/
>
>>                 OPT_END(),
>>         };
>>
>> @@ -675,7 +680,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>         if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
>>                 list = 1;
>>
>> -       if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
>> +       if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
>>                 list = 1;
>>
>>         if (!!delete + !!rename + !!new_upstream +
>> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
>> index 38c68bd..1deb7cb 100755
>> --- a/t/t3203-branch-output.sh
>> +++ b/t/t3203-branch-output.sh
>> @@ -154,4 +154,13 @@ EOF
>>         test_i18ncmp expect actual
>>  '
>>
>> +test_expect_success 'git branch --points-at option' '
>> +       cat >expect <<EOF &&
>> +  master
>> +  branch-one
>> +EOF
>> +       git branch --points-at=branch-one >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>>  test_done
>> --
>> 2.4.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Copy paste, errors, thanks for pointing out.

-- 
Regards,
Karthik Nayak
