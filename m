From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 3/4] attr: do not attempt to expand when we know it's
 not a macro
Date: Tue, 9 Dec 2014 18:27:39 -0500
Message-ID: <CAPig+cSej-7iFOJcprEnkqhsbt87htZ+OB37HE6RuiXdG_F3Yw@mail.gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
	<1418133205-18213-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:27:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyUC3-0008PV-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbaLIX1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 18:27:41 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:64132 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbaLIX1j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 18:27:39 -0500
Received: by mail-yh0-f43.google.com with SMTP id z6so774025yhz.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 15:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qaoyi+xT7IDBtIn+91EFRruEHPmHoNiwxFeWwqR0xGg=;
        b=SRwAU0TOb0u0X2Tj4viVttjkQovoC44Qd2C4RfOT2N9GNKdaAyVXMv4rrKtoJyKD86
         X0P4tkxrBICAOXPBgPYQpG6Gt8u4emA6yUrYB6SqVXv+aZaIshHP72OyG5oIvaAuBN2K
         aN67usNir0LkNlCD8tMUaNap9MawYLYSq5Cy15VY1ZvbpikW0hMYxpO9q+5KWVAQ+Aj8
         vPTZlN2RNxsBolfP98o+sOyrgnVZ9aDt9AXdc7Z/qHKqZzIVDHLHdIDcdVvKIWCjWaj7
         x13Eqr0LJpv62rxNvmAU0cHSSodYrj7vsIBex4djgCBYe1X1wfstbivVssNW4gqPlQ2U
         c02A==
X-Received: by 10.236.206.74 with SMTP id k50mr543777yho.180.1418167659072;
 Tue, 09 Dec 2014 15:27:39 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 9 Dec 2014 15:27:39 -0800 (PST)
In-Reply-To: <1418133205-18213-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: RA-T8WQzLAaB2VvL4SrFVXxtQYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261177>

On Tue, Dec 9, 2014 at 8:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Keep track of all recognized macros in the new "maybe_macro" field.
> This this field is true, it _may_ be a macro (depending on what's in

s/This this/If this/

> the current attr stack). But if the field is false, it's definitely
> not a macro, no need to go through the whole attr stack in
> macroexpand_one() to search for one.
>
> Without this, "git grep abcdefghi" on git.git hits the inner loop in
> macroexpand_one() about 2500 times. With this, it's about 60 times.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
