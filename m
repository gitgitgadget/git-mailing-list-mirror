From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <totte.enea@gmail.com>
Subject: Re: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Wed, 08 Dec 2010 17:25:44 +0100
Message-ID: <4CFFB188.6000006@gmail.com>
References: <4CFA27E0.8070308@web.de> <20101206192326.GA12383@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 17:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQMq8-0005KE-Sn
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 17:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0LHQZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 11:25:55 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:41683 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0LHQZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 11:25:54 -0500
Received: by eyg5 with SMTP id 5so1028752eyg.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1oNxFDMRjSmtFDXjVIRi+W/Zx7td/tnZAmql06ac9XQ=;
        b=nRhxzzKRN/D88XPqm6VLYU7vYoxcRH8ppmVgHvFuvpSGV30Kg3ucx1e2n8cIrvByMj
         o9IHv1ZAAl++SIAbgzLftKvCU2NoMaUmLuO14F6VhZZfgw00kYfNiwggKdK9lPmY2SJm
         lgKl9AYl5hFN2NOuFI2I6GiTycjDAuIkoLPj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tRUfJiMujRCnFEqOZ5WODYqIb0Ivm2q1ZYES70DWRrlbOsBhdwQIMuBDWuj9XhmBXO
         HzJ8Tpadu2kHUcLYHqT7/EfTEkea3on8dp8hFwj6Jt+jtUOWI1rfNwyPO+bf5GeMxCUH
         FSTKr6zzrRprMhxoPLyagl+SEAmhcmh64zr9g=
Received: by 10.213.109.15 with SMTP id h15mr217753ebp.64.1291825552518;
        Wed, 08 Dec 2010 08:25:52 -0800 (PST)
Received: from [192.168.209.23] (h195n4fls31o954.telia.com [213.64.3.195])
        by mx.google.com with ESMTPS id x54sm530576eeh.11.2010.12.08.08.25.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 08:25:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
In-Reply-To: <20101206192326.GA12383@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163204>

On 12/06/2010 08:23 PM, Eric Wong wrote:
> Torsten B=F6gershausen<tboegi@web.de>  wrote:
>> Commit df73af5f66 is does not let the test case fail,
>> when Compress::Zlib is missing.
>> But:
>> On a MacOS X 10.6 system with missing Compress::Zlib
>> using svn version 1.6.5 (r38866) the gz file is created.
>> Solution:
>> Check for the existance of the unhandled.log.gz file.
>
> I wonder if your system could have multiple perl installations and
> git-svn is calling one while the shell scripts are calling another.
> I'm not sure if there is another way the gz file could be created whi=
le
> Compress::Zlib is missing.
>
>> Signed-off-by: Torsten B=F6gershausen<tboegi@web.de>
>
> Torsten B=F6gershausen wrote in<4CFA27DD.7030105@web.de>:
>> Now we do not depend on internal implementation details of svn.
>> And the code is 3% easier to understand :-)
>
> I agree on this point completely
>
> Acked-by: Eric Wong<normalperson@yhbt.net>
>
>> ---
>>   t/t9143-git-svn-gc.sh |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
>> index 337ea59..8a95d78 100755
>> --- a/t/t9143-git-svn-gc.sh
>> +++ b/t/t9143-git-svn-gc.sh
>> @@ -37,7 +37,7 @@ test_expect_success 'git svn gc runs' 'git svn gc'
>>    test_expect_success 'git svn index removed' '! test -f
>> .git/svn/refs/remotes/git-svn/index'
>>   -if perl -MCompress::Zlib -e 0 2>/dev/null
>> +if test -r .git/svn/refs/remotes/git-svn/unhandled.log.gz
>>   then
>>   	test_expect_success 'git svn gc produces a valid gzip file' '
>>   		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
>> --
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Eric,
thanks for the input.
I have indeed 2 perl versions:
find / -xdev -name perl -type f 2>/dev/null | xargs ls -l
-rwxr-xr-x  2 root  admin  1297824 Jan  7  2010 /opt/local/bin/perl
-rwxr-xr-x  2 root  admin  1297824 Jan  7  2010=20
/opt/local/var/macports/software/perl5.8/5.8.9_3/opt/local/bin/perl
-rwxr-xr-x  1 root  wheel    86000 Jun 26  2009 /usr/bin/perl
-r--r--r--  1 root  wheel     1813 May 18  2009 /usr/share/file/magic/p=
erl

  which perl
/opt/local/bin/perl

/opt/local/bin/perl -MCompress::Zlib -e 0 ; echo $?
Can't locate Compress/Zlib.pm in @INC (@INC contains: /sw/lib/perl5=20
/sw/lib/perl5/darwin /opt/local/lib/perl5/site_perl/5.8.9/darwin-2level=
=20
/opt/local/lib/perl5/site_perl/5.8.9 /opt/local/lib/perl5/site_perl=20
/opt/local/lib/perl5/vendor_perl/5.8.9/darwin-2level=20
/opt/local/lib/perl5/vendor_perl/5.8.9 /opt/local/lib/perl5/vendor_perl=
=20
/opt/local/lib/perl5/5.8.9/darwin-2level /opt/local/lib/perl5/5.8.9 .).
BEGIN failed--compilation aborted.
2


  /usr/bin/perl -MCompress::Zlib -e 0 ; echo $?
0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
If you agree, I will send a V2 version of the patch, which
will use the following:
---------------------------
if test -r .git/svn/refs/remotes/git-svn/unhandled.log.gz
then
	test_expect_success 'git svn gc produces a valid gzip file' '
		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
		'
fi
----------------
This will simply check if the unhandled.log.gz exist,
and if, it will be unpacked.
I removed the else and
   say "# Perl Compress::Zlib unavailable, skipping gunzip test"

/Torsten
