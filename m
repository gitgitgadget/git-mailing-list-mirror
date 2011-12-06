From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 13:17:39 +0100
Message-ID: <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 13:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXtyc-0003n5-7k
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 13:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933467Ab1LFMSV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 07:18:21 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39841 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933307Ab1LFMSU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 07:18:20 -0500
Received: by dadv6 with SMTP id v6so5128210dad.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 04:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=JkOWssaLUfBIGzziEPLeXitwB1gKO4AgN3uoLqc/gD8=;
        b=Ww3IN5OR6PMe2OjpAPefhbuJq1ouVkaZ88R13wGcfXyL1pILqfAtsDWMMI6MZ+u/tq
         HlErym5zPpqgJ/pNaNJM0dIVqyZT1poDqCeucF/w5NafbCQLAlkaQaJRjDYWxgivbo5j
         TxlbNp6mqTz77EdqhHlUxXUhth+QTCKv0DCqk=
Received: by 10.68.38.71 with SMTP id e7mr32053339pbk.88.1323173900163; Tue,
 06 Dec 2011 04:18:20 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Tue, 6 Dec 2011 04:17:39 -0800 (PST)
In-Reply-To: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186344>

2011/12/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Too deep delta chains can cause stack overflow in get_base_data(). Se=
t
> a hard limit so that index-pack does not run out of stack. Also stop
> people from producing such a long delta chains using "pack-object
> --depth=3D<too large>"
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0I used to make very long delta chains and triggered this in ind=
ex-pack.
> =C2=A0I did not care reporting because it's my fault anyway. Think ag=
ain,
> =C2=A0index-pack is called at server side and a malicious client can
> =C2=A0trigger this. This patch does not improve the situation much, b=
ut at
> =C2=A0least we won't get sigsegv at server side.
>

Wouldn't it make more sense to make the limit a config option rather
than a hard-coded value of 128 (which seems arbitrary to me)? After
all, different platforms have different stack-limitations...
