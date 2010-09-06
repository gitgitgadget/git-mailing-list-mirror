From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/15] gettextize: git-revert split up "could not
 revert/apply" message
Date: Mon, 6 Sep 2010 13:55:47 -0500
Message-ID: <20100906185547.GF25426@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-15-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsgtB-0003fP-0J
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab0IFS5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 14:57:52 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39259 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0IFS5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 14:57:51 -0400
Received: by qyk36 with SMTP id 36so2663665qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wT5BFPKYGsperi8R2nhpJUy5F1+yvGN0xENDze6wsrM=;
        b=UvQBeOk9NsqHJ1hsj79VQQRtwuPaoPk8t/9oCsLhjF1FIPNO4pg/RhCIyaT2cK8hwx
         Lgo+jE2tCBRxUscDb00NJ7f8U/51m3qUg2ths9yf7ctRH5gbllzk/hHgKyR5RxTDtJC4
         1jmTxwuwzjuTfrkVefefmx6EkXynXusYCbDoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wcq5MI0KqCIj/yg5tZsl1aWWVx51up9i3hDbzG/sB9gbMz0qXGTYoeujbhdSeUxixj
         ViDD6VAzfY5rEU4ERmD9uk6LckjQoX5hbB2rCMMQWJiWo1/de438QzsTRDykljln/luE
         6j8t546H3y44RyprYgiQ5fD+Qz2Gb3ZAsCYDA=
Received: by 10.229.181.210 with SMTP id bz18mr3857783qcb.43.1283799470223;
        Mon, 06 Sep 2010 11:57:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l8sm5941782qck.6.2010.09.06.11.57.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 11:57:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283775704-29440-15-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155601>

(+cc: Christian)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Split up the "could not %s %s... %s" message into "could not revert
> %s... %s" and "could not apply %s... %s". This makes it easier for
> translators to understand the message.

Right, parts of speech can be a pain.  So:
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -38,7 +38,7 @@ test_expect_success 'failed cherry-pick does not ad=
vance HEAD' '
>  	test "$head" =3D "$newhead"
>  '
> =20
> -test_expect_success 'advice from failed cherry-pick' "
> +test_expect_success NO_GETTEXT_POISON 'advice from failed cherry-pic=
k' "

An idea (it may or may not be a good one ;-)): what if we made the gett=
ext
poison into an automatically generated .po file?  Then testing poison
would be a special case of running tests with an arbitrary locale:

 $ TEST_LANGUAGE=3Dpoison prove t[0-9]*.sh

and this test prerequisite could be more intuitively named LOCALE_C or
similar.
