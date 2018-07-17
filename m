Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80FD1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGQWOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:14:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54503 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbeGQWOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:14:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so746232wmb.4
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+OkjmCkNz5EK6kh7JPWs8C58CJ4JVJ5qZm6N/NECMMs=;
        b=G7FQYtJNbfLa8FxyocR3reVxcdEVRtPAJY+U/c0Oc8g1ovqwZGUze5IhL46dTgar1P
         6/IZj3K/GXCUmcDT6IVOeGtkexejrZnnCCYZNHZuA3akN+42QEEm3r92lObEHEyCfA6e
         VjJtMignNB7/kNX0DS3xOrb5yIukCnf74nSmtte7VKjET1mbY6lPAiQGEJ8eYVHlFmn4
         OqE58aAzN0BIG0Io4vdAoBOhKN/RS4ccdf5svWhywq/3qpNo9DdceDEgD7bMWHE8Wcny
         hBLAaWIPKiwB7rVNgp9YJyxC+IpmOt34Bdk09JKS1JaKuwhHkqkWwzAPxU6v+2toO745
         jL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+OkjmCkNz5EK6kh7JPWs8C58CJ4JVJ5qZm6N/NECMMs=;
        b=Nj9edEx7D2b4fTdI9f2RDOvPsYECgbKSwwsd4KUexcFeLcOsQNifc8fmoJJpB9EuE3
         88jG58EAgYE1+HLn8bixO/0V4iDNdlo8EBKTa3tacR/ymbhAl4ot8zNsez7AtJW9cN7b
         1VQqi+PkQkg00trajsHlSjyYod9pq9C42IGqL/beeqm3GRU9gnKZHkhsQNXD8WEbvvy9
         3Igyb62jLnx5nOZtyU6B+TtzKmuyCLxyklKqUMKay5vx/iWHGafTtnng4bLiSrVSMOkU
         kIItcCIeCjb4Zg+N7NrrmPTGjwAAHq3O+C4NpK9yyQ+W2sMQ7k6toW1/l+ktZ989jw9i
         oy2A==
X-Gm-Message-State: AOUpUlHQudN8ly0A5Yk1QeIBetc/sV49EhUSTBGRjZWjsZRk9HgON5KE
        6eUZtSn2WFpxpwIZq0W20xE=
X-Google-Smtp-Source: AAOMgpcRiZV/wqTLDhi4vd5WwAU0CoZRTRle4W9d7uF+cmNqUg+MswjkNWefDrvgp3r4Fz9TgxrFbA==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr2465433wmd.77.1531863564438;
        Tue, 17 Jul 2018 14:39:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o4-v6sm383769wmo.20.2018.07.17.14.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 14:39:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
References: <20180717002654.120375-1-sbeller@google.com>
        <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
        <xmqqa7qpod29.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbYtws-HhX_kQ5Gb4FeAfgRjbCfVbPS1Gcow4xfN-04XQ@mail.gmail.com>
Date:   Tue, 17 Jul 2018 14:39:22 -0700
In-Reply-To: <CAGZ79kbYtws-HhX_kQ5Gb4FeAfgRjbCfVbPS1Gcow4xfN-04XQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Jul 2018 13:56:48 -0700")
Message-ID: <xmqq36whmtit.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> As I most often edit the log message and material below three-dash
>> lines (long) _after_ format-patch produced files, I do not think it
>> is a win to force me to push and ask to pull
>
> Ah, that is an interesting workflow. Do you keep patch files/emails
> around locally, only to (long after) add a message and resend it?

The time I "finish" working on a series and commit is typically much
closer to the time I format-patch the result, but it will take time
for me to actually mail out these files.  It will take time to
re-review and re-think if the explanation in them makes sense to
readers, and sending half-edited patch is something I try to avoid
as it would be a waste of time for everybody involved (including me
who would then need to respond to messages that helpfully point out
silly typoes, in addition to those who spots them).

I am trained myself not to touch these files after sending them out,
as comparing them with a newer iteration of the correspoinding files
was one way to see what has (and hasn't) changed between iterations
before I learned "git tbdiff", and that habit persists.

