From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 9 Oct 2009 10:01:02 +0200
Message-ID: <fabb9a1e0910090101g2de58824p6cfdea86c98e0191@mail.gmail.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> 
	<1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 10:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwARD-0004Sz-V3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 10:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbZJIICA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 04:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbZJIICA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 04:02:00 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:51555 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZJIIB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 04:01:59 -0400
Received: by ewy4 with SMTP id 4so386578ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B/utaD3cMNDUVkJuGFrjPbDX0SlXk42RDhOv5aG4ido=;
        b=QBlr/oXWgD6oC2+PcYvxTro/AheKGRJrzY/Duys8Tv5l7Lxepf0jGmFVQ4dzn+fE/N
         eJdewRb4FsQcoEjhbZbpT/UItq90WP7h70xFOPn4ZB1dCZriF10tAcN77hguKIgULqyJ
         IYNY3WZJE8wzhdI6jnJD3Ib07frrnzaheRZqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hOUAAgx5FTq6w1swudsY6BlAWITTV+t/5+iE8TtYoOi7t54h3YUGL7AiELGCIWSWxh
         tr1552wduaASqO/nFESyAuCq/rkSES5F1Yy+kjnRai0IZQ8/QSQ9ALvzilXTYCnIIqUe
         wWzBCdnY2zU+h7X+U4HSRF7bhlmZv4Zhy3UlI=
Received: by 10.216.87.197 with SMTP id y47mr799522wee.202.1255075282176; Fri, 
	09 Oct 2009 01:01:22 -0700 (PDT)
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129751>

Heya,

I had some spare time, I hope these comments from someone that is not
too familiar with the protocol are helpful :).

On Fri, Oct 9, 2009 at 07:22, Shawn O. Pearce <spearce@spearce.org> wro=
te:
> +Compatible clients must expand
> +'$GIT_URL/info/refs' as 'foo/info/refs' and not 'foo//info/refs'.

Does this not need s/must/MUST/

> + =A0 =A0 =A0 S: ....# service=3Dgit-upload-pack
> + =A0 =A0 =A0 S: ....95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/he=
ads/maint\0 multi_ack
> + =A0 =A0 =A0 S: ....d049f6c27a2244e12041955e262a404c7faba355 refs/he=
ads/master
> + =A0 =A0 =A0 S: ....2cb58b79488a98d2721cea644875a8dd0026b115 refs/ta=
gs/v1.0
> + =A0 =A0 =A0 S: ....a3c2e2402b99163d1d59756e5f207ae21cccba4c refs/ta=
gs/v1.0^{}

Shouldn't this contain HEAD as the first ref?

> + =A0 =A0 =A0 ref_list =A0 =A0 =A0 =3D empty_list | populated_list
> +
> + =A0 =A0 =A0 empty_list =A0 =A0 =3D PKT-LINE(id SP "capabilities^{}"=
 NUL cap_list LF)
> +
> + =A0 =A0 =A0 non_empty_list =3D PKT-LINE(id SP name NUL cap_list LF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ref_record

Does this need a s/non_empty_list/populated_list/ ?

> + =A0 =A0 =A0 cap_list =A0 =A0 =A0=3D *(SP capability) SP

You never define capability.

> + (c) Send one $GIT_URL/git-upload-pack request:

I don't think you documented what $GIT_URL/git-upload-pack means.

> + =A0 =A0 If the client has sent 256 HAVE commits and has not yet
> + =A0 =A0 received one of those back from S_COMMON, or the client has
> + =A0 =A0 emptied C_PENDING it should include a "done" command to let
> + =A0 =A0 the server know it won't proceed:
> +
> + =A0 =A0 =A0 C: 0009done

This should probably move down to after you define what S_COMMON is in
the first place.


> + =A0 =A0 Here a "closed set of objects" is defined to have at least
> + =A0 =A0 one path from every WANT to at least one COMMON object.

A 'path from' is perhaps a bit unclear.

--=20
Cheers,

Sverre Rabbelier
