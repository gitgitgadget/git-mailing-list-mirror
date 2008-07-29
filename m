From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Tue, 29 Jul 2008 21:46:36 +0200
Message-ID: <E8DB683F-209F-4D49-9BE4-7F8209C512F0@zib.de>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <1217104655.488b8b0f5ca48@webmail.nextra.at> <4CCD1862-48FB-412B-80B6-E1B822BF3A87@zib.de> <1217186640.488ccb50a934a@webmail.nextra.at> <B6158330-640B-4CA3-8589-310FA8EA6CC9@zib.de> <1217320426.488ed5ea47384@webmail.nextra.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvBo-00064g-DR
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbYG2Try (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYG2Try
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:47:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:57984 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbYG2Trx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:47:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6TJkGuf003340;
	Tue, 29 Jul 2008 21:46:21 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db80f37.pool.einsundeins.de [77.184.15.55])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6TJkEd4016408
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2008 21:46:15 +0200 (MEST)
In-Reply-To: <1217320426.488ed5ea47384@webmail.nextra.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90676>


On Jul 29, 2008, at 10:33 AM, Johannes Sixt wrote:

> Zitat von Steffen Prohaska <prohaska@zib.de>:
>
>>
>> On Jul 27, 2008, at 9:24 PM, Johannes Sixt wrote:
>>
>>> Zitat von Steffen Prohaska <prohaska@zib.de>:
>>>
>>>>
>>>> On Jul 26, 2008, at 10:37 PM, Johannes Sixt wrote:
>>>>
>>>>> Zitat von Steffen Prohaska <prohaska@zib.de>:
>>>>>> With MinGW's
>>>>>>
>>>>>> gcc.exe (GCC) 3.4.5 (mingw special)
>>>>>> GNU ld version 2.17.50 20060824
>>>>>>
>>>>>> the old define caused link errors:
>>>>>>
>>>>>> git.o: In function `main':
>>>>>> C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
>>>>>> collect2: ld returned 1 exit status
>>>>>>
>>>>>> The modified define works.
>>>>>
>>>>> I have the same tools, but not this error. ???
>>>>
>>>> I cleaned my work tree and built several times but did not
>>>> find out what exactly is causing the error.  So I came up
>>>> with the modified define, which declares the static
>>>> mingw_main in global scope.  I have no clue why I see the
>>>> error that you don't have.
>>>
>>> Neither do I. But a strange line number you have there. In 01d9b2d
>>> (from
>>> mingw.git) I have 'exit(1)' in line 500 of git.c.
>>
>> I have the same in line 500.  I am still wondering what this could
>> mean.  But I do not yet now :-(
>
> Can you try 'make -k' and see whether you have a similar problem  
> with the
> non-builtins that have their own main()?


With your master 01d9b2d:

$ make -k
     LINK git.exe
git.o: In function `main':
C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git.exe] Error 1
     LINK git-hash-object.exe
hash-object.o: In function `main':
C:/msysgit/git/hash-object.c:114: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-hash-object.exe] Error 1
     LINK git-index-pack.exe
index-pack.o: In function `main':
C:/msysgit/git/index-pack.c:974: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-index-pack.exe] Error 1
     LINK git-merge-index.exe
merge-index.o: In function `main':
C:/msysgit/git/merge-index.c:120: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-merge-index.exe] Error 1
     LINK git-merge-tree.exe
merge-tree.o: In function `main':
C:/msysgit/git/merge-tree.c:346: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-merge-tree.exe] Error 1
     LINK git-mktag.exe
mktag.o: In function `main':
C:/msysgit/git/mktag.c:144: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-mktag.exe] Error 1
     LINK git-mktree.exe
mktree.o: In function `main':
C:/msysgit/git/strbuf.h:73: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-mktree.exe] Error 1
     LINK git-pack-redundant.exe
pack-redundant.o: In function `main':
C:/msysgit/git/pack-redundant.c:181: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-pack-redundant.exe] Error 1
     LINK git-patch-id.exe
patch-id.o: In function `main':
C:/msysgit/git/patch-id.c:80: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-patch-id.exe] Error 1
     LINK git-receive-pack.exe
receive-pack.o: In function `main':
C:/msysgit/git/receive-pack.c:386: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-receive-pack.exe] Error 1
     LINK git-show-index.exe
show-index.o: In function `main':
C:/msysgit/git/show-index.c:64: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-show-index.exe] Error 1
     LINK git-unpack-file.exe
unpack-file.o: In function `main':
C:/msysgit/git/unpack-file.c:19: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-unpack-file.exe] Error 1
     LINK git-update-server-info.exe
update-server-info.o: In function `main':
C:/msysgit/git/update-server-info.c:20: undefined reference to  
`mingw_main'
collect2: ld returned 1 exit status
make: *** [git-update-server-info.exe] Error 1
     LINK git-upload-pack.exe
upload-pack.o: In function `main':
C:/msysgit/git/upload-pack.c:180: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-upload-pack.exe] Error 1
     LINK git-var.exe
var.o: In function `main':
C:/msysgit/git/var.c:51: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [git-var.exe] Error 1
make: Target `all' not remade because of errors.
     SUBDIR git-gui
     SUBDIR gitk-git
make[1]: Nothing to be done for `all'.
     SUBDIR perl
mkdir -p blib/lib
rm -f blib/lib/Git.pm; cp Git.pm blib/lib/
rm -f blib/lib/Error.pm
     SUBDIR templates
     LINK test-chmtime.exe
test-chmtime.o: In function `main':
C:/msysgit/git/test-chmtime.c:50: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [test-chmtime.exe] Error 1
     LINK test-date.exe
test-date.o: In function `main':
C:/msysgit/git/test-date.c:3: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [test-date.exe] Error 1
     LINK test-delta.exe
test-delta.o: In function `main':
C:/msysgit/git/test-delta.c:67: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [test-delta.exe] Error 1
     LINK test-sha1.exe
test-sha1.o: In function `main':
C:/msysgit/git/test-sha1.c:14: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [test-sha1.exe] Error 1
     LINK test-match-trees.exe
test-match-trees.o: In function `main':
C:/msysgit/git/test-match-trees.c:23: undefined reference to  
`mingw_main'
collect2: ld returned 1 exit status
make: *** [test-match-trees.exe] Error 1
     LINK test-parse-options.exe
test-parse-options.o: In function `main':
C:/msysgit/git/test-parse-options.c:21: undefined reference to  
`mingw_main'
collect2: ld returned 1 exit status
make: *** [test-parse-options.exe] Error 1
     LINK test-path-utils.exe
test-path-utils.o: In function `main':
C:/msysgit/git/test-path-utils.c:8: undefined reference to `mingw_main'
collect2: ld returned 1 exit status
make: *** [test-path-utils.exe] Error 1
make: Target `all' not remade because of errors.

	Steffen
