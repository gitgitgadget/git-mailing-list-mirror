From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Fri, 1 Oct 2010 06:52:24 -0500
Message-ID: <20101001115224.GB18405@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-3-git-send-email-newren@gmail.com>
 <7vd3rwo22t.fsf@alter.siamese.dyndns.org>
 <AANLkTiksEBVUyJnrUETxManHa+ZMCT6+V3C83K75KW2A@mail.gmail.com>
 <20101001102315.GA6816@burratino>
 <AANLkTinqVTqxiHL5tEv+-SS6YURGUoWaPxCgpccZgjEq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1eDC-0004C8-4l
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036Ab0JALzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 07:55:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62973 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab0JALzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 07:55:32 -0400
Received: by gxk9 with SMTP id 9so1098127gxk.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=elkJAgMM2XJAWlmRg3auZkwmd8HPKYB3G8tNkl10JKw=;
        b=KrXeb1DhQk3oJbEE4qHsymnmmSd0ztD4fk/jG/+lz0pxYGFfsLDUetZljksaM3YHNT
         1UX43q4bmZtecsbddkvPW1JYnGDua1MJVQOrH8cqXnG4G6gNH1CHmE7TCAP8bu0+TmdF
         7PeKSldh+/b0BxNn51cDZYnI1b/PiYqgW3WVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fDwiFAlH6j958fYCps2DWsfOHcod25wVPblGspNyxZgUFlfa1aOarPgm0BERTnK4Bg
         PT5+2y8YqxsK1s3+gAiBkOQIsifbvBMkYxrRQbDwMeTlezuGRzZtKQzgWEZXUQKIL9qY
         U6YmGBQ8EPG6MpBgXvaRwwKPTCgWboq9revgw=
Received: by 10.90.50.5 with SMTP id x5mr1337104agx.62.1285934131651;
        Fri, 01 Oct 2010 04:55:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r20sm1741413anf.27.2010.10.01.04.55.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 04:55:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinqVTqxiHL5tEv+-SS6YURGUoWaPxCgpccZgjEq@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157749>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Oct 1, 2010 at 10:23, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> +check_exit_status () {
>> + =C2=A0 =C2=A0 =C2=A0 echo "$1" >expect.status
>> + =C2=A0 =C2=A0 =C2=A0 shift
>> + =C2=A0 =C2=A0 =C2=A0 "$@"
>> + =C2=A0 =C2=A0 =C2=A0 echo "$?" >actual.status
>> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect.status actual.status
>> +}
>
> If we add this it should be in the test-lib.sh, it'll probably be
> useful for other tests.

=46WIW a more generally useful function would have to look something
like this:

test_exit_status () {
	want_code=3D$1
	shift
	"$@"
	exit_code=3D$?
	if test $exit_code =3D $want_code
	then
		return 0
	else
		echo >&2 "test_exit_status $want_code: command had status $exit_code:=
 $*"
		return 1
	fi
}

to avoid touching the file system.

>                                                               and
> change the tests using test_expect_code in t1504-ceiling-dirs.sh and
> t6020-merge-df.sh to use test_expect_success + test_expect_code.

Not a bad thing to do anyway.
