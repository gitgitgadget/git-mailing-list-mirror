From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Wed, 16 Jun 2010 12:43:50 -0700
Message-ID: <AANLkTikM8fRb7oeeMrsEfqTzDAYhTJxN63mblhyUXJM6@mail.gmail.com>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com> 
	<DB1710D5-1699-45C2-8884-5D60C5240ED9@mit.edu> <7vwrtygbq5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 21:44:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOyX3-0001fp-P0
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759221Ab0FPToJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jun 2010 15:44:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64647 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab0FPToI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 15:44:08 -0400
Received: by gwj15 with SMTP id 15so4285457gwj.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=s5FDdasgI+W8q+DfnI65ip6Gjqvdnv5jL5VB822A2mE=;
        b=sg2DeBiOHuPBj9g1XB/XKeI0wYiW2W1HsEkK0l1rr5pi8tUtfxF7MylDkHET19BO2s
         ORm+kx7NBN303HZuKEvO/2expl1xHt2Q+hqpRsjcdAf+oT+vLi3lADFnd8QBPZDKhPaz
         cyjfo/2J3YcsxL3f+sGUFR44rNRnm1sEj0dyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OVjIXSLUOPITHwkCp124fzQir/g20e/luThhkjRiKT7vj8F0iKdtEzCxH01XQhZkir
         l9BOTTmgkb1MMDCNKWoCCvTyVH4C8kigEWTLad5LUjqerJGjY+zfEjWpoxijot/i1YBf
         xwIGZvCmFkgqDuBVM2sxVd0O7VCGa4rOT0hI0=
Received: by 10.229.218.211 with SMTP id hr19mr4199410qcb.92.1276717445458; 
	Wed, 16 Jun 2010 12:44:05 -0700 (PDT)
Received: by 10.220.179.77 with HTTP; Wed, 16 Jun 2010 12:43:50 -0700 (PDT)
In-Reply-To: <7vwrtygbq5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149274>

On Wed, Jun 16, 2010 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Theodore Tso <tytso@MIT.EDU> writes:
>
>>
>> I don't know how important people will feel this to be, but I've occ=
asionally
>> found it interesting to see how many people are using various differ=
ent
>> versions of git in a particular development community, and having th=
e
>> version in the signature is a useful gauge on that.
>
> The original motivation of the version signature was exactly that ;-)=
=2E
>

At least with git send-email you get the X-Mailer header and you know
what version is being used. I admit that isn't as visible/useful as
the signature though and not everyone is using git send-email.

>
> I think you misread Stephen, he misspoke, or I misread the patch. =C2=
=A0The
> intention of the change as I understand it is to put the signature in=
 the
> cover letter, in addition to the patches.
>

Yes, this is one intention. The other intention is to allow me to
customize what that signature is (or to have no signature at all).
Currently it replaces the version number.

The other option is appending the signature to the version number, but
I thought it looked funny:

    --
    1.7.0

    Signature goes here

but now that I look at it again maybe it looks ok.

If the answer is there should always be the version number in the
signature then renaming --signature to --custom-signature or
--extra-signature or --append-signature would be more clear (albeit
verbose). Then  --no-*-signature wouldn't imply that you are removing
the default version signature (because you can't).

If the signature is causing problems for third-party tools then maybe
in some projects they wouldn't want the signature at all and
--no-signature would be a good option there. It doesn't mean we have
to add a --signature=3D<str> option too, instead it could just be a
boolean option.

The real question is how useful is it to have the version number
there? There are other ways to gauge the version usage and it's opt-in
so you'll still get some version number coverage.
