From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Fwd: [PATCH v3] autoconf: Test FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 16:22:35 +0000
Message-ID: <e2b179460803040822v1161190n45c6080da36700c9@mail.gmail.com>
References: <200803041514.42783.michal.rokos@nextsoft.cz>
	 <e2b179460803040732k222651c2vdb04e553b8137891@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Michal Rokos" <michal.rokos@nextsoft.cz>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:23:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZvA-0003nO-FC
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764770AbYCDQWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764714AbYCDQWi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:22:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:59735 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763617AbYCDQWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:22:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so548811rvb.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jJrpd2ofK0JFrhgGv244bJ7bkHDcA1Ak6wNGZ3R9U6k=;
        b=k5r9S4wap1HHdP/zdrrkEPtdQxSpK123nltnyWtKN38Hvqy7YZ6sH0eSyUfcVm13b0fOeWd8Id/TM1ZqdY5y1twgr0f4H+gHAF+QO/+Ukh2OR7RQ2A8IyzAXYCAeF9mL7ixaV6fx60qymBE2hibmpIy4y7TGCvpM0Oup93Nt7Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OMuf+xtexRJlESq7Xr4KDwB5mWKg8dKv2UZy0pgu4N69WoA27FI8+CmiNHy4Sf7DPERGv18+z00TaASQZ6gW11/kg94xlbBVsD4UdIpPGR6Nnmbw3ThUb4hEShj8MZZdOy4QdpNerCeidXlDOV0olB0UZLliGpo3hCUI2YRPpro=
Received: by 10.141.161.6 with SMTP id n6mr704591rvo.201.1204647755357;
        Tue, 04 Mar 2008 08:22:35 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Tue, 4 Mar 2008 08:22:35 -0800 (PST)
In-Reply-To: <e2b179460803040732k222651c2vdb04e553b8137891@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76117>

On 04/03/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Tue, 4 Mar 2008, Michal Rokos wrote:
>
>  > On Tuesday 04 March 2008 15:59:02 Johannes Schindelin wrote:
>  > > On Tue, 4 Mar 2008, Michal Rokos wrote:
>  > > > +AC_RUN_IFELSE(
>  > > > + [AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
>  > > > +         [[char c;
>  > > > +         FILE *f = fopen(".", "r");
>  > > > +         if (! f) return 0;
>  > > > +         if (f && fread(&c, 1, 1, f) > 0) return 1]])],
>  > > > + [ac_cv_fread_reads_directories=no],
>  > > > + [ac_cv_fread_reads_directories=yes])
>  > >
>  > > I do not see the issue addressed that I saw on msysGit.
>  >
>  > ahh, sorry I've included some old one. Now it's
>  > +AC_RUN_IFELSE(
>  > +     [AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
>  > +             [[char c;
>  > +             FILE *f = fopen(".", "r");
>  > +             return f && fread(&c, 1, 1, f)]])],
>  > +     [ac_cv_fread_reads_directories=no],
>  > +     [ac_cv_fread_reads_directories=yes])
>  >
>  > I've tried to reproduce, but I failed to do so. When I put "return 0;" it
>  > detect that "no"; when I return something else, "yes" is detected - as it
>  > should.
>
>
> I finally figured out what is going wrong.
>
>  But first let me say what a PITA it is to debug configure.  It is utterly,
>  completely painful!  When you insert random "exit"s, like you usually do
>  with scripts that are too garbled and complex and ugly to understand (the
>  worst Perl code I ever saw was not as ugly), it does not exit _at all_!
>
>  Turns out that the compilation fails:
>
>         ...\ld.exe: cannot find -lsocket 1 exit status
>
>  Nice.
>
>  FWIW it tries to link with
>
>         cc -o conftest.exe -g -O2   conftest.c  -liconv -lsocket >&5
>

Should probably have copied you on the mail below. Seems like you hit
a similar problem.

With configure you have to always go back to the initial failure
(which may have been reported as a success!) as all subsequent test
results could be invalid.

Either the test to see whether gcc accepts -g is flawed (it doesn't
check whether it actually works, only that the gcc wrapper accepts it;
or -g only works if libg is available, and it fails to test for
that...

---------- Forwarded message ----------
From: Mike Ralphson <mike.ralphson@gmail.com>
Date: 4 Mar 2008 15:32
Subject: Re: [PATCH v3] autoconf: Test FREAD_READS_DIRECTORIES
To: Michal Rokos <michal.rokos@nextsoft.cz>
Cc: GIT <git@vger.kernel.org>


On 04/03/2008, Michal Rokos <michal.rokos@nextsoft.cz> wrote:
 > Add test for FREAD_READS_DIRECTORIES to configure script.
 >
 >  When "." could be opened and fread reads more than 0 items,
 >  FREAD_READS_DIRECTORIES will be set.


On AIX 5.3 this appears to work correctly, i.e. it defines
 FREAD_READS_DIRECTORIES

 I've negatively tested it just by swapping the return values.

 It is susceptible to failing for other reasons than those expected
 (i.e. the configure script gets the libsocket test wrong on my
 platform if I forget to amend CFLAGS because libg is not available,
 and then various tests including this one fail because libsocket is
 erroneously linked in and the test programs fail to compile at all),
 but that is I think a wider issue with autoconf tests in general.

 So, with those caveats:

 Tested-by: Mike Ralphson <mike@abacus.co.uk>

 Patch to set this option by default on AIX for the non-autoconf
 Makefile to follow.
