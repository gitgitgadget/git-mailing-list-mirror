From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 1/4] contrib: add git-contacts helper
Date: Tue, 2 Jul 2013 15:04:17 -0400
Message-ID: <CAPig+cSt2+xjRo36veWSAJbAJ+q5XKSox7Gr=1892znFz5Tgcw@mail.gmail.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-2-git-send-email-sunshine@sunshineco.com>
	<7vbo6mgm5e.fsf@alter.siamese.dyndns.org>
	<CAPig+cRbBGqrXj-Anib1ESdBBbdUGM-9um4XoPcwG2QxJBubuA@mail.gmail.com>
	<7vk3l895in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 21:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5sF-0002iB-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab3GBTET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 15:04:19 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:57605 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3GBTET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:04:19 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so5975615lab.18
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=W1Tuyd8KFOUvdrd4hH0JGwzwzHZRcXbxtBQ/99jUmtI=;
        b=juxM7gZIxj5eESYnrQVetQq9PoLQGsDoWKqvku+HaeZFlrz7v/YpsrjkYV0veJTR98
         CR/jmceCFDP+NHH/XTAAsljTqBSJukapVw2VHzr4NaN5AbxAct+mF33N2ITHmOU4MCNP
         3bqE2AOz0k26qmVPCob5+cvXlIgS/dYjrzGn1GGxrZPb93VscUNI9F1R+3P6BgBmtcV6
         ir0S3GKvwgSmljq+/eUx8Se5r8dMXBfKuZPZcYJUlD1qg7B6DutNr/GOVAJjC7+ZNety
         +VnywQxAdg7C3Du+fnb6dQ2ACIhwqrDyE0UlZTEZJSRn5o8mUIbGW9mEHb/UIBEVCJZK
         HmLA==
X-Received: by 10.152.43.82 with SMTP id u18mr14664259lal.86.1372791857726;
 Tue, 02 Jul 2013 12:04:17 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 2 Jul 2013 12:04:17 -0700 (PDT)
In-Reply-To: <7vk3l895in.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 571T3VFAYlexrc0hUdyvGGBHsKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229418>

On Tue, Jul 2, 2013 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> The author name and email can be grabbed from the "blame" output
>>> without doing this (and the result may be more robust), but you
>>> would need to read from the log message anyway, so I think this is
>>> OK.
>>>
>>> Note that the names and emails in blame output are sanitized via the
>>> mailmap mechanism, but "cat-file commit" will certainly not be.
>>
>> Thanks for pointing this out. Grabbing the author name and email from
>> git-blame output does seem like a better approach.
>
> Well, that was not what I was suggesting.  Reading from blame output
> will map only the author/committer names/addresses, and you have two
> choices:
>
>  (1) if you read author/committer from blame output and other names
>      from the commit object without applying mailmap, the same
>      person can appear under different names, from his authorship
>      (mapped name) and from his name on footers (unmapped), which
>      would be inconsistent.  By reading from "author" and
>      "committer" header lines in the commit object, you will be at
>      least consistently using unmapped names.
>
>  (2) if you want to apply mailmap to names you collect by reading
>      the footer, you will write the mapping logic yourself anyway,
>      and at that point, passing the names you collect by reading the
>      "author" and "committer" header lines in the commit object to
>      the same logic will give you mapped names. At that point, you
>      do not gain much by reading names from the blame output.
>
> So in either case, you would be better off not reading the
> author/committer from blame output, as long as you need to pick up
> other names from the commit object payload.

Thanks for the clarification.
