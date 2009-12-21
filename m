From: Wincent Colaiuta <win@wincent.com>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 08:09:36 +0100
Message-ID: <2E55A685-834C-4C64-99F1-4060FEC7C2DB@wincent.com>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMcbh-0006NJ-Iq
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 08:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbZLUHW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2009 02:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbZLUHW6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 02:22:58 -0500
Received: from outmail128067.authsmtp.com ([62.13.128.67]:50075 "EHLO
	outmail128067.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751163AbZLUHW6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 02:22:58 -0500
X-Greylist: delayed 793 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2009 02:22:57 EST
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nBL79gdR056136;
	Mon, 21 Dec 2009 07:09:42 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nBL79e9o025698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Dec 2009 07:09:41 GMT
Received: from [192.168.1.2] (231.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id nBL79aG1005048
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 21 Dec 2009 02:09:39 -0500
In-Reply-To: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: cf49fe2d-edff-11de-80b9-0022640b883e
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH aB8dAldYdwdEHQAR A2EBW11eVFw/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSncUBhVU D0EeUBx0fg0IfXt2 bQgxCHRSChF4IVso FhgCCGwHMTJ9YGBN WV1YdwFWdgdKLBdN aQUxNiYHcSVYJTk5 FQs+dzs2MTgXJT5P RRtFJE5aW1sNKTU7 QhULGzlpFiUA
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135543>

El 21/12/2009, a las 07:46, Frank Li escribi=F3:

> int start_command(struct child_process *cmd)
> {
> 	int need_in, need_out, need_err;
> 	int fdin[2], fdout[2], fderr[2];
> 	int failed_errno =3D failed_errno;
>
> I have not found failed_errno as global variable.
> failed_errno =3D failed_errno means nothing.
>
> It is possible coding error and should be
> int failed_errno=3D 0 or
> failed_errno=3Derrno.

Via "git blame":

commit 5a7a3671b74c043216549b94a718da04cc3ffcd6
Author: David Soria Parra <dsp@php.net>
Date:   Tue Aug 4 11:28:40 2009 +0200

     run-command.c: squelch a "use before assignment" warning

     i686-apple-darwin9-gcc-4.0.1 (GCC) 4.0.1 (Apple Inc. build 5490) =20
compiler
     (and probably others) mistakenly thinks variable failed_errno is =20
used
     before assigned.  Work it around by giving it a fake =20
initialization.

     Signed-off-by: David Soria Parra <dsp@php.net>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>


Cheers,
Wincent