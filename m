From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Wed, 21 Oct 2009 20:33:56 -0500
Message-ID: <fabb9a1e0910211833qb1315aan89f43a7b5b51c556@mail.gmail.com>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com> 
	<7vbpk2sg6m.fsf@alter.siamese.dyndns.org> <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com> 
	<7vbpk2ovio.fsf@alter.siamese.dyndns.org> <fabb9a1e0910201304j2730e6f3j1ebc5c17be07dd12@mail.gmail.com> 
	<7viqe9n72w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 03:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0mZL-0003dt-DV
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 03:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbZJVBeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 21:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZJVBeN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 21:34:13 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36581 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbZJVBeM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 21:34:12 -0400
Received: by ewy3 with SMTP id 3so40814ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kDngIpV56FLFUISj8gJp+L9vrW9pI5sEsEIVuPbq8J4=;
        b=AFbrXV2XcY4/PnwdErtkLeu6Kx1VGJ4NjM+IN6TEjmMgVbuP5fmQVatnDH4hG5fc8Z
         EOXJjacAXyZGGl9Ye37znhYH14c6GGWJUBTh10zsmadnFb15YqqHK+8sRrUy6B5cSssr
         X/F4zLRHiF+BPmrfz7uSZU1BdAGkqydbJoN1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WdBIV2XjPAv7L/MfNbi7b1y+zmE4fERF7ZXlFQOM3zlx9NnFU38vzYRGjDd6Zly+bB
         p+3phUuWPbdvy4uQ/iUampPRlpfTN6ythKX5Ikug9rId22F8x1etARs8UJi6hqg4zsFn
         /7Oav0/mCwxfugzQjJBLpOZGjmFrPzNpICZB0=
Received: by 10.216.88.146 with SMTP id a18mr1908328wef.56.1256175256117; Wed, 
	21 Oct 2009 18:34:16 -0700 (PDT)
In-Reply-To: <7viqe9n72w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130989>

Heya,

On Tue, Oct 20, 2009 at 15:28, Junio C Hamano <gitster@pobox.com> wrote=
:
> For both styles of output, adding an extra LF after "no newline" woul=
d be
> necessary to make the output legible (for human) and parsable (for
> scripts).

You mean like this right?

```
+               printf("\n\\ No newline at end of file\n");
```

Or does it need _another_ newline, like this

```
+               printf("\n\\ No newline at end of file\n\n");
```

> In addition, it would help Porcelains to re-construct the final text =
if
> you added a boolean "incomplete-line" (put it on its own line, immedi=
ately
> after "filename test" line). =A0Then they will know that LF after "se=
cond
> line, no newline" was not there in the original and was added for
> parsability.

What do we do in the case that the last few lines are attributed to
the same commit? Do we just signify 'incomplete line' to mean that the
last one of those is incomplete?

> I am not sure what we want to do for non-porcelain output (other than
> adding the extra LF at the end). =A0Assuming that they are meant to b=
e read
> by humans (and casual scripts that do not bother reading --porcelain
> format), it might be best not to add any extra marking.

=46ine by me :).

--=20
Cheers,

Sverre Rabbelier
