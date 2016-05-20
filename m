From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Fri, 20 May 2016 17:39:56 +0000
Message-ID: <573F4BEC.7000906@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
 <CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
 <573E30C8.4070600@sapo.pt>
 <CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
 <xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 20 19:40:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3oPE-0007js-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbcETRkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 13:40:07 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:37459 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750810AbcETRkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:40:06 -0400
Received: (qmail 29623 invoked from network); 20 May 2016 17:40:02 -0000
Received: (qmail 23387 invoked from network); 20 May 2016 17:40:02 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <avarab@gmail.com>; 20 May 2016 17:39:57 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295191>

=C0s 16:39 de 20-05-2016, Junio C Hamano escreveu:
> We want to see the string appear after "Did you mean this?" and we
> do not want to be fooled by a future change in the early part of the
> message, which may contain a substring l-g-f that does not have
> anything to do with the alias we are looking for.
>=20
> And the way you express "I do not care anything above this line" is
> to say "sed -e '1,/^that line/d'".
>=20
> Of course, if you use this with POISON, you'd need to consider that
> "Did you mean this" would not be a good marker to identify where the
> introductory text we want to ignore ends.  You'd need to find a
> different mechanism to exclude the introductory text if you want to
> retain the future-proofing the existing "sed -e" gave us.
>=20
> Perhaps discarding up to the first blank line (i.e. assuming that we
> would not remove that blank, and also assuming that we will not
> rephrase "Did you mean this?") may be a good alternative.
>=20
> Or assuming that the explanatory text would not begin its lines with
> a tab, i.e.
>=20
> 	grep '^	lgf$' actual
>=20
> (the space between '^' and 'l' above is a TAB) without using
> test_i18ngrep?
>=20
> I think I like that the best among what I can think of offhand.
>=20
>=20
Alternatively, we could leave sed alone as it were before this patch an=
d
use test_i18ngrep instead of grep to fake success under GETTEXT_POISON.
I think I prefer this way. What do you think?
