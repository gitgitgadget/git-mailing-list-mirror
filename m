From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 to deepen into full repo again
Date: Fri, 20 Aug 2010 11:22:08 +0200
Message-ID: <201008201122.09392.jnareb@gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com> <m362z6pact.fsf@localhost.localdomain> <AANLkTinQZxpLdFiCFH3kDTFVQ-ZLjJ1PEdmmsJSb=0YD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, computerdruid <computerdruid@gmail.com>,
	joey <joey@kitenet.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 11:22:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmNnw-0005LT-NV
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 11:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0HTJWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 05:22:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52310 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab0HTJWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 05:22:16 -0400
Received: by fxm13 with SMTP id 13so1668585fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tcRg8xfmyCSh9rsyuYPZ0qtTwzOC5fw9xrcRHFpvY2Q=;
        b=UAvBCUYnxcj+509Qh0pYjiZthh9scD1oGTslPLnznIIhdmR2Em9jhZXtNRXmbXinZQ
         I0gPsyUeij+aiJcY+nOFhoyBCcZlPcQVCw6gZV/l8d5Ovu47wljFJQBoF76BtnLVf62h
         N7jMY8KuL42ZWYCVct20BDJ5nOxeOdU4B5xA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WC6iVX9LxeLAQptxowySbz7AqEY1KTsXlXnryLz72jHdfttftX8rFBPtF7n7Bx/kex
         GJqc9T7nA3SHo+XWxxMpnIDiLemKAa1JUvL0BpjH8GB3Kmd/kdnN5no04cwGd0PWr5gE
         bJGjDvTNQym+2jsJpRnKZo20bis3Ss1kQZn7k=
Received: by 10.223.119.210 with SMTP id a18mr852969far.52.1282296134693;
        Fri, 20 Aug 2010 02:22:14 -0700 (PDT)
Received: from [192.168.1.13] (abvr199.neoplus.adsl.tpnet.pl [83.8.215.199])
        by mx.google.com with ESMTPS id 5sm1105484fat.23.2010.08.20.02.22.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 02:22:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinQZxpLdFiCFH3kDTFVQ-ZLjJ1PEdmmsJSb=0YD@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153990>

On Fri, Aug 20, 2010, Nguyen Thai Ngoc Duy wrote:
> On Fri, Aug 20, 2010 at 7:22 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> =C2=A0The funny thing is, even with --depth=3D0, I still have two c=
ommit grafts
>>> =C2=A0in $GIT_DIR/shallow, which are grafts of tags. I think there =
is a bug
>>> somewhere..
>>>
>>> =C2=A0builtin/fetch-pack.c | =C2=A0 =C2=A02 +-
>>> =C2=A0shallow.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02 +-
>>> =C2=A0upload-pack.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 +++=
+----
>>> =C2=A03 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>
>> Fist, it lacks documentation update that --depth=3D0 means infinite
>> depth (making repository not-shallow).
>=20
> Yeah. I would do documentation and tests later once I figured out why
> --depth=3D0 did not give me full repo. It turns out I need --tags to
> (refetch?) tags and have full repo.

Perhaps --depth=3D0 should also work as if --tags were specified on
command line?  BTW. shouldn't git fetch tags that point to commits
that got doenloaded because of deepening the clone?

>=20
>> Second, it would be nice (though probably not easy with parseopt, as
>> it would require hacks/extensions) to be able to use --depth=3Dinf
>> (like wget supports '-l inf') to mean infinite depth...
>=20
> Hmm.. make --depth a string parameter and fetch-pack should parse the
> parameter itself, like git-clone. Good idea.

If there were more options that use <n> =3D=3D 0 to actually mean unlim=
ited
(infinity), perhaps it would be better to extend parseopt to provide fo=
r
such situation, e.g. OPT_INT_INF or something.  This way we would avoid
code duplication.

=2E.. oh, wait, the newly introduced[1] git-merge `--log-limit' option
uses --log-limit=3D0 to mean unlimited.

[1] http://permalink.gmane.org/gmane.comp.version-control.git/153984
    Message-ID: <20100820081641.GA32127@burratino>
    Subject: Re: wishlist bugreport: make limit configurable for do_fmt=
_merge_msg (merge.log)

--=20
Jakub Narebski
Poland
