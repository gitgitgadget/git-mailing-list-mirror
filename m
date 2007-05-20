From: Timo Sirainen <tss@iki.fi>
Subject: Re: [PATCH 1/3] Added generic string handling code.
Date: Sun, 20 May 2007 13:27:29 +0300
Message-ID: <B5F56D1C-4EC2-4A79-9489-B4F1C9FC9BA7@iki.fi>
References: <1179627869.32181.1284.camel@hurina> <20070520100155.GB3106@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16--513813483"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 12:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpidN-0005sa-U0
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806AbXETK1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758775AbXETK1Y
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:27:24 -0400
Received: from dovecot.org ([213.157.71.38]:57433 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757806AbXETK1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:27:23 -0400
Received: from [192.168.10.217] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id AF44FF0B78;
	Sun, 20 May 2007 13:27:21 +0300 (EEST)
In-Reply-To: <20070520100155.GB3106@steel.home>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47815>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16--513813483
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On 20.5.2007, at 13.01, Alex Riesen wrote:

> Timo Sirainen, Sun, May 20, 2007 04:24:29 +0200:
>> So here's my try on starting with something simple. Unlike almost all
>> other string handling libraries, it doesn't allocate the memory
>> dynamically.
>
> Sometimes you _need_ dinamic memory allocation.

It's easy to use the same str_*() functions to implement dynamic  
memory allocation. I think I could have done a bit different naming,  
like maybe:

extern struct string *str_alloc(unsigned int len);
extern void str_append(struct string *str, const char *cstr);

#define static_string(name, size) ..
#define sstr_append(str, cstr) str_append(&(str).string, cstr)


>> This makes it really easy to convert existing code to use it. I'm
>> including some example changes in the other patches. Besides making
>> the code safer, it can also make it faster, especially those
>> strcat() replacements.
>
> It is also bigger, heavier on stack and sometimes slower because of
> more function calls involved.

I would hardly call 8 extra bytes on stack heavier. Also if this was  
used everywhere I wouldn't be surprised if it made the code faster,  
because it would remove a lot of overflow checking code so more code  
will fit into L1 cache.




--Apple-Mail-16--513813483
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (Darwin)

iD8DBQFGUCKVyUhSUUBViskRAluAAKCTQRVZ6RhFveZfEiJRCwu6kdSg1QCgme/t
n8XwhyvoFszSF3wf2Mlu7vw=
=ACkc
-----END PGP SIGNATURE-----

--Apple-Mail-16--513813483--
