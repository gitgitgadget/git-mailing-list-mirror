From: Christian Himpel <chressie@googlemail.com>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Mon, 28 Sep 2009 11:32:16 +0200
Message-ID: <20090928093216.GA31459@lamagra.informatik.uni-ulm.de>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
 <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
 <20090927074015.GB15393@coredump.intra.peff.net>
 <4AC06FFF.20008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 11:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsCaw-0005om-CO
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 11:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbZI1JcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 05:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZI1JcY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 05:32:24 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:50793 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZI1JcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 05:32:23 -0400
Received: by bwz6 with SMTP id 6so1122632bwz.37
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8dwiAPpZrVOpsj5dzFAKuHXMe4o74VHtSyk+U9r4PrI=;
        b=Zmj3gZtu9mt5qHX093ax4y0jzOijlKLXC7eRF4J/GliyTGri2XytE47XOSfBCa9hJS
         SwEDJ0i1emNMEQjVdenQPkUhDoknDZfX+pCMaViKTpWWmldVPreUapcYC8Gvb0Jhft+h
         b/F2y3+zEY3LGVTTHFHR+lYfQbs4AzJIhfcZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=E8+Elmzk09vqq/LNvRjcLXvjK4XO/fkPUsm2aoK1J/xgT931a3YzkY3Pnj+egxEnLZ
         5P6qEpHfNrd/yt1O5ciNhgr2iC6y5xcZ1K9ay0rf0co9RRVqYRgPYMCIMK2OeabG5kl8
         mM5mSBHORElUj6fxggjEddHvpVsk4vmixayyM=
Received: by 10.204.3.220 with SMTP id 28mr2818357bko.4.1254130346090;
        Mon, 28 Sep 2009 02:32:26 -0700 (PDT)
Received: from lamagra.informatik.uni-ulm.de (lamagra.informatik.uni-ulm.de [134.60.77.31])
        by mx.google.com with ESMTPS id k29sm27397fkk.27.2009.09.28.02.32.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 02:32:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AC06FFF.20008@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129239>

On Mon, Sep 28, 2009 at 10:12:47AM +0200, Johannes Sixt wrote:
> Jeff King schrieb:
> > On Fri, Sep 25, 2009 at 06:43:20PM +0200, Christian Himpel wrote:
> >=20
> >> According to egrep(1) the US-ASCII table is used when LC_ALL=3DC i=
s set.
> >> We do not rely here on the LC_ALL value we get from the environmen=
t.
> >=20
> > Hmm. Probably makes sense here, as it is a wide enough range that i=
t may
> > pick up other stray non-ascii characters in other charsets (though =
as
> > the manpage notes, the likely thing is to pick up A-Z along with a-=
z,
> > which is OK here as we encompass both in our range).
> >=20
> > There are two other calls to egrep with brackets (both in
> > git-submodule.sh), but they are just [0-7], which is presumably OK =
in
> > just about any charset.
> >=20
> > Do you happen to know a charset in which this is a problem, just fo=
r
> > reference?
>=20
> It's not so much about charsets than about languages:
>=20
>        Within a bracket expression, a range expression consists
>        of two characters separated by a hyphen.  It matches any
>        single character that sorts between the two  characters,
>        inclusive,  using  the  locale's  collating sequence and
>        character set.  For example, in the  default  C  locale,
>        [a-d]  is equivalent to [abcd].  Many locales sort char-
>        acters in dictionary order, and in these  locales  [a-d]
>        is  typically  not  equivalent  to  [abcd];  it might be
>        equivalent to [aBbCcDd], for  example.   To  obtain  the
>        traditional  interpretation  of bracket expressions, you
>        can use the C locale by setting the  LC_ALL  environment
>        variable to the value C.
>=20
> For example, in locale de_DE.UTF-8, GNU grep '[a-z]' matches lowercas=
e
> letters, uppercase letters (!), and umlauts (!!) because in dictionar=
y
> order, 'A' and 'a' are equivalent and '=C4' sorts after 'A'. (The inp=
ut must
> be UTF-8, of course.)

Thanks for pointing this out.  You are right.  I must have read the
"dictonary order" part over.

> Given that this applies not only to egrep, but to grep in general (an=
d
> perhaps even to other tools that support ranges, like sed), it may be
> necessary to audit all range expressions.

After doing a quick:

LC_ALL=3DC find . -name '*.sh' -exec \
         egrep -Hne '(grep|awk|sed).*\[.*-.*\]' {} \;

As far as I can see, range expressions are used:

1. to replace or grep hexadecimal numbers (SHA1 sums).  This shouldn't
be a problem, if we can assume that these numbers are never malformed.

2. to replace or grep numbers (with digits).  This shouldn't be a
problem, since digits should be in dictionary order in every language
(?!).

3. in git-rebase--interactive.sh:742 to grep for a previously generated
string.  So it should be safe here.

> The case identified by Christian is certainly important because it is
> applied to a file whose contents can be anything, and the purpose of =
the
> check is to identify the text as an mbox file, whose header section c=
an be
> only US-ASCII by definition. So, I think it has merit to apply the pa=
tch.

Yes.  It seems that this is the only place where it is important to mat=
ch
just the ASCII printable characters.


Regards,
chressie
