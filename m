From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git global usage and tests
Date: Tue, 31 May 2011 13:52:31 +0200
Message-ID: <BANLkTinW_se8VAhF9wk3KyzNHVc_wH_PqA@mail.gmail.com>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
	<20110530153620.GA24431@sigill.intra.peff.net>
	<B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
	<20110530161230.GA25291@sigill.intra.peff.net>
	<7v7h97la4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Romain Geissler <romain.geissler@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 13:52:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRNV0-0008TO-AS
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 13:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab1EaLwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2011 07:52:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53539 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab1EaLwc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2011 07:52:32 -0400
Received: by fxm17 with SMTP id 17so2977897fxm.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VWWJ/bifcTN+wiw/3f5Ox7qkd7zW5lo+hAGwkv9rOKo=;
        b=deCJ4gg5dpL+K/uSAkAjamOHRajsCFkvr3GTAyfUjH4frp/logKTtUgR7itHG5ol1p
         3v3tuO+qwko3cUJa2m4GSX/U8WiKaWMY35pO/Djoy6ZU8+zjO5wVWj3rOldhj/w9nq7w
         MBmIQPFVdBQvGLOGXMHOHZA1784w8EErnG1as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uOgQ3DFHCMSHf9R3bLS7KAHnaarUG5lh2IbQzrOFWE7FSvDBV7Rxmavu+VHHIKOq+B
         Oq23A+V+wmvefhYHrsAJcus7LA6+0qGXkfmTHSuq2qUBDBFb4TnFbD7mV1K045P2yfgE
         Kx0rqI39NYFe+UyRdG04Uiff3Fd3rE4OWoFxc=
Received: by 10.223.3.132 with SMTP id 4mr4078922fan.132.1306842751522; Tue,
 31 May 2011 04:52:31 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Tue, 31 May 2011 04:52:31 -0700 (PDT)
In-Reply-To: <7v7h97la4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174801>

On Tue, May 31, 2011 at 07:19, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, May 30, 2011 at 06:10:20PM +0200, Romain Geissler wrote:
>>
>>> > Have you considered pulling the parse-options parser from git int=
o
>>> > libgit2? It's one of the more modularized and lib-ified bits of c=
ode in
>>> > git already.
>>>
>>> Yes and No. We have already copied some code from git : parse-optio=
n,
>>> the error handling functions, a part of the run-command block and a
>>> part of the compatibility layer. To my mind, there is no reason to
>>> pull it into libgit2 as it's only a client feature that works on
>>> strings, and libgit2 does not aim at being a client, only a git
>>> library.
>>
>> Yeah, good point. Definitely it should not be part of the libgit2
>> library itself.
>
> IIRC, libgit2 has a lot looser license than ours, and the core GPLv2 =
part
> of C git cannot be directly copied without authors' consent; relicens=
ing
> of necessary parts of C git needs to be arranged.

Seems like a PITA:

$ git log --pretty=3Dformat:%an parse-options.[ch] | sort | uniq -c | s=
ort -nr
     19 Pierre Habouzit
     15 Junio C Hamano
     11 Ren=C3=A9 Scharfe
      9 Stephen Boyd
      7 Jonathan Nieder
      4 Johannes Schindelin
      2 Michele Ballabio
      1 Tuncer Ayaz
      1 Thomas Rast
      1 Olivier Marin
      1 Nanako Shiraishi
      1 Miklos Vajna
      1 Mike Ralphson
      1 Michael J Gruber
      1 Mark Lodato
      1 Linus Torvalds
      1 Jeff King
      1 Jake Goulding
      1 Giuseppe Scrivano
      1 Gary V. Vaughan
      1 Christian Couder
      1 Carlos Rica
      1 Andreas Schwab
      1 Alex Riesen
