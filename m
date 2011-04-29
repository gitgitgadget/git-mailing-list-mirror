From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Fri, 29 Apr 2011 09:46:09 +0200
Message-ID: <BANLkTinGn0WFNm805PeWuTp+71yby1ySNw@mail.gmail.com>
References: <20110427213502.GA13647@elte.hu> <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
 <20110429072604.GA16371@elte.hu> <20110429073825.GA16941@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Apr 29 09:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFiPf-0006mx-Ig
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 09:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386Ab1D2Hqu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 03:46:50 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53629 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318Ab1D2Hqt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 03:46:49 -0400
Received: by qyk7 with SMTP id 7so139617qyk.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=iQ/jcYWbh1ml7bW20l60qUiNuS44yI3SM23XCJbkyPw=;
        b=xnbkJo1UQWLe6TSDMyRpZwZWr25rW8FZJAVxdReHjhW7yn8K8dXS/Nww2Sxb118NsN
         +3TkhbHmMrnoVFSlaEdnhFg76sxPfyW759Vj3Hhfaok8xMNrb0OCKuJIj3AwZs0hSLed
         qHfMWadkHaKQ7O6x5LKkKlp6CTj9AWHfH1y90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VbQid6JUfY2eHR9miCJ8Ry7XTYA4gs5yqEsYlSMLwPNOq0M430i9ubkRWbkrtywvM2
         b9Hhl2qZTATD40zEy6CPG+S61PnJN74Jl/WafwRo1dtOHivfhpFAvroHkWjj3LIM13Ft
         gkrb7ce+zhyxUMEuSQmtY/NSrrCxge72uDekU=
Received: by 10.229.36.67 with SMTP id s3mr3709096qcd.60.1304063209070; Fri,
 29 Apr 2011 00:46:49 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Fri, 29 Apr 2011 00:46:09 -0700 (PDT)
In-Reply-To: <20110429073825.GA16941@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172433>

Heya,

On Fri, Apr 29, 2011 at 09:38, Ingo Molnar <mingo@elte.hu> wrote:
> =C2=A0 16: =C2=A0 =C2=A0 =C2=A09,402,077,866 cycles:u =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # =C2=A0 =C2=A02.987 GHz =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0( =
+- =C2=A00.20% )
>
> They are utterly unconvincing - there seems to be no improvement, it'=
s all
> within noise.

Is this in a different repository from the one you ran the numbers on
initially, or did something else change to negate that 12.2% decrease?

--=20
Cheers,

Sverre Rabbelier
