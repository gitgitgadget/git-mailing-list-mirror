From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 12/12] pretty: support %>> that steal trailing spaces
Date: Sun, 17 Mar 2013 05:06:31 -0400
Message-ID: <CAPig+cSzHuSnT2+e+U+zJtOUtReUo=3JWZDQcCbMKS4ibZtjvA@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
	<1363400683-14813-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 10:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH9YS-0005mb-UH
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 10:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab3CQJGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 05:06:33 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:41845 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053Ab3CQJGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 05:06:32 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so5006806lab.21
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pOppAp/me+t1nN61/dLzNF2/iTnhLpQM0JBzhzWwHPo=;
        b=MfQtXK74RnFDPcm5ee6G6jY8AY1EAFRnzeIalIt61vdyPsHD2qnFZG2mty/FEkxzV5
         oaq2IBYaQemUieH3nXKFZuz7d2HdgEnHcG3lUpj1tiCxFOcJ3v1EFhD3EgedU3XUgLmX
         vh4TlyntIlDxzc2KdsbJmqcCFAemdEE6dw2LiZX49vbviQ5ZN1E8DdyQ/F//1PaWTA0L
         F9QZZk3LPVxdNsVtRKLrRkjJ569aAhNDTnqPo0WmWH3+ThGQtlv01QnlisaiUaTllEZa
         BHTKo6/wWPPSRSBRSYyz2JxUPH6shQ5PbGvnfEhHesePlm7/EFt7KC8zK5+f1JH546IK
         ecEQ==
X-Received: by 10.112.134.166 with SMTP id pl6mr4804186lbb.68.1363511191474;
 Sun, 17 Mar 2013 02:06:31 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 17 Mar 2013 02:06:31 -0700 (PDT)
In-Reply-To: <1363400683-14813-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Z8tQ38Whx8rf8yURH93NlPBdmZY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218358>

On Fri, Mar 15, 2013 at 10:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> This is pretty useful in `%<(100)%s%Cred%>(20)% an' where %s does not

s/% an/%an/

> use up all 100 columns and %an needs more than 20 columns. By
> replacing %>(20) with %>>(20), %an can steal spaces from %s.
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 17f82f4..036c14a 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -170,7 +170,10 @@ The placeholders are:
>    columns, padding spaces on the right if necessary
>  - '%>(<N>)', '%>|(<N>)': similar to '%<(<N<)', '%<|(<N<)'
>    respectively, but padding spaces on the left
> -- '%><(<N>)', '%><|(<N>)': similar to '%<(<N<)', '%<|(<N<)'
> +- '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N<)', '%>|(<N<)'

s/<N</<N>/g

> +  respectively, except that if the next placeholder takes more space=
s
> +  than given and there are spaces on its left, use those spaces
> +- '%><(<N>)', '%><|(<N>)': similar to '% <(<N<)', '%<|(<N<)'

Ditto: s/<N</<N>/g

>    respectively, but padding both sides (i.e. the text is centered)
