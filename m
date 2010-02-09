From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon, 8 Feb 2010 23:00:14 -0500
Message-ID: <76718491002082000s7be5b32dob5b3dfe764b12da0@mail.gmail.com>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
	 <7vtytrrrju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 05:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NehGx-0001hU-Vu
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 05:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414Ab0BIEAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 23:00:17 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:36764 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0BIEAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 23:00:16 -0500
Received: by iwn12 with SMTP id 12so8162202iwn.26
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 20:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8imxx2s01CQw1LmDvuKuHemMvjRpVxpGAhkOJBAzE3M=;
        b=YoW0OSBoqBzPJpEm60TK/jA2LDePue87vcnN9ibIuAPS6Ki4yKEJ1/H4SkTdGspshl
         uhWnbo2vXooPEy3kgXr2yObN5D8Ujm+aiYqdeitmALjiDGAONR1URmJaVOe/xAOBMnoe
         CPmoeXoC1CaYB0s39mc3DU7ViUCH1QQMVH2EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bA+6cKXQOlNSrMHaNe8p7RekkZ0EkiuPkvV8yrI44YQ6H/M7lZ0xbM2AABEaeggCMh
         QmWELlqOLcCu0VEZ4okSHNQh/o+i+r6thEnHKVDywS3oP5iu/hcey0ydqfY2jMegWoV5
         bmlLe9S7T/yblK/tWmipLgMyFGVQdsvLKeKBU=
Received: by 10.231.170.201 with SMTP id e9mr1031159ibz.15.1265688014788; Mon, 
	08 Feb 2010 20:00:14 -0800 (PST)
In-Reply-To: <7vtytrrrju.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139358>

On Mon, Feb 8, 2010 at 10:55 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> - =C2=A0 =C2=A0 if (lno < top)
>> + =C2=A0 =C2=A0 if (lno < top || lno < bottom)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("file %s has on=
ly %lu lines", path, lno);
>
> Thanks; I think we make sure that "bottom < top" always hold true bef=
ore
> we reach this point,

We swap them if they're reversed.

> so checking with bottom alone should suffice, no?

Ah true. You can squash that in? :-)

j.
