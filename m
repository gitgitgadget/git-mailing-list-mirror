From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_ functions
Date: Thu, 26 May 2016 14:47:15 +0700
Message-ID: <CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
References: <20160518223712.GA18317@sigill.intra.peff.net> <20160518224323.GD22443@sigill.intra.peff.net>
 <20160519000821.GA22543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 09:47:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5q1G-0002Ox-2k
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 09:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbcEZHrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 03:47:46 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33048 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcEZHrp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 03:47:45 -0400
Received: by mail-ig0-f171.google.com with SMTP id z9so1324431igu.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dflV1EVG7VZu/SkeeTj3ZdT+MgXpLVG4ESmApS5do1U=;
        b=Hyt0zeNa9tC0k1uK7eJQZvQQ0buutwE3aWgxKjvDwZqHnQKuiSZxqbuAUWGstAEwtE
         KErGih+7mHNrnIm9Wz9JTB3sjW0zkkdn1bBP3v+XxgingIfV8z4DPpsc7CO4x2A73Y7Y
         tbvvV2cpvadoMVhlLbUyqdBWWj7LPGUU2hd0L3tiAG6sflHAdre+6sL++nkmZj3gdugF
         ItBT5UY4DjzK+j/5bq/jl/X4ExYBqh8vmsrVmRM7xZERAQ/l+ps1DDLIMhPF3+Y8GDXW
         1Gz/BW0K+qiu3/KTtzEGu1G2IMFdsqsSiWGoNlxSkxay8AJAGpoou6euEuADYHdB+t9S
         W4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dflV1EVG7VZu/SkeeTj3ZdT+MgXpLVG4ESmApS5do1U=;
        b=SfXrXOPVJFv6Hj/fV9i67YNxGtRQvZs4ncSXpKfdogrfuMV3n0DanYswaFaok1jbyE
         8MlT6KgSQoF3uy558c4uNKW/wh8YlNZwDfqvE0WdK3o5RZTwydInvyU1s79ZwgdJ+zJK
         TJXpsONg406ugNy9q5DpI5FnvzhSvY8THDwnBRilbVZucuVcMwY0wxzgg5J8Wv8GSNkG
         q3kPb3nZX4x0rHSv0R5TiYWiVymEH3LeGvVtGzJr/ccBy+8Ar1Lq8aIsosYiWNbbjih9
         FQKg6IhG1f+hWvuRqr+lohIokd/X07N+SLWt0ctJFIfXOF1ECDe7ZCaXvpZ/qbXjwky3
         uPvw==
X-Gm-Message-State: ALyK8tImKaYSvsvzOS74ht30ZmQOmxSHe32tC+D2BOrUUceoW50WoAm0Y7j6HMf4ttS8y/RSkp/JmyRPlKvANw==
X-Received: by 10.50.77.5 with SMTP id o5mr1833566igw.33.1464248864736; Thu,
 26 May 2016 00:47:44 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 26 May 2016 00:47:15 -0700 (PDT)
In-Reply-To: <20160519000821.GA22543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295636>

On Thu, May 19, 2016 at 7:08 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 18, 2016 at 06:43:23PM -0400, Jeff King wrote:
>
>>  cache.h                |  1 +
>>  config.c               | 51 +++++++++++++++++++++++++++++++++++++++++---------
>>  t/helper/test-config.c | 20 ++++++++++++++++++++
>>  t/t1308-config-set.sh  | 23 +++++++++++++++++++++++
>> [...]
>> +test_expect_success 'iteration shows correct origins' '
>> +     echo "[alias]test-config = !test-config" >.gitconfig &&

How about using 'which' to get absolute path for test-config and put
it here? Then we don't rely on $PATH anymore.

>> [...]
>> +     git -c foo.bar=from-cmdline test-config iterate >actual &&
>
> While writing and testing this, I got bit by e6e7530 (test helpers: move
> test-* to t/helper/ subdirectory, 2016-04-13). I had an old test-config
> binary leftover in the root of my repository, and the new one was
> correctly built in t/helper/. Running "test-config" is fine, but inside
> the git alias, it sticks the repository root at the front of $PATH
> (because it's the exec-path). And so it ran the old version of
> test-config, which did not understand my new "iterate" option.
>
> Now I'll admit what I'm doing here is pretty funny (running test-* from
> an alias). I'm doing it because I want to see how the program operates
> with the "-c" config, and it's nicer to spell it as a user would,
> instead of munging $GIT_CONFIG_PARAMETERS directly.
>
> So I'm not sure if it's worth working around or not. The single tree
> state produced by this commit is fine, but it does behave badly if
> there's leftover cruft from a pre-e6e7530 build. A more robust version
> would look more like:
>
>   sq=\' ;# to ease quoting later
>   ...
>   GIT_CONFIG_PARAMETERS=${sq}foo.bar=from-cmdline${sq} test-config ...
>
> Which is ugly, but it's probably worth it to avoid the flakiness.
>
> The other option is to somehow make bin-wrappers more robust. E.g., it
> would be nice if we didn't actually point into the repository root
> directly, but rather somehow linked all of the git-* entries that
> _would_ be installed into the exec-path into a fake exec-path (or
> alternatively, actually build them directly into that fake exec-path).
>
> That's a much bigger change, though. Given how unlikely the sequence of
> steps in my test is, maybe it's better to just work around it in this
> one case.
>
> -Peff



-- 
Duy
