Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39137207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 23:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757734AbcIWXbQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 19:31:16 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35098 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcIWXbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 19:31:15 -0400
Received: by mail-wm0-f53.google.com with SMTP id l132so57738044wmf.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PCxIjS9Rt8QINwDFUSHG8ZywDGG76AIPywWJLFLpIK4=;
        b=ayH47r6ZHJXC+oJaauo5+7reazFGSfr9GYI9zpOanQxqoM8r3VsBmfbm8Cla8Y9ASL
         ivfvUTafGpiPCR+r87OD1GE1cT/A8ZSNMY9ZU7IEWhU4Dc3sdCPSDQE86z1RIhEc9KUp
         JZbM1WU1SEIrosRCChbdD67seamZezWtrOb/HC6I77QmF0wXgu6T8Wb9qFw5dxy9mYJQ
         uYX2pAzPwzK25Y6oa1GY4meD2990X/hfOwP4H+6kwTvUUUc/asIQmd4CUK7eHDRV7Xcm
         6S3U3/f5hvqINAbvuDHA4TZaBTaPVyjR/50blcW90Y2vEQVQkLIIaAjK5Es81vTQ3wJB
         SIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PCxIjS9Rt8QINwDFUSHG8ZywDGG76AIPywWJLFLpIK4=;
        b=QQODPEC3WTVbWjf9pryaipFLNkXjOSXhCVxVlvdfUUZ/M7fNSfB9XiTIBPJay934ig
         +0Rqgg8PedSa3ExPDvHgKCaoTPFEW7R98pfJ8i4LgdzczVZE3HvcQ2jDjSQK5fpy0yO5
         VVdjj1CPr9JWOVmIlaZxWW1x4M+xQtG5WUV0DWH8KewfgA3wIRkM7/vh3UV6Uy8iZO1C
         d2GAp6VaG/aPidHPhBXETZqoL/Ij1Pf9Z+wHpdjmwbstVqHmF78rUS8/K28Xb6e1GAmc
         zwYErVIrokw/vYPKyNre22s5hZYyM6LLeu2/37umueNSPDStmcIYgsItMZ9IIVnUuesC
         b4ig==
X-Gm-Message-State: AE9vXwOK3f6+/uPy6AGeH2mzVgEYKXK64CKXp6cH6d0ng1q9HTXeh/c6qjcqQJ6WPI7GNwcx6AeCxfP/gbqJBQc7
X-Received: by 10.194.178.130 with SMTP id cy2mr8807019wjc.138.1474673473727;
 Fri, 23 Sep 2016 16:31:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Fri, 23 Sep 2016 16:31:13 -0700 (PDT)
In-Reply-To: <20160922062047.jbxsgfabej26jt5i@sigill.intra.peff.net>
References: <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <1474497772-97986-1-git-send-email-bmwill@google.com> <20160922062047.jbxsgfabej26jt5i@sigill.intra.peff.net>
From:   Brandon Williams <bmwill@google.com>
Date:   Fri, 23 Sep 2016 16:31:13 -0700
Message-ID: <CAKoko1od4=PtHkYaU5bdktH4orL_k_G32M=3svgFGwvy6BKKsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: optionally recurse into submodules
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 11:20 PM, Jeff King <peff@peff.net> wrote:
>> +/**
>> + * Recursively call ls-files on a submodule
>> + */
>> +static void show_gitlink(const struct cache_entry *ce)
>> +{
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +     int status;
>> +
>> +     argv_array_push(&cp.args, "ls-files");
>> +     argv_array_push(&cp.args, "--recurse-submodules");
>> +     argv_array_pushf(&cp.args, "--submodule-prefix=%s%s/",
>> +                      submodule_prefix ? submodule_prefix : "",
>> +                      ce->name);
>> +     cp.git_cmd = 1;
>> +     cp.dir = ce->name;
>> +     status = run_command(&cp);
>> +     if (status)
>> +             exit(status);
>> +}
>
> This doesn't propagate the parent argv at all. So if I run:
>
>   git ls-files -z --recurse-submodules
>
> then the paths are all NUL-terminated in the parent, but
> newline-terminated in the submodules. Oops.

Yep definitely missed that.  I can fix that.  I think the main reason
for not blindly
copying the argv array is that there may be some things we don't want to pass
to the child. While not in the context of ls-files, I was working on
recursive grep
earlier and with that you can pass a rev to grep.  You can't blindly
copy that because
 the rev is meaningless to the the child and may produce broken
output.  Instead we
would need to pass the actual rev of what the parent has checked out
in that particular
rev.  I haven't thought it completely through yet but it did
discourage me from blindly
copying the args across.

-Brandon
