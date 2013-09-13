From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 12:56:50 -0700
Message-ID: <CA+55aFws7iNGRpu6wKBkKj_5bw3vu_E+q+1__Aw4kmhkaUMRGw@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 21:56:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZU7-0001Se-8B
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 21:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab3IMT4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 15:56:51 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:50481 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3IMT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 15:56:50 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so1350570vbe.27
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/x54xvYfGQHDnsnQnkfUcZhpvK5bLOCL7+cs5IhKelc=;
        b=fkGLCfkPxJFf6SZeujZthYAe6RGpIzxhCES4apbkuFAGnLXFTaNIH9SgSpmEqK2j4U
         iq4RPX0E46WlMM/zjTZxSyUhnysGpep6QdCGuaA8nUWj/h21ONc2IhHLlERkFEK93BJm
         QF7yphS3KiVtbis7j7NvBAVA8ARs7pT8VXwj6FveOLrmw63G3BIe9fwt3GUjwFliY4bE
         Gvcd/Gb/NZGwyEE4xGE0uyUabfL91FdvsNIo1A/Z4AB/2+buvVBaNhpgwxQ6nwwv93kP
         +DmIn+mBEFoqSi+97xMMUv98hz2y1E9JX1XgN1zuym2+3ZbSqMxuMt4mgIgYnbDHJ6vz
         +26g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/x54xvYfGQHDnsnQnkfUcZhpvK5bLOCL7+cs5IhKelc=;
        b=C60q09lTZ+ABoklcUorjyv9LGB0bNsMLx8yTQPEK+yyidZIulRt/uQtDYAYbR6Fe8T
         5HSgB4lB8JvI9Z/qn9UBQzlkOpcdtDH+uSWe98n3VS64UzfEy5NHxEt9aQxkeN/ZC6LL
         Trem+9QXLA+JbUsdCR0odP6yO6ftAwaC+lxJw=
X-Received: by 10.52.230.233 with SMTP id tb9mr11169172vdc.17.1379102210317;
 Fri, 13 Sep 2013 12:56:50 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Fri, 13 Sep 2013 12:56:50 -0700 (PDT)
In-Reply-To: <CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
X-Google-Sender-Auth: Zm5h6SRPboPYGRKABrNH7oaAd9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234766>

On Fri, Sep 13, 2013 at 12:53 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
>
> +#ifdef __MINGW32__
> +#ifdef __NO_INLINE__

Why do you want to push this insane workaround for a clear Mingw bug?

Please have mingw just fix the nasty bug, and the git patch with the
trivial wrapper looks much simpler than just saying "don't inline
anything" and that crazy block of nasty mingw magic #defines/.

And then document loudly that the wrapper is due to the mingw bug.

               Linus
