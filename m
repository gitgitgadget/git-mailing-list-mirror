From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6] git-p4: add config git-p4.pathEncoding
Date: Thu, 3 Sep 2015 19:24:52 +0200
Message-ID: <9986CCDA-DB0B-4D7E-B758-668A46010188@gmail.com>
References: <1441271647-67824-1-git-send-email-larsxschneider@gmail.com> <1441271647-67824-2-git-send-email-larsxschneider@gmail.com> <xmqqa8t3l9km.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de,
	sunshine@sunshineco.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 19:25:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXYFw-0007yg-4o
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 19:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707AbbICRY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 13:24:56 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36341 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbICRY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 13:24:56 -0400
Received: by wibz8 with SMTP id z8so106466381wib.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=crJhsjwieaVfkD7wqBy8Yoxg4nrcNCviaeECkn6Z4bw=;
        b=NvytFYwC4he4q866c05BXkGdc9T5XkJ6XB/Trwd0rqdeVmprhztnUTnQp+X/cVgT5W
         rTUBAUqhdSuRvC8nzTlDes8vCIEvAzP1ZUtyQbNTEL4crG/K4v2fSOeYCWmhLxqFL0Y/
         syDxnzHA0q25dKh7zDMyzT3MNEFzcAfEkmjDuLgktS8mjeXMXp+RSmRt4ZVJlDIcsqG2
         Up1HZJnOucibnAwDp8mGPVtWQjyzUSFUAcju4CrdOKfUSV69VymbAOFJ0eT6Sm9Xjyjn
         U6Mno/3srZdXtYPlw3AUAW29gD2JeNOx3Qz8MUeLmykzmqP3pzqs6qLEm8JsxE45cE7h
         PUVA==
X-Received: by 10.180.149.146 with SMTP id ua18mr16460979wib.86.1441301094959;
        Thu, 03 Sep 2015 10:24:54 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id hr17sm9998041wib.16.2015.09.03.10.24.53
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 10:24:54 -0700 (PDT)
In-Reply-To: <xmqqa8t3l9km.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277235>


On 03 Sep 2015, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> +test_expect_success 'Clone repo containing iso8859-1 encoded paths =
without git-p4.pathEncoding' '
>> +	git p4 clone --destination=3D"$git" //depot &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
>> +		echo $UTF8 >expect &&
>> +		git -c core.quotepath=3Dfalse ls-files >actual &&
>> +		test_must_fail test_cmp expect actual
>=20
> I am not sure what this test wants to do.  It is not inconceivable
> that future versions of "git p4 clone" becomes more intelligent to
> detect the need for git-p4.pathEncoding and set it, so the only
> effect to insist the comparison fails is to block future advance in
> that direction.
>=20
> Besides, "test_must_fail test_cmp" looks like a strange thing to
> say.  "! test_cmp expect actual" perhaps.
>=20
> Even better, expect that "expect" and "actual" becomes the same, but
> mark the test itself to expect failure, to say "it ought to work
> this way in the ideal world, but we know the system currently does
> not pass this test".
>=20
> I'm tempted to suggest squashing the following in.  Thoughts?
OK. The diff looks good to me. For some reason I can=92t apply the patc=
h though. git patch gives me "fatal: corrupt patch at line 10=94. Any i=
dea? (I might do something stupid because I am not used to patches=85)

Thanks,
Lars

>=20
>=20
> t/t9822-git-p4-path-encoding.sh | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-en=
coding.sh
> index e507ad7..2d652d89 100755
> --- a/t/t9822-git-p4-path-encoding.sh
> +++ b/t/t9822-git-p4-path-encoding.sh
> @@ -21,15 +21,15 @@ test_expect_success 'Create a repo containing iso=
8859-1 encoded paths' '
> 	)
> '
>=20
> -test_expect_success 'Clone repo containing iso8859-1 encoded paths w=
ithout git-p4.pathEncoding' '
> +test_expect_failure 'Clone auto-detects depot with iso8859-1 paths' =
'
> 	git p4 clone --destination=3D"$git" //depot &&
> 	test_when_finished cleanup_git &&
> 	(
> 		cd "$git" &&
> 		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
> -		echo $UTF8 >expect &&
> +		echo "$UTF8" >expect &&
> 		git -c core.quotepath=3Dfalse ls-files >actual &&
> -		test_must_fail test_cmp expect actual
> +		test_cmp expect actual
> 	)
> '
>=20
> @@ -39,16 +39,15 @@ test_expect_success 'Clone repo containing iso885=
9-1 encoded paths with git-p4.p
> 	(
> 		cd "$git" &&
> 		git init . &&
> -		test_config git-p4.pathEncoding iso8859-1 &&
> +		git config git-p4.pathEncoding iso8859-1 &&
> 		git p4 clone --use-client-spec --destination=3D"$git" //depot &&
> 		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
> -		echo $UTF8 >expect &&
> +		echo "$UTF8" >expect &&
> 		git -c core.quotepath=3Dfalse ls-files >actual &&
> 		test_cmp expect actual &&
> -		cat >expect <<-\EOF &&
> -		content123
> -		EOF
> -		cat $UTF8 >actual &&
> +
> +		echo content123 >expect &&
> +		cat "$UTF8" >actual &&
> 		test_cmp expect actual
> 	)
> '
