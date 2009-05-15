From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 17:51:09 +0200
Message-ID: <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	 <op.utwdsutn1e62zd@merlin.emma.line.org>
	 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
	 <op.utwyczlf1e62zd@merlin.emma.line.org>
	 <20090514182249.GA11919@sigill.intra.peff.net>
	 <op.utxydvnu1e62zd@merlin.emma.line.org>
	 <20090515020206.GA12451@coredump.intra.peff.net>
	 <op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain>
	 <4A0D8211.5010806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 15 17:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4zgt-0005Ld-Kw
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 17:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbZEOPvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 11:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZEOPvK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 11:51:10 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:46256 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbZEOPvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 11:51:09 -0400
Received: by bwz22 with SMTP id 22so1991388bwz.37
        for <git@vger.kernel.org>; Fri, 15 May 2009 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NMsOTb55FJmQ47cE8ZxSVJzJ7oImZlZuDRjJmgz771U=;
        b=iQm0obNG2UGCuXFHbczk4ENJj2SKUzdeMwFu15VGPImIgBdoZgqbGWiB8i2UdBaE3D
         9CpKM09uU2e7Adk0AnXBEtxu7DewSRmGmMAU39wayrpzj+vYuK1TkxypCHu28wruJOJ0
         ixFT+WsBlsqLni3aYOKyjJ+PdlFPXCjxta1NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ftmAoow7y2u3SLuNPIDlSFNLfAslSmJ0oWmn6wGUikvKvAiNyHvBtcZYiuUnFRwsYv
         OptgPhn27iIbJs83DexbRfd/Iti2JxP+ipQrW71yBX6ZegfOk+F9/ckiswP1hqWVDEQ9
         Ec8vN7V9d9OdUzZ2sqBH6yYCJjoh422hLd1C0=
Received: by 10.204.31.201 with SMTP id z9mr3468696bkc.79.1242402669129; Fri, 
	15 May 2009 08:51:09 -0700 (PDT)
In-Reply-To: <4A0D8211.5010806@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119259>

2009/5/15 Johannes Sixt <j.sixt@viscovery.net>:
> Jakub Narebski schrieb:
>> "Matthias Andree" <matthias.andree@gmx.de> writes:
>>> =C2=A0 =C2=A0 =C2=A0commit <-- signed-by-- NIL (removed) <--signed-=
by-- tag1.
>>
>> THIS IS A FEATURE, NOT A BUG.
>
> Please stop it. Everone agrees about this.
>
> Matthias only wants a patch like below. Matthias, if you are serious =
about
> it, please pick this up and turn it into a proper submission. I don't=
 care
> enough.
>
=2E..
> + =C2=A0 =C2=A0 =C2=A0 if ((tag_object =3D (struct tag *)parse_object=
(object)) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag_object->object.type =3D=3D O=
BJ_TAG &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag_object->tag &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !strcmp(tag_object->tag, tag)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("A tag canno=
t tag itself. If you meant to tag the commit");

If it ever turned into submission, I'll always patch this out. It is st=
upid.
