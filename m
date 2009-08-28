From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 21:20:50 +0200
Message-ID: <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828190319.GA9233@blimp.localdomain>
	 <20090828191521.GA12292@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh70W-0006Fi-7x
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZH1TUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 15:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZH1TUv
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:20:51 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41229 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbZH1TUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 15:20:50 -0400
Received: by bwz19 with SMTP id 19so1785211bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pDryQ9ukfYB1h5H0rlgcBl1Fnefq+KBWnJfcJYegjdE=;
        b=EqbVsu/UOQtO8sxrf7mI2CfUY+91s1dTXJNhhyiwIrWPFIxbkR9sNFm6LSPytbreLu
         Xric8q04vbKSsaSGM+xaa1Um3CAZpeyd97+nul+cPkvx5klcU0iTfrEpvvhe8MQh8VhA
         PlWlRoXv90wAcCqASwC2Zmal8lBmCT5ylekrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ms9qjTpXsQsp1q2lc16S10YhpIS1pDgMf/YyiWZqwR7swMU0U0Em0JWthJrqBWR/oh
         GMFVB5IHE2tL/IqkevFuaoytxqpmAhCOrjv+3i1MvS2zLeBKvg49tigQwsAhoaugzW5V
         kKpyvXzPWygQnzbUtMWJ2MeolMjO58qX6ahPw=
Received: by 10.204.161.197 with SMTP id s5mr1256122bkx.8.1251487250922; Fri, 
	28 Aug 2009 12:20:50 -0700 (PDT)
In-Reply-To: <20090828191521.GA12292@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127338>

On Fri, Aug 28, 2009 at 21:15, Jeff King<peff@peff.net> wrote:
> On Fri, Aug 28, 2009 at 09:03:19PM +0200, Alex Riesen wrote:
>
>> +unsigned long approxidate(const char *date)
>> +{
>> + =C2=A0 =C2=A0 struct timeval tv;
>> + =C2=A0 =C2=A0 gettimeofday(&tv, NULL);
>> + =C2=A0 =C2=A0 return approxidate_relative(date, &tv);
>> +}
>
> This now always calls gettimeofday, whereas the original approxidate
> only did if parse_date failed.

Oh, bugger...

> On the other hand, refactoring the relative date code into its own
> function is probably a good thing in the long run.

Exactly.
