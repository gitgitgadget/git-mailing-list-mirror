From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Wed, 27 Jul 2011 23:19:38 +0530
Message-ID: <CALkWK0npk7T+=XArxgft93XAifQvWLpjisg_XhhS-h6EmjS4Hg@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-4-git-send-email-artagnon@gmail.com> <20110727041809.GB18470@elie>
 <CALkWK0kFngXcyrKeB4HM5GdHebkuXOQ5jBETxWuxZCzYL94tqg@mail.gmail.com> <20110727174234.GC29924@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 19:50:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8FB-0007xC-KV
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 19:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab1G0RuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 13:50:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54360 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1G0Rt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 13:49:59 -0400
Received: by wyg8 with SMTP id 8so1171721wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YpHlUWUMFQ32CNYVZYRX8YpPxVeDAi/SntYQbNP/IZQ=;
        b=g1l4P8C78jfpP/KurjmCTl1/Y6jqMDgqkb0WjqefJG3vzsLO8YbpVMvEphUSz39bWM
         72GK/KVWzsL+b9lquClcF77I5dPqxbzU6E/yHG/p+QcGtetXqnXMB3faBajAQ35EMfoF
         arWp0V8QiQqMp29k9kZTxwJn4EvdJhg81M0CI=
Received: by 10.216.9.134 with SMTP id 6mr48577wet.111.1311788998579; Wed, 27
 Jul 2011 10:49:58 -0700 (PDT)
Received: by 10.229.221.205 with HTTP; Wed, 27 Jul 2011 10:49:38 -0700 (PDT)
In-Reply-To: <20110727174234.GC29924@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177986>

Hi,

Jonathan Nieder writes:
> But git already has a strategy for this. =C2=A0It is quite simple: gi=
t can
> give insane results when fed malformed objects, but it does not blind=
ly
> trust it and let scripts segfault, corrupt something else, escalate
> privileges, etc. =C2=A0Remember that malformed objects might even hav=
e been
> received from a remote machine with "git fetch" --- one simply cannot
> trust objects beyond the assertion "each object is a stream of bytes"=
=2E
>
> And on the other hand, git maintains sanity by _preserving_ invariant=
s
> and providing good behavior when it deals with valid objects. =C2=A0T=
o a
> rough approximation, "valid object" is a synonym for "git fsck accept=
s
> it" (but that approximation is only modulo bugs --- git fsck has both
> false positives and false negatives). =C2=A0It is perfectly legitimat=
e for
> commands to get confused and give a wrong result when working with
> invalid objects, and this ability is a nice thing because it allows
> for some optimizations.
>
> As for the example at hand: perhaps we should teach "git fsck" to cal=
l
> commit objects without a blank line after the header invalid. =C2=A0A=
fter
> all, historical implementations of commands like "git cherry-pick" ar=
e
> not ready to cope with them. =C2=A0But that is no excuse to pretend t=
hey
> don't exist! =C2=A0While the best thing about your patch (and the mos=
t
> invasive aspect of it) is that it improves that situation, for some
> reason you don't want to document this important aspect of its impact=
=2E
> It leaves me completely puzzled.

Ah, thanks for the elaborate explanation.  I'll document this aspect
in my patch accordingly.

-- Ram
