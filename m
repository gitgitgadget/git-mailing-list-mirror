From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Fri, 22 Oct 2010 18:44:37 -0700
Message-ID: <AANLkTi=KC1fc35xygbQXJ_pmmdy4ePS-zWwfoDLN4_Ao@mail.gmail.com>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <201010221741.25390.johan@herland.net> <AANLkTinY2q-nM8tSWgNG2TtuNXPPzwhY0M-QknODqAoK@mail.gmail.com>
 <201010230247.45097.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 23 03:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9TI2-0003fz-7C
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 03:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab0JWBwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 21:52:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45532 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab0JWBwY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 21:52:24 -0400
Received: by gxk23 with SMTP id 23so919738gxk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=dosSUPXbgBbNimjqzb7jTrnx/wceb91GoH6ngPc5BOU=;
        b=lZ/EQRcIgymqmWYUUQrkjfV3KgWAqIZ97Yp5OtNV82T2IMVojZR0qCPlwPUCxLSFjP
         nJ6IYfsW67rVtaCD+Fl+CGwijw9cO0VVtfTPcLjqbRWPcDF8NiGULLmbKohTIg7AWazO
         d9EPIm5f3LjJPZPiDGKsj4JUaAEjgce1fRYFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iFJk4DXtkIG4+jSLAdsCDnCU9kE1mdG9ibp5whapLTKJHyKogqZ5uxUjr0Me0qRtpB
         0gHEylEVAYtZDEgG89j7yWD756L5TFxHLfil9sno2xN2vQRbBu2GBZl0Nr/NaW6aKmpq
         IpH1O/J8g6ZI5p+9dMWd3U/Nqj40/2H73rMcc=
Received: by 10.151.10.12 with SMTP id n12mr1849266ybi.148.1287798743416; Fri,
 22 Oct 2010 18:52:23 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 18:44:37 -0700 (PDT)
In-Reply-To: <201010230247.45097.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159770>

Heya,

On Fri, Oct 22, 2010 at 17:47, Johan Herland <johan@herland.net> wrote:
> On Friday 22 October 2010, Sverre Rabbelier wrote:
>> I think notes directly under /refs/notes/ should be shared by default,
>> but those in sub-refs (such as the /refs/notes/am/ that's been
>> mentioned before) should not.
>
> In theory that would make sense, but how you write that as a refspec? AFAIK,
> refspecs don't (yet) support a syntax for (a) _excluding_ something from a
> glob, and certainly not (b) excluding all "sub-refs" from a glob.

Indeed, which I think is a shame. For that matter, I'd love to be able
to have negative globs for branches in general (e.g., 'git log
--branches :-heads/hidden/**).

> Alternatively, we could share everything under refs/notes/, except
> /refs/notes/local/ (or refs/notes/private/ or whatever). That would just
> require support for (a)...

That goes against how notes are used though. The refs/notes/* space is
the one that is shown by default, not refs/notes/local/*.

>> Who's going to type that out though? The only use case I can think of
>> is if you want to be able to give someone a line they can paste and be
>> set right away, but I don't see why in that case pasting multiple
>> commands (i.e., calling 'git config' a few times) wouldn't suffice.
>
> You might be right. I was thinking that before we provide shorthands, we
> should provide an option that let you specify _any_ refspec. Sort of as a
> fallback if somebody's scenario doesn't fit into any of the shorthands.
>
> But as you say, this can also be done with a few calls to git config.
[...]
>> Adding refspec shorthands _does_ make sense. However, it might make
>> more sense to put those under 'git remote' instead?
>
> I'd say _both_ 'git remote' and 'git clone'.

I think getting those shorthands in git config/git remote is step one,
if we do want that. Then, if desired, we can add that to git clone.


>> That sounds like a good use case.
>
> But I believe we need to extend the refspec syntax to support at least (a)
> from above (excluding named entries from a refspec glob) in order to support
> hiding of certain refs. Still, I think it would be a useful addition.

Agreed.

-- 
Cheers,

Sverre Rabbelier
