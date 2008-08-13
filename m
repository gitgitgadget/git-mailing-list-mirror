From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/3] git-svn: Reduce temp file usage when dealing with
 non-links
Date: Tue, 12 Aug 2008 23:42:50 -0400
Message-ID: <48A2583A.1000509@griep.us>
References: <1218470035-13864-4-git-send-email-marcus@griep.us> <1218556876-26554-1-git-send-email-marcus@griep.us> <20080813032956.GC5904@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:44:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT7HF-0001VG-1r
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbYHMDm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 23:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbYHMDm6
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:42:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:3391 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbYHMDm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:42:57 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1921492wxd.4
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=jhjh28mzOmqWJUqu00Yyr/iHqM5OpqtmRdNr031JCKI=;
        b=wnywr8UcG/mx8GMGinMuYRsL4EVxm6+xOLpxo6KbfhYdjdRE9sFEAO+gwL/P9fcQRa
         ia7q9TxKgPa0s1kVS/z08bMdHBiW+yjiR7Pk3lb12Yjsc9Jhqj1cq4WtzZdkzoRiNNkq
         eeiy/VyU76TM32m/DByUkD56mkEsCb7go4FO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=UAARtIHUazBdnMQFOtJ45psgv8n+wd49LBACcZsSO/vfIGtX/0OmPWoBEKUGEDKtIj
         sUG4pN6doiG1El8pkNqT+IItv1AwjCnW2JL3iOQnJb53gPb26vlqnwuSWvYFiPImJ073
         b2/JfEEBoJ7w2B9m1/vDbZirLpXmCSW97UJpA=
Received: by 10.70.20.10 with SMTP id 10mr13418356wxt.36.1218598976853;
        Tue, 12 Aug 2008 20:42:56 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id i37sm2940629wxd.29.2008.08.12.20.42.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 20:42:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080813032956.GC5904@untitled>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92176>

Eric Wong wrote:
> Thank you Marcus!
>=20
> Acked-by: Eric Wong <normalperson@yhbt.net>

Errr, you want to Ack [PATCH v2 3/3]; not this one; there's one minor
typo when I shortened the variable $result to $res.

>> +				my $res;
>> +				while ($res =3D sysread($fh, my $str, 1024)) {
>> +					my $out =3D syswrite($tmp_fh, $str, $res);
>> +					defined($out) && $out =3D=3D $res
>> +						or croak("write ",
>> +							$tmp_fh->filename,
>> +							": $!\n");
>> +				}
>> +				defined $result or croak $!;

That last line causes compilation errors with 'use strict'.  It is fixe=
d
in the alternate version.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
