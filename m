From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 18/22] tests: use test_i18n* functions to suppress
 false positives
Date: Fri, 27 May 2016 19:34:18 +0000
Message-ID: <5748A13A.6070608@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <1464031661-18988-19-git-send-email-vascomalmeida@sapo.pt>
 <xmqqd1o7sa30.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 21:34:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6NWg-0007wU-1q
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 21:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbcE0TeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 15:34:23 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35596 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753221AbcE0TeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 15:34:22 -0400
Received: (qmail 21144 invoked from network); 27 May 2016 19:34:19 -0000
Received: (qmail 746 invoked from network); 27 May 2016 19:34:19 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 27 May 2016 19:34:19 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqd1o7sa30.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295788>

=C0s 17:08 de 27-05-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
>> index 3c6791e..4079fef 100755
>> --- a/t/t1307-config-blob.sh
>> +++ b/t/t1307-config-blob.sh
>> @@ -64,7 +64,7 @@ test_expect_success 'parse errors in blobs are pro=
perly attributed' '
>> =20
>>  	# just grep for our token as the exact error message is likely to
>>  	# change or be internationalized
>> -	grep "HEAD:config" err
>> +	test_i18ngrep "HEAD:config" err
>>  '
>=20
> It is unfortunate that the gettext-poison mechanism is too dumb to
> notice that it is clobbering a format string with placeholders and
> leave them intact, which is what the comment above this change is
> wishing for.  I do not think we will be granting that wish any time
> soon, so perhaps remove the two lines while we are at it?
>=20
Yes, that was more or less what I thought when read that comment, but
forgot about it after.
I'll remove that comment in the next re-roll. Also, because it can be
deceiving for someone not entirely sure how does gettext poison,
translations and tests work together when test are run.

=46or the record, test are run under C locale, so translations don't
matter in tests. Under GETTEXT_POISON build, all strings interpolated b=
y
gettext (for instance _("a message from git") in C language) are
replaced by garbage string "# GETTEXT POISON #".
