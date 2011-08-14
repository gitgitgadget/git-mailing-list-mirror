From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/7] revert: Make commit descriptions in insn sheet optional
Date: Sun, 14 Aug 2011 21:51:21 +0530
Message-ID: <CALkWK0kdd=+w4-jiBX8hh1_-mi9US+A4nng4qeoRRNmR5yDpDw@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-4-git-send-email-artagnon@gmail.com> <20110814160923.GL18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 18:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsdRf-0001XJ-QT
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 18:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab1HNQVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 12:21:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47588 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab1HNQVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 12:21:42 -0400
Received: by wyg24 with SMTP id 24so3067048wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BQqsI0RD0rhsvz9UBobP8eJPKq7w2PVQhecYBKMLmk8=;
        b=n9sVA8+5iHjnT6N7iXFcsJ1Fr+Nonozo2iNL0wy3lhlu49cLzY/KG1seurerCAKkU7
         4B3ShHX14t/Gn/tEKYloeMXZnhKE8efBo3TVnKBWZAVFXbqHf5+MsGaHLBI9y8M9gtbe
         ej6HpCY5Gv181Bh14cOfb9kxrWE81zkIeMnB0=
Received: by 10.216.131.134 with SMTP id m6mr2077021wei.78.1313338901280; Sun,
 14 Aug 2011 09:21:41 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 09:21:21 -0700 (PDT)
In-Reply-To: <20110814160923.GL18466@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179334>

Hi Jonathan,

Jonathan Nieder writes:
> If I understand correctly, the current code makes it perfectly possib=
le
> to use commands like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick origin/master^^2~5

I was thinking exactly the same thing a few hours ago!  I was
wondering what to do about such a tree'ish specification, and I came
to the conclusion that we should discourage this atleast for normal
users.  Why?  Because the tree'ish has to be invariant over the entire
sequencer operation*: something like "pick HEAD~3" is clearly flawed
since the picking operation updates HEAD.

* Some of us might find some really clever uses for a tree'ish that
refers to different commits during the course of the sequencer
operation, and I'm alright with that.  It might just be something
that's too complicated for many users to grok, and we can protect them
by not advertising this tree'ish operand feature.

> when that is more convenient to type. =C2=A0So I wonder whether 40 is=
 actually
> a good limit. =C2=A0Another possibility would be to do something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static struct strbuf cmit =3D STRBUF_INIT;

I don't like this; the sequencer will just end up drinking a lot of
memory for no reason if the insn sheet is horribly corrupted.  I think
40 is a very reasonable limit, even for the most complex tree'ish I
can dream of.

Thanks.

-- Ram
