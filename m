From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Mon, 7 May 2012 11:43:27 +0200
Message-ID: <878vh4con4.fsf@thomas.inf.ethz.ch>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1336287330-7215-2-git-send-email-rctay89@gmail.com>
	<1336287330-7215-3-git-send-email-rctay89@gmail.com>
	<1336287330-7215-4-git-send-email-rctay89@gmail.com>
	<1336287330-7215-5-git-send-email-rctay89@gmail.com>
	<20120506082130.GB27878@sigill.intra.peff.net>
	<CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:43:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKTj-0000hT-5s
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab2EGJne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 05:43:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:47693 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2EGJnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 05:43:33 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 7 May
 2012 11:43:31 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.209.244) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 11:43:31 +0200
In-Reply-To: <CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
	(Tay Ray Chuan's message of "Mon, 7 May 2012 00:07:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.209.244]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197249>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sun, May 6, 2012 at 4:21 PM, Jeff King <peff@peff.net> wrote:
>> On Sun, May 06, 2012 at 02:55:30PM +0800, Tay Ray Chuan wrote:
>>
>>> =C2=A0 $ git sh --pretty=3Doneline
>>> =C2=A0 git: 'sh' is not a git command. See 'git --help'.
>>>
>>> =C2=A0 Did you mean one of these?
>>> =C2=A0 1: =C2=A0show
>>> =C2=A0 2: =C2=A0push
>>> =C2=A0 [1/2/.../n] 1
>>
>> Ugh. Please protect this with a config variable that defaults to
>> "off". =C2=A0It is very un-Unix to prompt unexpectedly, and I suspec=
t a lot
>> of people would be annoyed by this behavior changing by default (I k=
now
>> I would be).
>>
>> -Peff
>
> While I agree there should be a config to protect this, I was hoping
> this would be useful to users on the terminal who make the occasional
> slip-up, without having to do any prior configuration.

We already have help.autocorrect.  It defaults to 0, which results in

  $ g rebest
  git: 'rebest' is not a git command. See 'git --help'.
 =20
  Did you mean one of these?
          rebase
          reset
          revert

But it can also be a timeout in deciseconds, after which the match is
automatically executed (if there is only one).  You could hijack it by

* making 'ask' mean your new feature

* making 'off' etc. be the same as 0 for sanity

* making the default value be like 0, but with an extra message such as

    Use 'git config --global help.autocorrect ask' to let me prompt for
    the correct command.

  though I'm sure you can improve on the wording.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
