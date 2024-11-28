Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCB148857
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802333; cv=none; b=vBnZAZY4ZG+gF0Q35mq3mpOqvJSbezc5GnrBhMxbw9k/CEEFxI78w232thc4XwOj/U0Rdq1AF9s61TIyxeComJjD0mLa7nf8DeJZZviNa0BxZQnZ7XuxUgsUXvmrmLWHLumLqPbH3dp9tlJW8CGLKxrdukb9p8HPrqgjy4tjBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802333; c=relaxed/simple;
	bh=JLpFdUL1LoLxECDod6tlHRlCxO2RltcsI0Rgrtg1Jio=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=d1pakDPSU0OAm60ImKNsugdpNiHONcCS1xBuFPJNrDezY8c2MwxiwZ/ji8qs43jwW+6GUOmXx6ZOViAEXeDBRUj6Ph2eS2GrCZ+WP1YJKwF6wI0EB/Ls6V08A0tSyTyi4jjWkbyKjDgRehhX1CqlyLtLV1N1ZsmTGLsPF2uzFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b=llHuNW/y; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b="llHuNW/y"
Authentication-Results: mail.aegee.org/4ASDrLph1565200; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1732802002; i=dkim+MSA-ssl@aegee.org;
	bh=JLpFdUL1LoLxECDod6tlHRlCxO2RltcsI0Rgrtg1Jio=;
	h=Subject:From:To:Date;
	b=llHuNW/yYP+6j5bnP1f8ZbWdoEJ3oyfNSbdHlnGVEIaqN3kozvKw+GYVETvIv+MXO
	 UOCTyhO9JufspvJYKDEhgL0BoSalw6Sd0zXkh2m6soc4khTl8t3/yuGQB3VcSdurlS
	 urzzXY2boJKQhKw/uDeI/hBg3jXEbOqJAE8O8ujW31cJ1VWIIfhjRCzrdJHEzqk7Bt
	 b1rPi5uPp/jmam8d9IwHzmirrjYpwcrZKc7b6pFtWlio+FgfbGO7+yXyLWARU7rEoY
	 D+9E33Q8vYRs6bxu8FcS84UjSXlUxUr7vOaP0lFNzXaNutYZKd/3x/QMHOnBQKrRwe
	 hpbVc4cL+eyNen2XXous2LbAXrBMRkdTOMILx7ItwgLnzY+tTC17R1BkFjs2pUEKul
	 1BMcKroV5/AJiYwyO9BvsFgfM/N+tAU+ikx6nbz/PwzoHwpJIKXtdYH/vcZORNx/oV
	 P1RCbz+eoZpkASfSVCkQA3m5yC8jcW1frRiCyQC6apycb412mWxcpnD4n44HYZkyEQ
	 W0N2r2IfXqS0MhQkRr9gJJ55Jkc8ZNReU1ornNdbo9YH+bY7dln0mo/b5xwQiLH47p
	 wo8PLhmp7GSq3GnZMcr39pI6qvtcqQKAa7Qngb6W0L19armf5gnHaZOPms8EPtwJVl
	 zmKbsvjrbbL2gObOjSWtrph0=
Authentication-Results: mail.aegee.org/4ASDrLph1565200; dkim=none
Received: from [192.168.0.100] (ip-046-223-162-065.um13.pools.vodafone-ip.de [46.223.162.65])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 4ASDrLph1565200
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 13:53:22 GMT
Message-ID: <b4ef94b2a0294c338d115fee68e0c31e44dad3b9.camel@aegee.org>
Subject: Building git with =?UTF-8?Q?=2Fbin=2Fsh=E2=87=94dash?= produces
 suboptimal GIT-CFLAGS file
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: git@vger.kernel.org
Date: Thu, 28 Nov 2024 14:53:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

when /bin/sh is bash, target GIT-CFLAGS: FORCE in Makefile puts in the file=
 GIT-CFLAGS the content

gcc:  -g -O2  -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DUSE_LIBPCR=
E2 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS=
_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH=
_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"git-compat-util.h\"" -DSHA=
1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHA=
VE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOC=
K_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-
DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DSHE=
LL_PATH=3D'"/bin/sh"':

when /bin/sh is dash (b3e38ad), the same file GIT-CFLAGS contains

gcc:  -g -O2  -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D""x86_64"" -DUSE_LIBPCRE2=
 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS_S=
IMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_D=
EFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D""git-compat-util.h"" -DSHA1DC_=
CUSTOM_INCLUDE_UBC_CHECK_C=3D""git-compat-util.h"" -DSHA256_BLK  -DHAVE_PAT=
HS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONO=
TONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-
DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DSHE=
LL_PATH=3D'"/bin/sh"':

Note the differences in the -DGIT_HOST_CPU, -DSHA1DC_CUSTOM_INCLUDE_SHA1_C =
values.  Because of the differences, in Makefile:3150   if test x"$$FLAGS" =
!=3D x"`cat GIT-CFLAGS 2>/dev/null`" ; then  always succeeds, prints =E2=80=
=9C* new build flags=E2=80=9D and every run of make starts rebuilding daemo=
n.o.  So the empty build is not empty.

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
