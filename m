From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Thu, 28 May 2015 14:02:36 -0400
Message-ID: <CAPig+cR_N10=k6QX=udpfWG-qNYkBNXQQNZ-LOrGC=1UqoZcVw@mail.gmail.com>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CAPig+cRb0GstQThkprzBA=VwHSFxUeX6KDdSA7Xjdb_B2mH6Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 20:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy28h-0002C4-1G
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbbE1SCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:02:39 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35477 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbbE1SCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:02:37 -0400
Received: by iesa3 with SMTP id a3so44672105ies.2
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XNUPpYOsGeEvRqsVBN6bDJQNhE3rbq9g7nBlaCUpHvo=;
        b=wuYZRqyMW8wQtlhFOGm6xuka7JHLw7jzLrq7T0JeGeKsFy4OR3Tfz56yHVAgaXkH9e
         2MjRfojdRawS+2aXShT45l8M5kiE4io40K7zqGrCWGVp3Xa0hmzOVszF66s2ab7raFhr
         WJ8WWTjGa9a83tc8jXsuQ5VCOrTKZsU6fji1rVpUIj/gr1fpEdwsl9gID0VYpmtwwr5V
         VbifV+8ickIbTMa9E7ECLymtoZX4ukkQL0q1OMiFVC0WAXhGihOo3uDJZwGrM636vzCS
         vzQrkzpUsatIbtPXIDGxJBFp0nHL+4HbPKOEhhQLagShAghmf/oA6JYzUBnerWZNlADF
         foDg==
X-Received: by 10.42.166.200 with SMTP id p8mr3285415icy.25.1432836156721;
 Thu, 28 May 2015 11:02:36 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 11:02:36 -0700 (PDT)
In-Reply-To: <CAPig+cRb0GstQThkprzBA=VwHSFxUeX6KDdSA7Xjdb_B2mH6Uw@mail.gmail.com>
X-Google-Sender-Auth: -RpkbojySa2UaR8ubI0D1AvsWsU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270173>

On Thu, May 28, 2015 at 11:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 28, 2015 at 6:42 AM, Remi Lespinet
> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>> +       The format supported for email list is the following:
>> +       "Foo <foo@example.com>, bar@example.com".
>> +       Please notice that the email list does not handle commas in
>> +       email names such as "Foo, Bar <foobar@example.com>".
>
> A few issues:
>
> In order for this to format correctly in Asciidoc, the text needs to
> be left-justified (just as was the line which you removed).

s/left-justified/unindented/

> The sentence "The format supported..." seems superfluous. It's merely
> repeating what is already clearly indicated by "--bcc=<address>,...",
> thus it could easily be dropped without harm.
>
> Mention that commas in names are not currently handled is indeed a

s/Mention/Mentioning/

> good idea, however, "please" tends to be an overused and wasted word
> in documentation. More tersely:
>
>     Note: Addresses containing commas ("Foo, Bar" <...>)
>     are not currently supported.
> [...]
>>  sub sanitize_address_list {
>> -       return (map { sanitize_address($_) } @_);
>> +       my @addr_list = split_address_list(@_);
>> +       return (map { sanitize_address($_) } @addr_list);
>>  }
>
> Although, it was convenient from an implementation perspective to plop
> the split_address_list() invocation into sanitize_address_list(), it
> pollutes sanitize_address_list() by making it do something unrelated
> to its purpose.
>
> If you examine places where sanitize_address_list() is called, you will see:
>
>     validate_address_list(sanitize_address_list(@xx))
>
> which clearly shows that sanitation and validation are distinct

Oops: s/sanitation/sanitization/

> operations (and each function does only what its name implies). To
> continue this idea, the splitting of addresses should be performed
> distinctly from the other operations, in this order:
>
>    split -> sanitize -> validate
>
> or:
>
>     validate_address_list(sanitize_address_list(
>         split_address_list(@xx))
>
> That's pretty verbose, so introducing a new function to encapsulates
> that behavior might be reasonable.
