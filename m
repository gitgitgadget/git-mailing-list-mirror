From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Mon, 09 Nov 2015 22:28:54 +0000
Message-ID: <87si4e6c49.fsf@red.patthoyts.tk>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	<xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
	<20151027012336.GK31271@freya.jamessan.com>
	<xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 09 23:29:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvuvw-0002WZ-2O
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 23:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbbKIW27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 17:28:59 -0500
Received: from know-smtprelay-omc-11.server.virginmedia.net ([80.0.253.75]:44149
	"EHLO know-smtprelay-omc-11.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbbKIW25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 17:28:57 -0500
Received: from red.patthoyts.tk ([82.37.112.67])
	by know-smtprelay-11-imp with bizsmtp
	id faUv1r00E1TJ4Ay01aUvZM; Mon, 09 Nov 2015 22:28:55 +0000
X-Originating-IP: [82.37.112.67]
X-Spam: 0
X-Authority: v=2.1 cv=dtgmcAU4 c=1 sm=1 tr=0 a=jfuJrPDYcJsiQYN5ZEnYVQ==:117
 a=jfuJrPDYcJsiQYN5ZEnYVQ==:17 a=Rf460ibiAAAA:8 a=FP58Ms26AAAA:8
 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10 a=qtqOOiqGOCEA:10
 a=pGLkceISAAAA:8 a=uPZiAMpXAAAA:8 a=nf7C1gF8nOJN6Q3La5UA:9
 a=dSkICczvZ5eqJfcG:21 a=g_VigiOCBnvEmY2Y:21 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id 11BC019664B8;
	Mon,  9 Nov 2015 22:28:55 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 27 Oct 2015 16:53:34 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281086>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>Hi,
>
>On Tue, 27 Oct 2015, Johannes Schindelin wrote:
>
>> On Mon, 26 Oct 2015, Junio C Hamano wrote:
>> 
>> > James McCoy <vega.james@gmail.com> writes:
>> > 
>> > >> The code looks OK but the last paragraph makes _us_ worried.  What
>> > >> is the licensing status of the original at SO?
>> > >
>> > > According to Stackoverflow[0],
>> > >
>> > >   As noted in the Stack Exchange Terms of Service[1] and in the footer of
>> > >   every page, all user contributions are licensed under Creative Commons
>> > >   Attribution-Share Alike[2]. Proper attribution[3] is required if you
>> > >   republish any Stack Exchange content.
>> > >
>> > > [0]: https://stackoverflow.com/help/licensing
>> > 
>> > Yes, and (please correct me if I am wrong--this is one of the times
>> > I hope I am wrong!) I thought BY-SA does not mesh well with GPLv2,
>> > in which case we cannot use this patch (instead somebody has to
>> > reimplement the same without copying).
>> 
>> Pat, could you please allow us to insert your SOB?
>
>On second thought... Junio, could you please sanity-check my claim that
>this patch:
>
>-- snip --
>@@ -465,6 +465,17 @@ static CURL *get_curl_handle(void)
> 
>        if (curl_http_proxy) {
>                curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>+#if LIBCURL_VERSION_NUM >= 0x071800
>+               if (starts_with(curl_http_proxy, "socks5"))
>+                       curl_easy_setopt(result,
>+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
>+               else if (starts_with(curl_http_proxy, "socks4a"))
>+                       curl_easy_setopt(result,
>+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
>+               else if (starts_with(curl_http_proxy, "socks"))
>+                       curl_easy_setopt(result,
>+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
>+#endif
>        }
> #if LIBCURL_VERSION_NUM >= 0x070a07
>        curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>-- snap --
>
>cannot be copyrighted because it is pretty much the only way to implement
>said functionality?
>
>Still, Pat, if you find the time, could you please simply relicense your
>patch (I know that you are fine with it, but we need an explicit
>statement)?
>
>Ciao,
>Johannes

A bit late to the party but 'yes'. Frankly by posting something to SO I
rather consider it public domain but I hereby license this patch as
required for use by the Git project.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
