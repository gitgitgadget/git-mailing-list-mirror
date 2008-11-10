From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 21:17:29 +0100
Message-ID: <200811102117.30372.jnareb@gmail.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <200811101903.27685.jnareb@gmail.com> <871vxjl5af.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdDp-0001F1-86
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbYKJURi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 15:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYKJURi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:17:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:37463 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYKJURh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:17:37 -0500
Received: by ug-out-1314.google.com with SMTP id 39so515385ugf.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kZKfwVzCz+a6cn3jbYlXftTdLT3Yy2q347rVopSn3qg=;
        b=etbQtI/ZtNrM5iUrQcoeyonDeWbdflC4e6ie1o+ZBwCpG0mUKI3FeLF/hQ9oy9AFXa
         dsG9vzdaBDu0gLKYBu7j21Q2i4+Z4sLAf6faEeQxOzyYaPRtYE9JQEi9VhJiDt4UEMfL
         ghyfYjlA+MOa0U6DTqSisjyHnPjHpYo906ITk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=b+0jp4Wz6dnCtlZ/2l9s2ywAgu238rwT1cJ5SeIHgqS8bzxVFI0q7xyhkX+445geIq
         pyoTgs2eSmT4+9g1uAnfOaTr1qOHPYVPNfHPBbjm/f0xCyXYImOobCQfnBeqFFdYut48
         rby0FcPPnefnv6tOY3nnfyrIAFv6dHjlhPguo=
Received: by 10.67.116.16 with SMTP id t16mr2366048ugm.51.1226348255970;
        Mon, 10 Nov 2008 12:17:35 -0800 (PST)
Received: from ?192.168.1.11? (abwz230.neoplus.adsl.tpnet.pl [83.8.249.230])
        by mx.google.com with ESMTPS id w40sm4206846ugc.6.2008.11.10.12.17.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 12:17:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <871vxjl5af.fsf@erwin.mina86.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100557>

Michal Nazarewicz wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Dnia poniedzia=B3ek 10. listopada 2008 18:38, Michal Nazarewicz napi=
sa=B3:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>=20
>>>> The reason why git doesn't support keywords like $Revision$ or $Da=
te$
>>>> is performance: the $Revision$ and $Date$ are keywords related to
>>>> _commit_ data, not blob data.=20
>>>=20
>>> In my case identifying content not commit would be even better.
>>
>> Well, in that case using `ident` attribute would be enough
>> (but cryptic).
>=20
> Yes, but it forces me to do some voodoo magic (ie. checkout) to get t=
he
> Id in the file, ;) like so:
>=20
> #v+
> $ echo '$Id$'>bar && git add bar && git commit -m 'Added bar' && cat =
bar
> Created commit d49d436: Added bar
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 bar
> $Id$
> $ rm bar && git checkout bar && cat bar
> $Id: 055c8729cdcc372500a08db659c045e16c4409fb $
> #v-

Well, _some_ command has to be invoked to expand keywords. "git add"
doesn't do that (perhaps it should?), so you need to use checkout.

And checkout doesn't touch file if it is identical, so you need
to remove it first; nevertheless you don't need to use commit in
betwen, as "git checkout bar" would checkout file out of index (you
added contents of file to index with "git add bar").

--=20
Jakub Narebski
Poland
