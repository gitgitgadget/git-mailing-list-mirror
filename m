From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 06/14] pull: support pull.ff config
Date: Thu, 21 May 2015 17:53:42 +0800
Message-ID: <CACRoPnQoZRc_DPM+kqxXmrepa4tKy7wX6eVjRNNMV8Sf9ue0vw@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-7-git-send-email-pyokagan@gmail.com>
	<86694e742e55b6db71ec30d43c5643d7@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 11:53:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvNAj-0002U6-6R
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 11:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbEUJxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 05:53:45 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:34009 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbEUJxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 05:53:44 -0400
Received: by laat2 with SMTP id t2so98526056laa.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HT1zhxhZy+eD6Tf6q47NwUWAJJJT65ZWdceEj6UENdg=;
        b=yKlNAQy5wEmQwRMchhS0LY4Gi1SKrnmB+I2RZrNy7ZSQzCZ0q2QYicxx8JI94KfXpR
         dFQucN7W2DdP8E7eHVZxL/Bky5auO4Swacy9Yhb5zYbqWCAgQesbYkdf73abYFOtcKVr
         ETVcFXEsjfiNqMlrWMYAPxvMYydaf7zj3OifDu2RFLn9cmhB3O2CIiB/nmhiienFySn/
         kZvWF1ocwj3sALxr/2xFJvVJz7HHjqSlciKk28rb2OgNkJq02nRDdT4Kp4+COGju+Ays
         bEf+5fMLnWcMTuoFVUnyuFlzQAVYGFlyjQycbf6UBqNtWbforTj7oqY0k1Nw26P76cBm
         W4pQ==
X-Received: by 10.152.2.38 with SMTP id 6mr1536307lar.80.1432202022730; Thu,
 21 May 2015 02:53:42 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 21 May 2015 02:53:42 -0700 (PDT)
In-Reply-To: <86694e742e55b6db71ec30d43c5643d7@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269575>

Hi,

On Tue, May 19, 2015 at 3:02 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-05-18 17:06, Paul Tan wrote:
>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 8982fdf..b305a47 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -209,6 +209,28 @@ static void argv_push_force(struct argv_array *arr)
>>               argv_array_push(arr, "-f");
>>  }
>>
>> +/**
>> + * If pull.ff is "true", returns "--ff". If pull.ff is "false", returns
>> + * "--no-ff". If pull.ff is "only", returns "--ff-only". Otherwise, returns
>> + * NULL.
>> + */
>> +static const char *config_get_ff(void)
>> +{
>> +     const char *value;
>> +
>> +     if (git_config_get_value("pull.ff", &value))
>> +             return NULL;
>> +     switch (git_config_maybe_bool("pull.ff", value)) {
>> +             case 0:
>> +                     return "--no-ff";
>> +             case 1:
>> +                     return "--ff";
>> +     }
>> +     if (!strcmp("pull.ff", "only"))
>
> I think you want to test `!strcmp("only", value)` ;-)

Ugh >.<

Fixed, thanks for catching.

Regards,
Paul
