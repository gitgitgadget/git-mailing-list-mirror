Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166971FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 19:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcFPTGF (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 15:06:05 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35548 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbcFPTGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 15:06:03 -0400
Received: by mail-yw0-f172.google.com with SMTP id z186so51835356ywd.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 12:06:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O2IbHn8Te/Tk3uujRMJdAzjwIvHFsREK9aB91CW8xrg=;
        b=OKXqt41F2HWoO57aogiRg4u8a7UYs+QKr9Da9WeQQcK7Xp3J4Hn8Bg0BGhO/z03RMZ
         +iGwF5BrYi0e20ZRGJXhtz2xCFT3Yrz1pJkkMtwEeXMjdreqUPNVe19mwoqwBaaB8A4N
         /A+Cb7XPGl+lH4E92pwBVcOfqRM5QF+DWF0MQAGKrpobvvXK6AhJHva/91M5A1vDXwQ2
         1Bs+y7DbEOagUzFzurv6Lx1IS2CV5xNpuP6OIIW55wNz49Lj3DWchC6J3LUWgdVaz+e8
         FuT7sruSB+R3XouzpiLsUtHCqVSwzqNDX06Z0YnOokrLZaiZ/Z6G76ZkhMCXXLADC35P
         1gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O2IbHn8Te/Tk3uujRMJdAzjwIvHFsREK9aB91CW8xrg=;
        b=iDnCp3IA4uo2IlGJAobUNGiz6tRhVpsxXI0NKgjAUF2tRytlkllhu7CrNq1RTbkOrY
         fRRt1H4h220vOc589R+mNZav9tpVtM7k5IA8eaTQh2GciRJ8ZWvwsnnFCLVyT9gVHR88
         Tz3RG1FNXXJmn/3bJYj81C38izA9ihkBlGTaMn7g/Ps2oGLNJ2nBoE2+mMbNRpJOKI9K
         Z9VTN4af6l+8OvMAybzHtZgAF8b5jVK4OSkAxRnIewL/9/IAuXFfuzut4V1cTGWv7uJz
         klpo29Vp5SCSsHrOpUtitG0V1dGrKAFQFG2ffVinSJmJOCfc//PF8yvnSWRlpM7c/Sef
         ASQQ==
X-Gm-Message-State: ALyK8tLdFixEpjn5vkKkRsrD2za7OGigwa8pbGcUiiHtp0u2RIyYHIB2zsrCqMja7LtEWKJvm5fuZN2T+QzwbA==
X-Received: by 10.37.212.129 with SMTP id m123mr3562001ybf.154.1466103962238;
 Thu, 16 Jun 2016 12:06:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Thu, 16 Jun 2016 12:06:01 -0700 (PDT)
In-Reply-To: <CAPig+cTf72M2iaZr3bZj+0V_0VHXJahpusY6zwT_B5uJx0BP1g@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-5-pranit.bauva@gmail.com>
 <CAPig+cTf72M2iaZr3bZj+0V_0VHXJahpusY6zwT_B5uJx0BP1g@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 00:36:01 +0530
Message-ID: <CAFZEwPPuoP6s2BZgKfvT5fZ_TGyqO16fCmJkGpbxDt8YR2gxVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] bisect--helper: `bisect_reset` shell function in C
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Eric,

On Thu, Jun 16, 2016 at 2:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
>> subcommand to `git bisect--helper` to call it from git-bisect.sh .
>> [...]
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -123,12 +127,48 @@ static int bisect_clean_state(void)
>> +static int bisect_reset(const char *commit)
>> +{
>> +       struct strbuf branch = STRBUF_INIT;
>> +
>> +       if (!commit) {
>> +               if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
>> +                       printf("We are not bisecting.\n");
>> +                       return 0;
>> +               }
>> +               strbuf_rtrim(&branch);
>> +
>
> Style: unnecessary blank line

Will fix.

>> +       } else {
>> +               struct object_id oid;
>> +               if (get_oid(commit, &oid))
>> +                       return error(_("'%s' is not a valid commit"), commit);
>> +               strbuf_addf(&branch, "%s", commit);
>
> strbuf_addstr(&branch, commit);

Seems better. :)

>> +       }
>> +
>> +       if (!file_exists(git_path_bisect_head())) {
>> +               struct argv_array argv = ARGV_ARRAY_INIT;
>> +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>> +               if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +                       error(_("Could not check out original HEAD '%s'. Try"
>> +                                       "'git bisect reset <commit>'."), branch.buf);
>> +                       strbuf_release(&branch);
>> +                       argv_array_clear(&argv);
>> +                       return -1;
>> +               }
>> +               argv_array_clear(&argv);
>> +       }
>> +
>> +       strbuf_release(&branch);
>> +       return bisect_clean_state();
>> +}

Regards,
Pranit Bauva
