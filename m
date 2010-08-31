From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 05/17] gettext: make the simple parts of git-init
 localizable
Date: Tue, 31 Aug 2010 10:44:46 -0500
Message-ID: <20100831154446.GJ2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-6-git-send-email-avarab@gmail.com>
 <20100831150301.GE2315@burratino>
 <AANLkTikd7mc4DjTVaKip_WFqVdezE13ZbL+Vmfqd8yCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:46:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqT2n-0000nw-Nz
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570Ab0HaPqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:46:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46648 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171Ab0HaPqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:46:31 -0400
Received: by vws3 with SMTP id 3so5471737vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OpH12ywJhAwigWqDhhBOZJvTYf+lu+cTyNjHYNwFrps=;
        b=oZ338v/8Tg2C0fwzfZ3RjiuoiNgRmpuhU2krTIBNSzyovMeUWIXGDpvRenk0zsGB4t
         GdnPi90a73QmYkp9/73XyS38T8OpEr6cvNZkZIFY7PomNev0en5rj/vrRlHCbxAdbnDs
         YZPSlPmOA3W7qLrIx8dV068tguXb16GYhjllw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Xn49d4ja+wPVqn9q+F3Kf1Vgra2Okxd7JQQOI1fIJpZRBjQLVzG47OcaNQSFi8riMz
         XfD4j15ZKJ5zU1uJUuuPWUrhG5+1ns4SMor9pyzLddvQYNvuRQ8fFOZzp7inSz9Jud7/
         iDpmF9JDXhU0h7u/PEoRvxEnZ4HNcXV81wsr4=
Received: by 10.229.2.24 with SMTP id 24mr4230500qch.276.1283269590482;
        Tue, 31 Aug 2010 08:46:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t4sm9840295qcs.40.2010.08.31.08.46.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:46:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikd7mc4DjTVaKip_WFqVdezE13ZbL+Vmfqd8yCu@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154917>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The only way that could work is if I taught xgettext to extract
> strings passed to die(), but then managing the false positives would
> probably be more effort than just marking them manually, and it would
> be a big load on the translators:
>=20
>     $ ack 'die\("(.*?)"' --output '$1' *[ch] builtin/*[ch] | sort -u =
| wc -l
>     1153

To pursue this a little further: would there be any false positives?

We could avoid overwhelming translators by waiting until a file has
been fulling gettextized before allowing xgettext to scavenge it
(i.e., temporarily using a hard-coded list of files in the xgettext
invocation).

>> Will strerror() cope correctly without LC_CTYPE set up? =C2=A0(Not p=
art
>> of this series, just something I was reminded of.)
>
> My GNU/Linux strerror(3) claims to use LC_MESSAGES, but I didn't test
> it.

Sounds like no, then.

$ cat foo.c
#include <stdio.h>
#include <locale.h>
#include <errno.h>

int main(void)
{
        setlocale(LC_ALL, "");
        setlocale(LC_CTYPE, "C");
        errno =3D ENODEV;
        perror("test");
        return 0;
}
$ make foo
cc     foo.c   -o foo
$ ./foo
test: No such device
$ LANG=3Dde_DE.UTF-8 ./foo=20
test: Kein passendes Ger?t gefunden
