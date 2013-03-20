From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] remote.c: simplify a bit of code using git_config_string()
Date: Wed, 20 Mar 2013 23:42:35 +0530
Message-ID: <CALkWK0mKKRmVdvvLmrqCPdPQoeYxWaFcuixyonnDM6o8Nt7ppg@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-2-git-send-email-artagnon@gmail.com> <20130320180707.GH3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINVw-00008z-8X
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab3CTSM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:12:58 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:46414 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab3CTSM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:12:56 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so2271841iee.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fHKzyFtkwfOk9TXT4TUi7+9lakJZHLcaQwQJXhAEl2w=;
        b=I+BtPYhAW/dmq2rAVfdxHgx8R2RO4XxhhOBe5ps33suKKLb1MYFMx+So5icvQNS8BM
         anukD4UCTBZp+nxflhANYsryoz8UzYVTVxpN4jXzBkDA6YtRc8zfnYOMwB3EvlIm11HL
         4OdyBnfjs/nf7mRMkurBgIlPyK6b+rIlunxtVPkIbsB7HFDw7eQLKGSr3ZFfzlIVtZFR
         5/+IYYcgN5Qod4x5yI1rPVeeqkkDyRmZUGxM2BC4PMJh7qVXeMbH7zskuorSWZhzRNXC
         DW4rLexSI7sJ8KE6AEhkMV8mRwF30uDhY5sHYq7L4NObR9TiJL5txbv4hovPcn3AUTvO
         ep1A==
X-Received: by 10.50.119.102 with SMTP id kt6mr45886igb.12.1363803175206; Wed,
 20 Mar 2013 11:12:55 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 11:12:35 -0700 (PDT)
In-Reply-To: <20130320180707.GH3655@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218635>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -356,9 +356,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>>                       return 0;
>>               branch = make_branch(name, subkey - name);
>>               if (!strcmp(subkey, ".remote")) {
>> -                     if (!value)
>> -                             return config_error_nonbool(key);
>> -                     branch->remote_name = xstrdup(value);
>> +                     git_config_string(&branch->remote_name, key, value);
>
> Shouldn't this say
>
>                         if (git_config_string(&branch->remote_name, key, value))
>                                 return -1;
>
> or something?

Yes, and so should the instances in [5/6] and [6/6].  Thanks for catching it.
