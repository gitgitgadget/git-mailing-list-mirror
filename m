Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B41CCA47D
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiFVJhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 05:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbiFVJhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 05:37:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B53526C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 02:37:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k14so3418438plh.4
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/YjaOwFH3qhozVzGf8nZ4oULgIynnAEB/hwSUnQDeYY=;
        b=AVB1CagI+gGBLQ8rhvOmAWcBQGzb251dwXD5nJzUGIsVKcz0h4GGqI1QMaAueHMZXW
         ffdwif1rtHY7+6PmtyhkFkJOW8HoefuReTpsvcNo8tiNJu0X3tjTN28LjMHmymAL+DeC
         +2qKmS4hg5YJA4utn9Nrm4sCyIamq9h5qz5Uy3Oz6jcs4sH2d8ms3ZV9M1/cxc/GoU0b
         ummlZaDBnCrsZ4VN354HzH7AfB9dO57Cq9DJWwtpLX7nzGS+0fadvK5F8Ja7cHOWD1DI
         3u6uVsnl557epJWZ+Gb7oUjQ5ywy/znVdwyTjTOoMVC1xAf3n25gGNUoEu1YWmpF4XZP
         GCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/YjaOwFH3qhozVzGf8nZ4oULgIynnAEB/hwSUnQDeYY=;
        b=MiOPOHSda54fLfwYUcaut9Xh5PXSXf1Ur5axdE0poeD/uJpRV4Fa42KE2hdZsgs2hI
         rl614C1lGbbUDVLYBTs1CLvU0VKsbCCwhnN2xoUKFgRKWWGv+4jpu8u2OqJFRaxglsdz
         JNExD2WD6WIvdYO4LgcidZp2U6wpQAKD1D5KGsI1w4R0c8gdC0zffyMmSR0DVJInLtsq
         CQZQ3nwzdVUsOYjlt0hb1esXINRSypXqJKQz8rHxyBf5HNqkBfCoZc1jf8A0wZNCB+Bv
         H5BCcdPLD6ZBXF7WkoYJ3vI+nFWgnSq3U3yjnE7aKmHUN1HHAE1oE4Wv0e+bK6+yg18r
         0FyA==
X-Gm-Message-State: AJIora8fClRLBFEvzVBI/l/ClsJzHNzWEU5DMKN8s97NkFeboCKVwLOO
        7xgTS9YhcNihOhg1wYX1rqM=
X-Google-Smtp-Source: AGRyM1t2wMBLoNfEhlSnnPmyNobgpfr4kW8Dr8Z2HENZagLtatjcWk0mHufpcZ+YRBhhLyHEoYIAiA==
X-Received: by 2002:a17:902:7c13:b0:16a:4e69:a5c3 with SMTP id x19-20020a1709027c1300b0016a4e69a5c3mr1003556pll.132.1655890664751;
        Wed, 22 Jun 2022 02:37:44 -0700 (PDT)
Received: from [127.0.0.1] ([128.1.248.98])
        by smtp.gmail.com with ESMTPSA id jc20-20020a17090325d400b0016a16bd25ebsm7352762plb.36.2022.06.22.02.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:37:44 -0700 (PDT)
Message-ID: <94540a13-2f6d-8a92-6426-29df8284f2a7@gmail.com>
Date:   Wed, 22 Jun 2022 17:37:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [WIP v3 5/7] mv: use flags mode for update_mode
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-6-shaoxuan.yuan02@gmail.com>
 <01b39c63-5652-4293-0424-ff99b6f9f7d2@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <01b39c63-5652-4293-0424-ff99b6f9f7d2@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/22/2022 6:32 AM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> As suggested by Derrick [1],
>> move the in-line definition of "enum update_mode" to the top
>> of the file and make it use "flags" mode (each state is a different
>> bit in the word).
>>
> This message doesn't quite cover all of what's done in the commit. In
> addition to moving the enum definition, you introduce a 'SKIP_WORKTREE_DIR'
> flag and change the flag assignments to '|=' (additive) from '=' (single
> assignment). If those changes belong in this commit (not a later one), they
> should be explained in the message here.


Sure! It makes the commit sound clearer.


