From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 4/4] grep -O: allow optional argument specifying the pager 
	(or editor)
Date: Sun, 13 Jun 2010 19:04:44 +0200
Message-ID: <AANLkTikny5zhO18cbGvq2zcMOdfAcDbAG6LiOLGTtepv@mail.gmail.com>
References: <20100605005116.GA8774@progeny.tock> <alpine.DEB.1.00.1006051810300.1732@bonsai2> 
	<20100612075542.GB2918@burratino> <alpine.DEB.1.00.1006121139290.2689@bonsai2> 
	<20100612162945.GB1406@burratino> <20100612163946.GD5657@burratino> 
	<7vvd9mevqy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 19:05:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONqcT-0003o0-N5
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 19:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab0FMRFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jun 2010 13:05:06 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:54990 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0FMRFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jun 2010 13:05:05 -0400
Received: by ywh42 with SMTP id 42so2809044ywh.15
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=DBl/WdW8HI+bjBL5I60Q+H5ddpgp/MjDL9Y2X/mzsD4=;
        b=WzVjPphZCMmmZUSgywsHT2CKKLvC3tuuPm4k9X3YL8yxlLp8knETZHf4SiMpOIWXcZ
         1tg0zHRzJBkjIBbwp8OD4snCFrw6KlZK9BpYt2rUOIFVDKNKYAArcrIKGXxSv7uK7pqr
         aDkfz8h1FbL3FKo1wzH7aDFYBkNkiwKTkExQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=dLJM0frYamGBYQ544rgUtdUxs0IRFl/h3O6YQgi8zOLGXG83YZYVv8e39cdmllIC/p
         qqzzi33SIcPZs5R05m/69Z1MKChzpO9y+N2kcPNZZ3uD2mZQo3XfkJKGY6cIwD/F20k+
         OZkzUF93DWvJK75CB4BOf+S9WSuYCbpdbtC2U=
Received: by 10.101.192.24 with SMTP id u24mr3817665anp.181.1276448704149; 
	Sun, 13 Jun 2010 10:05:04 -0700 (PDT)
Received: by 10.100.11.3 with HTTP; Sun, 13 Jun 2010 10:04:44 -0700 (PDT)
In-Reply-To: <7vvd9mevqy.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: S6FehEzn1GeX-kVYyLT98DGHDVE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149054>

>> - =A0 =A0 =A0 =A0[-O | --open-files-in-pager]
>> + =A0 =A0 =A0 =A0[(-O | --open-files-in-pager) [<pager>]]
>
> Hmm, does "git grep -e Heh -O frotz" look for Heh and show in the fro=
tz
> pager, or does it look for Heh in paths under frotz/ directory and sh=
ow
> hits in the default pager?

The latter.

>> + =A0 =A0 const char *show_in_pager =3D NULL, *default_pager =3D "du=
mmy";
>
> If there were another instance of constant string "dummy" elsewhere i=
n the
> program, is a clever compiler-linker combo allowed to optimize memory=
 use
> by allocating one instance of such a string and pointing default_page=
r
> pointer to it? =A0IOW, if the patch were:
>
>> + =A0 =A0 const char *show_in_pager =3D NULL, *default_pager =3D "du=
mmy";
>> + =A0 =A0 const char *another_dummy =3D "dummy";
>
> could another_dummy and default_pager start out with the same value?

In the same file, the compiler will do it already today.  In another
file, no (except if it does link-time optimization of course).

Paolo
