From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-email: use catfile() to concatenate files
Date: Tue, 14 Sep 2010 13:35:40 -0700 (PDT)
Message-ID: <m3iq28kqs4.fsf@localhost.localdomain>
References: <1284490944-16964-1-git-send-email-avarab@gmail.com>
	<7v7hio86tz.fsf@alter.siamese.dyndns.org>
	<AANLkTim7y3qUqQ4TN4w9+5qwR-uLmCP=dTKnMUSnqUrP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 22:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvcEV-0005X1-RH
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 22:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0INUf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 16:35:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51605 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0INUf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 16:35:56 -0400
Received: by bwz11 with SMTP id 11so5915978bwz.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=g6VhsxfeVrNVyDBtGQU+Upz0A4FdTa2u+FQv8W6X6pI=;
        b=hz2Yg7+T/1zUSWyWQJ0vEdLgsNEdW/8PqnGU8jDa4NSwxfOWAtpPpXgRRvYaQlOLio
         3A8fZ3akfRxzx1YP3thc8bUBN8zOr3t4k4wpWGxIAex9kObTBVB6P/kTb3LIk/uJzqBM
         pu2euuau5JXTco2IJbiZYGM/Md4JLi6scG3Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=i/ETJJzQ75Asy1c7cyCs/lRwwYuQBUiJIrdmy2BeSyLM5aU1S6GPa+U7IIK1xH7Yhu
         X96iE1d7FPeaQYi4RgtCKfjYc+TESISL6I2a/GIv5kq42X6KRqj49Ru6V+HjPLcQslGX
         Zqowx924XIhRWKW+UI7vmp+sTWF2965ac0loo=
Received: by 10.204.48.75 with SMTP id q11mr480494bkf.0.1284496542298;
        Tue, 14 Sep 2010 13:35:42 -0700 (PDT)
Received: from localhost.localdomain (abwn161.neoplus.adsl.tpnet.pl [83.8.237.161])
        by mx.google.com with ESMTPS id 11sm580724bkj.23.2010.09.14.13.35.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 13:35:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8EKZ81i024767;
	Tue, 14 Sep 2010 22:35:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8EKYqQQ024763;
	Tue, 14 Sep 2010 22:34:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTim7y3qUqQ4TN4w9+5qwR-uLmCP=dTKnMUSnqUrP@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156209>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
> On Tue, Sep 14, 2010 at 19:26, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Change send-email to use Perl's catfile() function instead of
>>> "$dir/$file". If send-email is given a $dir that ends with a / we'l=
l
>>> end up printing a double slashed path like "dir//mtfnpy.patch".
>>>
>>> This doesn't cause any problems since Perl's IO layer will handle i=
t,
>>> but it looks ugly.
>>>
>>> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
>>
>> If you mentioned in the proposed log message that File::Spec::Functi=
ons
>> have been with us since Perl 5.6.1, it would have saved me (and othe=
rs)
>> some time worrying about the portability issues.
>=20
> I thought you might trust me to write portable code by default :)
>=20
> Anyway, I forgot to mention it. But one can use the corelist(1)
> program to see when what modules appeared in perl core:
>=20
>     $ corelist File::Spec::Functions
>     File::Spec::Functions was first released with perl 5.00504

Also using File::Spec / File::Spec::Functions makes code more portable
(with respect to things such as different directory separators, and
volume portion of pathname) than using "$dir/$file".

--=20
Jakub Narebski
Poland
ShadeHawk on #git
