From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 4/6] builtin/verify-tag: replace name argument with sha1
Date: Wed, 6 Apr 2016 02:56:36 -0400
Message-ID: <CAPig+cQ_R+YJVAsDDDPBHRZ=Un=34kum096YeFrGOo3_pU-g3A@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-5-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:56:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anhOO-00020x-5h
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcDFG4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:56:38 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35332 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcDFG4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 02:56:37 -0400
Received: by mail-ig0-f194.google.com with SMTP id ya17so5949026igc.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=qeiNN02Jijg77psI2PT+zQ8IUOnyNl7s7QUd/pV19Rs=;
        b=SCclTAmYtPoROfEulOu45V2B3TfjzUyH2KCBCdqrZRyBqza/W4iiZWka8Nk7rCbOUv
         SpKM8oXkfBvCantILnYg9LqG10cYYEtTbo/ykIrV95I0UmvaF6pVTmgkf8xmHVQ56DuT
         hlzhvWKK2ALwHYGfby5MDY3IDQNRbVNX6YSVOfVYdadnVHaQ3CmoadswrnJX3wHOzibv
         W8lxuHbNIpc1+MjFNfXULDUzFKbxl1VuhmezYrClCHiPnQpWA6aXcfRddrcBmDz4NjGG
         /CR5uCcWR8Nk+Sp2Xrmarym9u2saROkUcyg8ZugMfOcXv4g5GJ4M0mOUhLqe52vkBak+
         L/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qeiNN02Jijg77psI2PT+zQ8IUOnyNl7s7QUd/pV19Rs=;
        b=jNyJVw3XXKTLllRHa1eRa1MFi7iX+kJLgyzm0OuAugCDWzZvpAXnONZAanrAuOp8gq
         0+lhYH7iWcsOruhJBd0Zk8swnpCp0r9B7knXnYSgMrh2CrJqRmXWoklRXGBGPV9rDWvp
         7FCxefb9yAZtCO0W6FreJo+VsEfoO6vOIS6K686XuyqFyjqoB3+fGrI9eFIYYdAGuTCl
         HYrYhZwWO2hGH8s78PrKSMsCIcgIfee+QviGESOtxm2LK/0220wh2YMpbagr4u/QSayd
         7UMUWPbb8oYA6CELenUd8B5ThhsmypupcOoDsB2Fi0Y61UF2EtORBcyhIDJdLikdNql/
         +WuA==
X-Gm-Message-State: AD7BkJLdyHlX2sA84qpfLUFo42f/KGy2dzE+JrIz922DIpbqzLIMUZKxLZ7qtLHw3IhBoYg/3S71k+U9DvaLZw==
X-Received: by 10.50.97.70 with SMTP id dy6mr19103882igb.73.1459925796758;
 Tue, 05 Apr 2016 23:56:36 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Tue, 5 Apr 2016 23:56:36 -0700 (PDT)
In-Reply-To: <1459872449-7537-5-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: _H7ebrNfV6PuTQFNBE-sHXeSnlI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290829>

On Tue, Apr 5, 2016 at 12:07 PM,  <santiago@nyu.edu> wrote:
> builtin/verify-tag: replace name argument with sha1

    builtin/verify-tag: prepare verify_tag() for libification

> This change is meant to prepare verify_tag for libification. Many
> existing modules/commands already do the refname to sha1 resolution, so
> should avoid resolving the refname twice.

If I hadn't already understood the purpose of the patch, I think I'd
still be somewhat clueless after reading this because it doesn't do a
thorough job of explaining what the actual problem is that this is
solving. Perhaps something like this might be better:

    verify_tag() accepts a tag name which it resolves to a SHA1
    before verification, however, the plan is to make this
    functionality public and it is possible that future callers will
    already have a SHA1 in hand. Since it would be wasteful for them
    to supply a tag name only to have it resolved again, change
    verify_tag() to accept a tag SHA1 rather than a name.

> To avoid breaking
> builtin/verify-tag, we move the refname resolution outside of the
> verify_tag() call.

The reasonably intelligent reader should understand implicitly that
this is a natural consequence of changing the signature of
verify_tag(), thus it's not really necessary to state it explicitly.
(It makes the commit message noisier without adding value.)

More below...

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> @@ -42,25 +42,23 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
> -static int verify_tag(const char *name, unsigned flags)
> +static int verify_tag(const unsigned char *sha1, unsigned flags)
>  {
>         enum object_type type;
> -       unsigned char sha1[20];
>         char *buf;
> +       char *hex_sha1;
>         unsigned long size;
>         int ret;
>
> -       if (get_sha1(name, sha1))
> -               return error("tag '%s' not found.", name);
> -
> +       hex_sha1 = sha1_to_hex(sha1);
>         type = sha1_object_info(sha1, NULL);
>         if (type != OBJ_TAG)
>                 return error("%s: cannot verify a non-tag object of type %s.",
> -                               name, typename(type));
> +                               hex_sha1, typename(type));
>
>         buf = read_sha1_file(sha1, &type, &size);
>         if (!buf)
> -               return error("%s: unable to read file.", name);
> +               return error("%s: unable to read file.", hex_sha1);

Nit: sha1_to_hex() gets invoked *always*, even when there is no error.
An alternative would be to call it within each error() invocation,
when it's actually needed.

    return error("%s: unable to read file.", sha1_to_hex(sha1));

> @@ -96,8 +96,15 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> -       while (i < argc)
> -               if (verify_tag(argv[i++], flags))
> +       while (i < argc) {
> +               name = argv[i++];
> +               if (get_sha1(name, sha1)) {
> +                       error("tag '%s' not found.", name);
>                         had_error = 1;
> +                       continue;
> +               }
> +               if (verify_tag(sha1, flags))
> +                       had_error = 1;

An alternative without 'continue':

    if (get_sha1(...)) {
        error("tag ...");
        had_error = 1;
    } else if (verify_tag(...))
        had_error = 1;

I don't feel strongly about it, and it's certainly not worth a re-roll.

> +       }
>         return had_error;
>  }
