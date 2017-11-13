Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1371F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbdKMW0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:26:49 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45028 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdKMW0q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:26:46 -0500
Received: by mail-vk0-f66.google.com with SMTP id x65so11066708vkx.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=inzE3eEf5RZQIzgCGQDMfETBHFvx+FjP98goov2BvRs=;
        b=Ktb9qpN63M2k2bjX/BSazIClfDUVaz57rRRE94RLJUUna8aKfhXkTE3plnEV+qV8kH
         EjLlIjj8CHxQvfxU7hkPhYT8sKztlAkdB8mQTZWJ7hBznvaAjPnSLt9ZSNHMfvyfXuyq
         y04CMMXc0Qf5v6lxpHah6xrIxuBDyVW+pNNhkrTfSzlh/b9mMQjKVxFxbemwW/4Hp/xF
         MCUymVJuYaQKGkTtk3pscmOXy4fTLhnHqM2olmHkGSl36+VIkVDq7zwb2hv7mOGl/qGx
         0f5OYaHEkNLN3RcMHeROv8u0oIvYy2N3vPVKST7fAbx8mM7fXGf7rNhPMhe4lrdAhbNe
         QZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=inzE3eEf5RZQIzgCGQDMfETBHFvx+FjP98goov2BvRs=;
        b=CTMe4Ra7WGQ+nifPRd3NQ6W5sTy3g0iZ/1DeSl5XFxnnQvvgdC+eXkVgGqjKQFqVVL
         JWMjm3XmTmKnlMtg9BGVghx8+QK8/00+yw1O596koNp0ire85RA7qaLyRs0zoKmYjfos
         bMkW6UDsXLLBI+hsfZVqGIKWPIVhrezVjNb5IsD8iNUWA+yuZIINCz0QRhWH3s7uWWIW
         8Z8Pl3LtQLi3NcqIHzadmnZf8KYnynTE1nGBCrQc3XUuDoRDmBOde82QyrdtJra1RHmD
         LvxadJ7ENZrxYFre33qFQY9d0nP4W/iyXkeoBAzfSeAy0sKDRLNI6bdaZ7yjYa2XQolA
         qNGA==
X-Gm-Message-State: AJaThX7qnwf98fwQ5QzUWNTQY9hJxZ9brDi7MNh0+msNXp/DQEqirRW4
        8/GfGgg7fIh0TqUpiHo5xrGdDpJOUMzDYhkEIfI=
X-Google-Smtp-Source: AGs4zMYscPPFaG4zpHD2kjqadEMDMUw/58hHCj85ymqhlrQMbFCMr/u2zrPFA76FAeb8+EZNzt6rOzb4gNAIaGssfGo=
X-Received: by 10.31.238.138 with SMTP id m132mr7803842vkh.114.1510612005141;
 Mon, 13 Nov 2017 14:26:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 14:26:44 -0800 (PST)
In-Reply-To: <20171113133316.c10bd360b4af10e572049443@google.com>
References: <20171113201600.24878-1-newren@gmail.com> <20171113201600.24878-3-newren@gmail.com>
 <20171113133316.c10bd360b4af10e572049443@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 14:26:44 -0800
Message-ID: <CABPp-BHhFq3C1t6TO2FMVT8=Bwf__cHhu2U-c+wd5zwHX-=9uQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] progress: fix progress meters when dealing with
 lots of work
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reviews!

On Mon, Nov 13, 2017 at 1:33 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon, 13 Nov 2017 12:15:58 -0800
> Elijah Newren <newren@gmail.com> wrote:
>
>> -static int display(struct progress *progress, unsigned n, const char *done)
>> +static int display(struct progress *progress, uint64_t n, const char *done)
>>  {
>>       const char *eol, *tp;
>>
>> @@ -106,7 +106,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
>>               if (percent != progress->last_percent || progress_update) {
>>                       progress->last_percent = percent;
>>                       if (is_foreground_fd(fileno(stderr)) || done) {
>> -                             fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
>> +                             fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
>>                                       progress->title, percent, n,
>>                                       progress->total, tp, eol);
>
> I think it would be better to cast the appropriate arguments to
> uintmax_t - searching through the Git code shows that we do that in
> several situations. Same for the rest of the diff.

Interesting.  My first inclination was to ask why not just change the
variables to be of type uintmax_t instead of uint64_t (since we're
already changing their types already), and then get rid of the cast.
But I went digging through the source code based on your comment.
Almost all the existing examples in the codebase were off_t and size_t
values; there was only one case with uint64_t...but that one case led
me to commit 5be507fc95 (Use PRIuMAX instead of 'unsigned long long'
in show-index 2007-10-21), and that commit does suggest doing exactly
as you say here.

I'll fix it up.
