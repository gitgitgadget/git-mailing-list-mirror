From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 0/5] Lazily generate header dependencies
Date: Thu, 7 Jan 2010 14:22:08 +0100
Message-ID: <40aa078e1001070522k2be6c490se5d45faffca764f1@mail.gmail.com>
References: <4B0F8825.3040107@viscovery.net>
	 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
	 <20091127174558.GA3461@progeny.tock>
	 <20100101090550.6117@nanako3.lavabit.com>
	 <20100107071305.GA11777@progeny.tock>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 14:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSsJd-0007F3-Ef
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 14:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab0AGNWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 08:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460Ab0AGNWL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 08:22:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:20573 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0AGNWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 08:22:10 -0500
Received: by fg-out-1718.google.com with SMTP id 19so7486128fgg.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VskstX2zoAOD4t7xbKrTdVY2joCk4LG4HYLTBC5IMX4=;
        b=GHSukkGXHSaz/jKVhtSVL8HHDgxAB/hRRZ3Lf46XLaM+gwugszRJO3S6yuQndpYeyU
         SVmvrDotSR0KRNf90K0GL6W3kApK8tnI49dntQYmQrDbb3y0flfkfMxQ0yb4JtKpIt4z
         5OdSEQM80Jc8Z2kzuNpmpu7l15Rxbcy958cRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=a0ji8MFYfiEtvWPtjegnQTi5o1ZFj3p6Kns3MkmW6DUgwvjbaiO2sLB0lE/VNTk+Rk
         BgKGKhID1GCVKrmSBAngSvxByhhJIKPUglD8Weq6nbxwzrJo3k+R2Y+sc3d8TrFrY8kl
         helvYeL7ckXeDuy+AIkJj3SzkUcdGHdBgMVMg=
Received: by 10.216.90.209 with SMTP id e59mr3817521wef.193.1262870528699; 
	Thu, 07 Jan 2010 05:22:08 -0800 (PST)
In-Reply-To: <20100107071305.GA11777@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136342>

On Thu, Jan 7, 2010 at 8:13 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Nanako Shiraishi wrote:
>> Junio, could you tell us what happened to this thread?
>>
>> Makefile improvements. =A0No discussion.
>
> My bad. =A0The previous version was very rough because I was not sure
> yet how this could help in making the header dependency rules more
> maintainable. =A0If all compilers worth using support something like
> gcc's -MD option (does MSVC?), we could switch over completely;
> otherwise, we need some way to use the generated dependencies to
> check the static ones, or the static ones will go stale.

Nope, there's no support for -MD in MSVC. It does have an "/MD"
option, but it means something completely different (link with
multithreaded DLL CRT). There IS the "/showIncludes" option [1], which
should make it possible to do some build-magic to generate the correct
dependency-files, though.

[1] http://msdn.microsoft.com/en-us/library/hdkef6tk(VS.71).aspx

--=20
Erik "kusma" Faye-Lund
