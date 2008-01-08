From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-diff across branches?
Date: Tue, 08 Jan 2008 02:01:35 -0800 (PST)
Message-ID: <m3wsqkmy22.fsf@roke.D-201>
References: <478337DE.7@advancedsl.com.ar>
	<20080108085705.GA4222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 11:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCBHZ-00042X-S5
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 11:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbYAHKBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 05:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYAHKBj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 05:01:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:25896 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYAHKBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 05:01:38 -0500
Received: by fk-out-0910.google.com with SMTP id z23so9035199fkz.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=VN3gbMwNg1erno6vKkHBCZ5iNZ25Nuz9cmVeNiGEvYA=;
        b=ZVVJ+EABed6lNjW2TRJEQpY5WIRViksNor6bjXgV9Rs40RCuGUsKWwV6NfstCCwgzY2QG5/hIUv52yp9xHGCaullEqLGcF8Wi9VSmk5TuLyYZHaU1+n6GzUP7iGGSVAptWOOmjClKV+MHOagRtPMCGMlNvibjEH5rHYPXtSo3Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=p9nOoEFIL9IvlE2IVOiadYmEtOAV5y6qVr4kfRXO3kj946/76KmfslEPAb+n9+IZqIDJcpOkoix6Rxx4zzjOsMAmYP/JpMQ7l7H6alfFhPKApznJigJOrX+6S2VfBZZHqiqv8dSI6cAOAyi6ZJPOxmn/wBTKhRMRSx0j9qh1pBE=
Received: by 10.78.201.10 with SMTP id y10mr335773huf.11.1199786496606;
        Tue, 08 Jan 2008 02:01:36 -0800 (PST)
Received: from roke.D-201 ( [83.8.234.59])
        by mx.google.com with ESMTPS id f8sm28591893nfh.13.2008.01.08.02.01.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2008 02:01:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m08A6HDR001874;
	Tue, 8 Jan 2008 11:06:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m08A6E18001871;
	Tue, 8 Jan 2008 11:06:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080108085705.GA4222@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69855>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 08, 2008 at 05:44:14AM -0300, Gonzalo Garramu=F1o wrote:
>=20
> > I was wondering if there was a way to make a git-diff across (local=
) =20
> > branches.
> >
> > Something like:
> >
> > $ git-diff --branch test1 HEAD --branch test2 HEAD  file.cpp
> > (would show a diff for file.cpp between test1 HEAD and test2 HEAD)
>=20
> I think you are mistaken about how HEAD works; it is a pointer to a
> particular branch. So there is no "HEAD" for test1; there is simply
> test1, and from time to time your repository's HEAD points to test1.
>=20
> However, that makes things easier. You can simply do this:
>=20
>   git-diff test1 test2 file.cpp

Canonically it is

  # git diff test1 test2 -- file.cpp

but you can also use (for example if file was renamed)

  # git diff test1:file.cpp test2:file.cpp
=20
> Unless you mean that you have two separate repositories, test1 and
> test2. In which case each _does_ have its own HEAD, and you will have=
 to
> fetch from one repo into the other to get your answer:
[cut]

Not necessary. If those two repositories are on the same local
filesystem, you can use trick from GitTips:

  http://git.or.cz/gitwiki/GitTips#head-9f79516c05f0c1b51945b848adb3dd1=
c5a2bf016

  (assuming we are in test1, and ../test2 is relative path to test2)
  # GIT_ALTERNATE_OBJECT_DIRECTORIES=3D../test2/.git/objects git diff-t=
ree \
     $(GIT_DIR=3D../test2/.git git rev-parse --verify HEAD) HEAD

--=20
Jakub Narebski
Poland
ShadeHawk on #git