>> [1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/
>>
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>   builtin/mv.c | 26 ++++++++++++++++++--------
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index abb90d3266..7ce7992d6c 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -19,6 +19,14 @@ static const char * const builtin_mv_usage[] = {
>>   	NULL
>>   };
>>   
>> +enum update_mode {
>> +	BOTH = 0,
> I know this comes from the original inline enum, but I don't see 'BOTH' used
> anywhere. The name itself is somewhat confusing (I have no idea what "both"
> is referring to - possibly "both" 'WORKING_DIRECTORY' and 'INDEX'??), so
> would you mind removing it in the next re-roll?


Yep, this BOTH is confusing.

I think it could be changed to something like UNDECIDED?

If taking it as UNDECIDED, it could potentially help determine if an 
argument

is untouched throughout the checking, then we can give the argument a 
REGULAR

flag (this may serve a purpose in my planned in-cone to out-of-cone move).


>> +	WORKING_DIRECTORY = (1 << 1),
>> +	INDEX = (1 << 2),
>> +	SPARSE = (1 << 3),
>> +	SKIP_WORKTREE_DIR = (1 << 4),
> You're not introducing any assignment of 'SKIP_WORKTREE_DIR' in this commit
> (looks like that's done in the next one, patch [6/7]), so you should
> probably 'SKIP_WORKTREE_DIR' and its corresponding usage in that patch
> instead of this one.


Right. SKIP_WORKTREE_DIR should go to a different patch.


>> +};
> When the update modes were mutually-exclusive, it made sense for them to be
> represented by an enum. Now that they're flags that can be combined, should
> they instead be pre-processor '#define' values (e.g., like the 'RESET_*'
> modes in 'reset.h' or 'CE_*' flags in 'cache.h')? I don't actually know what
> the standard is, since I also see one or two examples of using enums as
> flags (e.g., 'commit_graph_split_flags' in 'commit-graph.h'). Maybe another
> contributor could clarify?


I'm not sure either. Though a enum groups the flags together, which 
seems nice to me

as the flags are naturally distinguished from other '#define's.


>> +
>>   #define DUP_BASENAME 1
>>   #define KEEP_TRAILING_SLASH 2
>>   
>> @@ -129,7 +137,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   		OPT_END(),
>>   	};
>>   	const char **source, **destination, **dest_path, **submodule_gitfile;
>> -	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
>> +	enum update_mode *modes;
>>   	struct stat st;
>>   	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>>   	struct lock_file lock_file = LOCK_INIT;
>> @@ -191,7 +199,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   			pos = cache_name_pos(src, length);
>>   			if (pos < 0) {
>>   				/* only error if existence is expected. */
>> -				if (modes[i] != SPARSE)
>> +				if (!(modes[i] & SPARSE))
>>   					bad = _("bad source");
>>   				goto act_on_entry;
>>   			}
>> @@ -207,14 +215,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   			}
>>   			/* Check if dst exists in index */
>>   			if (cache_name_pos(dst, strlen(dst)) < 0) {
>> -				modes[i] = SPARSE;
>> +				modes[i] |= SPARSE;
>>   				goto act_on_entry;
>>   			}
>>   			if (!force) {
>>   				bad = _("destination exists");
>>   				goto act_on_entry;
>>   			}
>> -			modes[i] = SPARSE;
>> +			modes[i] |= SPARSE;
>>   			goto act_on_entry;
>>   		}
>>   		if (!strncmp(src, dst, length) &&
>> @@ -242,7 +250,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   			}
>>   
>>   			/* last - first >= 1 */
>> -			modes[i] = WORKING_DIRECTORY;
>> +			modes[i] |= WORKING_DIRECTORY;
>>   			n = argc + last - first;
>>   			REALLOC_ARRAY(source, n);
>>   			REALLOC_ARRAY(destination, n);
>> @@ -258,7 +266,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   				source[argc + j] = path;
>>   				destination[argc + j] =
>>   					prefix_path(dst, dst_len, path + length + 1);
>> -				modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
>> +				memset(modes + argc + j, 0, sizeof(enum update_mode));
> One benefit of using '#define' values would be that 'modes' would just be an
> array of unsigned ints, so you could just assign '0' rather than using
> memset. In terms of the implementation as-is, though, I think what you have
> is correct.
>
>> +				modes[argc + j] |= ce_skip_worktree(ce) ? SPARSE : INDEX;
>>   				submodule_gitfile[argc + j] = NULL;
>>   			}
>>   			argc += last - first;
>> @@ -355,7 +364,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   			printf(_("Renaming %s to %s\n"), src, dst);
>>   		if (show_only)
>>   			continue;
>> -		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
>> +		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
>> +			rename(src, dst) < 0) {
> Nit: could you align 'rename' with the line above it (per the highlighted
> section in the CodingGuidelines [1])? As far as I can tell, the "align with
> tabs and spaces" approach is what's *intended* to be used in 'mv.c'
> (although it's admittedly pretty inconsistent).
>
> [1] https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L371-L383


Sure. My 'format-patch' always gives me this issue, will check.


>>   			if (ignore_errors)
>>   				continue;
>>   			die_errno(_("renaming '%s' failed"), src);
>> @@ -369,7 +379,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   							      1);
>>   		}
>>   
>> -		if (mode == WORKING_DIRECTORY)
>> +		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
>>   			continue;
>>   
>>   		pos = cache_name_pos(src, strlen(src));
