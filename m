From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:17:34 +0700
Message-ID: <CACsJy8BTj8Vb5dyJJXhAtQ4soUTAAshKATYB+f9X2p1n6VFHMQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com> <CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:18:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3tO-00026h-8c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab3D3GSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 02:18:18 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:36643 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3D3GSG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 02:18:06 -0400
Received: by mail-oa0-f54.google.com with SMTP id l20so148416oag.41
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+ZA8+vPjAR6Ndxnustg2W11tcoJwoi5gEZ1Ld0JrYEg=;
        b=lk5q+ayQ4AhyITGwCuWOAms3T2msZDZMUyXkNop3ORPSlq0es9/UlAQ4HnbvLBQi1W
         RDo9oMU0AbNDDfVd8qK+Tj93Be8qBD5xrlpJ869y+0xEMb52o6l0TkLk7laa5r5bGDI+
         0PBq/xqs24MihYKhPcrr1wb+d5Ye6o72MdWe7oBkgUAIhJrUJIky+VsYeF/BK+Z/8IE3
         afVuvbe95DYfQs4/iynsyHIIKaSDKK34OaGlheteejt6g+YRK2dObz7n/ViPip7VCehF
         z68lUV88HPn3XIAwdoNCNK9B4c/AqN2dN3Z/w9KfG4CxQen7YhqZ36hsc8rAqxrYSXnQ
         bZwQ==
X-Received: by 10.60.65.68 with SMTP id v4mr25818208oes.13.1367302685815; Mon,
 29 Apr 2013 23:18:05 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 29 Apr 2013 23:17:34 -0700 (PDT)
In-Reply-To: <CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222912>

On Tue, Apr 30, 2013 at 1:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 30, 2013 at 12:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>>> use 'git show @~1', and all that goody goodness.
>>
>> I like this. I haven't spent a lot of time on thinking about
>> ambiguation. But I think we're safe there. '@' is not overloaded much
>> like ':', '^' or '~'.
>>
>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>> 'master@'.
>>
>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>> '@' has always been followed by '{'. Can we have the lone '@' candy
>> but reject master@ and HEAD@? There's no actual gain in writing
>> master@ vs master@{0}.
>
> That's what I tried first, but it just didn't feel elegant to have one
> check for this case only. foo@ does follow naturally, and it doesn't
> hurt.
>
>>> +'@'::
>>> +  '@' alone is a shortcut for 'HEAD'
>>> +
>>
>> And this does not explain about HEAD@ or master@. But because I prefer
>> the candy part only. This documentation part looks good :)
>
> Yeah, there's no point in documenting things that are not useful for
> the user. The fact that HEAD@ is translated to HEAD is just an
> implementation detail.

Exactly. As it's implementation detail, it should not be exposed to
user as "huh?" moments when they type "HEAD@". I'm may be paranoid,
but if some user finds it nice (or just different) to try master@ in
scripts, then we change implementation details and master@ no longer
works, people could be upset. Undefined behavior syntax should be kept
to minimum. And to answer your other mail regarding the harmlessness
of @{-1}@, I'd rather pay some extra code than leave some loose ends
like that.
--
Duy
