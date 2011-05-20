From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Fri, 20 May 2011 19:26:42 +0200
Message-ID: <BANLkTinX2Nvq9OtDs6DGdtE7qFL9QjZTbw@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
 <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de> <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
 <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de> <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com>
 <BANLkTingSqEM5=4=rLq7Yu1x9YXstiSsNw@mail.gmail.com> <A4C82C4A-4A6A-412C-89D5-803F6DC85FD3@gieschke.de>
 <BANLkTikRCXLJfOJFZ7j0TV_rxsySgQwSsw@mail.gmail.com> <7vtycp2sva.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 19:27:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNTTi-0002mK-DM
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 19:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935419Ab1ETR1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 13:27:04 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:57252 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934043Ab1ETR1C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 13:27:02 -0400
Received: by pxi16 with SMTP id 16so2628107pxi.4
        for <git@vger.kernel.org>; Fri, 20 May 2011 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=37L4jlTM3TOSMYAr0oS/awI0tW7uqDkMzAvTGfcty3M=;
        b=NAE5OJUrZ+1/HJj/v9DKVkkHl8zkbBeEYfCZpiSgsODDU/6f9do3QSndfdBdJxr9ji
         /fTE9ImgsGGx0tG9wwJmHo1NjBctQsq2dPbLG/vvPq2yQcrTZC2vIHLiojqsyPGhP8Vp
         64J7HZG1TPDGFpvF3Q36gzOYGGNsLKKhuFRy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=h3dSgpPKcd4KbRTUDFPJwVyMj28xul1SKEM2MMPZqZPEZ/UWVUUF3bUm98/6nLSfJS
         LfenMIYWpqBDo8BkrrMX3S6TKd3IKMzYiY/R8xcuJwXZ3HtLOj6zaOuxrlpdgGyGK8B2
         ZGh3wLfj4gMBsOipE8R+yMU53sajOSpz8QNjU=
Received: by 10.68.71.135 with SMTP id v7mr7464944pbu.232.1305912422055; Fri,
 20 May 2011 10:27:02 -0700 (PDT)
Received: by 10.68.47.131 with HTTP; Fri, 20 May 2011 10:26:42 -0700 (PDT)
In-Reply-To: <7vtycp2sva.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174071>

On Fri, May 20, 2011 at 7:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>> Instead,
>> we should make our own function (based on your most recent patch?)
>> that fills a caller-specified strbuf instead (git_getpass already have
>> a static strbuf that we can fill).
>
> Heh, I thought you earlier felt "a bit pointless" to "a properly
> abstracted common version" I outlined earlier in the thread ;-)

Well, if we're going to change git_getpass to not use getpass, then we
need to do something; the mingw-version is a getpass-interface.

Sure, we could continue to use the getpass-interface for the
POSIX-version, but it feels silly to limit the password-length when we
could just pass in that strbuf that is already there (for the
GIT_GETPASS-case). The Windows-version still should be fixed to avoid
the leak that is already there - passing the strbuf in from the caller
would solve that.

I'm fine with just having two implementations, one for POSIX and one
for Windows. In fact, that's probably the right thing to do; my
experiment lead to more lines of code, not less.

My patches were more of an experiment than a proposal :)
