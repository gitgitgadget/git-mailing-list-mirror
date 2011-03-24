From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: reserve some letters after a colon pathspec
Date: Thu, 24 Mar 2011 14:49:20 +0700
Message-ID: <AANLkTinjdi3+qcQxcBYj8SdQgbZYP=KiLwxM3Vq0c1Er@mail.gmail.com>
References: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <1300894353-19386-1-git-send-email-pclouds@gmail.com> <7vvcz9emrn.fsf@alter.siamese.dyndns.org>
 <4D8AEF9B.9050001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:49:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2fIr-0001VA-LM
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306Ab1CXHtw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 03:49:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49907 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab1CXHtv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 03:49:51 -0400
Received: by wwa36 with SMTP id 36so11208959wwa.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=a1R2Uqzf9dRJSM4VEOoBKYqmUY9szNbfYijKenH4sp8=;
        b=YI36uh6lmh0jyBl3yP9foasWrezY65rK4wN5SjwNCcXBpu9Lz5VDIYsDvV7PGW67xu
         IWx45Ctlz//WWXXRo0/B78CDc115OEE5c+HK95jR0iHR1m37sYFq1K7ZV30Go2q4cGve
         jpsz4P8vlOb93gg2cUckIUSG4fZX7HQISCaJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XFJV4CMOFfb+8znKn6H/ZTm+SzrHkgIIJlGBmOxWmPpaW3Chl5k77DFik/wgaoiuta
         KdSyVxsTN2OKzLedcPN1S5YB8Pddgf+eYpZUCXVw+YqRC4KVHAUi524zLSfQmJ7aausU
         D7wiEQgwxem7fEMR3raHBI27LDoucDJ3NxbQ0=
Received: by 10.216.66.131 with SMTP id h3mr7787510wed.111.1300952990134; Thu,
 24 Mar 2011 00:49:50 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Thu, 24 Mar 2011 00:49:20 -0700 (PDT)
In-Reply-To: <4D8AEF9B.9050001@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169902>

2011/3/24 Michael J Gruber <git@drmicha.warpmail.net>:
>> Here is a weather-baloon. =C2=A0I will use colon below as the magic =
introducer,
>> as I don't care very deeply about the choice of it.
>>
>> =C2=A0- "^:([^\w\d]+)(.*)$", that is "a magic introducer followed by=
 a sequence
>> =C2=A0 =C2=A0of non-alnum followed by the remainder" means that the =
part that is
>> =C2=A0 =C2=A0given to the matching engine is $2, and each gibberish =
character in $1
>> =C2=A0 =C2=A0determines what magic is requested when the matching en=
gine does its
>> =C2=A0 =C2=A0work. =C2=A0Among the gibberish that can be in $1, we c=
urrently would want
>> =C2=A0 =C2=A0to support:
>>
>> =C2=A0 =C2=A0 . '/' denotes that $2 is relative to root of the worki=
ng tree, i.e. do
>> =C2=A0 =C2=A0 =C2=A0 not add 'prefix' to it at the left.
>>
>> =C2=A0 =C2=A0 . '!' denotes that the matching with $2 should not hon=
or globbing.
>>

And maybe:

    . ':' to reach the superproject if user's inside a subproject. So
'::/foo' means foo at superproject while ':/foo' means foo in the
current project, both at root.

>> =C2=A0...
>
> I like this a lot, especially the fact that we would have descriptive
> long names as well as short versions for a subset!

I'll leave it to you to come up with something we can test :)

> Two remarks:
>
> :(symlink|submodule|directory|file): would fit into that scheme (for =
use
> in .gitattributes), though I'm not sure we want that for general
> pathspecs. We probably want textconv applied to :file: only by defaul=
t,
> attributes to match with :file only?

It does not hurt to have generic support for everything. 'git ls-files
-- :executable:' would be nice, though I'm not sure if I will ever use
it.

> We already have ":./cdwfile" as in "commit:./cwdfile", and this looks
> like a preexisting instance, although it is not ("commit:" gets strip=
ped
> and "./cwdfile" is the pathspec). People will probably try something
> like "commit:/rootfile", and we may or may not want to support this.
> That particular one is easy, but "commit:full-tree:name" has a define=
d
> meaning now...

I think we should leave this one out. It's to address a single path.
If you bring full pathspec support to it, a pathspec may resolve to
multiple paths, which is unwanted. If people want pathspecs, they can
do "git cmd commit -- pathspecs" most of the time.
--=20
Duy
