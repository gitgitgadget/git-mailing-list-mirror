From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] t7004-tag.sh: re-arrange git tag comment for clarity
Date: Sun, 14 Nov 2010 11:32:41 -0600
Message-ID: <20101114173241.GB26459@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:33:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgS9-0008QX-0l
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab0KNRdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:33:16 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60667 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:33:15 -0500
Received: by gyh4 with SMTP id 4so2634487gyh.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=12T/IoY+4ikMXyQug/dcx21ek92X9oON99OEGW0EHEg=;
        b=ADM8nuGU7OIfc3i9aaZdG52e7zU7QxpNrP0uAU6wE/qcuWw9xmV0h2iBz+OjCWdxFC
         6QW577m3s93aOIhR9kBlrINVQhQ/kUyL+0v7bH4BCZapnm4W2ZyTNfSTsd5Hh68UoXNz
         G97L3XpL05nLR2JY9Q+N1BD8k1yoa4ARrN60Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QL62PX5akAwNukGqbpNpxDCkVcxsd08HOz6SBzj7iaUn7fe+5ZSuwvmoUSarA0Lx6L
         eeG3pBxvSWz1n/C0VP8Jm1PnQnol4cptMka9Ec/vUKTbE9uCdVVHXRa1JxMcVHoBMBTO
         JD+JUZSgz4a/vsNbBdVgmGSEQmFKj4+QDscEw=
Received: by 10.151.44.17 with SMTP id w17mr7842875ybj.169.1289755994404;
        Sun, 14 Nov 2010 09:33:14 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r6sm2282069yba.11.2010.11.14.09.33.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:33:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289745857-16704-3-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161422>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>                           I used ! instead of test_must_fail so that
> the GIT_EDITOR variable was only used in this command invocation,

	(
		GIT_EDITOR=3Dcat &&
		export GIT_EDITOR &&
		test_must_fail ...
	)

?

>                                                                   and
> because the surrounding tests use this style.

Oh, okay.  I had the test_must_fail version sitting in my local tree
as part of the unsent part of the &&-chaining series
http://thread.gmane.org/gmane.comp.version-control.git/157903/focus=3D1=
60419

I am happy to see this fixed sooner.

[...]
> +test_expect_success \
> +	'message in editor has initial comment: first line' '
>  	# check the first line --- should be empty
> -	first=3D$(sed -e 1q <actual) &&
> -	test -z "$first" &&
> +	echo >first.expect &&
> +	sed -e 1q <actual >first.actual &&
> +	test_cmp first.expect first.actual
> +'
> +
> +test_expect_success \
> +	'message in editor has initial comment: remainder' '
>  	# remove commented lines from the remainder -- should be empty
> -	rest=3D$(sed -e 1d -e '/^#/d' <actual) &&
> -	test -z "$rest"
> +	>rest.expect
> +	sed -e 1d -e '/^#/d' <actual >rest.actual &&
> +	test_cmp rest.expect rest.actual
>  '

Nice.  Note that you've changed the semantics of the test here
(probably for the better): the $() backquoting operator strips
trailing newlines, while your sed expression does not.

I assume you've run the tests and made sure they still pass.

=46or what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
