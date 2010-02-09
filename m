From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 0/4] Some improvements for git-imap-send
Date: Tue, 9 Feb 2010 16:13:26 +0100
Message-ID: <40aa078e1002090713h7e7d2f93r4cca9649e98db735@mail.gmail.com>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
	 <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <20100209150650.GA15982@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, gitster@pobox.com,
	git@vger.kernel.org, jwhite@codeweavers.com,
	robertshearman@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 16:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NermV-0006Dl-0E
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 16:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab0BIPNa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 10:13:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:12236 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab0BIPN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 10:13:29 -0500
Received: by fg-out-1718.google.com with SMTP id e21so409472fga.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HRwKiGvvtU35x9XF4oYRWk1RiaBfCVTitdj/HywhJEQ=;
        b=bje5n4fhq6Uumb5mYNY5ntEeHQMegsnkA6MTA2xnsg7DvhSvCEVtFU4XdOnCHTW+iM
         b+IUhth20QrsOoB9a69fs/R0h4XZdOBJOJwhSgSkubpAUDaY8kvQu7PGlrq9NpUjMMZD
         1eMPIGvc2+gbq+an7H/taVKxpr1no9T6RIRdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=hTURaNqFtW34hL7lYITR/JtzLoZhCoeUPMg8j1VVj4Tw6KOSCP9NEaI4bXQm+FQDvd
         QMmxaBcSa1bT+vSWcfVzfqfVABNanSg1OgAwh29ufegh/QD++Ne4wKd2gHsEjZmwqDgR
         yZVbtOtDkfsMHURSmMuw8OlOoBBvaulQ2o5p8=
Received: by 10.216.87.67 with SMTP id x45mr1543370wee.18.1265728407549; Tue, 
	09 Feb 2010 07:13:27 -0800 (PST)
In-Reply-To: <20100209150650.GA15982@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139409>

On Tue, Feb 9, 2010 at 4:06 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 09, 2010 at 09:09:01PM +0900, Hitoshi Mitake wrote:
>
>> =A0base64.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0122 =
++++++++
>> =A0base64.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 36 =
+++
>> =A0md5.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A060=
0 +++++++++++++++++++++++++++++++++++++++
>> =A0md5.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 6=
1 ++++
>> =A0md5_hmac.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0137 ++=
+++++++
>> =A0md5_hmac.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 36 ++=
+
>
> That's a lot of extra code. Doesn't imap-send already conditionally
> compile against openssl for starttls support? Can't we just get all
> three of these algorithms from openssl?
>

I don't think OpenSSL includes SASL-support that is needed for
STARTTLS. But it might make sense to use something like GSASL[1]
instead of rolling all the SASL-mechanisms ourselves.

[1]: http://www.gnu.org/software/gsasl/

--=20
Erik "kusma" Faye-Lund
