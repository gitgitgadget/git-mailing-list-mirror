From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 6/6] gettext: Add a skeleton po/is.po
Date: Mon, 31 May 2010 14:17:24 +0000
Message-ID: <AANLkTimutYPEcaCALfO1fDOZcxkrRMN5Axj8eYJGuvcE@mail.gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<1275252857-21593-7-git-send-email-avarab@gmail.com>
	<20100530212912.GA422@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 16:17:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ5o7-0003nq-Pg
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 16:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0EaOR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 10:17:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56453 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab0EaOR0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 10:17:26 -0400
Received: by gwaa12 with SMTP id a12so2709127gwa.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0iPifSRYuDZdzTrKseNQLTCpHsZuFG3FUEs/hbgcWS4=;
        b=VV1Thq2O1W5gFJdS/tXbeO6r6AxrqTklb0iNAYT+co4gqBvcSFrXnC/NR0lP3QicXc
         JvrO2J+zF1vXt9KgtcTZ2rFbopJZBnyxmU/58o2krX8dti9U+2eE4bO3GBD2dwB9lA42
         6CZhUVQV6Rh/J1Xw8qtDiN4dzzNzWp/lo6+Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T7qw3gEHbtxd6uNSxEnwgGA6TyOaFKiCwEKCYhjKiIjsN/dXs6YOVbUat9fJbhnfs0
         YgFKEjqhHJoe9sfBGOeIu5KqyW0oZG1HiZVSQWrWomP00LwTC5cSt02mkILTrJzh+qZv
         28Ttk23GQFhc79sXgHxc2wpd3Uc0WnofRz22I=
Received: by 10.231.158.131 with SMTP id f3mr5930232ibx.54.1275315444547; Mon, 
	31 May 2010 07:17:24 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 31 May 2010 07:17:24 -0700 (PDT)
In-Reply-To: <20100530212912.GA422@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148044>

On Sun, May 30, 2010 at 21:29, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi =C4=98var,
>
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> +#: wt-status.c:53
>> +msgid "# Unmerged paths:"
>> +msgstr ""
>
> On projects that use gettext, merging these line number changes can
> be a royal pain. =C2=A0In effect, the .po files are mixing semantical=
ly
> meaningful text and automatically generated cruft.
>
> So my ignorant questions:
>
> =C2=A0. does gettext use the #: comments for anything important?
> =C2=A0. can they be suppressed when generating the .po file?
> =C2=A0. can they be easily re-added if some translation front-end nee=
ds
> =C2=A0 them?

Let me answer that more generally.

Usually when people first see the Gettext format they go "ew!". The
thing is that it's really meant as a format for mixed human and
programmatic editing. Almost everyone editing PO files doesn't do so
purely with a simple non-PO aware text editor.

PO editors use these comments to allow you to jump to the source
definition to see the message in context. E.g. Emacs's po-mode allows
you to do this, and Launchpad displays the file & line number (but
last I checked they didn't have an embedded viewer).

A merge of two PO files that doesn't use msgmerge(1) is going to be
painful. There are some things that it'll throw out and regenerate
(e.g. automated comments, those matching /^#\S/), and it might move
messages around to match their new position in the respective source
files. Thus a merge that might be hard with a simple git merge might
be very easy with a msgmerge-based merge.

Now, we could filter out all these comments (and e.g. context
comments) before checking these files in. But that would cause a lot
of tools like Launchpad and PO editors to behave in unexpected
ways. The Gettext utilities themselves also seem to have no support
for initializing/emitting these sort of slim files.

I don't know what the answer is, but this is all something to
consider. I'm new to the Gettext format myself, but I've come to like
the automatic editing the tools do, especially the automaticy fuzzy
tagging.
