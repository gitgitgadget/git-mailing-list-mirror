From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Sun, 7 Feb 2016 02:43:06 -0500
Message-ID: <CAPig+cQbf6ek2zdaHh8voBY4DewcwYCW8TsOb2LoDMtDWupDqw@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-7-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
	<CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 08:43:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSK01-00026B-LE
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 08:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcBGHnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 02:43:09 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35994 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbcBGHnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 02:43:07 -0500
Received: by mail-vk0-f66.google.com with SMTP id k196so733407vka.3
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 23:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IvyzZi1faEr7gaG+4oSeriVWTJsedMSWzz93FO441nA=;
        b=DElrKfVPqKq+4J6m7lQ3oc/KOYrej1MDlRQngzaUU+jWRt5Em2FVLpzYnaaiiy8H8F
         PgWZKenwikb2K/o7izIzEWmkutKM5wC4jxtVrqjcE/KXuGKpcM7Mz8wt9Sr+Y5dcawbW
         Wv8m3VVlS+nwnd6XRjN34KktRcNlk+CC0nuahBcexieDNQAKKDKwqDuMnRMtxfYfBNtz
         fWaIBmSjC3f8phgzLtlXdiruiy0GFHYNVjgFmNQrRPLEc/Y7lrpoC4rNIa5oVvQDnbqY
         EhkCxUX7vrMcHUpS753893Jd2qjdRfOzO/5IG4m3PXmflnlmSDTzo7Mc9tadG14aW7wP
         EAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IvyzZi1faEr7gaG+4oSeriVWTJsedMSWzz93FO441nA=;
        b=UEieCb3okTAaRDUPzo6LWENKmPdjrqBZhYKAAApShKGPgvQph/MlIMlo8EKgGRAfWe
         5UYC5Jy+SRqlzWaB5euzcMkCEwOJ2nHtt9rHaZCL2QfaCKDT8XZaj4dZXkcIHHhB+jGV
         K5rxHPgwvPHVkVtV2mXdQJkHY2AWny7Bhr8joUVLwcbDCsXDuJqG9cA/1r0f60Yq8+Ww
         AIIl+LIhzKQhLjqm4/MYYEEpv5DrkzXQrIPHz3iYWh3zRlokolnt05b3nmeZeKnXt7nT
         O1pQw9RRaSh67Ium/cNLc1rtVG0GYwC1se+/s04n0wBTKnd1TKXjSCEy8GMxwnz+HD+M
         6ckA==
X-Gm-Message-State: AG10YORrtC/u930wPVk3hlm5QqqP90kHOrgs7uwkmHswP2S+hf/uvJcTxI7ZQf7ndYd6ZTqy+sl5/y6QMeqWzg==
X-Received: by 10.31.41.14 with SMTP id p14mr15424866vkp.151.1454830986588;
 Sat, 06 Feb 2016 23:43:06 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 6 Feb 2016 23:43:06 -0800 (PST)
In-Reply-To: <CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com>
X-Google-Sender-Auth: ixY0A1JxOFK6zlHr7s_HdzFeAYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285715>

On Sat, Feb 6, 2016 at 10:20 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Feb 5, 2016 at 3:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
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
> git for-each-ref  --format="%(color:sfadf)%(align:middle,30)%(refname)%(end)"
> error: invalid color value: sfadf
> fatal: invalid color value: sfadf
>
> What would be an ideal way around this?

According to f6c5a29 (color_parse: do not mention variable name in
error message, 2014-10-07), the doubled diagnostic messages are
intentional, so I don't think you need to do anything about it in this
series. If you want to make the "fatal" message a bit more helpful,
you could add a %(color:) annotation, like this:

    die(_("unrecognized color: %%(color:%s)"), color_value);

which would give you the slightly more helpful:

    error: invalid color value: sfadf
    fatal: unrecognized color: %(color:sfadf)
