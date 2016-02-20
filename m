From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 03:39:36 -0500
Message-ID: <CAPig+cQK15OoNdG0zyCC0eZJ1XeidD7sOU8BggnNN7k=Zi9zdw@mail.gmail.com>
References: <20160219111941.GA31906@sigill.intra.peff.net>
	<20160219112324.GF9319@sigill.intra.peff.net>
	<CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
	<20160220081010.GA16722@sigill.intra.peff.net>
	<CAPig+cTACku01im72Cd7LxYopwwFaXtKYXkxi53GMrTRyZpFGQ@mail.gmail.com>
	<20160220083426.GA17171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:40:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX35R-0002MS-51
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949129AbcBTIjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:39:37 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33443 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423122AbcBTIjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:39:36 -0500
Received: by mail-vk0-f47.google.com with SMTP id k196so94760957vka.0
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 00:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4bq2FUWxAfgj51ZY2aioT8gJOtT8nNZ9l/6UP2klEaA=;
        b=V79QksTa1vhFiFKIJA71keuPzXljDfMoxUCrsij49jUBaje/Cb7wmWiLCRSAnDB7Xd
         jTiNnbdcQG42lVZcOGcQN6YMUBHiL8hWYaW8PpBdXUQNFry+/DkYQRBMhYXPo0yYRn6O
         c0zccWglsPdzyZoD5SaERvdVFqWK2nA5elWtdYf327WBIfyQTD+PRcX7KJb1HbGSOu1H
         ol2Ee+OkY1iDFdhxsQ/IUc1TDovxeT4Ma2LHGN+5b7Us+LO2Sl14VFeqCs6UlM5mXIfn
         kn19Ms7Q0/RI/uNwcakCt0XulOckqG6MMieTPBmITe3uoe9HXNcZdRt+J7e4ASAiZeNU
         lFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4bq2FUWxAfgj51ZY2aioT8gJOtT8nNZ9l/6UP2klEaA=;
        b=kQ1GSKb6PICj5J7LnGpbcJYfJueN2tSb0sx0quyyVkQbqMGlMrG23rBaocePrUV6eQ
         TIHaUQg8FdSIBXOr+fXAp2yxq1VvM5ye36PlyuBmY+wG9ZMZrswdEZUjqkqzN2yRNg10
         y6/MkeanWwE0ybdNPza6YxmERcqsejMk0Q4zTESoOpoR5W6tNEzvgsPOvVHfzV5cWEhi
         OOlr+01+rznp21ivA/OH27KKDPTeEjGpa849KitljhDF5gmh2Ez1FMxTS7Fw/xJMqOjB
         JGFBmsgNjiBHzO4QvHFm8pmtPTUW+odwQNByY+HDnBLUWNeeUgXiOy+8lqr0QGi0NSHU
         jKsA==
X-Gm-Message-State: AG10YOTY6YyN/diMkVF6fXwM85pq7IEJ6AW+wzB6B6FpGPEVzz4hIXyqeKxYsszQQqSGmrdsFcBwdcfkCOuoGw==
X-Received: by 10.31.150.76 with SMTP id y73mr14618702vkd.84.1455957576062;
 Sat, 20 Feb 2016 00:39:36 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 20 Feb 2016 00:39:36 -0800 (PST)
In-Reply-To: <20160220083426.GA17171@sigill.intra.peff.net>
X-Google-Sender-Auth: CCkzaaXOnSz-Gu8eDz-XjwqQoPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286771>

On Sat, Feb 20, 2016 at 3:34 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 20, 2016 at 03:29:29AM -0500, Eric Sunshine wrote:
>> On Sat, Feb 20, 2016 at 3:10 AM, Jeff King <peff@peff.net> wrote:
>> > On Sat, Feb 20, 2016 at 03:07:00AM -0500, Eric Sunshine wrote:
>> >> > +               /* argv strings are now owned by pathspec */
>> >> > +               paths.argc = 0;
>> >> > +               argv_array_clear(&paths);
>> >>
>> >> This overly intimate knowledge of the internal implementation of
>> >> argv_array_clear() is rather ugly.
>> >
>> > Yep, I agree. Suggestions?
>> > [...]
>> >
>> > I guess we can make an argv_array_detach_strings() function. Or maybe
>> > even just argv_array_detach() would be less gross, and then this
>> > function could manually free the array but not the strings themselves.
>>
>> [...]
>> I wonder if a simple "dup'ing" string_list would be more suitable for
>> this case. You'd have to append the NULL item manually with
>> string_list_append_nodup(), and string_list_clear() would then be the
>> correct way to dispose of the list without intimate knowledge of its
>> implementation and no need for an API extension.
>
> A string_list doesn't just store pointers; it's a struct with a util
> field. So you can't pass it to things expecting a "const char **".

Yep, I knew that but wasn't thinking straight.

> I think argv_array_detach() is the least-bad thing here. It matches
> strbuf_detach() to say "you now own the storage" (as opposed to just
> peeking at argv.argv, which we should do only in a read-only way).

I also had made the strbuf_detach() analogy in my response but deleted
it before sending; I do think it's a reasonable API template to mirror
via new argv_array_detach().
