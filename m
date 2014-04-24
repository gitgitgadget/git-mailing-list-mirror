From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 1/3] fetch.c: clear errno before calling functions that
 might set it
Date: Thu, 24 Apr 2014 08:21:32 -0700
Message-ID: <CAL=YDWk9xd3d4Z8YoXvy7Z=5q=3=6+s_KaBS3W0yyESZ=ueDSA@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<1398192327-21302-2-git-send-email-sahlberg@google.com>
	<CAPig+cTu4hUCF4r6wAHnGpfcoQP9SqDUWgA2SjjKbjDNrDG8fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 17:23:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdLUK-000660-ET
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 17:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbaDXPWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 11:22:52 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:34646 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912AbaDXPVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 11:21:34 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so3086729vcb.7
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+X1f1+Ryaj+SIDf3avSWbkuVpgDC1cYQj8d3RYJTluo=;
        b=ZSRGFjbGvAljAKgCp6P7J2FeQe2uF4WE7pp10RiPRZ2BOqt/9fhiV33na9P9V7OF72
         JeoSIsJZTgs2eLIHSbhzV94CYj6K/QO4+Mwrm7h5/6oCITgbgBrk019ogtl72E+UhcdU
         gtcIeTa7NC/ISgLgVyZ4sxT8xD+adW2Dc0BYDusnfMk5loEoMJexvvVql67SkAqD8d0i
         mcnEYKVP4vADTr6aRdyawDfnjBEWYYx96h7Z0Z7Cn/xBuMAcU1ybfJksAVIFlktsKbs+
         tnMutPwVPgTjJjBRxyJfvTWnNaD/fEbtQEKUa3nBLqrz5SNVwGPYZfv4I0sopjgATjIF
         1gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+X1f1+Ryaj+SIDf3avSWbkuVpgDC1cYQj8d3RYJTluo=;
        b=HzQo93I0KSH8CPUXYqLznCYV5cl1diQLvbKpptc8JX0Cy1sHsuCRunWNOBCR0CQHcU
         kN3Ywtyef4/tYQsMXDuGcMEjSHnqP3wkRr7zxgVZOBPgWkkDaq3ymzT+IXjuxepjhsEW
         ydtHvWCQcI5x4QXLh9Bm8D7Vfg0SowxoeBfxuWfFEy+pB7Df22zNQgzVPNtbIM+a2SK+
         w67ZxZgj56Y8sy3GWkjqFhU5GTTL5PHG1LO1c9CP3By74GJvbZmNbHa0/gmoCbASo1BU
         GzrQwM5Kz3aM+dvVQagJmP2GXGZRVqtCoRfpsEBjBAepts5REdVm7IPciXMeg5Sl8175
         MI3A==
X-Gm-Message-State: ALoCoQmfDM/e/BJQ3orMEmoaQHh7i0gnEtbkuX5idzGRPUbdWdxsxlyQsDzxppOWe7+cilO/WlZNjMdT7RG7pGaMRlmhPU3U6/pEHyVD0svd+lFgAJ0iipQq+bSm7ApnghCuIPZXwkUbgWj9iFB7no4vEi+TJovCXZ/owu2rdA8PqYrG5xvAP2RCIGI9M75zav2xF+wCTj5h
X-Received: by 10.221.17.200 with SMTP id qd8mr619514vcb.50.1398352892821;
 Thu, 24 Apr 2014 08:21:32 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Thu, 24 Apr 2014 08:21:32 -0700 (PDT)
In-Reply-To: <CAPig+cTu4hUCF4r6wAHnGpfcoQP9SqDUWgA2SjjKbjDNrDG8fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246973>

Fixed. Thanks.

On Wed, Apr 23, 2014 at 1:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 22, 2014 at 2:45 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> In s_update_ref there are two calls that when they fail we return an error
>> based on the errno value. In particular we want to return a specific error
>> if ENOTDIR happened. Both these functions do have failure modes where they
>> may return an error without updating errno, in which case a previous and
>> unrelated ENOTDIT may cause us to return the wrong error. Clear errno before
>> calling any functions if we check errno afterwards.
>>
>> Also skip initializing a static variable to 0. Sstatics live in .bss and
>
> s/Sstatics/Statics/
>
>> are all automatically initialized to 0.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/fetch.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 55f457c..a93c893 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -44,7 +44,7 @@ static struct transport *gtransport;
>>  static struct transport *gsecondary;
>>  static const char *submodule_prefix = "";
>>  static const char *recurse_submodules_default;
>> -static int shown_url = 0;
>> +static int shown_url;
>>
>>  static int option_parse_recurse_submodules(const struct option *opt,
>>                                    const char *arg, int unset)
>> @@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
>>         if (!rla)
>>                 rla = default_rla.buf;
>>         snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>> +
>> +       errno = 0;
>>         lock = lock_any_ref_for_update(ref->name,
>>                                        check_old ? ref->old_sha1 : NULL,
>>                                        0, NULL);
>> --
>> 1.9.1.518.g16976cb.dirty
