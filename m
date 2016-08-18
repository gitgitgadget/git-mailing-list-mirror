Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB891F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbcHSCfc (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:35:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36294 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753655AbcHSCfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:35:31 -0400
Received: by mail-yb0-f196.google.com with SMTP id r187so1171773ybr.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 19:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3KHIxGjztgmmAcnBelqg4OyRx9cjtATZk2/SB83lBIQ=;
        b=tJLQEVy6On++zu2y2GObFOo5hv7J3beOe+RS7WXyoPxDpkb5zmkYsHmhsPgrDWXjPv
         f+mnPbelhkKyXhMyP5pAPUNq5c/XsnCOrjRj34YWogcd+l3/sCB1dZvNjobTxkc1TJZ1
         nltcTrdHf429cPQuWq8KY4NlwkAr/yOu32GYuufcgNEEkCX2IWpZsHK8ImcrQurOMufQ
         vTLEgotzREqSyjeaq8uyd+IvO8p9AdSUxwpVUpv1ovjpqSQ4MqahMQfr/mW6swozvnCH
         yvAyfa9vjNQBCIHOmh0oAuRLcTYB3G9f6LLzYLYZ8hZUCJkG90pOpp78FOeZGsUR7VM8
         NxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3KHIxGjztgmmAcnBelqg4OyRx9cjtATZk2/SB83lBIQ=;
        b=FkpDjVe6rNOXC0nEenVwWZoKW63kKsN+v2Rvafpn9hBk5bwrz3NFxjvpT4gkCWWeE8
         /qolP+PVzAVwqfeS4EgT0ao4sb6fpI1wAmIi3ZSwGVuZSQvym5bcezPTYwE4wgiD2sGK
         gAE3SCJ6OphPkd4LSbB5kIGIP+5OUq3iEsDdegk/chbQYdBl6Z+AaPwPoyI7cFG/IGJk
         QOswXc+30epIiW4/rQ9GlAC1RnRceehqcLXlsSXvALFLezaGgGlRZXb+5iT8XmilXPLf
         yIU9UF8i8rfg6zgXzH9OZ7YqOzR6DB/qFuZ5Azf/EohPMuVzPT3/WxbNnb/gsXhg+3HX
         b2jA==
X-Gm-Message-State: AEkooutnVqc+UMQvn1QQs3z7t1GreOL8t1rtcM6QCNmlQREf1Ei5KJtiKQYCB/cT/FBqgbXEd6cpOPWKB+P4QA==
X-Received: by 10.37.197.211 with SMTP id v202mr3215724ybe.15.1471551865760;
 Thu, 18 Aug 2016 13:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Thu, 18 Aug 2016 13:24:01 -0700 (PDT)
In-Reply-To: <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-7-jacob.e.keller@intel.com> <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 13:24:01 -0700
Message-ID: <CA+P7+xrNzc-+KBdu20QpEcCJ_udYUUk=qQyDi26YoOyCwrPXiQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 12:04 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> +       if (is_null_sha1(one))
>> +               message = "(new submodule)";
>> +       else if (is_null_sha1(two))
>> +               message = "(submodule deleted)";
>> +
>> +       if (add_submodule_odb(path)) {
>> +               if (!message)
>> +                       message = "(submodule not initialized)";
>
> Before it was  "(not initialized)" for this case, I think we'd rather keep that?
> Though this code path is only used by the porcelain commands, we'd rather not
> want to change this in a subtle way in this commit.
>
> If we were to change those, we could discuss if we want to go with
> full sentences
> all the time:
>
>     submodule is new
>     submodule is deleted
>     submodule is not initialized
>
>

I agree, I'll make a new patch that does this as a cleanup prior to
this re-work.

Thanks,
Jake
