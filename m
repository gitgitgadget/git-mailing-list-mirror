From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Sat, 8 May 2010 17:03:15 +0800
Message-ID: <r2i46dff0321005080203m65cb8acak750f4ef46bf4d6e8@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <201005080143.21172.jnareb@gmail.com>
	 <u2p46dff0321005071930n21de08bcv62d88377f082521@mail.gmail.com>
	 <201005081018.59757.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 11:03:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAfwR-0008Gm-3y
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 11:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab0EHJDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 05:03:17 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:41098 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0EHJDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 05:03:16 -0400
Received: by qyk13 with SMTP id 13so3003594qyk.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DD8cCQf+CkYUFXJ6PpwF0UulJ+HvX5XTUV9xjQg7dm4=;
        b=hqwyTHMPfE0LBfyOsUcuWUHfNNzOmtNKBk/jdHtocYa6U3sO3q9WszbCvaSfEtDCSv
         5wh4zO8gU72SmOYF9z1D6yhq1a6hKdZvEMf6gcj3Ghz+XVQCjpnOqlEmroH2GbayRX8C
         OhDEXmmK1qpgwBw0groBZxlqVB/I0BAiD7lCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QQlihBsDX6VkbNQLxruaMyjQWsUvziytT4TlGTgmZCJ+8npyIhPIw8vsoLp31ppZOp
         gKeK1om6HSUUIRo7yBHXKz57aw96yh3clsKlk77DgLA914PoPFwIRsPNu2ECbmfQOXfV
         BvlG4nd+AG/zXDFF8o53iW/B+w8zshcpNlqiw=
Received: by 10.229.86.10 with SMTP id q10mr891634qcl.36.1273309395348; Sat, 
	08 May 2010 02:03:15 -0700 (PDT)
Received: by 10.229.83.145 with HTTP; Sat, 8 May 2010 02:03:15 -0700 (PDT)
In-Reply-To: <201005081018.59757.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146650>

On Sat, May 8, 2010 at 4:18 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>
> On Sat, 8 May 2010, Ping Yin wrote:
> > >
> > > But perhaps we can break backwards compatibility here. =C2=A0I do=
n't know...
> > >
> > I think we can. Because config file is not in repository, so if you=
r
> > older git doesn't support it, you should not use this new syntax.
>
> Actually per-repository $GIT_DIR/config file *is* in repository... bu=
t
> is not distributed (it is not transferred on clone / fetch).
>
> The problem with breaking backwards compatibility is when repository =
is
> on shared filesystem (be it networked filesystem such as NFS or
> CIFS/Samba share, or portable USB (pen)drive), and can be accessed by
> different versions of git.

You are right, i missed this case.
However, If NFS is used, the git version is very likely the same. So i
think this case is not worth the effort to keep the backwards
compatibility.

>
> The '@INCLUDE =3D db_config.ini' is taken from OpenInteract2::Config:=
:Ini.

I prefer "include foo" which is used by apache, and "@include foo"
which doesn't fail to parse when foo doesn't exist.
