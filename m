From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v4 6/6] tag.c: Change gpg_verify_tag argument to sha1
Date: Mon, 4 Apr 2016 22:10:29 -0400
Message-ID: <20160405021028.GE12006@LykOS>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
 <1459808535-8895-7-git-send-email-santiago@nyu.edu>
 <CAPig+cQ4i86JpLFe0tqA-tjFj6Y3DvxDz3nFL8XAMVDBLwLUPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:27:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anGhy-0005jJ-9c
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 04:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbcDECLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 22:11:34 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33646 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbcDECLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 22:11:33 -0400
Received: by mail-qg0-f52.google.com with SMTP id j35so30700qge.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z3Id0qEovP9qgzLZw49jjaRzmQZFYVlBpyPR9+a8Iuc=;
        b=EeYDwm0/c+WgFUQYjXxW7ogabQKs/HXgnVz30Rj3+4Khpk4wObfmFn6PFjqMrodnZm
         D7LM3/RE68SIEEhDn920j5R7QRhyKyNnAq3R1C0x8Jviz0ML0GjHeUwGDNr6FvwCYC0A
         yBtfc18wnn9pCFA40Jdc8Hc5nprN27WpDY7aQX5FLj1RWYbWqRKV4MCOOfKYwIAoqlgS
         NzggFeBvwTx7VgIU5NFzuxWLdgPR968GWfnh49HQu8s+nySlsq3qjFmXAfkp4DZ4WsB1
         lK8l5c4/3r3TxH8EhzixYEptTSAix/cYHQclVferApF883zhZvkRUzH07I4oqKqXht35
         z6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3Id0qEovP9qgzLZw49jjaRzmQZFYVlBpyPR9+a8Iuc=;
        b=QU11FnZhkRU1YZt1EI9KuunRrLEXGyK47jv7FmIU4lTMHhDrR5w04uALmfkbN1nZ7I
         XGBu3cgGzUHMeFyYJ40DZKiftcynaoSSwFUdN8a2BBd5+bjnWqSR2+xi0uEwFm/w23N0
         K+t2rKKz5B7IlkrNLaY8qdOrzMv1DJHaeewCTQy33WAboJ3rodStNfzR2oesYse2gfU+
         c92/hJDEvqKQdD8eGu4UmuAPeyd4oG2lb/opclU6OGmcpn1nmKD8CFXZpC7H3i98s7nX
         cQ7WBwgGpWiKvVcIs/+9Wt+ioJyJvLs1HKXUen7ocmppnz5b5azV5HykgLw/BUnc/vKI
         dvuA==
X-Gm-Message-State: AD7BkJKZt3dugvqyWS3kU20qlGVO6nvhpf3CYo7nwUIksCUY2ruw5qi70YhHzGKeUvV9EBUa
X-Received: by 10.140.96.137 with SMTP id k9mr44161569qge.23.1459822234370;
        Mon, 04 Apr 2016 19:10:34 -0700 (PDT)
Received: from LykOS ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id b67sm13522531qhd.11.2016.04.04.19.10.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2016 19:10:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQ4i86JpLFe0tqA-tjFj6Y3DvxDz3nFL8XAMVDBLwLUPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290755>

On Mon, Apr 04, 2016 at 10:00:17PM -0400, Eric Sunshine wrote:
> On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
> > tag.c: Change gpg_verify_tag argument to sha1
> 
> s/Change/change/

Sorry I've been consistently missing these... 
> 
> > The gpg_verify_tag function resolves the ref for any existing object.
> > However, git tag -v resolves to only tag-refs. We can provide support
> > for sha1 by moving the refname resolution code out of gpg_verify_tag and
> > allow for the object's sha1 as an argument.
> 
> This description leaves me fairly clueless about why this change is
> being made since justification seems to be lacking. More about this
> below...
> 
> > Signed-off-by: Santiago Torres <santiago@nyu.edu>
> > ---
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > @@ -104,7 +104,7 @@ static int delete_tag(const char *name, const char *ref,
> >  static int verify_tag(const char *name, const char *ref,
> >                                 const unsigned char *sha1)
> >  {
> > -       return gpg_verify_tag(name, GPG_VERIFY_VERBOSE);
> > +       return gpg_verify_tag(sha1, GPG_VERIFY_VERBOSE);
> >  }
> 
> So, by this point, 'name' has already been resolved to 'sha1', thus
> this change avoids a second resolution of 'name' inside
> gpg_verify_tag(). Therefore, this is really an optimization, right?
> Perhaps the intent of the patch would be clearer if the commit message
> sold it as such. For instance, the commit message might start off:
> 
>     tag: avoid resolving tag name twice
> 
> and then go on to say that by hefting tag name resolution out of
> gpg_verify_tag(), the extra resolution can be avoided.

Yep, this is actually true, but something I didn't consider. I think
that, from what I could draw on [1] and [2], git tag -v is reserved to
tags only (refs/tags iirc). This patch makes it so that this behavior is
not lost. I'm not sure if it should be separate from 5/6 though. 
> 
> >  static int do_sign(struct strbuf *buffer)
> > diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> > @@ -46,8 +47,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> >         if (verbose)
> >                 flags |= GPG_VERIFY_VERBOSE;
> >
> > -       while (i < argc)
> > -               if (gpg_verify_tag(argv[i++], flags))
> > +       while (i < argc) {
> > +               if (get_sha1(argv[i++], sha1))
> > +                       return error("tag '%s' not found.", argv[i]);
> 
> Why does this 'return' after the first error, but the gpg_verify_tag()
> call below merely sets a 'had_error' flag and continues? I would
> expect this one to set the flag and continue, as well.

This sounds better than what I had thought. I'll set had error and do
continue instead.
> 
 >  {
> >         enum object_type type;
> > -       unsigned char sha1[20];
> >         char *buf;
> >         unsigned long size;
> >         int ret;
> >
> > -       if (get_sha1(name, sha1))
> > -               return error("tag '%s' not found.", name);
> > -
> >         type = sha1_object_info(sha1, NULL);
> >         if (type != OBJ_TAG)
> > -               return error("%s: cannot verify a non-tag object of type %s.",
> > -                               name, typename(type));
> > +               return error("cannot verify a non-tag object of type %s.",
> > +                               typename(type));
> 
> This error message becomes much less useful since it now only says
> that there is a problem with *some* tag but doesn't give any
> identifying information. How about including the sha1 in the error
> message?
> 
> >
> >         buf = read_sha1_file(sha1, &type, &size);
> >         if (!buf)
> > -               return error("%s: unable to read file.", name);
> > +               return error("unable to read file.");
> 
> Ditto regarding making this more useful by including the sha1.

yes, I wasn't sure about how to move forward here. I'll replace the name
with the sha1 instead of just removing it.

Thanks!
-Santiago.


[1] https://git.kernel.org/cgit/git/git.git/tree/builtin/tag.c
[2]
http://git.661346.n2.nabble.com/PATCH-v3-0-4-tag-move-PGP-verification-code-to-tag-c-tp7652334p7652437.html
