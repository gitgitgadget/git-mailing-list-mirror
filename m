From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to use_wildcard
Date: Wed, 6 Apr 2011 22:54:19 +0700
Message-ID: <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7V4J-0007SS-KS
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400Ab1DFPyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 11:54:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61189 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab1DFPyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 11:54:49 -0400
Received: by pvg12 with SMTP id 12so592094pvg.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=IIjIaC93vO0rf0eE7rOj6pYt1i1HFlwd5gDxH3HUmNc=;
        b=QvZxOJXqF8QsMN+JM3NFypGRKBH/1mPvXrR0Qkua9DVcdU5kc8R8Ip3zUYohEv9aYr
         VPVBxOLl9aOfynT1spTZmsz3KRwhIYGRpd75D2bpd1M1rxKeSdCKfW4JGATBZCTAHNkY
         8VpeaMZvg5wzUUXYXaC+/oi0DTp6nXWcs9hU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HBW297E0DBUgKL/sPeXuP76wY6Z4sAQynlg03wuzHZWHNcQH6skF4dwqVGK0K+UUmj
         rS1f3H3hTToARWNRu5yhfOqNe3dXBN2tln2qwbPGfAe/GdH+SBucufQjX+F8g/64P9y6
         7k0ij2/DvDivkJF6oqhlR0tC4vGZhrvvEQ/u4=
Received: by 10.142.62.6 with SMTP id k6mr1024149wfa.100.1302105289152; Wed,
 06 Apr 2011 08:54:49 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Wed, 6 Apr 2011 08:54:19 -0700 (PDT)
In-Reply-To: <7vr59gl581.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170986>

2011/4/6 Junio C Hamano <gitster@pobox.com>:
> =C2=A0* I was looking at the codepaths that would need to be touched =
in order
> =C2=A0 to properly support the "magic pathspec" we have been discussi=
ng, and
> =C2=A0 am leaning to conclude that all the users of get_pathspec() ne=
ed to be
> =C2=A0 rewritten to throw the remainder of argv[] at a function that =
fills a
> =C2=A0 struct pathspec (in other words, a combination of get_pathspec=
() and
> =C2=A0 init_pathspec()). =C2=A0Michael's "alternative approach to gre=
p --full-tree"
> =C2=A0 was operating at the get_pathspec() level, but that function i=
s an
> =C2=A0 interface to return an array of plain-vanilla strings only, an=
d there
> =C2=A0 is no place to hook richer per-item information on the element=
s. =C2=A0We
> =C2=A0 would need "struct pathspec" in the function where we parse th=
e argv[]
> =C2=A0 and combine its elements with prefix.

I have started working on the conversion, but it may take a while
because in many places pathspec is still assumed a prefix (and handled
separately, which is not good for negative pathspec). Fundamental
support for magic pathspec and "top dir" notation probably do not need
get_pathspec() converted to struct pathspec.
--=20
Duy
