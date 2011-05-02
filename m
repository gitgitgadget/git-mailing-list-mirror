From: Csaba Henk <csaba@lowlife.hu>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Mon, 2 May 2011 14:08:28 +0530
Message-ID: <BANLkTimMCsXuP45WFDG-1FvkicLm5idKEQ@mail.gmail.com>
References: <ipek0o$l0v$1@dough.gmane.org> <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
 <20110429224829.GC3434@sigill.intra.peff.net> <7vk4ecvf2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 10:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGoed-0008Hy-GU
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 10:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782Ab1EBIiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 04:38:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36840 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1EBIit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 04:38:49 -0400
Received: by wwa36 with SMTP id 36so6117679wwa.1
        for <git@vger.kernel.org>; Mon, 02 May 2011 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dptLNi/YD6hgB/OWhbjQX+0HYh6rQ+DAYKVXYJYZj3w=;
        b=Lp1CKdOZQ7h7zynIevcKTO3VI44wgIcnzz78vspKyW26x/D3YNy+BYlZ35Kq4byzWH
         5D8sDJqXkz0DhoIbOloisoRcE5DWVW4TC7+IoE2moNbv7mpcqnwd6REny6lAP8NtyqhJ
         ylM9nUNEc5E0Q/0fxAdrOO5cbmt4GfTAqaelM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=xbksaX/zeu+WfPLLhGSNIwosLduSuUPyRhfAxxHE9v/UqMZUTFiLWjL7388nniCise
         bPjQ3gM44hbtkYhyA7v6GmSxFK4p8/Jv33lUMKW08C1hVykyPaCpkqid3UsIKfIIxz09
         zUGkQgagqJ0yyNM9zidwHnDBS2f2tY9CeL1Bk=
Received: by 10.216.24.73 with SMTP id w51mr7649655wew.72.1304325528103; Mon,
 02 May 2011 01:38:48 -0700 (PDT)
Received: by 10.216.186.143 with HTTP; Mon, 2 May 2011 01:38:28 -0700 (PDT)
In-Reply-To: <7vk4ecvf2c.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: fyJ1kycYLm48uRanLDFDJP2PYzo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172565>

On Sat, Apr 30, 2011 at 4:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> I think every caller should be using "-m" these days. =A0I know we c=
an't
>> _require_ it for historical reasons. But shouldn't symbolic-ref alwa=
ys
>> write a reflog entry? Even something like "we changed and I can't te=
ll
>> you why" to cover older scripts that call symbolic-ref?
>
> I think the particular instance Csaba saw in rebase may want to pass =
the
> reason why it flipped the HEAD.
>
> Flipping HEAD temporarily to another ref to do something, only to fli=
p it
> back before giving the control back to the user, might be something a
> script may want to have a choice of not logging, so I am mildly negat=
ive
> on changing the command to unconditionally log empty entry without be=
ing
> told.
>
> "update-ref" seems to write an empty entry even when not given an "-m=
"
> option, and we can view it as robbing a similar choice from the scrip=
ts.
> We might want to fix it. =A0I dunno.

What if symbolic-ref and/or update-ref were changed so that the default
invocation would add a reflog entry with a default (empty?) note, howev=
er,
also provide an option with which suppressing the reflog can be request=
ed?

Csaba
