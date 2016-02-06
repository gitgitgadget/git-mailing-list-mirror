From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 08/12] ref-filter: introduce align_atom_parser()
Date: Sat, 6 Feb 2016 20:56:35 +0530
Message-ID: <CAOLa=ZRGFFE0QZXM8gsFCO7iGShq491DX_bnKj+nXg8Eq4WtgQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-9-git-send-email-Karthik.188@gmail.com> <CAPig+cQXK6xENN864XuxYFQEKtw59FAO7qh=wEGv4maomKpCzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 16:27:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS4lU-00050R-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 16:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbcBFP1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 10:27:07 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33843 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcBFP1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 10:27:05 -0500
Received: by mail-vk0-f67.google.com with SMTP id e6so3341848vkh.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 07:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b0Xpx9lv5eimNXAaS0zPi2Fhc8K/JuCcfL5Cv0Do9aY=;
        b=vQlHNnY+T6fl4Gzg5VpVr5NK6N4c1MqcWb7aSwBp1H2obPYdAiYG7LUyibWyn1QKWR
         GaeKQyrUvnsvzuMBzvGdUy5kJf0JidU7VmHZEBb1jWaEMzT3C6dDNQG+Z28YyXkcDdfB
         nlT3ZSTUrBZAaZAkzF9DydpHv+z+R2Xpci6F0N6gk7kRBZx/kiFrK73bywxh/pLrt5nB
         rg4jGEUlWzBn7LOjOnF2ntaXQUO5WMmbZn4t1gALfKMBSLexlegO0MedzivIaI8F52U1
         8wyDBsghZclt30e1v+Ke4Dof5k2eEAhHZTUVFi+I3L6JP9uNiVQUJ6ntfD5YLl+wOTpu
         eheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=b0Xpx9lv5eimNXAaS0zPi2Fhc8K/JuCcfL5Cv0Do9aY=;
        b=dgk5c+KwIb3iEyRYMCk5Zcu9iGcHKw4vORVZeIucRkslW1Qjd/PbSrohdjaYnREkLa
         iJ/LPWHDEBExOJp+UQJQLDONFLkZWF9gfmGwtWUlhaY2MgrnqM9MJEn2MkPyqZFfrcD5
         aCWr9HMfoqPeESS7qtil+ug40PrwXmNuS9Nususf1xHwn1UPGOske2G8w6CP5IDgT5+h
         1DPXpgZj3kuMSoY2wyhu7+PVdm2beMY6kb9KArtxoWjVFDPpiu8d5ExOLMCHVJmR1buf
         BllfQqXbNz4UdghN1dTJ4zKM8rUfMw5aezoS4UZlV+lGLLzSgHnwG+uUug/90Mw9Dc0u
         KOfw==
X-Gm-Message-State: AG10YOQmgJVpe+YHTHHzpwjWItu2uwP6K3wEzXygWzDF16TN0lGSozxZpjDLJ4wGnayOTFdkPSNXSWgjLZf2Qg==
X-Received: by 10.31.16.218 with SMTP id 87mr12567510vkq.106.1454772424741;
 Sat, 06 Feb 2016 07:27:04 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 07:26:35 -0800 (PST)
In-Reply-To: <CAPig+cQXK6xENN864XuxYFQEKtw59FAO7qh=wEGv4maomKpCzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285696>

On Fri, Feb 5, 2016 at 5:18 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce align_atom_parser() which will parse an 'align' atom and
>> store the required alignment position and width in the 'used_atom'
>> structure for further usage in populate_value().
>>
>> Since this patch removes the last usage of match_atom_name(), remove
>> the function from ref-filter.c.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -55,6 +61,37 @@ static align_type parse_align_position(const char *s)
>> +static void align_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +       struct align *align = &atom->u.align;
>> +       struct strbuf **s, **to_free;
>> +       unsigned int width = ~0U;
>> +
>> +       if (!arg)
>> +               die(_("expected format: %%(align:<width>,<position>)"));
>> +       s = to_free = strbuf_split_str_omit_term(arg, ',', 0);
>> +
>> +       align->position = ALIGN_LEFT;
>> +
>> +       while (*s) {
>> +               int position;
>> +               arg = s[0]->buf;
>
> It's confusing to see 'arg' being re-used here for a different
> purpose, and leads the reader to wonder if this is done because the
> s[0]->buf might be needed outside the loop (when, in fact, it isn't).
> It would be better to declare a new variable here in the scope of the
> 'while' loop to hold this value.
>
> (I might have named the result of the strbuf split 'tokens' or even
> short-and-sweet 'v' -- for vector -- and then used 's' for the name of
> the new variable here in the 'while' loop, but these name suggestions
> aren't particularly important; it is important to declare a new
> variable here -- whatever you name it -- rather than re-using 'arg'.)
>

You're right, that is indeed confusing, I should stop reusing variables
and trying to micromanage.

I also like the naming scheme you suggested, so will stick to that.
Thanks.

-- 
Regards,
Karthik Nayak
