From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 02:29:24 +0100
Message-ID: <4F3472F4.4060605@aegee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080405070202070702050906"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 02:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvfdJ-0007Cf-6J
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 02:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103Ab2BJBue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 20:50:34 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:42636 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2BJBue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 20:50:34 -0500
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Feb 2012 20:50:34 EST
Received: from smtp.aegee.org (aegeeserv.aegee.uni-karlsruhe.de [129.13.131.80])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1RvfIp-0003nF-Px; Fri, 10 Feb 2012 02:29:31 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
Received: from [192.168.2.104] (p4FDCFE97.dip.t-dialin.net [79.220.254.151])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.5/8.14.5) with ESMTP id q1A1TWvA030147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:29:33 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
X-Virus-Scanned: clamav-milter 0.97.3 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190363>

This is a multi-part message in MIME format.
--------------080405070202070702050906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

git 1.7.9 makes use of libcharset and /Makefile contains:

ifdef HAVE_LIBCHARSET_H
         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
endif

when building git-daemon., the compiler reports
make V=1
cc  -I. -DUSE_LIBPCRE -pthread -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H 
-DHAVE_DEV_TTY -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -o 
git-daemon -L/usr/lib64 -L/lib64  daemon.o libgit.a xdiff/lib.a  -lpcre 
-lz  -liconv  -lcrypto -pthread
/tmp/ccvPEthi.ltrans0.ltrans.o: In function `main':
ccvPEthi.ltrans0.o:(.text.startup+0x59): undefined reference to 
`locale_charset'
collect2: ld returned 1 exit status
make: *** [git-daemon] Error 1


and the problem is, that libcharset is not used when linking.  To solve 
this, please replace the above extract from /Makefile with

ifdef HAVE_LIBCHARSET_H
         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
	EXTLIBS += -lcharset
endif

Със здраве
   Дилян

--------------080405070202070702050906
Content-Type: text/x-vcard; charset=utf-8;
 name="dilyan_palauzov.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dilyan_palauzov.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUQwPTk0PUQwPUI4PUQwPUJCPUQx
PThGPUQwPUJEID1EMD05Rj1EMD1CMD1EMD1CQj1EMD1CMD1EMT04Mz1EMD1CNz1EMD1CRT0N
Cgk9RDA9QjINCm47cXVvdGVkLXByaW50YWJsZTtxdW90ZWQtcHJpbnRhYmxlOj1EMD05Rj1E
MD1CMD1EMD1CQj1EMD1CMD1EMT04Mz1EMD1CNz1EMD1CRT1EMD1CMjs9RDA9OTQ9RDA9Qjg9
RDA9QkI9RDE9OEY9RDA9QkQNCmVtYWlsO2ludGVybmV0OmRpbHlhbi5wYWxhdXpvdkBhZWdl
ZS5vcmcNCnRlbDtob21lOis0OS03MjEtOTQxOTMyNzANCnRlbDtjZWxsOis0OS0xNjItNDA5
MTE3Mg0Kbm90ZTpzaXA6ODM3MkBhZWdlZS5vcmcNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQN
Cg0K
--------------080405070202070702050906--
