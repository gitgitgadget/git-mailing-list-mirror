From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 18 Aug 2009 02:49:46 +0200
Message-ID: <200908180249.48404.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de> <200908180217.35963.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:43:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCmx-0006ss-9g
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbZHRAmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 20:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbZHRAmv
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:42:51 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:33359 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZHRAmv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:42:51 -0400
Received: by bwz22 with SMTP id 22so2635118bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O4g+Xtw8fFyJ55IMb78hHuoxPZK/JoTL/gJW910+Nb4=;
        b=M4lIJ/UGK8Wu14I1bN9tU+JMGe9IMZ01rmjk2GKgbrXmK1Yhx1D0SMcDKuKQ9trtDf
         eWeadQvv1mXE7BpJMp5aDF7zdniLQFo5KEDmX5E1qKDlnkCSAPTxfOoaRVUYlctWVElh
         z8jGN5jLqE9DKvqbEvlsNFk4AjRvAwWc0X41I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XWH9XC8baEyEGB/4sPvI7/zyqcFlKtbaXeqAFp/l5xFLMeKQzJktYnoM5DCjh8FFC0
         1QFr2+6zRTF7VcV1H7gn9OzwTfTzX4Dz0Qgcuc0vxMoZlilW4vq9SHeKhu7DpBJfaiyX
         XiwdbkK+d+OV2rn30GbVTIGmEnb/4WwGnJ0nc=
Received: by 10.103.81.14 with SMTP id i14mr1568969mul.85.1250556171669;
        Mon, 17 Aug 2009 17:42:51 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id 23sm21707776mum.35.2009.08.17.17.42.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 17:42:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200908180217.35963.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126332>

Jakub Narebski wrote:
> Johannes Schindelin wrote:
>=20
> > The thing is: we need a way to determine quickly and without any=20
> > ambiguity whether a file is tracked, assumed unchanged, or sparse'd=
-out=20
> > (which Nguy=E1=BB=85n calls no-checkout).
>=20
> Let's reiterate: "assume-unchanged" is about telling git that it shou=
ld
> assume for performance reasons that state of file in working director=
y
> is the same as state of file in the index.  But, from what was said i=
n
> this thread, there are situations where git for correctness reasons
> ignores performance hack.
>=20
> "no-checkout" bit is about telling git that the file is not present
> in working directory, and it has to use version from the index.  Then
> there is a question if there is file in working area (e.g. from apply=
ing
> patch) which corresponds to a "no-checkout" file in index (correspond=
s
> because of rename detection).

Also there is a question if one might want to use them together.  I thi=
nk
it is not inconceivable ;-)  One might want for example to limit checko=
ut
to some subdirectory, but within that directory one might want to use=20
assume-unchanged bit, because filesystem performance sucks (FAT, NFS).
Now couple that with changing in sparse patterns...

--=20
Jakub Narebski
Poland
