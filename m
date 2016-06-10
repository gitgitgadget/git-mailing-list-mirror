From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for files_ref_store
Date: Fri, 10 Jun 2016 04:08:42 -0400
Message-ID: <CAPig+cQqnDFQ1=ydQReJimVhL7WrjH9CD1RZ63ddCnNm=YVenA@mail.gmail.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu> <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:08:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHUt-00061b-GI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbcFJIIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:08:47 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36209 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcFJIIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 04:08:43 -0400
Received: by mail-io0-f196.google.com with SMTP id o127so5316220iod.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XXqyE8T9D9osfcN29jaIhWNXTpA0ZLCXqatQtsFUfoY=;
        b=ayThXXPrpyY9OJWJblGxqgkEL3ElwEkt3hBS4XzL6D/9G9FHZ98+L4ARgto5orNv5I
         UmY6GpZ0fsIxrPxrq8HtcuVyprEfU3UAaZLJ7tWopWNqw6cZfCDJ6WK2UllxG3DAKmAk
         82t6fQ/TKdSiop0ukdmiMiMJwTnc/gUyOY9Ja5voJqSipAxdARYDrVdcub7ftcJwYtxA
         bm6gaGt/yrIAGUpzjrEf3BhJP+WV1lXFNMn+fWAgdO0UQoh3jC2Iz0tAgWq5w/nUYoMI
         D1jWwLe8Sb5g7sr8/BXkI97k97jtpTpntnxl+49Snz/2/H3zAZzWiUzp4qA23MTkFjRI
         5/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XXqyE8T9D9osfcN29jaIhWNXTpA0ZLCXqatQtsFUfoY=;
        b=Sdb+yuwh2xC15b5293JWHxqrMNsM+2/CRqDIZSnUJ95kluPwtFRHTOGzV/gIzmVeyW
         GKURXNDVZU9P3ZfX/22I3PmnIMuhp3OTX6lfIWEtHKXOIcX43CG1CATMTSYi2m/SXEkv
         9JcGjKs+02zL5Rp0SaUmgr0ejsx4TD/CdtZInnyad4DUCL6gOtf7Ytpr0sIK4bhWCyU9
         6BP8+M+MvBJ5ZH0Z8pB4lJlFChSajUAfdkKSGt0+25yIx+yy+XWpSjgfPLPvq1VOhto1
         E6CRKmc7Xp+92o+YUVphrOAXisIV+wyGoEGX2gQOBOTYvt/jsi8JsgFUrsZl8G3cW5G5
         0lMg==
X-Gm-Message-State: ALyK8tLIJUQYQo5bQw8HJp7/iMQfPCKi2JRnY9gD4s4vXawzWA4Ccri4kd0tYl3oue/MIyoRxW9A5TEdP9fCEg==
X-Received: by 10.107.47.41 with SMTP id j41mr1805844ioo.168.1465546122551;
 Fri, 10 Jun 2016 01:08:42 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 10 Jun 2016 01:08:42 -0700 (PDT)
In-Reply-To: <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: t-M7WlsHbFtzYz8ZgGIAsWUEK04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296949>

On Fri, Jun 3, 2016 at 5:03 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> We want ref_stores to be polymorphic, so invent a base class of which
> files_ref_store is a derived class. For now there is a one-to-one
> relationship between ref_stores and submodules.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> @@ -973,53 +967,54 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
> +/*
> + * Downcast ref_store to files_ref_store. Die if ref_store is not a
> + * files_ref_store. If submodule_allowed is not true, then also die if
> + * files_ref_store is for a submodule (i.e., not for the main
> + * repository). caller is used in any necessary error messages.
> + */
> +static struct files_ref_store *files_downcast(
> +               struct ref_store *ref_store, int submodule_allowed,
> +               const char *caller)
>  {
>         struct files_ref_store *refs;
>
> +       if (ref_store->be != &refs_be_files)
> +               die("BUG: ref_store is type \"%s\" not \"files\" in %s",
> +                   ref_store->be->name, caller);
>
> +       refs = (struct files_ref_store *)ref_store;
> +
> +       if (!submodule_allowed)
> +               assert_main_repository(ref_store, caller);
> +
> +       return refs;
>  }

Aside from returning the downcasted value, 'refs' doesn't seem to be
used for anything, thus could be dropped and  the downcasted value
returned directly:

    return (struct files_ref_store *)ref_store;

Not worth a re-roll.

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> @@ -521,11 +521,89 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
> +/*
> + * A representation of the reference store for the main repository or
> + * a submodule. The ref_store instances for submodules are kept in a
> + * linked list.
> + */
> +struct ref_store {
> +       /* The backend describing this ref_store's storage scheme: */
> +       const struct ref_storage_be *be;
> +
> +       /*
> +        * The name of the submodule represented by this object, or
> +        * the empty string if it represents the main repository's
> +        * reference store:
> +        */
> +       const char *submodule;

Tangent: Apart from backward compatibility due to all the existing
code which tests *submodule to distinguish between the main repository
and a submodule, is there a technical reason that this ought to store
an empty string rather than (the more idiomatic) NULL to signify the
main repository?
