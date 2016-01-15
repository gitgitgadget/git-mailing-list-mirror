From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Fri, 15 Jan 2016 07:45:16 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601150743590.2964@virtualbox>
References: <20160114202608.GA8806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJy8g-0001xG-G1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 07:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbcAOGpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 01:45:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:54338 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbcAOGpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 01:45:32 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LzGV3-1a6zZn3kkj-014Vur; Fri, 15 Jan 2016 07:45:19
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160114202608.GA8806@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2XVu9iVKNsoESaskkd5li1wIkGiZkONALo9FVvCktx/exdCtJjs
 XfQjo+Ftpk4i5nfaJlZJmW25y4r52XpWDoz28xLIF4dqyPhg2Bb7twBZ+T/Pa01YDNH12NE
 vFJu9V6DVxBpR0rmfmomS6/0NZXBl96euMb/yZBuLOxwXBEarTNYII1Nz5URI2VpDx09kem
 bj4MH45enUfzigxOVKmbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wf5W3CSI9l0=:JSBsp/wM3gPM05Q0AA+RMz
 DZjjFLjjoDbBx0hI2dc5tuNDIjfcXprgkLJ6QNdV2EE6e9RxgPHFSG1CWbzd3lv3o721AGxaD
 armOqI6ojeSy8SUQuP78a0XTFKJ9bgyZpA3cEoibqDlUdd+aEGzpXkB+RooNEs6+llQrnmxjQ
 sSosk/XvCaV8XJdlnmOGFuOUyqUbbWhmUu9JqVC5QgFrDt03VEqYzhp0Cmc9eGRPHShf6MW+L
 U6/cxZqfCQQPbA/vhT0NqjJBeNS5gRQcC7lHxjHWJCG4ZH/inaFX+xqE7JQVOYY4gVbkg8FJT
 gUr7eo0lmE8IGyZH1MHNI/dGlGYBLVZvdFrEqG7vybWR2M/mM7qos7m4VxuDLEXr+7/VQgitd
 PSD4IBk905giOB1zyZNMGRgLjQdXoXsAcDM+FqPHuzsYnt934m3idkgER/mx15w2CNqxwEFgq
 bdhKbLIjs9o7QHjVwsaOz5SW+6QJM9Ootq9eicOz88xeQNJx5qwqI2ixc609xoixM6COZ2A+7
 hrWZE2IbkJd9l+btUK3Mm9UUJ/+eW9sW36l3FRGQs1/COe+gxFrEIPHw4XkrhnAN+1lSgzaJe
 ItMaPhrRK4sAVMgUakpBvoO93zEb3sYt9cCs3mmg5T5miEKUKIFcMol4nLesa6JuANSYC5yVc
 gdSONZnhnPY/zrGazt3Pt3IJO0LhSsq2vfnNRgLoqNnDhz8w0MI2mNCLJM7Ox4rfDzoOzSy/9
 bQiOGEyBlxD02a0WursF5QqmtAAsisPoZBqWB8Yw5n5bR49GVbDkJUsdVBk4vqSU+it/yeIu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284137>

Hi Peff,

On Thu, 14 Jan 2016, Jeff King wrote:

> This strcpy will never overflow because it's copying from
> baked-in test data. But we would prefer to avoid strcpy
> entirely, as it makes it harder to audit for real security
> bugs.

Thanks.

> This sort-of applies on top of js/dirname-basename, which is in next.
> Textually, it's fine, but that topic is based on v2.6.5, and xsnprintf
> was only added in the v2.7.0 cycle. The simplest thing is probably to
> wait for it to graduate to master, and then apply there as a new topic
> (if we do v2.6.6, it's OK for it not to have this patch).
> 
> I can hold and resend in a week or two if that's easier.

If you have a patch to make dirname/basename safer based on xsnprintf, I
would like to have that as soon as possible (next was rewound to 2.7.0,
no?)...

Thanks!
Dscho
