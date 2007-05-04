From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 11:17:12 +0200
Message-ID: <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 11:17:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjtul-0003SM-Ow
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767775AbXEDJRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767777AbXEDJRO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:17:14 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:21405 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767772AbXEDJRN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:17:13 -0400
Received: by an-out-0708.google.com with SMTP id b33so770051ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 02:17:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYgW8jBYOJLMWgGarX8imVfgmCT9iMNg5w/tHkVUD0TOCBdxba+LD+3abG3EnQlJnGgG7UIkpjMLkVAz0PjT1U8rGw8eGs4b6Rcd502YtNtLKvQjw0wogkXolXGJw5CkOMKa2UK2fiVbdQIZ43+EOz+lUlm7lWaVaJGBdSet+uE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a/2iozbJk7m1kcimt4WHnjxpiawyWTLsmSIgd1O/R9B+t19xs2nkKbYdi1KGr7HRzyfoGT2vd3o2hTF1TXeHtwhlKUO5Bfn79KP0yvbVpeEj2KlP6lRVQd5LLuV4A9yJL8hMQdIZQGoNh7KdYZUQdFgWpOTZYck6xKnDYAiIZSQ=
Received: by 10.100.251.9 with SMTP id y9mr2474213anh.1178270232747;
        Fri, 04 May 2007 02:17:12 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 02:17:12 -0700 (PDT)
In-Reply-To: <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46149>

On 5/4/07, Dana How <danahow@gmail.com> wrote:
> > >  (1) we say it was a mistake that we did not make it relative to
> > >      the current directory when we introduced the X:<path>
> > >      syntax (X could be empty or :[0-3]: for index, or a commit
> > >      or tree object name), and change the semantics in a future
> > >      major release for everybody, apologizing for potentially
> > >      breaking existing scripts; or
> >
> > That would be my first prio preference
>
> Mine too,  but I don't want to break anything.

It probably wont break anything which is not already broken.
It's somehow hard to imagine someone would use the
syntax to check for absence of a file in non-top-level
subdirectory. Besides, the existing syntax is ambiguous:
for anyone using pathname tab completion.

Besides, you can give a warning of ambiguity in case there are
equal relative and a top-level paths. Return the relative, but print
the warning, so people can fix their scripts.

> > > My preference is (2), (3) and then (1), but I do not have
> > > offhand a suggestion for a good metacharacter we could use.
> >
> > "./" :)
> Heh.  Yes, that works in the current patch.
>
> I'm really starting to like the idea of introducing "="
> as an alternative for ":" :
> "=" assumes relative paths, ":" assumes absolute (full) paths.
> That could be Junio's new metacharacter.

Just keep in mind: "once introduced, you'll never be able to remove it".
And I don't share your feelings regarding the special character, for instance.

I'd suggest to define a special character for _top_ level. Real pity
":/" is taken.
