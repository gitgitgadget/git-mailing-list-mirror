From: David Sharp <dhsharp@google.com>
Subject: Re: [PATCH] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 13:20:43 -0800
Message-ID: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com>
References: <1390866262-10188-1-git-send-email-dhsharp@google.com> <xmqqtxcnly39.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 22:21:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8G5m-0001FT-Se
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 22:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbaA1VVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 16:21:06 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37647 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbaA1VVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 16:21:05 -0500
Received: by mail-ig0-f181.google.com with SMTP id j1so2785389iga.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PuY9yjd2ByYxgXQp+MV+S4BP8CNz9ugsUhjNc0/c/hA=;
        b=ZZMoLKG02BxlbUKriX3lYUJX0DscNfkO5kEDwi0TV2ITpbgjS1mSEY+1l97/KWvQas
         9+uuclRMayanXBQsrcv0Sh/OuzA6IhT2TXaiOepLRRjXtfQDOfWRwTH8NNRv8UG2DAZP
         jjf0IV1a6vgQynWEi/MM0+mpWWRQaM9q1rLylmLtSsReomXqxdvz2U9JSDt/FR1+Ezo3
         LhjsgwUTPfXrMSgb//+X9XQsaHe7PWVgwUWy9q4Vq0te9rQUHyRUbRzGdnWZO9rdBtE6
         E49fgAXgrbiM5SA2GrA44jFGdClB6X6KuupbTnP4Kgdc3uEokeLQkVfHAmlNhPeP7qt5
         H4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=PuY9yjd2ByYxgXQp+MV+S4BP8CNz9ugsUhjNc0/c/hA=;
        b=GQl1+r0DGqzCxWc9O2yS/D+zKrtzlViWFerEb73CpskswPSOhgL7z01S8rAkPiywlV
         fEARdSudUjOg+YE0A4D1A62K2j33FS/rt3WJqu5/iAmddQii84hlhNF60bOuHPqWnxnd
         q4+/QqKZ1t2nLc52tSYmTeBGcNnA3sdCEO+VudCZQYVr3fC3CbaCgETDCkc1jDOUUzIW
         /klUl3QdKld4ubBncKYQ6dsBpJxpdZEURHzV+KrJhweJDt9miIYy1BD8wyFkdDr/3Mpk
         /AEEgQZX5JiqjyPOECVl8Ks8v0gc03ur7CHrCnuVokjo5HLNULwZn+zScUjiB25XPo82
         NXsA==
X-Gm-Message-State: ALoCoQl1WK+frEJxu+AXDBH4gagqXyls8cnVI2QHJckc4G4Vm45c8G8httRUonRy4rGmfkgZyqgSLy0JeyF8HSc1exU+f+m+P22QJdAWi9pfknHzZfGKkpoVOY50hlBTsQeskx7GjSyNY2+zKrja7KZ2KM2VnrOBl71R23s5pqELkHyoJpV+Ks6mAjgIqMFVJibmg2qMIdxu
X-Received: by 10.50.239.162 with SMTP id vt2mr25222071igc.48.1390944063384;
 Tue, 28 Jan 2014 13:21:03 -0800 (PST)
Received: by 10.64.224.137 with HTTP; Tue, 28 Jan 2014 13:20:43 -0800 (PST)
In-Reply-To: <xmqqtxcnly39.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241191>

On Tue, Jan 28, 2014 at 11:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Sharp <dhsharp@google.com> writes:
>
>> @@ -738,9 +740,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>>                               continue;
>>                       }
>>                       if (!strcmp(arg, "--resolve-git-dir")) {
>> -                             const char *gitdir = resolve_gitdir(argv[i+1]);
>> +                             if (++i >= argc)
>> +                                     die("--resolve-git-dir requires an argument");
>> +                             const char *gitdir = resolve_gitdir(argv[i]);
>>                               if (!gitdir)
>> -                                     die("not a gitdir '%s'", argv[i+1]);
>> +                                     die("not a gitdir '%s'", argv[i]);
>
> This adds decl-after-statement.

Sorry, I wasn't aware that git is trying to conform to C90. (It's not
compiled with -std=c90, -ansi or -Wdeclaration-after-statement.)

> As referencing argv[argc] is not a
> crime (you will grab a NULL), how about doing it this way to see if
> the value is a NULL, instead of comparing the index and argc?

I'm not convinced this is any better, but alright. I did something
slightly different based on that, though.

v2 patch incoming...

>
>         const char *gitdir;
>         if (!argv[++i])
>                 die("--resolve-git-dir requires an argument");
>         gitdir = resolve_gitdir(argv[i]);
>         if (!gitdir)
>                 die("not a gitdir '%s'", argv[i]);
>
> Same comment may apply to other hunks.
>
> Thanks.
