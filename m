From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 0/8] port the filtering part of branch.c to use
 ref-filter APIs
Date: Mon, 21 Sep 2015 11:41:19 +0530
Message-ID: <CAOLa=ZSyMV04wjhdM11RK9z8fz5tHM4PzPBxrN8_VA_Cacw82g@mail.gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com> <vpqwpvkgblz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 08:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZduKP-0001nl-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 08:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbbIUGLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 02:11:50 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34088 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030AbbIUGLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 02:11:49 -0400
Received: by vkhf67 with SMTP id f67so58815379vkh.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=R4eME5m8FZoSsloztY1H69KiOcItzJp8cOXdhSZMWr8=;
        b=BOkE3y/D9rRcCLSnThirycEcyUOBkziihKET5ZWs/iQx9E30EiTmIRUVuO4j+ekp/E
         p0CfBfCGi9IzkHnTsYOBFUO0H52Jio92+pl7XA6RkMwejC1zag/9nPqRqjgLTx59PzRM
         K53A2s8U+yc+1uKMQfAQ1+GdNvOhhZDKQbNR+wrKhdpaFJvsfIVYVJB9cJT0XN5a8bEC
         ty+z6I5j7U88J34euDg1EVk/bHc/EbQjj7HB3VsKz+E4aAM8PnfSulvnXa32Z+YZcGn8
         ERu+n/Vqhlf6VHLUMwFH3tBdMdG2LvU1xAjdbKBJ4KciLPEhwOzuyVNL0EBx2iafAnV8
         0UCw==
X-Received: by 10.31.15.69 with SMTP id 66mr1957705vkp.142.1442815909020; Sun,
 20 Sep 2015 23:11:49 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 20 Sep 2015 23:11:19 -0700 (PDT)
In-Reply-To: <vpqwpvkgblz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278277>

On Mon, Sep 21, 2015 at 12:30 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/t/t3203-branch-output.sh
>> +++ b/t/t3203-branch-output.sh
>> @@ -145,8 +145,8 @@ EOF
>>
>>  test_expect_success 'git branch `--sort` option' '
>>       cat >expect <<-\EOF &&
>> -     * (HEAD detached from fromtag)
>>         branch-two
>> +     * (HEAD detached from fromtag)
>>         branch-one
>>         master
>>       EOF
>
> I thought this was obviously wrong, but this tests uses
> --sort=objectsize, so it's OK. Indeed, HEAD and branch-one have
> objectsize=215, and branch-two has objectsize=167.
>
> So, the previous code was hardcoding "detached HEAD always comes first",
> but we now sort the whole list, including detached HEAD, so branch-two
> comes first.
>

Yeah! Even Junio said this was better, and even I think this is what
the user would
expect.

-- 
Regards,
Karthik Nayak
