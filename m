From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 01:14:20 +0100
Message-ID: <CACBZZX7bgjFz7mvTySPKhR24coqOeVVy8+CsKHVj8Q3LF_-5ww@mail.gmail.com>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 01:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdWJU-00082S-CV
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 01:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab1LVAPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 19:15:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62227 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab1LVAOm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 19:14:42 -0500
Received: by eaad14 with SMTP id d14so1579684eaa.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 16:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zf/whay84d7hBoVeqwl+y1lEbA4c05Tcs1KkfXmMc38=;
        b=oX9pqbYXV4R3icqubq03id/UzbOR/7rOUYdto63HdkGFP812vXgs5vzjlUFaPnva5X
         2ph3PptMyPC7rKohpia8Zs6L1esEDYtXlHFJ6DEYj5SEHTPz+n1KIb5qD6SD0+f8wte+
         zYv13BBeQ/QDE71wyqarGYuLgwTkfQp+I7lEQ=
Received: by 10.204.128.130 with SMTP id k2mr2573004bks.7.1324512881135; Wed,
 21 Dec 2011 16:14:41 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Wed, 21 Dec 2011 16:14:20 -0800 (PST)
In-Reply-To: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187595>

On Thu, Dec 22, 2011 at 00:55, Junio C Hamano <gitster@pobox.com> wrote=
:

Nice. Thanks for tackling this. I'll no doubt be submitting some of
these myself once we start getting translations.

This is not a regression, but note that something like this:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "%=
s%.*s\n", _("hint: "), (int)(np - cp), cp);

Isn't going to cut it for RTL languages like Hebrew and Arabic, since
for them the "hint: " would effectively be at the end of the line.

I think the easiest way to tackle that sort of thing is to just do:

    _("hint: %.*s\n")

And have a TRANSLATORS comment indicating that the format string
should be kept, but that translators can move around the "hint", GNU
gettext also has a msgcheck feature to check that format strings are
compatible in the translations.
