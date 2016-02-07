From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Sun, 7 Feb 2016 14:34:13 +0530
Message-ID: <CAOLa=ZS6J-0RLf-qjCvzhpAtvnetCBB6XRRuDswPwRhXz8s3bQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-7-git-send-email-Karthik.188@gmail.com> <CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
 <CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com> <CAPig+cQbf6ek2zdaHh8voBY4DewcwYCW8TsOb2LoDMtDWupDqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 10:04:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSLH0-0002cS-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 10:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbcBGJEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 04:04:46 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35431 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbcBGJEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 04:04:43 -0500
Received: by mail-vk0-f49.google.com with SMTP id e6so79578522vkh.2
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rCw+fkFrVo11W74AQmXbZfh6hFy4ZoMoOlzzUlVAntc=;
        b=qNAsnr04WCFhHOFsTIZdPb9pByFXisaGC2bWGGfefERVY9GVKUmJy60I+0+0Tr0pLN
         ROIkHHyk3DvkSRWiXnoJcqV8l38bsayx14ZcK4FqqusbtUhx74p9Z13LMutz+PEbCXri
         bpwbEK/F7a5xMCGcmhxoPZEbh8TKdewd8BhPah+BQnDxTvvPZxZbHXTuY2JkBIjA2Hze
         jZf4oZGroyDTJ3tbN6VWRZWhZnAeDlr1zXSPLpDJ95XLZ/A1v3hjcUxf5BWa0L4tSzha
         PzSesjdvkGyVnZ+uSYB8ewBSzdr8fXQ1TQiEy9heW6XQF7ksMoU8T+WFkH3bs5wVQaC7
         9ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=rCw+fkFrVo11W74AQmXbZfh6hFy4ZoMoOlzzUlVAntc=;
        b=SXpWulVuNexM/y8oznScEpiduQChS8k8gmmgIQs/Bkd6IKA0TV922UCDH/G4IJxGPb
         HuOiHrRWvDk26afscxzOn0UmYq4eZBfEHvswziocLzbrrKSk8AR46b2eBGLBA1oXvhPj
         QCl5e2F9h16cYAN3CjWCwFP2VMJ9zTwJm3W0QK5iZDliAO83iuG1kDnwgvHLRCZ0Ytvc
         KMycJjWYOtoKGyl8hcsuIREn/GS8ZrPLasZGFIJuiA2/PWtVxuudEe+eelhEy6Ru+WdJ
         HjXBvo2P52TRcQhPTHflQ2yOWWsjG0GsGvrNeNKSoNDYgJ5oBTPc6esLFaNs7Zq43wGW
         eCQA==
X-Gm-Message-State: AG10YOR5zx9iq0F1CnN078WlN2yaSX0zOCwCS5EQABazofIEiH/AYxIyzt4rYT3OUqvjcsbBaHcX+e8Xmq+rPQ==
X-Received: by 10.31.159.136 with SMTP id i130mr15860850vke.144.1454835883212;
 Sun, 07 Feb 2016 01:04:43 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sun, 7 Feb 2016 01:04:13 -0800 (PST)
In-Reply-To: <CAPig+cQbf6ek2zdaHh8voBY4DewcwYCW8TsOb2LoDMtDWupDqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285724>

On Sun, Feb 7, 2016 at 1:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Feb 6, 2016 at 10:20 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Fri, Feb 5, 2016 at 3:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> +static void color_atom_parser(struct used_atom *atom, const char *color_value)
>>>> +{
>>>> +       if (!color_value)
>>>> +               die(_("expected format: %%(color:<color>)"));
>>>> +       if (color_parse(color_value, atom->u.color) < 0)
>>>> +               die(_("invalid color value: %s"), atom->u.color);
>>>
>>> Shouldn't this be:
>>>
>>>     die(_("invalid color value: %s"), color_value);
>>>
>>> ?
>>
>> Oops. You're right, it should.
>> Also the error is reported already in color_parse(...), so seems duplicated.
>>
>> git for-each-ref  --format="%(color:sfadf)%(align:middle,30)%(refname)%(end)"
>> error: invalid color value: sfadf
>> fatal: invalid color value: sfadf
>>
>> What would be an ideal way around this?
>
> According to f6c5a29 (color_parse: do not mention variable name in
> error message, 2014-10-07), the doubled diagnostic messages are
> intentional, so I don't think you need to do anything about it in this
> series. If you want to make the "fatal" message a bit more helpful,
> you could add a %(color:) annotation, like this:
>
>     die(_("unrecognized color: %%(color:%s)"), color_value);
>
> which would give you the slightly more helpful:
>
>     error: invalid color value: sfadf
>     fatal: unrecognized color: %(color:sfadf)

That seems to be a good way around the repetitive message.
will add thanks.

-- 
Regards,
Karthik Nayak
