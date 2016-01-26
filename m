From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 10/15] ref-filter: introduce parse_align_position()
Date: Tue, 26 Jan 2016 17:04:56 +0530
Message-ID: <CAOLa=ZS8MP_88Ox9YUKsPUC0hDw5YGoHR=JhY4Jx6ip80L=DWg@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-11-git-send-email-Karthik.188@gmail.com> <CAPig+cSUBQiW396qyiczcdPV9qU9o_8imuL89O6jLWLY8sX2-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:35:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO1uF-0000mk-R5
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbcAZLf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 06:35:28 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33967 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674AbcAZLf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:35:26 -0500
Received: by mail-vk0-f41.google.com with SMTP id e185so89663506vkb.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3JIuxMINajyjet3/y/i3Vb2mDPKM8vGwgyRPnlGMk3U=;
        b=Zp5AfE1JJad5KIw+P8aYKiSmh0s8a0IHWTeg9+tZS6fp+PeFTg2jQDZmifeobNgF+M
         HdV0srCW2OjEf26wz9q04pdIL8d9LVVoPIknZ2MaVo8HQ8uPm8nDthB3Uy9oY59RMgNk
         XitV4A1gdPY/UbhS6JeQDMOU3nNJ4Be3oCbLueiKkIWpTN4YTqQU49sblECijqS956Id
         k6Mn3nMY0ieP/czMejariD1CMqbv8IYJ85wpDherpTdwSduoi1r1vWxfEZL2gjrQ6Q62
         KDCFCx1Mc0BmxV+KxdHc4p7OBqupkX8p4HvcskegDBNPJEDCLORmCS/fbWREpalvxeq/
         KzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3JIuxMINajyjet3/y/i3Vb2mDPKM8vGwgyRPnlGMk3U=;
        b=OZgTxs6RQ/CIMcX9Ot/PzMeSgeQw/S4bjEE0AtdMillNRJ8LV+oYl7+RDWddbMiZkY
         joaBKZ15Kd05Oib2mZKaywmLtvfPOXSjVi9+cSf3SSlBWotWU5YPG5HpfqvtqFbJVofW
         lyh0OJ1Fe+tJl0ox98JMqV1N3Jp99IoXV436tXGSl6AJkBWFRJue04G120pCcG5Y0W32
         4e/ULDfA4z+1RO/Ebgwki1oIP7KypHQDU3oe1csxKGJfREJYlVQTQJl8UhN0HKDSrZ1t
         y/Oxay2NR/E+dXxRfI3VKy7Zf0gCfL7fyqQ9tDYZgNde8voUKzc6DGm8fPWc/ZX9uOqc
         bvMg==
X-Gm-Message-State: AG10YORKDr7wSh8Vguz7h/0ZuHzgi+jMqNyhM1dwq4woPzlQsQs1CmCYsYGZLCRQrYlJuanq87+O6QLUNgh7VQ==
X-Received: by 10.31.155.131 with SMTP id d125mr6231863vke.146.1453808126178;
 Tue, 26 Jan 2016 03:35:26 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 26 Jan 2016 03:34:56 -0800 (PST)
In-Reply-To: <CAPig+cSUBQiW396qyiczcdPV9qU9o_8imuL89O6jLWLY8sX2-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284802>

On Tue, Jan 26, 2016 at 3:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 5, 2016 at 3:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From align_atom_parser() form parse_align_position() which given a
>> string would give us the alignment position. This is a preparatory
>> patch as to introduce prefixes for the %(align) atom and avoid
>> redundancy in the code.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -74,6 +74,17 @@ static void color_atom_parser(struct used_atom *atom)
>> +static align_type parse_align_position(const char *s)
>> +{
>> +       if (!strcmp(s, "right"))
>> +               return ALIGN_RIGHT;
>> +       else if (!strcmp(s, "middle"))
>> +               return ALIGN_MIDDLE;
>> +       else if (!strcmp(s, "left"))
>> +               return ALIGN_LEFT;
>> +       return -1;
>> +}
>
> This code was just moved in patch 9/15 and is being relocated again
> here in patch 10/15. If you change the order of the patches so that
> this preparatory refactoring is done first, the diff of the "introduce
> align_atom_parser()" patch will become smaller and be a bit easier to
> review. (Plus it just makes sense to do preparation first.)
>

It does reduce the diff as you said, I have swapped the order as you suggested.

-- 
Regards,
Karthik Nayak
