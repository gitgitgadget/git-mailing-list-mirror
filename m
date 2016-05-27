From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 14/22] i18n: rebase-interactive: mark strings for
 translation
Date: Fri, 27 May 2016 10:08:32 +0000
Message-ID: <57481CA0.5080801@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <1464031661-18988-15-git-send-email-vascomalmeida@sapo.pt>
 <xmqqpos8tpjo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 12:08:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6EhB-0006IP-JG
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 12:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbcE0KIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 06:08:41 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:51229 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752001AbcE0KIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 06:08:40 -0400
Received: (qmail 27440 invoked from network); 27 May 2016 10:08:38 -0000
Received: (qmail 20350 invoked from network); 27 May 2016 10:08:38 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 27 May 2016 10:08:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqpos8tpjo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295745>

=C0s 22:36 de 26-05-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> @@ -222,9 +223,10 @@ has_action () {
>>  }
>> =20
>>  is_empty_commit() {
>> -	tree=3D$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
>> -		die "$1: not a commit that can be picked")
>> -	ptree=3D$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
>> +	sha1=3D$1
>> +	tree=3D$(git rev-parse -q --verify "$sha1"^{tree} 2>/dev/null ||
>> +		die "$(eval_gettext "\$sha1: not a commit that can be picked")")
>> +	ptree=3D$(git rev-parse -q --verify "$sha1"^^{tree} 2>/dev/null ||
>>  		ptree=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904)
>>  	test "$tree" =3D "$ptree"
>>  }
>=20
> Both of the two callsites of this function use the variable $sha1,
> and at least one of them uses that variable after this function
> returns, but they pass it as the first parameter to this function,
> so the assignment added by this patch does not break them, which is
> good.
>=20
I didn't know that. I can change sha1=3D$1 to local_sha1=3D$1 or _sha1=3D=
$1 (I
don't know what is the convention here) if that is safer, avoiding usin=
g
the bash-ism "local" keyword, and preventing future distractions.
