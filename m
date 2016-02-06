From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 3/9] submodule-config: remove name_and_item_from_var
Date: Fri, 5 Feb 2016 17:21:50 -0800
Message-ID: <CAGZ79kaY7+vfTdtjT_Mty+pu75wX7dktaWoULoUOnzZC5QGDzw@mail.gmail.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-4-git-send-email-sbeller@google.com>
	<20160206004615.GB28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRrZT-0004kf-1Q
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 02:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcBFBVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 20:21:51 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33414 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcBFBVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 20:21:50 -0500
Received: by mail-io0-f173.google.com with SMTP id f81so146492661iof.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 17:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V9ubCPxcIs5b16X8V/KlKKJ5IbH0V2jo8UCmJu6UR/U=;
        b=F7hXDrevs13eoxwzo+hXThZyyMDvUvABW4yigvuQmwxymk/pp5IzoYMval6qNMSm54
         D8WesFRxgCYqZWA9oC4lcmYjyhGZMlI+n/PPufn9lFRQ9LzIt6FxJmDafdjvL2Ato9Va
         LYeiePI+AhJ9eRMxwGaicJAaxC2kT430QH8Eq+HgGYXhlYUjaiuCHA48AEkT5bdLMzlZ
         djyv5X3NrWVfOpmxWrIsGYnGMZY7LimPO8y4Ht2+UooyrbAb6lKvp7jxJhRET9/CBotx
         ReoScpfuXLHg/y7l455tIQLb5QTMje+6daoP+GCdS8F01dbzm3cdsHB4z0kCu6sJ45iI
         PI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=V9ubCPxcIs5b16X8V/KlKKJ5IbH0V2jo8UCmJu6UR/U=;
        b=XbkYKhe4wX6pwD6Fx1OlYMGpor1dSfNYzMrBonWWCwgIpZwM0Oc2C6NG3P3jneRdoN
         +RN2Nk+cABjhVpCT6KsAQEmFq+fb77xYyNFlcRSGdVy5APufHviy4TonvXLzyIhNGrRU
         Ycnqzj/a9X4PvIAAEcBzmSlBUTwgeBWT7xALP1f7xCMGjIa9dA/Cq3rs1KRzCUJ/WVTz
         xV18k+pQvkVsLofyc1RKT8abb02aSk8gFd77KqdVQkhBv+nENCeaNzTOx51sVeUBbjAd
         as2YigCiPIHzycpmet6BpMWJb+vR4hluV8gwBAgJGSMHp3OZkf/vE569DBs0D5R+9jRn
         qorQ==
X-Gm-Message-State: AG10YOS9t7yv9x5r5wMED8hnN2cz2j0GKG8drUQSnpUjqsB6btOa1bpf3eDyVcAuRyDQaDo5c9G1stxvC3n1As//
X-Received: by 10.107.137.100 with SMTP id l97mr20454353iod.110.1454721710150;
 Fri, 05 Feb 2016 17:21:50 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 5 Feb 2016 17:21:50 -0800 (PST)
In-Reply-To: <20160206004615.GB28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285662>

On Fri, Feb 5, 2016 at 4:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -251,18 +235,19 @@ static int parse_config(const char *var, const char *value, void *data)
>>  {
>>       struct parse_config_parameter *me = data;
>>       struct submodule *submodule;
>> -     struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
>> -     int ret = 0;
>> +     int subsection_len, ret = 0;
>> +     const char *subsection, *key;
>>
>> -     /* this also ensures that we only parse submodule entries */
>> -     if (!name_and_item_from_var(var, &name, &item))
>> +     if (parse_config_key(var, "submodule", &subsection,
>> +                          &subsection_len, &key) < 0 || !subsection)
>>               return 0;
>>
>> +     subsection = xmemdupz(subsection, subsection_len);
>
> This appears to be leaked.

Good point, will fix.

Though the impact is negligible, as this code goes away the next
patch and there is a free included.

Thanks,
Stefan

>
> Thanks,
> Jonathan
