From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 00/13] Port tag.c to use ref-filter.c
Date: Mon, 31 Aug 2015 16:39:00 +0530
Message-ID: <CAOLa=ZQyjfkbqMR6jSujVng-h=ezK0qPqwgJWynaEcvjeO3pSQ@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com> <vpqvbbwhrxp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 13:09:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWMxy-0006Vw-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 13:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbbHaLJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 07:09:31 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36303 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbHaLJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 07:09:30 -0400
Received: by obkg7 with SMTP id g7so87540572obk.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G9sH7F2KjqSlYZgVst4xeWBH/GMwaCv7FhQFOrNBbjk=;
        b=etTfDJ1pL/c3kRox9yv5m2nvJ2BE/oQT+eu2vXVJtbhxdWl/VOIoTSQ8S3D8sfZ8LJ
         FecCXN6te4cRVrLzDbMH7dZff0A3CKgHm2Yft4n8fgxWHuWqYQbz0EeyW0VrBCBEygc+
         dWjaynLLU6/ud8y6uCHCcMBqwAvwlEV6lI+OPOGRuMUBapU1KWZYt+h3C7C/ZndJTbDk
         rlXEUvjH/itD+NNmggEfltHMT1NbW9x+Q5YoEMIWGXPXt16TaI9ouZixzzFSPBwjZRNX
         qYbmIAuoyuS260+PKAcEi9LZQJbmhAE1zmCeDR/D8O+gV7B4P7MVY/uCz5V/+egEbwzW
         9QPQ==
X-Received: by 10.60.50.169 with SMTP id d9mr13994018oeo.9.1441019369531; Mon,
 31 Aug 2015 04:09:29 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 31 Aug 2015 04:09:00 -0700 (PDT)
In-Reply-To: <vpqvbbwhrxp.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276873>

On Mon, Aug 31, 2015 at 12:20 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 06d468e..1b48b95 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -149,6 +149,7 @@ Its first line is `contents:subject`, where subject is the concatenation
>>  of all lines of the commit message up to the first blank line.  The next
>>  line is 'contents:body', where body is all of the lines after the first
>>  blank line.  Finally, the optional GPG signature is `contents:signature`.
>> +The first `N` lines of the object is obtained using `contents:lines=N`.
>
> "Finally" in the last line of the context is no longer accurate.
>

Will remove that.

>> +test_expect_success 'check `%(contents:lines=X)`' '
>> +     cat >expect <<-\EOF &&
>> +     master three
>> +     side four
>> +     odd/spot three
>> +     double-tag Annonated doubly
>> +     four four
>> +     one one
>> +     signed-tag A signed tag message
>> +     three three
>> +     two two
>> +     EOF
>> +     git for-each-ref --format="%(refname:short) %(contents:lines=1)" >actual &&
>> +     test_cmp expect actual
>> +'
>
> Nit: I would find it more readable with an actual separator (anything
> but a space) between %(refname) and %(contents).
>

Will add.

-- 
Regards,
Karthik Nayak
