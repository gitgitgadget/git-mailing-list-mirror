From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Tue, 31 May 2016 19:12:50 -0400
Message-ID: <CAPig+cQte++ngtXdQmpjei9sr+KPKi7qs+vHgijU+Gj1eHDUXQ@mail.gmail.com>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
	<89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
	<CAPig+cSjzZGUjdgkz1y7brGNb1M2gHfW0UG-wgBc00beNDQmnA@mail.gmail.com>
	<574D4448.5020004@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:12:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sqF-0003Iu-Te
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbcEaXMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:12:52 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38191 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcEaXMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:12:51 -0400
Received: by mail-it0-f46.google.com with SMTP id i127so5585200ita.1
        for <git@vger.kernel.org>; Tue, 31 May 2016 16:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Wzr1rRK9FfqEGDorlqjH+ZSi2/M1M+rjBLhRFcuT4AI=;
        b=QbqbzMZ9RjT8hz4R8mUQdLPkvcWip1toNv2f+4lKlRyKexE0UysVxolUfBYho/6PoP
         q1oJRsytfT/xhR3SE1yLN0bZmrDjrMUkgEgE0JU5n1921iQSuZoytS485ri9GLMSt0IK
         dnvtn4uG00VDIcB5go/wVk9j+YhBZEfpMnVTpHKznodBu7I5XGtuNVg0kxFlFQBb3Y2B
         sd60+t5xo9HpuBcEUKeyVJ35u49mWc7sNbVF6XYWtKuZQLk2WpjP7PhwJ1u/R+0vDWE5
         J1MOaPLx7jlKYa6i05mJiP7N+yki97aMjvmOsj9MAPS1ydmWr3oGmbxI1qty+/qQ1hXr
         vi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Wzr1rRK9FfqEGDorlqjH+ZSi2/M1M+rjBLhRFcuT4AI=;
        b=D0KyZZlg9UBr7hYv/vBE1jw0yU4YVic7BxiajOSSH7yrNvOyovhfMF3MeFX1lxDeB0
         i7yXSQijWvq8WqDQey9XlTx2MViXNM9AAyMjc2mpu15iEg5waQgWw4tX7KIkILZ1JXy5
         fB041kiq3mz8PVsGk5qwN5Amec3dWs+JM842pDnDdCagkwyZr7LZGXokSeyhFVVrtGC9
         k3mtBM+Y2uqd03DhUlH8u3ScGztUP4OuOZI5FrS5tTD8AYcAFIz7+rNia1/qhvUHGvlr
         uADvt9Uehn08fBnjvHfY34SYMNc29ZkUfB+qKcYRC0PoBB8toBtNzYm28qSmhr15GXDE
         cunA==
X-Gm-Message-State: ALyK8tJC1DyzhGEhhSHIyIw44BCm3LqLiicu9hury/OIqN9zfieL81oZjZz/o2TtIyNxTC1tfPN6OaDR2b44Kw==
X-Received: by 10.36.69.33 with SMTP id y33mr15945642ita.84.1464736370071;
 Tue, 31 May 2016 16:12:50 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 16:12:50 -0700 (PDT)
In-Reply-To: <574D4448.5020004@alum.mit.edu>
X-Google-Sender-Auth: 373ATakiFOuJlbDu0wV91wYtjYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296034>

On Tue, May 31, 2016 at 3:59 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/31/2016 07:29 AM, Eric Sunshine wrote:
>> On Mon, May 30, 2016 at 3:55 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> +struct ref_iterator *empty_ref_iterator_begin(void);
>>> +
>>> +/*
>>> + * Return true iff ref_iterator is an empty_ref_iterator.
>>> + */
>>> +int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
>>
>> I can see that you used this function as an optimization or
>> convenience in overlay_ref_iterator_begin(), but do you expect it to
>> be generally useful otherwise? Is it worth publishing? Do you have
>> other use-cases in mind?
>
> It is only "published" within the refs module, in refs/refs-internal.h.
> This header file is not meant to be used by code outside of the refs module.

Ah, I forgot about that. In that case, it's probably less of an issue.

