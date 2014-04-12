From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push
 fails.
Date: Sat, 12 Apr 2014 16:24:14 -0500
Message-ID: <5349aefe85652_285f9032ec14@nysa.notmuch>
References: <20130511162936.0354e5d7@opensuse.site>
 <CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
 <20130516213856.2deba50d@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 23:34:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ5Z7-0008Cr-T4
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 23:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbaDLVeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2014 17:34:17 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47062 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaDLVeQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2014 17:34:16 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so7617326oag.5
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ae2iQ4XbqOS0ugYnyLctW6IxxV9aGNfW3SnizKIsyMU=;
        b=S1InqYuWYHoOtZESEgwa9Fwk3am1P2uGJO2rRf/Sej0oEUgtnoNnh4WAVMa9Td1CAC
         /qmy6ml11YCAzgz9vyVh4h6G8HZM0tXZyP63kFekByRXmp/9w0ypj8T1qRCfF09YAW/E
         /9waHrTgdHAfa+w4WrB7ty4dFQ+/EkwwxroL0sryLTNCKGy3iqSF7AENhTb+xvQGr7B+
         f3snoK3uBBW7EeKNJHlvx9L0fjCDtGW5D9AGZzTpmB7HxRH5PPlcB8+6US93TyruBRqI
         5J0B/RohjnaxDzufVwu2RxiKtPvtn+0UsSnUwVD/0LZYdPgCvCjmiq+uu+0+73GWTjW+
         EbEg==
X-Received: by 10.60.51.4 with SMTP id g4mr3406144oeo.52.1397338456231;
        Sat, 12 Apr 2014 14:34:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm3251777obc.3.2014.04.12.14.34.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 14:34:14 -0700 (PDT)
In-Reply-To: <20130516213856.2deba50d@opensuse.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246195>

Andrey Borzenkov wrote:
> =D0=92 Sat, 11 May 2013 08:57:14 -0500
> Felipe Contreras <felipe.contreras@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>=20
> > On Sat, May 11, 2013 at 7:29 AM, Andrey Borzenkov <arvidjaar@gmail.=
com> wrote:
> > > I noticed that using git-remote-bzr, but as far as I can tell thi=
s is
> > > generic for all transport helpers using fast-export.
> > >
> > >
> > >
> > > What happened was "git push" failed due to merge conflict. So far=
 so
> > > good - but from now on git assumes everything is up to date.
> > >
> > > bor@opensuse:/tmp/test/git> git push origin master
> > > To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
> > >  ! [rejected]        master -> master (non-fast-forward)
> > > error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/=
tmp/test/bzr'
> > > hint: Updates were rejected because the tip of your current branc=
h is behind
> > > hint: its remote counterpart. Merge the remote changes (e.g. 'git=
 pull')
> > > hint: before pushing again.
> > > hint: See the 'Note about fast-forwards' in 'git push --help' for=
 details.
> > > bor@opensuse:/tmp/test/git> git push origin master
> > > Everything up-to-date
> > > bor@opensuse:/tmp/test/git>
> > >
> > > The problem seems to be that git fast-export updates marks
> > > unconditionally, whether export actually applied or not. So next =
time
> > > it assumes everything is already exported and does nothing.
> > >
> > > Is it expected behavior?
> >=20
> > Indeed, this is the way it currently works, and it's not easy to fi=
x.
> > We would need some way to make fast-export wait until we know the e=
xit
> > status of the remote helper, and then tell it when it failed, so th=
e
> > marks are not updated.
> >=20
>=20
> Hmm ... actually as far as I understand transport-helper keeps track =
of
> which revisions to push in "remote helper ref" (for the lack of bette=
r
> word). This makes use of marks as tracking means rather redundant.
>=20
> What about the idea below? This relies on transport helper to provide
> correct revisions and uses marks exclusively as cross-reference betwe=
en
> GIT and remote SCM. It is on top of next branch.

This is one way of using it, but not ideal, and I think the patch serie=
s I sent
should work for all remote helpers.

--=20
=46elipe Contreras