From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 10:00:52 +0200
Message-ID: <201008031000.53581.jnareb@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <7vy6coiqdt.fsf@alter.siamese.dyndns.org> <201008030939.09999.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 10:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgCVj-0006Fz-QI
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 10:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab0HCIAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 04:00:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab0HCIAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 04:00:38 -0400
Received: by bwz1 with SMTP id 1so1778143bwz.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RW132jWOzgw6BuFTdn8pkmi50+guPlyaTOTElzWUwbE=;
        b=tQc0hjTgnN1nEwUix76XehHiaBTvo9DrB25UzWVuVaWizIsmkx7x3hvLuRAThvKNzL
         Sxjh2ksCbI2a+8vzLzBJhROUROfoayzsWSE8gtwusUZBuGyu+7mu5NZHuhYmBQ4X/R7M
         2WlcRAORl8SMXo+LNAqCUHY3tX4+LPvuuXYao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fWqucVbdVEIJIZRTgBIonOO5BhLoYhJkQJrcGgD8eBxbBJtSdsy/qJK9vFNi6lc5np
         bKOyCHXYlLseDieNTxC4s5QQNN9xGgQOB81EhRZHntsSEfEV9bHeZ6Af2PKkUw299GcX
         tE61Pl63IyekHLWqPc8q7+ggOTDjUT06tvmTY=
Received: by 10.204.46.23 with SMTP id h23mr4990104bkf.75.1280822436895;
        Tue, 03 Aug 2010 01:00:36 -0700 (PDT)
Received: from [192.168.1.13] (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id o20sm4810672bkw.15.2010.08.03.01.00.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 01:00:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201008030939.09999.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152491>

Dnia wtorek 3. sierpnia 2010 09:39, Jakub Narebski napisa=B3:
> Dnia wtorek 3. sierpnia 2010 00:47, Junio C Hamano napisa=B3:
> > Jakub Narebski <jnareb@gmail.com> writes:
> >=20
> > > The headers inside commit (and tag) objects are stored in text fo=
rm,
> > > so they are not limited to 32-bit value.  You would have to use s=
ystem
> > > that has 64-bit time_t, or patch git.
> >=20
> > I thought the internal representation of our time was "unsigned lon=
g", no?
> > How can you represent anything before Unix epoch?
>=20
> time_t is signed long.  Besides, git uses textual representation, its
> just a matter of putting minus sign.  We can always fall back to
> low level git-hash-object.

And it works:

  $ git show
  commit a5f4eaace56c6887846ea77725e1ac6827bb13b0
  Author: Jakub Narebski <jnareb@gmail.com>
  Date:   Fri May 31 18:24:20 1929 +0200
 =20
      git-hash-object

  $ git cat-file -p HEAD
  tree 953e0e451fdcb5c21a25ee7ef9faade5791b95ee
  parent 6a28c9c996d785b716559f57149a9b5c11fd83ff
  author Jakub Narebski <jnareb@gmail.com> -1280820940 +0200
  committer Jakub Narebski <jnareb@gmail.com> 1280820940 +0200
 =20
  git-hash-object

--=20
Jakub Narebski
Poland
