Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C76201CF
	for <e@80x24.org>; Thu, 18 May 2017 16:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756310AbdERQed (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 12:34:33 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34403 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdERQec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 12:34:32 -0400
Received: by mail-pg0-f48.google.com with SMTP id u28so25289201pgn.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BRsu1HzcrEJZZ1sfazdixT0NwEhw94KICpbyKEDbdLs=;
        b=b1EHBLuWs6oS7uI+QyxSTsJWahE3rmaZff4mbjVLx2QsIjRmsGtFHXnIFydF6cvGPf
         SUDiW2/zpGFYcRxmQg0tu2etYeMsTkKxLJ5kUj6ecprafGIAmQmhi4WbdahL68EE4Ln0
         GigPhslBsMbirpYjxuDYtQk+J+uDAP8m2esSIqrdLbm+GLSy1GD1DicYsHk56oOpCQvP
         bWwmFSMx3YDPGGbSuZhwFN+HyBv2YpVKPqPiI0F43yu6De4Y7UDfY1taaDM6hxlKzA8Z
         MwNQqfh7q3DCaIQTCUIZK/NXjnDZLIrWK2yqOWptsUrDSFGR2i8VrHQW/QQjYKjDmK7w
         o+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BRsu1HzcrEJZZ1sfazdixT0NwEhw94KICpbyKEDbdLs=;
        b=E51KIwJoeBchSS3nqziknXBWHhckkBUQZqkyG3/MuT7rQJQZ4nS5e2w1IacxqOPnnl
         fUMgA/xyo/o4pm28UQ0X68m2z1LIT2QGx6udCUPRvKUh3YpOgtA7UsMXfW8A50hzdOED
         hl0fixIcM0/IrWOEbaaW3sgDMVAss0lmsnJ9K3ruIvGaGler/hJUuKkEHqY3xFqlsL3c
         2HVl5lJaGNTVvkf0FTznKUOtXFsIjH7qLAB3D+tUVpB8WGu9V+ENuH1Ce+Qmwx8h153w
         NzgKeqqMTaqPpVVxjuhJy5v+MUN9wz6UiE8vF1CP6VgpnA5/34qs99098sm5PdQFm2uS
         fY8Q==
X-Gm-Message-State: AODbwcDSxIp6PiK7+VFixFD3Cu9mEEeEflk/pbIyWAai25EJqK/9d5ig
        VJ4AYFKqWZDYkSCpOs5agtqH0VaArw4VxFE=
X-Received: by 10.99.116.7 with SMTP id p7mr5333181pgc.162.1495125271842; Thu,
 18 May 2017 09:34:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 18 May 2017 09:34:31 -0700 (PDT)
In-Reply-To: <xmqqshk2u3kz.fsf@gitster.mtv.corp.google.com>
References: <20170517213135.20988-1-sbeller@google.com> <20170517213135.20988-2-sbeller@google.com>
 <xmqqshk2u3kz.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 May 2017 09:34:31 -0700
Message-ID: <CAGZ79ka3XBu-iNbvkp9yi5ovXVaAyTH9BY+M8HOj-Q6PEMB7iw@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule.c: add has_submodules to check if we have
 any submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 4ef7a08afc..510ef1c9de 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1344,7 +1344,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>                       set_config_fetch_recurse_submodules(arg);
>>               }
>>               gitmodules_config();
>> -             git_config(submodule_config, NULL);
>> +             load_submodule_config();
>>       }
>>
>> ...
>> +static enum {
>> +     SUBMODULE_CONFIG_NOT_READ = 0,
>> +     SUBMODULE_CONFIG_NO_CONFIG,
>> +     SUBMODULE_CONFIG_EXISTS,
>> +} submodule_config_reading;
>> +
>>  /*
>>   * The following flag is set if the .gitmodules file is unmerged. We then
>>   * disable recursion for all submodules where .git/config doesn't have a
>> @@ -83,6 +89,62 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
>>       return 0;
>>  }
>>
>> +static int submodule_config(const char *var, const char *value, void *cb)
>> +{
>> +     if (!strcmp(var, "submodule.fetchjobs")) {
>> +...
>> +     }
>> +     return 0;
>> +}
>> +
>> +void load_submodule_config(void)
>> +{
>> +     submodule_config_reading = SUBMODULE_CONFIG_NO_CONFIG;
>> +     git_config(submodule_config, NULL);
>> +}
>
> OK, so anybody who does the git_config(submodule_config) must
> instead call this one, so that we can notice there is some
> "submodule" stuff configured.  And that is ensured by making
> submodule_config private to this module.

Exactly.

> Nicely done.

Thanks.

>
> On a possibly related tangent, I've often found it somewhat
> irritating that that these two calls have to go hand-in-hand.
>
>>               gitmodules_config();
>> -             git_config(submodule_config, NULL);
>
> I wonder if it makes sense to roll that gitmodule_config() thing
> into this function as well?

This patch has been sitting on my hard drive for quite a while
and I just vaguely remember that I did not do that for some
complication along the way. I'll re-examine the situation.

Thanks,
Stefan
