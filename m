From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] log-tree: fix patch filename computation in "git 
	format-patch"
Date: Thu, 26 Mar 2009 21:31:05 -0700
Message-ID: <780e0a6b0903262131l26e9ea6ua3289925fd322d93@mail.gmail.com>
References: <20090327011301.a5185805.chriscool@tuxfamily.org>
	 <7v3acziot0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 05:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln3kG-0008Bf-EF
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 05:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbZC0EbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 00:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZC0EbI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 00:31:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:19571 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZC0EbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 00:31:07 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1096931wff.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 21:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sg6tLgw3naiX4pW+2IhDv7VtsKlAZfCdHVYg7CfQQdA=;
        b=ADSA/deNwqOyvCsMRiDG0Ovam16zEvZKZNw1cnKSU+qvrDajyV/bAnBbHbgslM6rHL
         gZ4cVra160r/IqoEBRHHVWoa7OTrZAH3XKgqcydcYER0SD3G+0aNo12M4+pFVFkOog6C
         nzxn/FSEsjlh/s8bt1+46rWfDwyRDY07h8rlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U6KO4ZZvTM6SSYaKfO8v0KHxrpsJyMYzA6Ch3SJY1wEYm6HyaVsllpRGVBi6ZcabFk
         ctV07SmfG3vI99ergb+rtKcZgMurar229G1BJNBQVFfFsujGMeQcA271RaXMW1QrcJgb
         gORAO7BoYdCkX0Qgoncb58ChdVPSmqo1pMoD8=
Received: by 10.142.142.14 with SMTP id p14mr703550wfd.188.1238128265184; Thu, 
	26 Mar 2009 21:31:05 -0700 (PDT)
In-Reply-To: <7v3acziot0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114847>

On Thu, Mar 26, 2009 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Shouldn't it be just:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t max_len =3D start_len + FORMAT_PATC=
H_NAME_MAX - suffix_len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (max_len < buf->len)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_setlen(=
buf, max_len);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addstr(buf, suffix);

Yes, this is good.

>
> The caller must make sure that suffix_len is sufficiently shorter tha=
n
> FORMAT_PATCH_NAME_MAX; I do not know if the current code does that,
> though.
>

The original code never did this. What should happen in this case?

I am away on travel this week, so I won't be able to update this until =
Monday.

Thanks,
Stephen
