From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Thu, 5 Dec 2013 20:11:23 +0100
Message-ID: <CANQwDwdw6MQW2wWvL=GmwYeDKF-gikNx55QdYH2oD50ZZUcPRw@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
 <1386164583-14109-4-git-send-email-krzesimir@endocode.com>
 <CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
 <1386235422.2186.7.camel@localhost.localdomain> <xmqq61r3i2ol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoeLL-0003Qf-P8
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab3LETMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 14:12:07 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:50990 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab3LETMF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Dec 2013 14:12:05 -0500
Received: by mail-we0-f172.google.com with SMTP id w62so11483955wes.31
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4pE0afGEHtw87cFtMtH6nvhbr58zKxc0F7JrJnvhsug=;
        b=HoV+EBw6WC0FEI9uNhzBL/HsypQG22mPN03ROlcbZdpPPRGbHbLl32w3dR/FGPNgfv
         PDeeF0DBUYwsjahtGVekNmvWLM07OqR8jFqQrDlrH6uuhFrCX0tyAMvlaUyqPLWCrDdj
         k9IDYizYZwQuWuzSA6hvT1nryTmE7glUexeEU1Ovv6NDp19cYzz2P9ytLeVDnqBTq6dX
         MxyiqBPYFpc1CaFdNBS5WyR2gmn1Wna1VUzR5b5dJt7TI+guOv64zHVYfe+pyb3C27dr
         W0C8umlcag8gFZnmVwrtxrYlCFNCzrdT5wXwCW8Sd6a4Ui/W2leYpfBvA9Pzfb5j6Xkx
         gHLg==
X-Received: by 10.194.172.105 with SMTP id bb9mr19253131wjc.45.1386270723624;
 Thu, 05 Dec 2013 11:12:03 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Thu, 5 Dec 2013 11:11:23 -0800 (PST)
In-Reply-To: <xmqq61r3i2ol.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238897>

On Thu, Dec 5, 2013 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>> On Wed, 2013-12-04 at 17:07 +0100, Jakub Nar=C4=99bski wrote:

>>> The only change that needs to be done is replacing
>>>
>>>            return $input;
>>>
>>> with
>>>
>>>            return 1;
>>>
>>
>> I prefer to use zeros instead of undefs - one might wonder if that u=
ndef
>> is somewhat special that we can't use 0.
>
> For Perl speakers, I suspect the code gives a totally opposite
> impression.  Normal "false" return from a sub, when there is no
> special need, is to return an undef from it, and a "return 0" would
> make the readers wonder if there is something special about the way
> the returned value has to be numeric zero, no?

Or even plain "return;" (see explanation for policy in [1])...
though for functions returning scalar it is recommended
to use explicit "return 0;" (or "return undef;").

Anyway, it is easier to see the change and intention of the change
if all that is changed id "return $input;" to "return 1;"

But I am not against "return 0;" on validation error (would putting
it in separate patch make review easier, or just pointlessly proliferat=
e
patches?).

[1]: http://search.cpan.org/~thaljef/Perl-Critic-1.121/lib/Perl/Critic/=
Policy/Subroutines/ProhibitExplicitReturnUndef.pm
--=20
Jakub Narebski
