From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Clone repositories recursive with depth 1
Date: Wed, 11 Nov 2015 12:09:41 -0800
Message-ID: <CAGZ79kazAWj+D85EXUyP9iHgcb=7QpymyaaKEqQRu9a+UO9msw@mail.gmail.com>
References: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
	<CAGZ79kbfFhCvQW=_7i4KxjWeh7uYRTTNvLzQUq+CJ641g3=UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbiF-00078Q-1O
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbbKKUJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:09:43 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33850 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbKKUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:09:42 -0500
Received: by ykfs79 with SMTP id s79so68214404ykf.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/dOgOQ/7GKpm7MhIjUJPnMhECtwHjsfOYSISH8XeB+U=;
        b=im9PRaPTHe+U+3kxxpzDdzBBlk54zgBKd7vv/Zkk/BPKiEK+cm6//UGSG52uviFNJX
         JTsJMJtj63yaGXEyP03OvyEfVaEzxvsJRer7ORzQc6xv0E/5RKjIu7RmKNnLn4t5PLvA
         Xo/ZesIijMn8OZNIwWSapAS3nLHzdCGYl9jOU6Ll86Z5kF8Uk9K45znF3ENz8W6p/dNH
         OPMO/iGAfcgnRlBVR0/QggPZNcYgqSZzFIXiMqjd27uMQnEjmpnQnDvJmlj/5lMEIU5a
         rKFXj+YBQ11mathL3ERVH87OTdQ7yn61a6U2viyVOH+v4wxaFAVBaBX046+MMjegswyr
         3GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/dOgOQ/7GKpm7MhIjUJPnMhECtwHjsfOYSISH8XeB+U=;
        b=LglTU9qjOZmJWw2qjhVHHh4sPWtshIDtTQAYe3BmCN4QsXk/TjEzaqnrL/BvxubfCE
         Z7AD/flyEDx2oeqAlCotJ6PLeVlp1R5Rqr4xZUdcv1+xmcm1AOuKbL8Clu8i3TQChIIj
         DSsPBeE4VWCAjHO26gmHmgwXScRUepQjru3+rY4LQIUlPtB3tnEUTcocQo1B/+FuM3eG
         VT6+SD5G5+okKcDjVAyBIXNotQUX4WLHxIV8AiOOcjfAHUzMQA6rCBjAGbmlNE48QlDu
         41aBR9d0eDvmdv58dKP0EiY1t67xIgQUrWlFa/AzbAQZjElq96Uy2TJuXjGcL71uPWg7
         Ih3A==
X-Gm-Message-State: ALoCoQlXMEepwkMizu7coHvXXosUMi4ltDeCfPdcENYFfEII9jYN3YQUpvoj2et72Gwxc7MPP8M/
X-Received: by 10.13.210.4 with SMTP id u4mr12062345ywd.68.1447272581885; Wed,
 11 Nov 2015 12:09:41 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 12:09:41 -0800 (PST)
In-Reply-To: <CAGZ79kbfFhCvQW=_7i4KxjWeh7uYRTTNvLzQUq+CJ641g3=UDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281194>

On Wed, Nov 11, 2015 at 11:19 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Nov 11, 2015 at 6:09 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>
>> I have a clean build machine and I want to clone my source code to this machine while transferring only the minimal necessary amount of data. Therefore I use this command:
>>
>> git clone --recursive --depth 1 --single-branch <url>
>
> That *should* work, actually.
> However looking at the code it does not.
>
> citing from builtin/clone.c:
>
>     static struct option builtin_clone_options[] = {
>         ...
>         OPT_BOOL(0, "recursive", &option_recursive,
>            N_("initialize submodules in the clone")),
>         OPT_BOOL(0, "recurse-submodules", &option_recursive,
>           N_("initialize submodules in the clone")),
>         ...
>     };
>     ...
>     static const char *argv_submodule[] = {
>         "submodule", "update", "--init", "--recursive", NULL
>     };
>
>     if (!err && option_recursive)
>         err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
>
> So the --depth argument is not passed on, although "git submodule update"
> definitely supports --depth.
>
> In an upcoming series (next version of origin/sb/submodule-parallel-update),
> this will slightly change, such it will be even easier to add the
> depth argument in
> there as we construct the argument list in code instead of hard coding
> argv_submodule.
>
> This may require some discussion whether you expect --depth to be recursed.
> (What if you only want a top level shallow thing?, What if you want to have only
> submodules shallow? What is the user expectation here?)
>
>>
>> Apparently this does not clone the submodules with "--depth 1" (using Git 2.4.9). As a workaround I tried:
>>
>> git clone --depth 1 --single-branch <url>
>> cd <repo-name>
>> git submodule update --init --recursive --depth 1
>>

The workaround works with the origin/master version for me.

Notice the other email thread, which suggests to include --remote into the
call to  git submodule update depending on a branch config option being
present in the .gitmodules file.
