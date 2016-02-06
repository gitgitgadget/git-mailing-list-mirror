From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Sat, 6 Feb 2016 20:50:49 +0530
Message-ID: <CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-7-git-send-email-Karthik.188@gmail.com> <CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 16:21:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS4gB-0005u5-FN
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 16:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbcBFPVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 10:21:20 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33024 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcBFPVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 10:21:20 -0500
Received: by mail-vk0-f67.google.com with SMTP id c3so1285578vkb.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0ywSl5XSnAKMFA2m+rtg/dYcN8pJNOnVDkPWxef+UC4=;
        b=tEjJxjnMia7ozcnIYBLxROU2c5mWmBmXvz3k0tKA36L1gk2iqpFqlE1e/yXUQFu0vl
         0cj3eKvPJtZYK7Kj90Wunzk9PNUJTMPTqesdGCjgz8AH4LU2xAq4r4451wCmUYAuw5wT
         GdCblhbz5WLyStr78dCYPewxcwa4b96qTO8C44SIPpOgkss/W/3Il00XL2qk+NwWzbpn
         gOXg+9vpHWhyI+zVgSN6X6/+YWv0zf85LEI2P2b5cPVIfgrMDU9bmHTyy54KHke1lEUg
         QcI7qwAy3w3nB1k5/2L0GKcpDDSWFi0JOvBzJAipBsqrf5omNzp1hV21KUPcRtzfqaKe
         RVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0ywSl5XSnAKMFA2m+rtg/dYcN8pJNOnVDkPWxef+UC4=;
        b=XXIUU5w7KvP55qQ5tKCWdbJMudGbqXON3jiwvxRJmi5BIFxVFailW/352Lqz596QW0
         n16taUSxd4xtjD6//8Q45ZYn35w3ZV8vOaeK47tSkZmVaQEGb+4Eg8/NBG7F6X9yr16a
         UU+dPAvLfA7P65URjd2vNUG13XH3RF+HNYQJoBNaMM76RuZvlYhyJfgQoNl0XtussxN0
         Y2C/ba4SgzVxzYF1x+USnxqy5zb9elCqKtq6L/2HsZoFN0+Tq27ycGA+qDY8ifpfDGy1
         NKjTkN56ydwsUAvEG2xFozXJLqs2OJSc8PyAw3xF24Vmrp+JeOhqgLxgkZdozWi8Sn8z
         lOsw==
X-Gm-Message-State: AG10YORgvKFNfpyHxZW37E2ld77sxwZyDOJy4X7BD0jBSCzi892Z1pZ+B8EXM6DIZa341r2VE2rXZL0aShxNcA==
X-Received: by 10.31.159.136 with SMTP id i130mr13582844vke.144.1454772079221;
 Sat, 06 Feb 2016 07:21:19 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 07:20:49 -0800 (PST)
In-Reply-To: <CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285695>

On Fri, Feb 5, 2016 at 3:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce color_atom_parser() which will parse a "color" atom and
>> store its color in the "used_atom" structure for further usage in
>> populate_value().
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -29,10 +29,21 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>  static struct used_atom {
>>         const char *name;
>>         cmp_type type;
>> +       union {
>> +               char color[COLOR_MAXLEN];
>> +       } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>>  static int need_color_reset_at_eol;
>>
>> +static void color_atom_parser(struct used_atom *atom, const char *color_value)
>> +{
>> +       if (!color_value)
>> +               die(_("expected format: %%(color:<color>)"));
>> +       if (color_parse(color_value, atom->u.color) < 0)
>> +               die(_("invalid color value: %s"), atom->u.color);
>
> Shouldn't this be:
>
>     die(_("invalid color value: %s"), color_value);
>
> ?

Oops. You're right, it should.
Also the error is reported already in color_parse(...), so seems duplicated.

e.g.

git for-each-ref  --format="%(color:sfadf)%(align:middle,30)%(refname)%(end)"
error: invalid color value: sfadf
fatal: invalid color value: sfadf

What would be an ideal way around this?

-- 
Regards,
Karthik Nayak
