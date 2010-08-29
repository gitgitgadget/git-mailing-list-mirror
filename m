From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sun, 29 Aug 2010 15:39:05 -0500
Message-ID: <20100829203905.GA1890@burratino>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:40:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpogT-0001oH-Ks
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab0H2Ukv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 16:40:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40409 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab0H2Ukv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 16:40:51 -0400
Received: by ywh1 with SMTP id 1so1426014ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ufa0Z5O3V+IKl8/qOJ9qC+EiDjkyM7qx9HNy337v55M=;
        b=uHSzMOXwDmEamiCsbqiEWBUvmOFb6nJa7ndhBSHU0IOIGH5Z3MZ1UIcU79Ox9vmCs6
         OwOiN/mU5Y/H/+YaDcifhyt318bTDqspdb9/k615a3Fw8AMI57PK40MTS8346pcdwSqD
         9GUx+jfoF4bREpf8/cO4LEJEYv6kcxqyQL40s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Xd4eFadyV9YRt9Kxjua404mVEC+hEvOAfBEghlsnATRFjYQHWWN86jwmtlsXjqR99S
         Or8BmuzPf8dYO3nLiNrnCRmCxhksMeoWV5YTJ1HxhbYGOS2bhUp4drN7dlQWlaYiQHvi
         4X9HDPcRIgO5+0xoEVhly0JV1Dbk+Uj88SFxY=
Received: by 10.90.55.19 with SMTP id d19mr3129777aga.54.1283114449996;
        Sun, 29 Aug 2010 13:40:49 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm6562045ibh.4.2010.08.29.13.40.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 13:40:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154715>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I have this alias in my .gitconfig:
>=20
>     review =3D "!f() { for rev in $(git rev-list --reverse \"$@\"); d=
o
> git show $rev; done; }; f"
>=20
> I use it after I "git pull" to see what changed, e.g.:
>=20
>     git review 49ea7b8..e1ef3c1

Hmm,

 git show --reverse 49ea7b8..e1ef3c1

doesn't work because cmd_show() bypasses the get_revision() magic. :(
