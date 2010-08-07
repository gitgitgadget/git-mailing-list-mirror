From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-object: trim memory usage a tiny bit
Date: Sat, 7 Aug 2010 10:03:40 +1000
Message-ID: <AANLkTikL8MtqFr1T=3TKA7GLKSEbyvf+6SLTT2BYehto@mail.gmail.com>
References: <1281114057-5982-1-git-send-email-pclouds@gmail.com>
	<AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 02:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhWt9-0008Ns-A8
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 02:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab0HGADn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 20:03:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50978 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0HGADm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 20:03:42 -0400
Received: by wyb39 with SMTP id 39so8309834wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=luhqSVNiMwsfEbW2DXD1qYRWsshbPhdWKd+zpOeWvd8=;
        b=gcTq/CzWrRwygk92GAkdmeY2O/ZZ1TIrLzVaaZ2DtEn0NUpkkBpJ5peD0Nkj4gVb4E
         oPJ6AVSjkQEwe4a9xDZhD09b0U7q6dfxG4XfLIfPjOSa5fz2mOU3rAJbPlCb7Gedo5e6
         ZIbJoZp26jFBhwMiKFsHQpnddXS0Icj/QNevc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vHOcFEeBuMeZLop4rdkcewbg3MInnH/15MpJjM74IbA4GMJoA76kIbq17TOmsXjfPD
         ChqCBtkOrPsuSwPuh6DlqsNMVgcshKoVKu+qgLCEd1FWgtltZG0+0ibEmKQS2Sha2VzY
         O8FZLKozWIdc2+mmFcuFKr8K77LRS4tGs95qI=
Received: by 10.216.159.72 with SMTP id r50mr11201502wek.92.1281139420639; 
	Fri, 06 Aug 2010 17:03:40 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 6 Aug 2010 17:03:40 -0700 (PDT)
In-Reply-To: <AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152827>

2010/8/7 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/8/6 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> This shrinks struct object_entry from 88 bytes to 80 bytes on my 32
>> bit machine. So that would be 12M less on linux-2.6.git (1.6M object=
s)
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0Don't know if it's really worth a patch..
>
> Either way, some explanation would be nice.

struct object_entry is allocated for every object to be packed. So if
you do a clone on linux-2.6, you would need 1.6M of those structs, 88
bytes each. I cut 8 bytes from each of them.
--=20
Duy
