From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Fri, 26 Mar 2010 16:45:41 -0500
Message-ID: <20100326214540.GA17503@progeny.tock>
References: <20100322145947.GA1709@pengutronix.de>
 <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
 <7vaatxobef.fsf@alter.siamese.dyndns.org>
 <20100325051743.GB5784@progeny.tock>
 <7v39zmlvz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 22:45:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvHLV-0005XF-MU
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 22:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab0CZVpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 17:45:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40525 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab0CZVpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 17:45:31 -0400
Received: by pva18 with SMTP id 18so1685015pva.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 14:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QkC1K2WeFKdhf4t9UcDa80CGqSRZxRl+VCwfepbWF3M=;
        b=PQ3eQzDE6Gea9kidPTL5mtSIzxo6bEY4R4mQ27VWHZvoiEfA3akvjsGQDQffbTZ/rL
         huibSgerKph0jvQmaFAbnZsQtNS49GkmGFmE7f+86uOl64Uaps/eMfPUmmG03g+qdFx+
         JEh6X2dN+f/8ih4pXMl8CVexBKt4OZPMfQbGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f5hcsgn3PcCzZqw1/XK4BMakY9RCpVHJcpobfPnocnq2BJa29rNbPs4P4tJvMUj1HG
         OiDdSRgexWJZFhdJ6IuReOeAU3kP6QqZTM4+RFD/T6K91OT1gk3Z5TF7LD+It6cgNKLE
         4Dh9cmn86yCEfGGhTjnepqO9p+C/+Oeg9klow=
Received: by 10.142.208.10 with SMTP id f10mr742545wfg.336.1269639930947;
        Fri, 26 Mar 2010 14:45:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 11sm381862pwi.1.2010.03.26.14.45.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 14:45:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39zmlvz1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143287>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Yes, please.  It would be more precise to
>>
>>   s/without a tty/with TERM=3Ddumb/
>>
>> in the second paragraph but regardless this is a good description of=
 the
>> problem.
>
> Strictly speaking, with TERM=3Ddumb the true "vi" fell back to the ex=
 mode
> and should have been usable.  A purist might say it is a bug that we =
fatal
> out in this case (I know that it is deliberately done to help newbies=
 from
> common confusion by not running any editor with TERM=3Ddumb, but to a=
 purist
> in me it feels somewhat wrong).

With DISPLAY set, running =E2=80=9CTERM=3Ddumb vi | cat=E2=80=9D with a=
n appropriate
symlink in $PATH:

vim
	Prints =E2=80=9CVim: Warning: Output is not to a terminal=E2=80=9D to =
stderr,
	waits about a second, then
	runs without clearing the screen, using ANSI escapes to move around.

elvis 1.4
	Prints =E2=80=9CThis termcap entry lacks the :up=3D: capability=E2=80=9D=
 to stderr,
	fails with status 1.

elvis 2 (more precisely, the elvisnox script from Debian)
	Prints =E2=80=9Ctermcap needs up=E2=80=9D to stderr,
	fails with status 1.

nvi
	Prints =E2=80=9Cex/vi: Vi's standard input and output must be a termin=
al=E2=80=9D to stderr,
	fails with status 1.

With TERM=3Ddumb but standard output going straight to the terminal, th=
e
situation is not very different for vim and elvis, while nvi gets
utterly confused (it only writes output to the bottom line for some
reason).

So I think it still makes sense to work around this bug in the vi clone=
s.

HTH,
Jonathan
