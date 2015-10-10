From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: implement %(if), %(then), and
 %(else) atoms
Date: Sat, 10 Oct 2015 22:42:54 +0530
Message-ID: <CAOLa=ZTkknFK8ZPEBkuSK2pP3pPoP8MhQ1AumeUqrg6CYp9VWg@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-2-git-send-email-Karthik.188@gmail.com> <vpqsi5lkw1h.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 10 19:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkxiD-0008Jr-Cy
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 19:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbJJRN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 13:13:29 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36445 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbJJRNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 13:13:24 -0400
Received: by vkgc187 with SMTP id c187so4295105vkg.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OB/MxEM/qBY5uZSlIADNW1fV5Na9MQ8IE4rRnqpDHmw=;
        b=pujh9BMxkjOgNa2zRn5/P/SVJCpD8hQz4f4jboOD4gZqw49Qpq4Q/sH+ZWobFop6Vy
         /RfAD33pwDwuii0AxeBLklkYP1Z5Irvbfw+pr9V2ZnPJ4ROuLEgD8ShLtYNqGD1D0sEJ
         psmMHNQ6ogAtToSiDxIaZkbYd7NMMeuCaRN0HXs7cEBtZU3TDPfKIoLoTWgyIh7D8mN1
         NaZGgtQNL6r7wTl9LgXwwKrpzgRTIJOuJaxxeKgVfo39RkdGNMxx1BKJnAo84ZtGkpwY
         ZEY7URxU9jM/Tn1NU1/IsbUcgW7LJnqtKJF2+UocaLecr35E2fEP7yTQGp4WrWdENzxC
         kZkw==
X-Received: by 10.31.15.69 with SMTP id 66mr12941753vkp.142.1444497203879;
 Sat, 10 Oct 2015 10:13:23 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 10 Oct 2015 10:12:54 -0700 (PDT)
In-Reply-To: <vpqsi5lkw1h.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279326>

On Fri, Oct 9, 2015 at 12:49 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -134,9 +134,17 @@ align::
>>       `<position>` is either left, right or middle, default being
>>       left and `<width>` is the total length of the content with
>>       alignment. If the contents length is more than the width then
>> -     no alignment is performed. If used with '--quote' everything
>> -     in between %(align:...) and %(end) is quoted, but if nested
>> -     then only the topmost level performs quoting.
>> +     no alignment is performed.
>> +
>> +if::
>> +     Used as %(if)..%(then)..(%end) or %(if)..%(then)..%(else)..%(end).
>
> I guess you forgot to replace .. with ... (I think you agreed with me
> that it was better).
>

Oops! I missed this.

>> @@ -69,10 +72,16 @@ struct contents {
>>       struct object_id oid;
>>  };
>>
>> +struct if_then_else {
>> +     unsigned int then_atom : 1,
>> +             else_atom : 1,
>
> Maybe "then_atom_seen" and "else_atom_seen" would be better names. Or
> maybe they'd be too long, I leave it up to you.
>

They do describe the usage in a better way, so why not.

-- 
Regards,
Karthik Nayak
