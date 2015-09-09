From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Wed, 9 Sep 2015 12:18:50 -0700
Message-ID: <CAPc5daWiACH6fVDyszdRBAs0aHg1wUi7wjKfH7VKu=TVK6dBtg@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
 <xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
 <vpqfv2qqq7y.fsf@scolette.imag.fr> <xmqqd1xs93iu.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZS5bM_h7CLJD+Nj1h1qi3FCfjVYX0ZBGCX6PDXt+9XQyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 21:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZkts-0004Cc-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbIITTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 15:19:12 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34297 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbbIITTL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 15:19:11 -0400
Received: by iofb144 with SMTP id b144so34516689iof.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tEhIcVLZE6hKCkLIMG9Ljd1CwdmFNeU2vwvbJciYlJ8=;
        b=ighyq+mx7Qo4LmVF3u70orTwgG9Q+pQmxVlis+7/XdXtWSyI/gWv2YuYMjUOR7gjEY
         2tCZaZQh2yDj13xB05Yxts9cb1CDp/VknMR152wHNMkNuILjA2Dra4qcTC+ZAZT13xIF
         vZlt5RjHtNCSfdVWqVQ7AjU2/lF0ccyg5m/htWlPb0EeSstUKPH1+wpcCjhGzVPfs4KF
         S8rqfJfXKO4Bu2PCubosXf4MQBPHp+90JeZNcVP9d88z75zJ0ehkny7S0pZGvTseT/W4
         kaDHeXkKevwOxED1/MX8umDExadDndq+PHN1rpYLBNE3n2X9gDaAb9PnbRCTyCVVsKpH
         T0fQ==
X-Received: by 10.107.41.211 with SMTP id p202mr37694925iop.132.1441826350367;
 Wed, 09 Sep 2015 12:19:10 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Wed, 9 Sep 2015 12:18:50 -0700 (PDT)
In-Reply-To: <CAOLa=ZS5bM_h7CLJD+Nj1h1qi3FCfjVYX0ZBGCX6PDXt+9XQyw@mail.gmail.com>
X-Google-Sender-Auth: EECwL2cMNSMKY7JAxzO2OjHy3gI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277562>

Ehh, I was only kidding, though...

On Wed, Sep 9, 2015 at 10:37 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Tue, Sep 8, 2015 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>>> This line still looks overlong.  Would it help to stop spelling this
>>>>> as a double "a = b = overlong expression" assignment?
>>>>>
>>>>
>>>> I'm not sure, I get what you mean.
>>>
>>> I guess
>>>
>>> format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>>>                  filter->lines);
>>> to_free = format;
>>>
>>> (still 83 columns + indentation, but that's a bit shorter than your
>>> version).
>>
>> Sure.  This may also be possible
>>
>>         xstrfmt("%s %%(contents:lines=%d)",
>>                 "%(align:15,left)%(refname:short)%(end)", filter->lines);
>>
>> and highlights that the only thing that is variable is the number
>> of lines, which might be better.
>
> Yeah looks better, thanks.
>
> --
> Regards,
> Karthik Nayak
