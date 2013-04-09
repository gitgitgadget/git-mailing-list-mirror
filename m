From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: Make feed title valid utf8
Date: Tue, 09 Apr 2013 20:27:37 +0200
Message-ID: <51645D99.6000106@gmail.com>
References: <m2y5csbx91.fsf@blackdown.de> <51642F67.5010501@gmail.com> <m2r4ija9gh.fsf@zahir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdGv-0004BG-Rg
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935198Ab3DIS1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 14:27:43 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:48007 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361Ab3DIS1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:27:41 -0400
Received: by mail-ee0-f53.google.com with SMTP id c13so3107696eek.40
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=G5d5AaSdGF/MtzV5NNImKCBWS+C16sjlydviv5AXWhs=;
        b=EfEyRDs6AbS82rXTQlYa399gKelsRnn8Tg2rqduEjsOomDEcmoeHJVIm7R1mVitdbG
         gKSKusNpQcZWTwU2YZg+1TkvGR1+1zjeNWVuN32V6m0W/wf3KAdadmGoXewATUQmVlLm
         uEtPDOt/08tvTesgWPSzJLnSkqyH3Z2oERyeVpQtDY3KBCFnH84AymRdNWfWUWsH5iN3
         e8EnbKAhtDYFcDKAyH22swrLjAtMquJWK1jLqq5goS9uyFy/9oomPwYVoKxtitT5m+Wq
         zk2mav/P+fEDXrRXNf8vWeNGjPYC1H81nw9GNJ7Fwx65fW2hdsbr5/esYbxKnWFiWEp0
         qwIg==
X-Received: by 10.15.41.2 with SMTP id r2mr7990957eev.20.1365532060023;
        Tue, 09 Apr 2013 11:27:40 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id s47sm39489851eeg.8.2013.04.09.11.27.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 11:27:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <m2r4ija9gh.fsf@zahir.fritz.box>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220609>

W dniu 09.04.2013 19:40, J=C3=BCrgen Kreileder napisa=C5=82:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>> J=C3=BCrgen Kreileder wrote:
>>
>>> Properly encode site and project names for RSS and Atom feeds.

>>> -	my $title =3D "$site_name - $project/$action";
>>> +	my $title =3D to_utf8($site_name) . " - " . to_utf8($project) . "=
/$action";

>> Was this patch triggered by some bug?
>=20
> Yes, I actually see broken encoding with the old code, e.g on=20
> https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Drss
> my first name is messed up in the title tag.
>=20
> New version: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Drss
>=20
>> Because the above is not necessary, as git_feed() has
>>
>> 	$title =3D esc_html($title);
>>
>> a bit later, which does to_utf8() internally.
>=20
> Good point.  But it doesn't fix the string in question:
> It looks like to_utf8("$a $b") !=3D (to_utf8($a) . " " . to_utf8($b))=
=2E

Strange.  I wonder if the bug is in our to_utf8() implementation,
or in Encode, or in Perl... and whether this bug can be triggered
anywhere else in gitweb.

What Perl version and Encode module version do you use?
--=20
Jakub Nar=C4=99bski
