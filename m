Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6892A1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcHCWZr (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:25:47 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36572 "EHLO
	mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbcHCWZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:25:46 -0400
X-Greylist: delayed 7013 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Aug 2016 18:25:46 EDT
Received: by mail-yb0-f196.google.com with SMTP id o3so49658ybo.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:25:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jS98ibzQyVPOlcLtcIyc6MYeUQvc0Gkh0j4BIRHmrGA=;
        b=REJ0MrC0lKsSe44k5DF0GasVLEOp6RMDYZML53HsoAaxh8U+MruxVQIzaOkt13T+XP
         BnxZevNndYrcCtGsQVWqe0du7RV2XHZYWTzqjWvdWR+B+Q2W4/5UQfAJabb2CX1eWFpy
         MfDuN41CVc2I9eWPAVB8GYOVAzVQP6GJQ/hICfkcHwAyxF3HssE3OAO7eg+W1iYuHtk3
         VwGuX2l58rD3vSYRmTdhMDhiFwvsYgzSUf6UOf00WtoqNYJ+MisRLHjMJi6wZIqjQvYh
         q2Oo/q+QeUfKb0fAp+YH+TR0D/V0HyYiOgCBNtvhwh3mt+i2SGABaFAPaw8ZpTypgeFo
         NHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jS98ibzQyVPOlcLtcIyc6MYeUQvc0Gkh0j4BIRHmrGA=;
        b=biPB0lEIJa2i4FvS0JQTx9KDeMhDGmWI9CyEJl82BjBrr0shVbq4iONdPsAmzXZZYU
         QODXwTI2/EiDamxacvBUGu724nKbJkCsTdn/HhhdAbdeskFusIsYbhzUKDMSadGO39K2
         oCa03X0/99CURUp+tScI3D3yUGmcgE4IF0eh1np9WWJ3GH1lQLF+zwE/YUDIpR7zyLnO
         M+WFxATrFB+vayWbcl/LbnnJlKfeeXcCFDR3wMho5sqfoYQNs6e4lefJ66+qa2jXbHnI
         DV5jBhBWeRHHAC3fMXLphw0SfYGrkUBbpqnbXmboqEnN881anRu8tMKoiV+daeP7rqWY
         mqsQ==
X-Gm-Message-State: AEkoout1eTHHctUxOlxWd46ePZy+67ca0gAjyUnCgMDQb1DV+2WknkK9lC25h72lhIn3jMu1bj4qf85ICjKpcA==
X-Received: by 10.37.96.10 with SMTP id u10mr21136738ybb.7.1470256075119; Wed,
 03 Aug 2016 13:27:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:27:54 -0700 (PDT)
In-Reply-To: <xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
 <xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 01:57:54 +0530
Message-ID: <CAFZEwPNFohRLCS4piB1t0LO-=keucwzRKZ2Jyhhf234tnWnVGg@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 04/13] bisect--helper: `bisect_clean_state` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Tue, Aug 2, 2016 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_clean_state(void)
>> +{
>> +     int result = 0;
>> +
>> +     /* There may be some refs packed during bisection */
>> +     struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
>> +     for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>> +     string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
>> +     result = delete_refs(&refs_for_removal);
>> +     refs_for_removal.strdup_strings = 1;
>> +     string_list_clear(&refs_for_removal, 0);
>> +     remove_path(git_path_bisect_expected_rev());
>> +     remove_path(git_path_bisect_ancestors_ok());
>> +     remove_path(git_path_bisect_log());
>> +     remove_path(git_path_bisect_names());
>> +     remove_path(git_path_bisect_run());
>> +     remove_path(git_path_bisect_terms());
>> +     /* Cleanup head-name if it got left by an old version of git-bisect */
>> +     remove_path(git_path_head_name());
>> +      * Cleanup BISECT_START last to support the --no-checkout option
>> +      * introduced in the commit 4796e823a.
>> +      */
>> +     remove_path(git_path_bisect_start());
>
> I can see that refs/files-backend.c misuses it already, but
> remove_path() helper is about removing a path in the working tree,
> together with any parent directory that becomes empty due to the
> removal.  You do not expect $GIT_DIR/ to become an empty directory
> after removing $GIT_DIR/BISECT_LOG nor want to rmdir $GIT_DIR even
> if it becomes empty.  It is a wrong helper function to use here.
>
> Also you do not seem to check the error from the function to smudge
> the "result" you are returning from this function.

Yes I should combine the results from every removal.

> Isn't unlink_or_warn() more correct helper to use here?

The shell code uses rm -f which is silent and it removes only if
present. So it makes me wonder which would be more appropriate
unlink_or_warn() or remove_or_warn() or remove_path(). Is
remove_path() different from its shell equivalent "rm -f"?

>> +     return result;
>> +}

Regards,
Pranit Bauva
