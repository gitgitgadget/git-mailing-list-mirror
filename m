From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: gitk: set uicolor SystemButtonFace error on X11 if .gitk created using Win32 tk
Date: Thu, 23 Feb 2012 11:20:13 -0800
Message-ID: <70952A932255A2489522275A628B97C31294E764@xmb-sjc-233.amer.cisco.com>
References: <70952A932255A2489522275A628B97C31288FA0B@xmb-sjc-233.amer.cisco.com> <CABPQNSZqX0_YAn=mOpuRquG9OzFgwS9fQ6=YXqULxMz-hbH6Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <kusmabite@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 20:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0eDj-0005Yu-EF
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab2BWTUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 14:20:17 -0500
Received: from mtv-iport-4.cisco.com ([173.36.130.15]:54040 "EHLO
	mtv-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2BWTUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 14:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=1345; q=dns/txt;
  s=iport; t=1330024816; x=1331234416;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:in-reply-to:references:from:to:cc;
  bh=LvxblgeNb9Da0KSi+Gmplnb+mqBKH/zqc0JOwRnxylQ=;
  b=hjQBLUjqYNOKX/rimTJ5RJLri2MSj6P/xBJC3mIFZlsLPTtFEIpJ5Msj
   6Xw+U4w5SmuJWUaShBvTr+2YooRjTlfbqkGiBllLrz6OhAxcgNv5sDUCE
   EFn4FP2vhms4mMszc3i/YWB/HJkkGmKzR3dfsiSfCsNJvXKWRUi7fbYsb
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAIKQRk+rRDoI/2dsb2JhbABEslOBB4FzAQEBAwESAR0KPwULAgEIFQ0GFwEGASAlAwENAQEEEwgah1+gIAGXB4JXhiiEBRUXRxEFAwKETAGBMw8PgjtjBIhPmACHdw
X-IronPort-AV: E=Sophos;i="4.73,471,1325462400"; 
   d="scan'208";a="31917900"
Received: from mtv-core-3.cisco.com ([171.68.58.8])
  by mtv-iport-4.cisco.com with ESMTP; 23 Feb 2012 19:20:15 +0000
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com [128.107.191.100])
	by mtv-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id q1NJKFlm009665;
	Thu, 23 Feb 2012 19:20:15 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-231.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 23 Feb 2012 11:20:15 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <CABPQNSZqX0_YAn=mOpuRquG9OzFgwS9fQ6=YXqULxMz-hbH6Zw@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitk: set uicolor SystemButtonFace error on X11 if .gitk created using Win32 tk
thread-index: AczyM/q3t3SnB4PqSe6oABRvVgRUUgAJPXjg
X-OriginalArrivalTime: 23 Feb 2012 19:20:15.0724 (UTC) FILETIME=[2C14BAC0:01CCF260]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191386>

> From: Erik Faye-Lund [mailto:kusmabite@gmail.com]
> 
> Are you saying that the tk shipped with recent Cygwin reports "win32"
> for "[tk windowingsystem]", but does not recognize the
> "SystemButtonFace" etc values?

Here is what I am saying:

1.  Cygwin tk 8.4.x and earlier:
-Reports "win32" for "[tk windowingsystem]"
-Recognizes the "SystemButtonFace" etc values

2.  Cygwin tk 8.5.11:
-Reports "x11" for "[tk windowingsystem]"
-Does not recognize the "SystemButtonFace" etc values

> Does this patch help?

No, this has the same problem: if gitk is installed using a tk that
reports "win32" for "[tk windowingsystem]", then gitk hard codes win32
specific values into .gitk.  If the user later changes to a tk that
doesn't support win32 specific values, gitk will no longer work.

Two use cases:  

1.  My situation:  User replaces a win32 tk with an x11 tk
2.  User uses a common .gitk file when running Windows and Linux.

Here's the error:
$ uname -a
CYGWIN_NT-5.1 matseitz-wxp 1.7.10(0.259/5/3) 2012-02-05 12:36 i686
Cygwin
$ wish
% tk windowingsystem
x11
% exit
$ gitk &
[1] 6312
$ Error in startup script: unknown color name "ButtonFace"
    while executing
"winfo rgb . $c"
    (procedure "setui" line 3)
    invoked from within
"setui $uicolor"
    (file "/usr/bin/gitk" line 11522)
