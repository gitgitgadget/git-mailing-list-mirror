Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BC81F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeAJTfY (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:35:24 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36173 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754287AbeAJTfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:35:20 -0500
Received: by mail-qk0-f176.google.com with SMTP id d21so343740qkj.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xXGFB7ZNn16akpJtUL1mSoDwa4/cycHnY/K0Wm82WNI=;
        b=DTsOR5VJs7iLnit7mvN+WbmLI+pbsEptF4OBcDtTBgxeiGWLfGTykyNW2K5AmuUnBn
         7gOXmjoxE2/Ca8zdI4H7Bss8Ezsa8rZ1rP1NYshiu5J9OzYRahoy8aP8Mqm3AbVrJhnQ
         8iKi6Tar01J/ksPnPbUGkSOBO6RWFsNJpuut5Y29bo5aVHckV2bo0FX/tpQxMC04u5yh
         p+EJomtPwcabMmvGyjriKJYntVdBEsPN0m8VYVnDBX/nHnqMn2QYEOOHChUg0jAUZIzJ
         Xdsb/1STlxveklnriwFvOUAOeYtZ/v/ESTLjtdd22yvnP5TlFY+kil/LQo9PJ/aoyJw2
         MLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xXGFB7ZNn16akpJtUL1mSoDwa4/cycHnY/K0Wm82WNI=;
        b=WfTrn8L7M6HKZZvPp3PNe+bynsIw6TXj3Uio7NRKzmDy0MVqF9+NHtEjDfaTpVaNEd
         K3NydGSCqbG1E6syqR8jMfVD45BiYrCszS2sVVk+f4DX3ZWO4usn8rAssh4sseoynPc0
         JzLV2W+7ao/EIMX2XtttMk7JMd6dN+Ffk9DtB32k6taNfVg2+CoL3398vv9ik9mprmjC
         rmxuxCLF/YStXo7CbA7ee+0t9ItX3AvkYUwR/vUPohP4iSrLAAAuAp9VTcFCUI6XGD0S
         /z3trIiLDQAVrtQRfTnX2srPMI58GXDFE+5t0EhalIV0/PvI1sGQ5PgaFGqF1MCtaukh
         /8ZA==
X-Gm-Message-State: AKwxytcAltQ0vuZHF/23VXX7MeqWkgJek2G7W2Mgw8r8wWRfFjrv3hRU
        Oh4ObGhOJf/XkQoSi0KtTG4YY7BcBaSku43LtcBei4rA
X-Google-Smtp-Source: ACJfBotbdWgmR2dwh9gCWg3P4G4Az/MdeYhON8NyvJHNnOGL+JDiMPmNwAz9F9HvwJdkkvNoJvTSn50nKP/l48stURw=
X-Received: by 10.55.77.142 with SMTP id a136mr27115536qkb.320.1515612918999;
 Wed, 10 Jan 2018 11:35:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 10 Jan 2018 11:35:18 -0800 (PST)
In-Reply-To: <20180110192606.GB53941@google.com>
References: <20180110104835.22905-1-pclouds@gmail.com> <20180110180945.GA53941@google.com>
 <CAGZ79ka0mhPy776fRYtvnaqd5P1dwvuaeONozEWpaJVZxSneiA@mail.gmail.com> <20180110192606.GB53941@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Jan 2018 11:35:18 -0800
Message-ID: <CAGZ79kayPNuCNBDe7Ba823APf+QLZU64j2WqFeMn3UjPU7jUGg@mail.gmail.com>
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
To:     Brandon Williams <bmwill@google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 11:26 AM, Brandon Williams <bmwill@google.com> wrote:
> On 01/10, Stefan Beller wrote:
>> On Wed, Jan 10, 2018 at 10:09 AM, Brandon Williams <bmwill@google.com> wrote:
>> > At first when i read this I was under the impression that the whole
>> > environment was going to be printed out...but i now realize that this
>> > tracing  will only print out the delta's or the additions to the
>> > environment that the child will see.  Maybe this should be called out
>> > more clearly in the commit message?
>>
>> It only adds newly set variables, I wonder why deletions are noisy?
>> I could not find an example of a removal of environment variables
>> specific to submodules that would be noisy.
>
> Deletions are noisy because we append local_repo_env anytime we kick
> off a child process (ok maybe not all the time, but a lot of the time)
> which is just a list of ~15 deletions.

Oh, I see. I'm fine with that.

Though to further the discussion, maybe we want to check if such a variable
is set and if so actually show the deletion? I have the impression that most
of the variables are not set, and yet we unconditionally delete them, "just to
be sure". Maybe we'd only want to delete them if we actually have them
set in the superproject, and then we can show the diff in env vars
more faithful?
