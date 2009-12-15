From: Brandon Casey <drafnel@gmail.com>
Subject: Fwd: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 20:09:46 -0600
Message-ID: <ee63ef30912141809k27bc73edp20abddd5e9c7c063@mail.gmail.com>
References: <20091214183337.GA25462@atjola.homenet>
	 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
	 <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
	 <7vhbrtdtth.fsf@alter.siamese.dyndns.org>
	 <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 03:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKMrQ-00032y-JD
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 03:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbZLOCJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 21:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758447AbZLOCJu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 21:09:50 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:48194 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758853AbZLOCJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 21:09:49 -0500
Received: by pxi4 with SMTP id 4so2247242pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 18:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=tuvpX439/LDEyTusNTdYyWTOREEkkmFpqQk30YzR0yk=;
        b=pSTkuuquVH/2lzMtgh4/MRiwWeLBRbGEHiVtx5tL8Q+utCn51omkqxVhBAjQcmGceN
         6mG3E9eGZr6TNyNfF4W4VE2+poiKLJMgT4zdsz46rIHCCgk471xjNSNY3VQlmk1q6lN5
         tzmYGDlXcsE3J/b63OuybjNVVrSDVTA6q5WZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=tY1U7oQ9pAX5kthjnZoTVrVYkKVXQ04KJzRZyWYMpfJG+VtcDA96fbCUfLSpeyPWSp
         rBWaxkr7inrr93vL3302RU9dkk6kW3/Xun3RHI63dAUMAd7L2AMaynIH84cro13vWogy
         0S5k7Cl4fYi2gDcSEtsty7NPkkZc7wtNef8eM=
Received: by 10.114.237.30 with SMTP id k30mr3815255wah.102.1260842986817; 
	Mon, 14 Dec 2009 18:09:46 -0800 (PST)
In-Reply-To: <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135260>

=46orwarding to the list.  The original was bounced since gmail sent a
multipart mime version with html.  Seems we can't disable html
composing in the gmail settings anymore (I thought we used to be able
to).


---------- Forwarded message ----------
=46rom: Brandon Casey <drafnel@gmail.com>
Date: Mon, Dec 14, 2009 at 6:50 PM
Subject: Re: am fails to apply patches for files with CRLF lineendings
To: Junio C Hamano <gitster@pobox.com>
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>, Bj=C3=B6rn
Steinbrink <B.Steinbrink@gmx.de>, jk@silentcow.com,
git@vger.kernel.org


On Mon, Dec 14, 2009 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
>
> > My understanding of the problem is that rfc2822 dictates that...
>
> I think the fundamental problem is that what MUA uses as the internal
> storage format doesn't necessarily have to even be RFC-2822, which on=
ly
> specifies what should be on-the-wire.

If CRLF is what is on-the-wire, how can the MUA tell whether the
original was also CRLF or whether it was only LF?=C2=A0 My assumption w=
as
that the MUA cannot tell, and that things worked for most people
because those people who wanted LF terminated output were on platforms
that used LF termination and their MUA produced output using the
native line termination.=C2=A0 Things broke recently for some people si=
nce
thunderbird devels decided to start saving emails with CRLF
termination on linux.

>
> =C2=A0The blamed commit took things too
> far.
>
> It actually is the norm to use LF as the line terminator in the body =
text
> in saved messages (and trailing CR as a true part of the payload), an=
d
> "am" traditionally used that definition. =C2=A0It is meant to read fr=
om "mbox"
> format to begin with.

But isn't each email in the mbox file supposed to be RFC-2822
formatted anyway?=C2=A0 If so, then my reading of RFC-2822 says that th=
ere
should only be CRLF everywhere and no bare CR or bare LF.=C2=A0 But may=
be
everyone has just been ignoring that part of RFC-2822?=C2=A0 I'm not an
email expert, so I really don't know.

>
> Before the blamed commit, "am" took what was given literally, and it
> treated the trailing CR as part of the payload in a text file, each o=
f
> whose line is LF terminated. =C2=A0This meant that if you sent and yo=
ur MUA
> didn't corrupt, or more importantly if you ran format-patch yourself =
to
> produce a patch on content with CRLF line endings and fed it to am wi=
thout
> any e-mail involved, your CRLF would have been preserved. =C2=A0So in=
 that
> sense, unlike what you said in your message, the blamed commit didn't
> decide that the line termination must be LF. =C2=A0It decided that th=
e line
> termination does not matter, which is a lot worse.

I think it is more correct to say that the line termination in an
email is ambiguous.=C2=A0 CRLF does not necessarily mean that the origi=
nal
had CRLF line termination if RFC-2822 is followed explicitly.

> As long as the use of CR is an internal storage matter and "Save As..=
=2E"
> doesn't add extra CR that wasn't in the original contents, I wouldn't=
 say
> that such a MUA is broken. =C2=A0In the use case that led to the blam=
ed commit,
> the user is choosing to read directly from the internal storage of MU=
A,
> bypassing its "Save As..." interface meant to be used to externalize =
the
> messages,

No, we're using "Save As..." in thunderbird, and it saves with CRLF
line endings.=C2=A0 I don't really care for thunderbird and its procliv=
ity
for munging my emails and _not_ doing-the-right-thing in my opinion.

Maybe someone can suggest a mail client that can use imap and provide
the nice sorting of emails into folders like thunderbird does.

-brandon
