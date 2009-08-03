From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 0/3] fast-import: add option command
Date: Sun, 2 Aug 2009 21:31:54 -0700
Message-ID: <fabb9a1e0908022131m454aee84laa5d276bba8b10e1@mail.gmail.com>
References: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com> 
	<1249189570-26576-1-git-send-email-srabbelier@gmail.com> <20090803001522.GE1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 06:32:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXpDn-0002Gt-FK
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 06:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZHCEcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 00:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbZHCEcP
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 00:32:15 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:4901 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZHCEcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 00:32:15 -0400
Received: by ey-out-2122.google.com with SMTP id 9so878961eyd.37
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 21:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gBFS8D4DEHBQNFiqStyRzQtyJBozeiBkyK1MRMsV1Ww=;
        b=lHRzb8GDaROgbz6mXfM30EF1i3f0j5i3iAY7N1Xh1myn/ugwgcuq/xrdwRPJFVV550
         gJtrY049zs4Y0/5K5E2ATxLy9NH7Na635DL8Nrw73AwyDCXlRuE5CFcG+R0qTPaRaIzH
         kasFpmWYqO1VGFMYklFb5YI0pUcGfFPcidvas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iOyrSZjX3NulSc+lMNIhuwj0Ow3egxRUBBIJw4RHP7TQ78B5/IFcUaAsFotHI2vwJ8
         3/MYgu2CVivMZ3hUa2jI3p2xjZp9UUWvjChLqKAeIUmKratLfpMCVl3jklCKVWUGbQtv
         XGtzBtN0o+UAAFQRoyrOOv4SH08Gs2nh4pFwA=
Received: by 10.216.28.208 with SMTP id g58mr1159846wea.11.1249273934578; Sun, 
	02 Aug 2009 21:32:14 -0700 (PDT)
In-Reply-To: <20090803001522.GE1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124682>

Heya,

On Sun, Aug 2, 2009 at 17:15, Shawn O. Pearce<spearce@spearce.org> wrot=
e:>
> Since you are changing the language format, please also update the
> documentation of the language.

Of course, but I wanted to know whether the change'd be accepted first =
:).

> It might be cleaner to say "option foo=3Dvalue\n" because then the
> if block to parse the command line and the if block to parse the
> input stream are the same. =A0When parsing argv just skip the "--"
> and pass the rest of the argv value into the function, when parsing
> the stream, just skip the "option " and pass the rest of the line
> into the function.

sounds like a good idea, will do.

> This has come up before on the list. =A0We had somewhat decided again=
st
> setting options in the stream header. =A0The only option class that
> really impacts the data itself is the date format, all others
> are about local file paths or how noisy the command should be.
> Thus we decided that the frontend should invoke `git fast-import`
> itself if it cared about these options, and that's what any typical
> frontend does.

Hmmm, yes, I guess that's possible, but that would require the
frontend to shell out, whereas the option-based approach is easier to
the user without requiring the frontend to know how to invoke git. And
while the only option that impacts the data format is the date format,
the import and export marks are very relevant when the frontend wants
to do post-processing of the exported repository. I guess the question
is, do we want to require frontends to create a wrapper around
'frontend | git fast-import --all-my=3Doptions', or is just "fronted |
git fast-import" desirable enough that we want to allow this?

--=20
Cheers,

Sverre Rabbelier
