From: =?UTF-8?B?SmFudXN6IEJpYcWCb2JyemV3c2tp?= <jbialobr@o2.pl>
Subject: Re: File path not escaped in warning message
Date: Sun, 05 Aug 2012 14:05:02 +0200
Message-ID: <501E616E.6000907@o2.pl>
References: <501D1BB5.6020200@o2.pl> <7v39429u58.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:06:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxzax-0004Th-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 14:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab2HEMFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Aug 2012 08:05:24 -0400
Received: from moh2-ve3.go2.pl ([193.17.41.208]:39658 "EHLO moh2-ve3.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab2HEMFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 08:05:24 -0400
Received: from moh2-ve3.go2.pl (unknown [10.0.0.208])
	by moh2-ve3.go2.pl (Postfix) with ESMTP id 3321F372804
	for <git@vger.kernel.org>; Sun,  5 Aug 2012 14:05:16 +0200 (CEST)
Received: from unknown (unknown [10.0.0.42])
	by moh2-ve3.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Sun,  5 Aug 2012 14:05:16 +0200 (CEST)
Received: from 89-69-97-238.dynamic.chello.pl [89.69.97.238]
	by poczta.o2.pl with ESMTP id xjnEEC;
	Sun, 05 Aug 2012 14:05:15 +0200
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7v39429u58.fsf@alter.siamese.dyndns.org>
X-O2-Trust: 2, 60
X-O2-SPF: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202907>

Here is output from linux:

[janusz@mikrus JavaCommon]$ git config --add core.quotepath false
[janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=C4=85.txt"
warning: LF will be replaced by CRLF in 1<B1>.txt.
The file will have its original line endings in your working directory.
diff --git a/1<B1>.txt b/1<B1>.txt
index 281ad6f..9444a66 100644
--- a/1<B1>.txt
+++ b/1<B1>.txt
@@ -1,2 +1,2 @@
 aaaa
-bbb
+bbbc


[janusz@mikrus JavaCommon]$ git config --unset core.quotepath
[janusz@mikrus JavaCommon]$ git config --add core.quotepath true
[janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=C4=85.txt"
warning: LF will be replaced by CRLF in 1<B1>.txt.
The file will have its original line endings in your working directory.
diff --git "a/1\261.txt" "b/1\261.txt"
index 281ad6f..9444a66 100644
--- "a/1\261.txt"
+++ "b/1\261.txt"
@@ -1,2 +1,2 @@
 aaaa
-bbb
+bbbc

Janusz Bia=C5=82obrzewski.

Junio C Hamano pisze:
> Janusz Bia=C5=82obrzewski <jbialobr@o2.pl> writes:
>
>  =20
>> I have enabled core.quotepath, but file path in warning isn't escape=
d:
>> File name is 1=C4=85.txt its content is encoded in windows-1250
>> Output of git diff after reencoding to windows1250 is:
>>
>> warning: LF will be replaced by CRLF in 1=C3=84=E2=80=A6.txt.
>> The file will have its original line endings in your working directo=
ry.
>>
>> But I expected it to be:
>>
>> warning: LF will be replaced by CRLF in 1\304\205.txt.
>> The file will have its original line endings in your working directo=
ry.
>>    =20
>
> Do msysgit folks want to look into this, perhaps?
>
> Thanks.
>
>  =20
