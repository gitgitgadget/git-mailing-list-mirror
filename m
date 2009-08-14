From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Fri, 14 Aug 2009 22:23:06 +0200
Message-ID: <200908142223.07994.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <m3skfwnihn.fsf@localhost.localdomain> <fcaeb9bf0908130538x396b1208s43d312107e3e198c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:23:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3JI-0005Um-1H
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137AbZHNUX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbZHNUX2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:23:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:32052 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbZHNUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:23:27 -0400
Received: by fg-out-1718.google.com with SMTP id e12so134307fga.17
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2gLuwlyhdaNxP+P50YqQ0R+ILD65dRLDIj4vLOUy2kQ=;
        b=JDGiJXTqFm3PP8yETb8n2aHEHZiA5+Cy/mLzS1UZrndL68jeiYWsdHny5jJX6d2MMa
         6J7bNgwybDIdhKc+H6kkBk5IQ7kMG6IVnXSBOuEQWy3p0ziXVDJyQEfH7UUL2Pvupy3c
         nCEnvEKhj81iFCZpjUOgOs7ccNYTRlXQkHfi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VItWdaIF00WA8SNOeyouRDbiqRJz8k4Z1Mw2OBN6Tz9enxosIZ2/KBL8MAD8nMKwtR
         ikAXo3UkzUvJp6fhBzX2mggoSxxvgbXAUVWfXrkLRQupQMlmTjcCl6t39siVDJMa+nuM
         2vUW6qgCj9mCeJXLwliOTz9L4TSvYyx8yMXKo=
Received: by 10.86.229.18 with SMTP id b18mr1374185fgh.34.1250281407624;
        Fri, 14 Aug 2009 13:23:27 -0700 (PDT)
Received: from ?192.168.1.13? (abwe173.neoplus.adsl.tpnet.pl [83.8.228.173])
        by mx.google.com with ESMTPS id d6sm6409644fga.5.2009.08.14.13.23.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 13:23:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0908130538x396b1208s43d312107e3e198c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125946>

Dnia czwartek 13. sierpnia 2009 14:38, Nguyen Thai Ngoc Duy napisa=C5=82=
:
> On 8/13/09, Jakub Narebski <jnareb@gmail.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>> 2009/8/12 Junio C Hamano <gitster@pobox.com>:
>>
>>>> It could also require core.sparseworktree configuration set to tru=
e if we
>>>> are really paranoid, but without the actual sparse specification f=
ile
>>>> flipping that configuration to true would not be useful anyway, so=
 in
>>>> practice, giving --sparse-work-tree option to these Porcelain comm=
ands
>>>> would be no-op, but --no-sparse-work-tree option would be useful t=
o
>>>> ignore $GIT_DIR/info/sparse and populate the work tree fully.
>>>
>>> Only part "ignore $GIT_DIR/info/sparse" is correct.
>>> "--no-sparse-work-tree" would not clear CE_VALID from all entries i=
n
>>> index (which is good, if you are using CE_VALID for another purpose=
).
>>>
>>> To quit sparse checkout, you must create an empty
>>> $GIT_DIR/info/sparse, then do "git checkout" or "git read-tree -m -=
u
>>> HEAD" so that the tree is full populated, then you can remove
>>> $GIT_DIR/info/sparse. Quite unintuitive..
>>
>>
>> Hmmm... this looks like either argument for introducing --full optio=
n
>>  to git-checkout (ignore CE_VALID bit, checkout everything, and clea=
n
>>  CE_VALID (?))...
>>
>>  ...or for going with _separate_ bit for partial checkout, like in t=
he
>>  very first version of this series, which otherwise functions like
>>  CE_VALID, or is just used to mark that CE_VALID was set using spars=
e.
>=20
> In my opinion, making an empty .git/info/sparse to fully populate
> worktree is not too bad. I wanted to have plumbing-level support in
> git so that you could try sparse checkout on your projects (possibly
> with a few additional scripts to make your life easier). Then good
> Porcelain UI may emerge later (or in worst case, people would roll
> their own sparse checkout).

Deciding whether sparse checkout should use CE_VALID only, or should it
(as it was in the very first version of series) use additional flag,=20
either CE_NO_CHECKOUT, or CE_VALID_IS_USED_HERE_FOR_SPARSE_CHECKOUT ;-)
is a design decision about *plumbing-level* support.

Note that shallow clone, while using the same mechanism as grafts file,
nevertheless use separate file; so perhaps sparse checkout while using
the same mechanism as --assume-unchanged should use additional flag.


BTW. you might want to use GIT_SPARSE_FILE, similar to GIT_INDEX_FILE;
see the fact that plumbing doesn't have .gitignore not .git/info/exclud=
es
hardcoded... well, except for --standard-excludes.  This way full
checkout would be as simple as using

  $ GIT_SPARSE_FILE=3D git checkout -- .

--=20
Jakub Narebski
Poland
