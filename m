From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Sat, 6 Feb 2016 16:51:30 +0100
Message-ID: <CAP8UFD0BMNYiL-N=eTwXvyMX4_exwURzufesW_xYktZoVPaoGA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-7-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
	<CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 16:51:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS59F-000667-ND
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcBFPve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 10:51:34 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34774 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbcBFPvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 10:51:31 -0500
Received: by mail-lb0-f181.google.com with SMTP id cw1so64063204lbb.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1dCp9auQ7vX9oDp4eWIJva/fzoPNNKdlFhEKsIy5Av0=;
        b=lqmRnO6FOjtdqSdXn/dHyiEn48B5A+VVJe28M7n8VkgyXdZn6tu3tdRhLCaLB51DNN
         6tXhq/Beyf3GrOdiUUmKyQ82Of6kvffN6MxlxL2y9N6FafLRuU0OiSAftQIzTft89ILE
         s2nOPg2f0tg2e+n9+ghOjf5Rj6335BoXoY1hYARMjQRLIlUl3nxv4jBccUogV8WO3Jwm
         kq4qE5172Uqr8YtfC76pfr9wLe4pezvXSn7acKuxM57ysfLuElWED54s3NBeX9/EKb0p
         iiPgEbfShLz4BYWmePMq4O3/6jGKjhpVBVyBKqq6narEBvxfG37MFD+A4bK5Vbt661uJ
         9XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1dCp9auQ7vX9oDp4eWIJva/fzoPNNKdlFhEKsIy5Av0=;
        b=MgsDjIiH6wear9a8GupbAEJORIKlmHtVPQNpZZLgnDLjSjMbMfO3P13TiYNTTxqQXm
         AHLhMFJMeXMcvFrs5gyF8PQTAUBwHxZoYCJE9seUJq1X93pNmLhuJXe2VReJlRXup9bV
         mxJc3oKcx+xMETlCrZgP1fCax1Cds0rAYFf5xxmJqWwnMluy+Glp/f7Qq7aFSlupA9n5
         ml39LjMbkV5H/8tGoIequnRfuUyJGN31hTrKxuwmhZBT7E2J16xpgpQbIZqzNaCKjUQ1
         pyU1mO4WSFdblmmq3XhecMxC4C7OBOQNiHAtFZNFs5sLzQPVHaY+aCzGm1v6cSUYMfJ4
         Gytw==
X-Gm-Message-State: AG10YOTESfFFEKVEIL6bQgNb9wn7TUaplNiioXyWWhDRmx4c3TndGA+zdg6Q5mNczsv2n5DPCwpesbFMwBsN/g==
X-Received: by 10.112.198.231 with SMTP id jf7mr7981386lbc.16.1454773890101;
 Sat, 06 Feb 2016 07:51:30 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Sat, 6 Feb 2016 07:51:30 -0800 (PST)
In-Reply-To: <CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285697>

On Sat, Feb 6, 2016 at 4:20 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Feb 5, 2016 at 3:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Introduce color_atom_parser() which will parse a "color" atom and
>>> store its color in the "used_atom" structure for further usage in
>>> populate_value().
>>>
>>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>>> ---
>>> diff --git a/ref-filter.c b/ref-filter.c
>>> @@ -29,10 +29,21 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>>  static struct used_atom {
>>>         const char *name;
>>>         cmp_type type;
>>> +       union {
>>> +               char color[COLOR_MAXLEN];
>>> +       } u;
>>>  } *used_atom;
>>>  static int used_atom_cnt, need_tagged, need_symref;
>>>  static int need_color_reset_at_eol;
>>>
>>> +static void color_atom_parser(struct used_atom *atom, const char *color_value)
>>> +{
>>> +       if (!color_value)
>>> +               die(_("expected format: %%(color:<color>)"));
>>> +       if (color_parse(color_value, atom->u.color) < 0)
>>> +               die(_("invalid color value: %s"), atom->u.color);
>>
>> Shouldn't this be:
>>
>>     die(_("invalid color value: %s"), color_value);
>>
>> ?
>
> Oops. You're right, it should.
> Also the error is reported already in color_parse(...), so seems duplicated.
>
> e.g.
>
> git for-each-ref  --format="%(color:sfadf)%(align:middle,30)%(refname)%(end)"
> error: invalid color value: sfadf
> fatal: invalid color value: sfadf
>
> What would be an ideal way around this?

Maybe it has already been discussed a lot and I missed the discussion,
but if possible the argument, the parameter or the atom itself might
just be ignored with a warning instead of dying when an atom argument,
format or parameter is not recognized, because in the next Git
versions we might want to add new arguments, formats and parameter and
it would be sad if old versions of Git die when those new things are
passed to them.
