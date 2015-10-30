From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 4/8] submodule-config: parse_config
Date: Fri, 30 Oct 2015 12:29:11 -0700
Message-ID: <CAGZ79kbPkc_+g1QHxAoN2yYKG-Tft=yR=uJ-NCddRjrc5Wy20A@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-5-git-send-email-sbeller@google.com>
	<CAPig+cRHy5iT940scnKyMNDx8zgXt50ZsFqF0tALVRpueKdo-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:29:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFMS-00078Q-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267AbbJ3T3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:29:13 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33332 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbbJ3T3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:29:12 -0400
Received: by ykft191 with SMTP id t191so86070030ykf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b2xTK8+myNLIDJKJvHSuOilpUTSBw/Tq22e8Tbn5i6U=;
        b=QzvHjleUUMMSrCV2395ETmzrdoSd1K2jS+rHmC4BVic5s+4O3IH+Atl0IBqlYHOsrd
         CwlnBzFIWzRpoQacMPZm3EIpddESmXqH/5K1vTg5XUB8wEdZdbDa08KlB10mJZl7wKvo
         GWvu+h6EIXHXlNOTgqJVgTM37IrYoV99zs2kXrqlMHmR+IPfU5RlgwYBvlJFljuH30ua
         8rJMQn4pPCW70z0S3bh0NX5Nob3lVa5BgHo83P8JXRRNga+8AZL/bkCEEPFlDvuuDJVA
         bs70g6MXvQb2Q+91UO9HkJkZacg1RPoSCc64pDWOQEVJpcTRPwttdxR0FNnbPOPlVVkk
         tOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=b2xTK8+myNLIDJKJvHSuOilpUTSBw/Tq22e8Tbn5i6U=;
        b=j7FLcZTWnjoPmtBP9m5DiOySs4/e4MYrakOzXJ+wR2kqLN9DQCQVb64p+/LNeVVEoT
         YnFXUODS8ljDAE8nBbepQLT8iaUdalXY66FCavirs/5h0K3QCUnqGIqo49hwHLluNmrD
         kHV1ANc/YgyYdj6FFR4KuiiLy5GqUScrI3kJPWOywOBJNPvOKmY6yQ/fkUklMX8OoWZT
         2AkqQ+XmKa59ZuZTU6DoF+rd83/xVXKw4x5gHzwmEOcfYRysoN2mmzSIj49ge6Wemxff
         ZmsfY4tLyJVh5/Pd6oIVVI8yVVFUMF7CRdVhjgahQ+0L4GMpNSZ69eVSWa8yaFYb0g5B
         Bvdg==
X-Gm-Message-State: ALoCoQkhrTUec6HAtIZoXduZqXh8HogWt1Qfh1cszaC4wc39Ez+6WD+C7+YEK06xd1hTSHRkYJ+/
X-Received: by 10.129.29.8 with SMTP id d8mr7724787ywd.63.1446233351268; Fri,
 30 Oct 2015 12:29:11 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 30 Oct 2015 12:29:11 -0700 (PDT)
In-Reply-To: <CAPig+cRHy5iT940scnKyMNDx8zgXt50ZsFqF0tALVRpueKdo-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280529>

On Thu, Oct 29, 2015 at 6:53 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
>> submodule-config: parse_config
>
> Um, what?

submodule-config: Introduce parse_generic_submodule_config

>
>> This rewrites parse_config to distinguish between configs specific to
>> one submodule and configs which apply generically to all submodules.
>> We do not have generic submodule configs yet, but the next patch will
>> introduce "submodule.jobs".
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>> # Conflicts:
>> #       submodule-config.c
>
> Interesting.

fixed

>
> Minor: Are these 'key', 'value', 'var' arguments analogous to the
> like-named arguments of parse_generic_submodule_config()? If so, why
> is the order of arguments different?

Reordered. I thought how they made most sense individually, but consistency
across functions is better.

>
>> +{
>> +       int ret = 0;
>> +       struct submodule *submodule = lookup_or_create_by_name(me->cache,
>> +                                                              me->gitmodules_sha1,
>> +                                                              name);
>>
>>         if (!strcmp(key, "path")) {
>>                 if (!value)
>> @@ -318,6 +314,30 @@ static int parse_config(const char *var, const char *value, void *data)
>>         return ret;
>>  }
>>
>> +static int parse_config(const char *var, const char *value, void *data)
>> +{
>> +       struct parse_config_parameter *me = data;
>> +
>> +       int subsection_len;
>> +       const char *subsection, *key;
>> +       char *name;
>> +
>> +       if (parse_config_key(var, "submodule", &subsection,
>> +                            &subsection_len, &key) < 0)
>> +               return 0;
>> +
>> +       if (!subsection_len)
>> +               return parse_generic_submodule_config(var, key, value);
>> +       else {
>> +               int ret;
>> +               /* subsection is not null terminated */
>> +               name = xmemdupz(subsection, subsection_len);
>> +               ret = parse_specific_submodule_config(me, name, key, value, var);
>> +               free(name);
>> +               return ret;
>> +       }
>> +}
>
> Minor: You could drop the 'else' and outdent its body, thus losing one
> indentation level.

By passing on the subsection, subsection_len, we only have one statement there

     if (!subsection_len)
         return parse_generic_submodule_config(key, var, value, me);
     else
         return parse_specific_submodule_config(subsection,
               subsection_len, key,
                  var, value, me);

will do without dedenting I guess.
