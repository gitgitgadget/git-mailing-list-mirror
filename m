From: Jacob Keller <jacob.keller-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GNU diff and git diff - difference on myers algorithm?
Date: Thu, 16 Jul 2015 21:22:27 -0700
Message-ID: <CA+P7+xrOPS6NeQhte-ATdm2Nqo0PpmUAxS+XYzWDvZGtwPtWMw@mail.gmail.com>
References: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
 <0add7d95076f5b112af90d8566c29203@www.dscho.org> <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg@mail.gmail.com>
 <CAB=NE6UFMv0qu8fJ1P2-pJCF0tSGKoW+uKhfwt0jV5fj2wZGSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>,
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>,
	"Luis R. Rodriguez" <mcgrof-IBi9RG/b67k@public.gmane.org>,
	"cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org" <cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org>,
	"backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Luis R. Rodriguez" <mcgrof-3uybbJdB1yH774rrrx3eTA@public.gmane.org>
X-From: backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Fri Jul 17 06:22:50 2015
Return-path: <backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glb-backports-wOFGN7rlS/M9smdsby/KFg@public.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>)
	id 1ZFxAg-0001UY-AX
	for glb-backports-wOFGN7rlS/M9smdsby/KFg@public.gmane.org; Fri, 17 Jul 2015 06:22:50 +0200
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1750824AbbGQEWr (ORCPT <rfc822;glb-backports@m.gmane.org>);
	Fri, 17 Jul 2015 00:22:47 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:32794 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbGQEWr (ORCPT
	<rfc822;backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Fri, 17 Jul 2015 00:22:47 -0400
Received: by ietj16 with SMTP id j16so69869428iet.0;
        Thu, 16 Jul 2015 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Is7aiCOVNStYH0lwtAI4SDL7EEPyuwm/75DLnXadlyw=;
        b=Pl4laolhoRLcAtlT21+2kU2g2A9ycup5ZX58uRikDuqgZrnlRgdIKlBDWfXuQkS20R
         8lnEmyKlKcX3wHUQ5b1hUsrgtRD0X9Z4x9XbW06hqUal2wkjRZs3WXBJWHaTqftExgbh
         UnOH5hZWGYWQdW3DTijVRkEHoKNPHt+Z/+CqI6SHHFOQ/utBvcm/NDj62WGGQzap7xy4
         87LJrY8IcpF0jdawPgmSQndDDZ9sl/LQNV26gP+QuTkkSIV3EX+/dTkpgGStzADkQqdE
         lZD31KKrvCi3hB37PsmNKXg+xNJN3Q/bkTcir9v6xgtohejPCT0g7TOf/XO3wZECvDyL
         1CiA==
X-Received: by 10.107.6.231 with SMTP id f100mr7615522ioi.61.1437106966433;
 Thu, 16 Jul 2015 21:22:46 -0700 (PDT)
Received: by 10.107.157.75 with HTTP; Thu, 16 Jul 2015 21:22:27 -0700 (PDT)
In-Reply-To: <CAB=NE6UFMv0qu8fJ1P2-pJCF0tSGKoW+uKhfwt0jV5fj2wZGSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274058>

On Thu, Jul 16, 2015 at 12:07 PM, Luis R. Rodriguez
<mcgrof-3uybbJdB1yH774rrrx3eTA@public.gmane.org> wrote:
> On Fri, Jun 12, 2015 at 11:52 AM, Luis R. Rodriguez
> <mcgrof-3uybbJdB1yH774rrrx3eTA@public.gmane.org> wrote:
>> OK wells I'm curious about more research / effort when trying to
>> evaluate a diff with two seprate but adjoining preprocessor directives
>> and if anyone has implemented an optimizaiton option to let the diff
>> generator join them.
>>
>> For example, to let it infer that:
>>
>> --- a/test.c
>> +++ b/test.c
>> @@ -10,8 +10,6 @@ int main(int argc, char *argv[])
>>
>>  #ifdef FOO
>>         a = 4;
>> -#endif /* FOO */
>> -#ifdef FOO
>>         a = 5;
>>  #endif /* FOO */
>>
>> is possible.
>
> Anyone familiar if any tool exists today that would optimize this? Is
> anyone working on it? Would git be a good place for such a thing? I'd
> consider it as an option to optimize a diff. This for example is
> extremely useful for us working with Coccinelle where we have a tool
> writing code for us, while such an optimization might be useful to
> Coccinelle it would seem like a rather generic feature, its just not
> clear to me where to give such a tool a proper home.
>
>  Luis

I do not understand exactly what would be optimized in this case?

In any regards, that's not a diff transformation, that is a code
transformation, and I would suggest starting with Coccinelle and
seeing if you can get that to do what you want.
http://coccinelle.lip6.fr/

Regards,
Jake
