From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the
 object store
Date: Sun, 5 Sep 2010 14:17:35 +0530
Message-ID: <20100905084731.GB15511@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905060854.GA15511@kytes>
 <AANLkTimqMJ1vHaJL65RZ4PuxONtg1evn4vBdPks_odqq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 10:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsAvA-0002Jl-Km
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 10:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0IEItn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 04:49:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44461 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0IEItm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 04:49:42 -0400
Received: by pwi3 with SMTP id 3so738728pwi.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CJIJvtAnN8b8SqiyXIPhHlK3+5dkb9uWcLmhmXcV4co=;
        b=SkDs4Yw9ayGCuAFk65bxretZ5SWO+disPhpWGRe5s6Dy+qF1PNm/MYnWEdQ7IQIzir
         os299ZJj+QbbGJUp+pU2Pz7xpFvUEwaIOaL3p2wHj4l/+3D98w4e/o8HMqTWGkuzpjYJ
         Hoq9OxLvo8x7NUdxjXdMGshIzM6p17qJpZ1h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=w8wojyRC9B/fNGaDdUZy0mBiUi8I0UqbqhnNOHVcofrBZjdq4j8fuVg6EPyK9/E5st
         +TE8FEvQgjp8GuY4WQt8c0ceKVDe8/P8C4StTxm1M5TARjhckFvx2Ylfgasr4XHY0UPC
         j+UVfe+SEheEVoXUVEC5eMdd7cNolR11oZbWE=
Received: by 10.114.151.5 with SMTP id y5mr1168942wad.172.1283676581961;
        Sun, 05 Sep 2010 01:49:41 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d39sm8261860wam.16.2010.09.05.01.49.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 01:49:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimqMJ1vHaJL65RZ4PuxONtg1evn4vBdPks_odqq@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155449>

Hi Sverre,

Sverre Rabbelier writes:
> On Sun, Sep 5, 2010 at 01:08, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> >> Another possible concern is that this is very much git specific.
> >> Other fast-import backends are just not going to be able to do
> >> it with the same format. =A0Is there a convention for naming
> >> options like that?
> >
> > Why is this a concern? We aren't even breaking backward
> > compatibility. This bidi interface should only be used by SVN-like
> > frontends.
>=20
> I don't agree, imagine implementing hg-remote-svn (or the conceptual
> equivalent at least), it would require the same functionality, yes?
> You need to retrieve something from fast-import that you previously
> gave it.

Ah, yes. I didn't think of that. If fast-import is already mature,
it's probably a good idea to design a new protocol altogether based on
this and not call it fast-import?

> > We'll get ideas to improve this as svn-fe gets built up. On a relat=
ed
> > note, we should probably extend the git-remote-testgit helper to us=
e
> > this feature in future to facilitate writing unittests.
>=20
> Hmmm, that would be somewhat difficult I suspect, the reason
> git-remote-testgit was so easy to write is because git-fast-export an=
d
> git-fast-import do exactly what I wanted to test. You'd have to teach
> munge the fast-export stream even more to insert this feature somehow=
,
> I suspect that'll be a non-trivial feat. Of course, you will need to
> test it somehow, I suspect that Jonathan's current approach (using
> hardcoded streams) might be the easiest.

Hm, ok. Whatever makes testing easier.

-- Ram