> My thinking was that it might be useful to other reference backends. The
> function is pretty safe for anybody to call, though I admit that it is
> not very general.
>
> I don't have a strong feeling either way. If nobody else chimes in, I'll
> remove it from the header file as you suggested. We can always add it
> back if somebody needs it.

I don't feel strongly about it either.

>> Also, can you explain why the merge iterator doesn't also perform the
>> optimization/convenience of checking if one iterator is an empty
>> iterator?
>
> That's because the merge iterator doesn't know what its select function
> will do. For example, you could imagine an "intersect" select function
> that only lets through references that were in *both* sub-iterators. In
> that case, your suggested "optimization" would be incorrect.

Makes sense. Thanks for explaining. I wonder if this deserves a
comment somewhere in code or commit message to make the situation
clear to a future developer who might think it a good idea to promote
the "optimization" to the merge iterator.

>>> +/*
>>> + * An iterator consisting of the union of the entries from iter0 and
>>> + * iter1. If there are entries common to the two sub-iterators, use
>>> + * the one from iter1. Each iterator must iterate over its entries in
>>> + * strcmp() order by refname for this to work.
>>> + *
>>> + * The new iterator takes ownership of its arguments and frees them
>>> + * when the iteration is over. As a convenience to callers, if iter0
>>> + * or iter1 is_empty_ref_iterator(), then abort that one immediately
>>> + * and return the other iterator directly, without wrapping it.
>>> + */
>>> +struct ref_iterator *overlay_ref_iterator_begin(struct ref_iterator *iter0,
>>> +                                               struct ref_iterator *iter1);
>>
>> When reading about the overlay iterator (both code and documentation),
>> my expectation was that iter0 would shadow iter1, not the other way
>> around as implemented here. Of course, that's entirely subjective, but
>> the generic names don't provide any useful clues as to which shadows
>> which. Perhaps giving them more meaningful names would help.
>
> That's a good idea. I also found myself having to refer back to the
> documentation to remind myself which was which.
>
> How about I rename them "back" and "front"? I will also reverse the
> order of the arguments.

I had a hard time coming up with better names, which is why I didn't
suggest any in my review. The best I had was "shadower" and
"shadowee", but they are far too similar (and long) for my tastes.
"back" and "front" feel a bit off, but are better than anything I
thought of.

As for the argument order, I can't explain why my expectation was that
it would be the other way around, so I certainly don't insist that
they be swapped.

> (But I will leave the names "iter0" and "iter1" in merge_ref_iterator,
> and also the constants like ITER_SELECT_0, because these don't
> necessarily have the interpretation of "back" and "front".)

Yes, those names are fine in the merge iterator.

>>> +/*
>>> + * Wrap iter0, only letting through the references whose names start
>>> + * with prefix. If trim is set, set iter->refname to the name of the
>>> + * reference with that many characters trimmed off the front;
>>> + * otherwise set it to the full refname. The new iterator takes over
>>> + * ownership of iter0 and frees it when iteration is over. It makes
>>> + * its own copy of prefix.
>>> + *
>>> + * As an convenience to callers, if prefix is the empty string and
>>> + * trim is zero, this function returns iter0 directly, without
>>> + * wrapping it.
>>> + */
>>> +struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
>>> +                                              const char *prefix,
>>> +                                              int trim);
>>
>> Minor: Similarly, when reading the code and documentation, I wondered
>> why this was named 'iter0' when no 'iter1' was in sight. Perhaps name
>> it simply 'iter'.
>
> I found that it got a little bit confusing, because the constructor and
> method implementations all use `iter` as a local variable. In particular
> in the constructor there would want to be an argument "iter" and also
> the local variable "iter" for the iterator being constructed, so a new
> name would otherwise have to be invented for one or the other. Between
> all the "iter" and "iter" and "iter->iter", I found that naming the
> sub-iterator "iter0" made things a little bit less bewildering.
>
> If you don't like that, we could name the embedded iterators something
> like "subiter", "subiter0", and "subiter1". But the current convention
> is a bit more succinct so I slightly prefer it.

I'd probably have called the sub-iterator "child" (which is the same
length as "iter0") or "wrapped". If you're not interested changing the
name in the code, perhaps in the header alone you could call it simply
"iter" or omit the name altogether, but this a very minor issue and
probably not worth much time or effort to address.
