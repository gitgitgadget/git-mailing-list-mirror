From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Thu, 3 Mar 2016 20:01:47 -0500
Message-ID: <CAPig+cTC-fkJS5Lskww+qRW5XEqFK4f6fBbY6MBqJWKv5UN_ug@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqd1rbiifi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 04 02:01:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abe7s-0008VO-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 02:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207AbcCDBBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 20:01:49 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34896 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbcCDBBs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 20:01:48 -0500
Received: by mail-vk0-f65.google.com with SMTP id e185so2820054vkb.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=wh/Kz3u2YM7XEN2sS+rNgHJQuMlffHnbrK0DOwpMy0I=;
        b=BpW1ak1fL1Bn2NAxJOEZyXoBwz9xoX28ntpP1JejT4znope737NaMPlzkNR2HkDvE7
         AqryjShI4T+wx3oEgOJBr+8rQz1tD1Ho2t8Mrd1Of7iDQ1AJgoAng6+LAO1PI3dYy1kc
         D1VMYO1xtLSIHBR9PhjWnWpZDsA+WVue9RKeT8fkIfql0XdgnOY5kBQEsIsz//sr1/0U
         2i+QtSfye9CIMqAyxWhQwdyZUaGAr5oQBJwfKWFtWK/cSqdYI6m4fCrUS2KY8/oKkme6
         AUO+ZzA9/KridEfmFlhR10QUDh3UCPs2AQtMQ1er6oqbHYkxveqV7uR3uyw+0asZMVp+
         Hrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wh/Kz3u2YM7XEN2sS+rNgHJQuMlffHnbrK0DOwpMy0I=;
        b=XX0kB+wf+DNPbxhYdzEpM7piY+0HRv6fDrD1or8tusN0U04XC7M1tNtUCUJBjUqDXc
         931izjFtz/mnXOrvxmULRr8CNdPEnKmpFSLPZmb9tJZLsRm1/VeXt9Y+1O7/t1KTk+jf
         aFdo/OaDyPrvIbt2erZpN8MocPXmyh6ToceuUsgyC3B0scPZtRTIx+iAEHBIYadWFZ1o
         lpO9zPO4Zvn1S71m2qIiXZtMk0+pujsVJWgry1jV8h/uYYMxJGk2ULlx2sAy8Fl2mg+f
         6Pmgdvu9oWfnPNBJ/zwctvjcclEEdhIRQnKhwkREW6kA31PeQcjeGmXvbFP8tmfm9iL3
         9L+w==
X-Gm-Message-State: AD7BkJIxhAxXQ7RkeCLEwkafABWVJ8AWab0pglFa7PDB7yJQyN8V19c6PqfP1dW3JMjaKY9vOhcDArq5shikQQ==
X-Received: by 10.31.150.76 with SMTP id y73mr4288943vkd.84.1457053307186;
 Thu, 03 Mar 2016 17:01:47 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 3 Mar 2016 17:01:47 -0800 (PST)
In-Reply-To: <vpqd1rbiifi.fsf@anie.imag.fr>
X-Google-Sender-Auth: IFsgV8PglFpsiZOoWITrsYgQnIY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288227>

On Thu, Mar 3, 2016 at 12:24 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>> +     else {
>> +             /* If --[no-]autostash option is called without --rebase */
>> +             if (opt_autostash == 0)
>> +                     die(_("--no-autostash option is only valid with --rebase."));
>> +             else if (opt_autostash == 1)
>
> The else is not needed since the other branch dies.

A couple other minor comments (to be considered or ignored):

The comment "/* If --[no-]autostash ... */" merely repeats what the
code itself already says, thus is not really helpful and can be
dropped.

It would be reasonable to combine the two cases into one:

    if (opt_autostash != -1)
        die(_("--[no]-autostash option is only valid with --rebase."));
