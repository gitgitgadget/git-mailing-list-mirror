From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 21 Sep 2015 11:05:06 +0200
Message-ID: <0BCEFDB9-9042-4D42-8775-AC22C3658F71@gmail.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com> <1442766131-45017-2-git-send-email-larsxschneider@gmail.com> <55FFB681.50500@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 11:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdx2C-0007Z6-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 11:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbbIUJFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 05:05:10 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37973 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbbIUJFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 05:05:09 -0400
Received: by wiclk2 with SMTP id lk2so101691877wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dNO9uZ23YaQ01yCAfe0sWhLwfJa+2974To/mvvaj3yg=;
        b=veBIJXJ0HbhuNacnogKp28pMKjHDIeDC42s1DCJVTP21PBwzd7GmWcy6wm4QAsROMu
         IojQJsXGyOlt0GRVfj7ZtIgYXY/7A++DyXGv8Igk/3nlOFC91+D4o9ZIORfS7vEEmurk
         FByv078Yluv/7fDVSzt1zMcpEIl0kdmU5jTJy0AY8o2nTscKlyHcQXLKWXS/hZLEwSJe
         w+hRMhRFzenFmTdwI95xlOgH5IEuh67CX7GGZUgXoTz4qoeAla+MebaTBkuBO57dl0vz
         KSgc4raz57YvDfkyhWyJRtaX6yUHhdYSRImCN1X6NfNytVag3iaTaLFwqEJdsuT8h8V8
         nHSA==
X-Received: by 10.180.99.5 with SMTP id em5mr12709420wib.43.1442826308331;
        Mon, 21 Sep 2015 02:05:08 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id jf3sm12362037wic.8.2015.09.21.02.05.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 02:05:07 -0700 (PDT)
In-Reply-To: <55FFB681.50500@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278290>


On 21 Sep 2015, at 09:49, Luke Diamand <luke@diamand.org> wrote:

> On 20/09/15 17:22, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>=20
> When I run this, I get errors reported on the sed usage:
>=20
> t9824-git-p4-handle-utf16-without-bom.sh:25: error: sed -i is not por=
table:             sed -i.bak "$ d" depot/file1,v &&
> t9824-git-p4-handle-utf16-without-bom.sh:25: error: sed -i is not por=
table:             sed -i.bak "$ d" depot/file1,v &&

I tried it on OS X 10.9.5 and on Ubuntu Linux 14.04.1 (sed version 4.2.=
2).=20

The =93-i=94 option is mentioned in the GNU sed docs here:=20
https://www.gnu.org/software/sed/manual/sed.html

The OS X sed man page indeed lists =93-i=94 as non-standard option:
https://developer.apple.com/library/mac/documentation/Darwin/Reference/=
ManPages/man1/sed.1.html

What OS/sed version are you using?

Thanks,
Lars


>=20
>=20
> Luke
>=20
>=20
>>=20
>> A P4 repository can get into a state where it contains a file with
>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>> attempts to retrieve the file then the process crashes with a
>> "Translation of file content failed" error.
>>=20
>> More info here: http://answers.perforce.com/articles/KB/3117
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  t/t9824-git-p4-handle-utf16-without-bom.sh | 49 +++++++++++++++++++=
+++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh
>>=20
>> diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-gi=
t-p4-handle-utf16-without-bom.sh
>> new file mode 100755
>> index 0000000..517f6da
>> --- /dev/null
>> +++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
>> @@ -0,0 +1,49 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git p4 handling of UTF-16 files without BOM'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +UTF16=3D"\227\000\227\000"
>> +
>> +test_expect_success 'start p4d' '
>> +	start_p4d
>> +'
>> +
>> +test_expect_success 'init depot with UTF-16 encoded file and artifi=
cially remove BOM' '
>> +	(
>> +		cd "$cli" &&
>> +		printf "$UTF16" >file1 &&
>> +		p4 add -t utf16 file1 &&
>> +		p4 submit -d "file1"
>> +	) &&
>> +
>> +	(
>> +		cd "db" &&
>> +		p4d -jc &&
>> +		# P4D automatically adds a BOM. Remove it here to make the file i=
nvalid.
>> +		sed -i.bak "$ d" depot/file1,v &&
>=20
> This line is the problem I think.
>=20
>=20
>> +		printf "@$UTF16@" >>depot/file1,v &&
>> +		p4d -jrF checkpoint.1
>> +	)
>> +'
>> +
>> +test_expect_success 'clone depot with invalid UTF-16 file in verbos=
e mode' '
>> +	git p4 clone --dest=3D"$git" --verbose //depot &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		printf "$UTF16" >expect &&
>> +		test_cmp_bin expect file1
>> +	)
>> +'
>> +
>> +test_expect_failure 'clone depot with invalid UTF-16 file in non-ve=
rbose mode' '
>> +	git p4 clone --dest=3D"$git" //depot
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +	kill_p4d
>> +'
>> +
>> +test_done
