From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Fri, 26 Feb 2010 16:33:23 -0500
Message-ID: <ca433831002261333n4165d450k40e5feae72937cdc@mail.gmail.com>
References: <20100222110814.GA3247@progeny.tock> <20100222112326.GA21929@coredump.intra.peff.net> 
	<ca433831002252011r3d3459a2xca7535300cd6630f@mail.gmail.com> 
	<20100226093633.GA9609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 22:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl7qS-0001ru-1g
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 22:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966206Ab0BZVf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 16:35:29 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36161 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966162Ab0BZVf2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 16:35:28 -0500
Received: by gyh20 with SMTP id 20so271484gyh.19
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wEfbFEIU74gM+SSaYIEiBNKxBGXlaeH8RTIghF6kb7g=;
        b=qdocLWVn4wbtvXFGzzXrYb145j+wcYuftu/SAot0+0iL6nDbmFrv15ShrbGe/jwMuV
         3S11LCEoN1AclA4OwEJGHAhpCHXWKd1AuuQ7ab4+b+s+St8Gq9dBib7pvG/Rp9opg9Nv
         EmYjxKlTKRsJtzdC9AoUVoINjGRedPysephU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nSb+Nua1CifWf+cSnF7sv/C6olfimk/c2tG/HIP/pdj97qXylHShAYaV+p+cU8s1WE
         mRS3Y2746zK82Gv+IhAqJTbnnNA+SFL3WcGIg0NnUnPBlEz/NkVtAJO//vTOhOblRSie
         wYfuo0pcIhU08R42T9ZQbBMLFebWMco4Hr+oM=
Received: by 10.90.40.31 with SMTP id n31mr1006703agn.76.1267220125430; Fri, 
	26 Feb 2010 13:35:25 -0800 (PST)
In-Reply-To: <20100226093633.GA9609@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141153>

On Fri, Feb 26, 2010 at 4:36 AM, Jeff King <peff@peff.net> wrote:
> Dropping the openssl link dependency gives:
>
> =C2=A0stock, make -j4 test (best of 3):
> =C2=A057.43user 74.60system 1:09.48elapsed 190%CPU
>
> =C2=A0NO_OPENSSL=3DTooSlow, make -j4 test (best of 3):
> =C2=A050.64user 68.74system 1:03.48elapsed 188%CPU
>
> Which is almost a 12% speedup by dropping openssl.

I got about an 8% speedup on this test.

master
make -j4 test  216.72s user 296.83s system 171% cpu 4:58.80 total
make -j4 test  217.21s user 293.97s system 171% cpu 4:58.53 total
make -j4 test  216.08s user 293.76s system 165% cpu 5:08.39 total

master + this patch
make -j4 test  199.21s user 258.88s system 159% cpu 4:47.60 total
make -j4 test  198.61s user 264.40s system 168% cpu 4:35.42 total
make -j4 test  197.12s user 268.74s system 169% cpu 4:35.33 total
