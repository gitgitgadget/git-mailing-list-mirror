From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in
 an ignored directory
Date: Tue, 24 Aug 2010 22:13:41 -0500
Message-ID: <20100825031341.GF11619@burratino>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
 <1282123788-24055-1-git-send-email-gdb@mit.edu>
 <AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
 <vpqk4noc9ro.fsf@bauges.imag.fr>
 <20100819000052.GA11081@burratino>
 <AANLkTikLUQCnrDAp8c0QBWoGE1XUgXmd8g_19v3HnxJ4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Greg Brockman <gdb@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 05:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo6Se-0007o5-13
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab0HYDPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 23:15:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47662 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab0HYDP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 23:15:29 -0400
Received: by ywe9 with SMTP id 9so53096ywe.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DZHGO8ozOa/QWBGkQmiMgIg3tal69f4Pfusgl3c7sUw=;
        b=WRLeofZsDBg2g4nCXZ9r9lcuYSk7Gg37xMFCTLsnExIFLS44b86o9DxPesaHcKqWMT
         NBOdZw+rlDI5DCHngnG5febuA7bd4STqNvgkyEwVorNPAKYVOVjcpX7mPMYR2sPKtBU7
         D/P7mAJhHOnNmypYugKAj1QdK9wW/c9MCQFJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FqhEnpVuLEj/L8ZCSBABvRuQsfWgRdM2zDnAE7nnx0lb71oiIH1+Xv5jMGK44uC0Cd
         WUHt6YrsmvYCnXy6K4jjXrPCdY7h3z8wo/3bCmbQhqB0I9ao1hlwf6B/Ow08VMkoz1Hc
         Y+uPQaVuDw2Jq5SlpNrSYDUZT5lIh6ItCQwzA=
Received: by 10.100.31.15 with SMTP id e15mr269559ane.119.1282706129115;
        Tue, 24 Aug 2010 20:15:29 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h5sm1161874anb.28.2010.08.24.20.15.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 20:15:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikLUQCnrDAp8c0QBWoGE1XUgXmd8g_19v3HnxJ4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154403>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I just try to
> (hopefully mostly helpfully) to point out common things that
> contradict the docs we have

Thanks for doing so, by the way.  One of the best ways to make sure
the docs are sane is to use them.

When a guideline is unclear, probably I should have been updating the
docs instead of dispensing advice.

How about something like this?

diff --git a/t/README b/t/README
index 410499a..f347de7 100644
--- a/t/README
+++ b/t/README
@@ -235,7 +235,9 @@ Do's, don'ts & things to keep in mind
 -------------------------------------
=20
 Here are a few examples of things you probably should and shouldn't do
-when writing tests.
+when writing tests.  If you are editing an existing test script and ha=
ve
+the time for it, consider updating the script to follow these guidelin=
es
+in a separate patch before adding your new test.
=20
 Do:
=20
--=20
