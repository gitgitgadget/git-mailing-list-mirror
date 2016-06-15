From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2 3/6] wrapper: move is_empty_file() from builtin/am.c
Date: Wed, 15 Jun 2016 23:45:06 +0530
Message-ID: <CAFZEwPOH_mkESin+Ykx4yXqS6oo2yAy0WzqvUgTh_eZ3HwXZXQ@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-4-pranit.bauva@gmail.com>
 <xmqqh9cu724n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:15:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFLN-0002GA-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbcFOSPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:15:09 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33035 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834AbcFOSPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:15:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id a186so4291809qkf.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fUy/hnLaUvOOrq5dNAUXFlsJyU6EGqFNKomkd67Aj/o=;
        b=BxS8btF5n5Oc5vNQnbYthRJEzro3tuHNWisnXsd9doXKicMZv5RDGgZuRMWbQtHSzs
         oRXY32YtEFLFIe57zYvDZtw+cdqFRa46+FsuPDxFFcDYubHnd18WibEAyEthGTut4Z83
         bHUpYvVbP9Cw6MIny4p3+oVp1gXfeNFQ6299AS27m/zCsLRnckJLasTG2PnkGlVYhpZe
         u+5uSZpobZ0VmcCe6Cfc4ylFVG4fB3Ye6tS4DtUOG6aHTWURvwgPzRP9spE5E0G12+EY
         bsRpgeBMI6ja9+d52sFEWS+FJv/jdFQsAtbefT/1r/SfVG8eiqNg7kqkOguBKip49EEk
         P2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fUy/hnLaUvOOrq5dNAUXFlsJyU6EGqFNKomkd67Aj/o=;
        b=MFYEtqow54413UEkU+oyz3R/7gzHQfaUnR/JxDV3IcPFWycgk6v0VjX8CwlP4lz+pm
         +BVKtT9BYBiHd67nm0LvNtUb5DYvDFdRVt0fv89e7WZ/xhYswLHZy0UWuXFxDRQNunDm
         GuxzBUFhpetHdYALxptWoXGwPErSZstgK3CwHkBJQxC1wzqzJrNov4aUJmdaeeQfsJou
         hDPpanS82lfF8SS0g30t+tltWXKVNycsyRMDwhAGcnQ8s9KP0h7XiEwsdopJ8YPwOjus
         J8u99FucAkEdGBmcduP2IbErrS9Gdf/T7dGW0ltBG3jYrK9Lu8IEzX8kF4sydTEcT6lB
         CytQ==
X-Gm-Message-State: ALyK8tKu2Nh6ZOcGA2aXOJ8zqhJ78Rq7NIK1KBosaEAeURjwbOTC47/7qUEgxbFtjOHp2XYXR1gFqmV1Hs0eIg==
X-Received: by 10.13.248.7 with SMTP id i7mr53148ywf.164.1466014506411; Wed,
 15 Jun 2016 11:15:06 -0700 (PDT)
Received: by 10.129.116.193 with HTTP; Wed, 15 Jun 2016 11:15:06 -0700 (PDT)
In-Reply-To: <xmqqh9cu724n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297385>

Hey Junio,

On Wed, Jun 15, 2016 at 11:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 3dfe70b..84f21d0 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -30,22 +30,6 @@
>>  #include "mailinfo.h"
>>
>>  /**
>> - * Returns 1 if the file is empty or does not exist, 0 otherwise.
>> - */
>> -static int is_empty_file(const char *filename)
>> -{
>> -     struct stat st;
>> -
>> -     if (stat(filename, &st) < 0) {
>> -             if (errno == ENOENT)
>> -                     return 1;
>> -             die_errno(_("could not stat %s"), filename);
>> -     }
>> -
>> -     return !st.st_size;
>> -}
>> -
>
> This is perfectly fine in the context of "git am", but as a public
> function that is called is_empty_file(), callers can come from two
> camps.  One is like the caller of this function in "am" where an
> empty and a missing file are treated equivalently.  The other would
> want to act differently.
>
> Renaming it "is-empty-or-missing" is necessary in order to make it
> clear that this helper function is not targetted for the latter
> callers.

Yes, its better to rename the function as is_empty_or_missing() . Thanks!

Regards,
Pranit Bauva
