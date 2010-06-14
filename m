From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [PATCH v2 3/3] t/t8006: test textconv support for blame
Date: Mon, 14 Jun 2010 09:52:48 +0200
Message-ID: <AANLkTikZCtymKUgD3uYj7kU3HDuo2Y-oJr2f10CKRbgU@mail.gmail.com>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275924218-20154-3-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<7vd3vxgm9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 09:53:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO4To-0001HN-TR
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 09:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab0FNHxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 03:53:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57622 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab0FNHxG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 03:53:06 -0400
Received: by fxm8 with SMTP id 8so2291752fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=w5aLXJHIKLNruqOx8LHBVXqRsxckgz1HIUoawLQeCeA=;
        b=wJEkcD/Uu4JF/dAwitaNe6B4jcTuAGNSCj+/mQvh6UWRvXFMuyb/PAg8yIx7tHs8q+
         /zfyc7SjXiAci9luJLs09BIQDZwQVYdi6IX7mdPTbTiFqblg08jtMjO4Gbpo/dTmhjPj
         RugO0rzhIEZd1+H+Y2LIz5FQP6wA5p+fpP/JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=maHdi+pFISG15tqHjGQP7HVQ1FJZTLQCRCat55tgBYjnE6jBX9wcnfMiiFLHYMGr9Y
         jDuR+t7B4Q+3dLHS7mZCnS8qqXyLH5CjWqOo3CKtn+SjjHmE4AIiWoySKBkFOozSGAp5
         ZoatEdYtQeUdZSTfGsE9ZZ67SiLzkiIvdZWpA=
Received: by 10.239.129.197 with SMTP id 5mr371289hbg.32.1276501983136; Mon, 
	14 Jun 2010 00:53:03 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Mon, 14 Jun 2010 00:52:48 -0700 (PDT)
In-Reply-To: <7vd3vxgm9x.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: OEhpmPqq7k-w5aDt6HaNC5kPrqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149084>

Le 12 juin 2010 01:52, Junio C Hamano <gitster@pobox.com> a =E9crit :
> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
>
>> Test the correct functionning of textconv with blame <file> and blam=
e HEAD^ <file>.
>> Test the case when no driver is specified.
>
> Good to see tests for both positive and negative cases. =A0Too many p=
eople
> forget the latter.
>
>> +find_blame() {
>> + =A0 =A0 sed -e 's/^.*(/(/g'
>> +}
>
> Two issues:
>
> =A0- No need for "g" as your pattern is anchored at the left;
>
> =A0- As ".*" is greedy, you will eat a lot more than what you expect =
when
> =A0 the line in the blamed contents happen to have '(' on it.
>
> I'd rewrite it as:
>
> =A0 =A0sed -e 's/^[^(]*//'
>
> Will queue all three patches, with this fix and a style fix for 2/3; =
no
> need to resend.
>
> Thanks.
>
Thanks. And thanks for fixing.
