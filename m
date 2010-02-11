From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/4] git-push: send "To <remoteurl>" messages to the 
	standard output in --porcelain mode
Date: Fri, 12 Feb 2010 06:54:47 +0800
Message-ID: <be6fef0d1002111454w10ad965ej72699d1e185d2a9f@mail.gmail.com>
References: <20100209054820.GA30907@cthulhu>
	 <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
	 <45357037fd8f928759c9e9064736c62e793b84be.1265694627.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 23:54:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfhvy-0002Xr-UQ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 23:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047Ab0BKWyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 17:54:49 -0500
Received: from mail-iw0-f195.google.com ([209.85.223.195]:60987 "EHLO
	mail-iw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab0BKWys convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 17:54:48 -0500
Received: by iwn33 with SMTP id 33so2139300iwn.5
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/30iFcrak7NPsUOc0IJpTrQjdzSgNzhfXKabA8+nk2o=;
        b=wpNi8OydcGwmOY0hNQ0rPE8unbpp39pwU1zCkDh3mFU8ZjauNDA0zaBbLKiqp+DTrB
         Yo8GsrOA7tw4ns3S8XUG+m2X9NQ4pDnwibGPmrQob+KtPGAG6XBlBRy0oxGS5YY0zejt
         tjJydfLFX23h/sHeHqOFcUAKx4EDQ7uTBmJIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nzTkM8TRhz9/vNQdKRk7OuGe4LgdCfYhQSkblWHCH4YWzmhufPOjg1COf4e5hvm29l
         eG3Gf0mc4/VAzDMqjPMsaFwJporwdPRqnkil4aBWkZ1L0f/S+O6crlUSI8kk6m3/Rcaa
         C5PaIu6p4MtHz7J9KN66LZi5EPG2nI3pRHLBE=
Received: by 10.231.170.14 with SMTP id b14mr884678ibz.26.1265928887141; Thu, 
	11 Feb 2010 14:54:47 -0800 (PST)
In-Reply-To: <45357037fd8f928759c9e9064736c62e793b84be.1265694627.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139637>

Hi,

On Tue, Feb 9, 2010 at 1:54 PM, Larry D'Anna <larry@elder-gods.org> wro=
te:
> diff --git a/transport.c b/transport.c
> index 3846aac..fb653c6 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -675,7 +675,7 @@ static void print_ok_ref_status(struct ref *ref, =
int porcelain)
> =A0static int print_one_push_status(struct ref *ref, const char *dest=
, int count, int porcelain)
> =A0{
> =A0 =A0 =A0 =A0if (!count)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "To %s\n", dest);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(porcelain ? stdout : stderr, "T=
o %s\n", dest);
>
> =A0 =A0 =A0 =A0switch(ref->status) {
> =A0 =A0 =A0 =A0case REF_STATUS_NONE:

just to check - are debug and user-specific messages (like advice and
info) to be sent, by convention/design/force-of-habit, to stderr? Are
those the "cruft" that has been referred to in other threads?

If that's the case, then perhaps the "To: <destination>" lines should
be sent to both stdout and stderr - stdout, for porcelain scripts as a
"header", and stderr, to help the user make sense of any errors that
occur ("oh, these errors were triggered when pushing to so-and-so
remote").

--=20
Cheers,
Ray Chuan
