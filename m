From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: What is an efficient way to get all blobs / trees that have notes attached?
Date: Mon, 4 Apr 2016 09:46:40 +0200
Message-ID: <CAHGBnuNQYrg70h+mjzDpYyKhHiR6tWx9j989KLO3bW-jC7XmZw@mail.gmail.com>
References: <ndljs8$vj3$1@ger.gmane.org>
	<CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 09:46:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amzDj-0006yC-1o
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 09:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbcDDHqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 03:46:42 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36800 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbcDDHql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 03:46:41 -0400
Received: by mail-vk0-f51.google.com with SMTP id c4so44089266vkb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Sy3qRtaanaBbH4QZ7KT93Kxp/URbBU778cgpEHSrm4E=;
        b=KybmFAC4jxQ5i0DYDGNghQzZJ2wk70DFa4/6iFZGiPLklWnpq2jryBiHXxt0f7Nxei
         dd6FjCJmjR/19gz3Tl85Q5FC23AvPG77aRDzvTK3+C4dazI5W/ziKor0edEx/w3tIj6a
         FrwX35iDQJxhqOke6nh32K+5XTbSASHOmCdkmonWVPe7mnpKeX5KFkwkPz6s2EJ5y14W
         ZoFvPd4j1QuTcLiVxZdI8LxR+j0H+Oqp1uZEFtx+L/xFmnIXrnTnJ39sizrJKeRalnvt
         YnJSoWB+WFh1lp1NLVcMm+ebLP4dZYYgMcApTq5d0E52zMo8ZrXmrcgu5Iw04/eiq38K
         VA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Sy3qRtaanaBbH4QZ7KT93Kxp/URbBU778cgpEHSrm4E=;
        b=cHyUUgA7WAgNuFcck5ube66ESMuC74UmxeCFbbPQk/KTmbm17oSfD9z3A7etfbwPei
         GBxizsYdal/rR7APwEbgu5My0BQenUBKOs0UsIVoTKJj24y+exqXDUcWck3CSSW4BhVp
         AwzPJ+6bTKgWumsifkajtj3Rt9AFQW6SbWx10a2N+BHSX5Vqv+vMYi3u+I45mWV/b0Vr
         qgteC2sBkDJO+yGmdB6pp4OxjBPgYo6kwF7dc4ZiqloEsCixOFWGBBqCPPv2a9UX744E
         w6+YdWBpWxz75ouyNjWMyevV7sr7Yo94G2dBW00qaUOrmpYfWRB3T5UvJJlZHausEP5M
         ruOQ==
X-Gm-Message-State: AD7BkJLCnbPnQuNQq0AEHb59xsGgfWqg0UOvpS+DNs1CGl2ZEAen/EUq0vzx1ROa8V3l2jI/fYpNDXclTVovtg==
X-Received: by 10.176.1.197 with SMTP id 63mr5859623ual.77.1459756000451; Mon,
 04 Apr 2016 00:46:40 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Mon, 4 Apr 2016 00:46:40 -0700 (PDT)
In-Reply-To: <CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290681>

On Fri, Apr 1, 2016 at 2:16 PM, Johan Herland <johan@herland.net> wrote:

>> 3) Recursively list all blobs / trees (git-ls-tree) and look whether an
>> object's hash is conatined in our table to get its notes.
>>
>> In particular 3) could be expensive for repos with a lot of files as we're
>> looking at all of them just to see whether they have notes attached.
>
> In (3), why would you need to search through _all_ blobs/trees? Would
> it not be cheaper to simply query the object type of each annotated
> object from (2)? I.e. something like:
>
> for notes_ref in $(git for-each-ref refs/notes | cut -c 49-)
> do
>     echo "--- $notes_ref ---"
>     for annotated_obj in $(git notes --ref=$notes_ref list | cut -c 41-)
>     do
>         type=$(git cat-file -t "$annotated_obj")
>         if test "$type" != "commit"
>         then
>             echo "$annotated_obj: $type"
>         fi
>     done
> done

Thanks for the idea. The problem is that I do want to list the notes
by path of the object they belong to. As a blob could potentially
belong to more than one path (copies of files in the repo), I do not
see another way of getting that information other than iterating over
all blobs and checking what path(s) they belong to.

-- 
Sebastian Schuberth
