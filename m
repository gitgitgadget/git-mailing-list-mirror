From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH v3] autoconf: Test FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 16:30:07 +0100
Organization: NextSoft
Message-ID: <200803041630.07585.michal.rokos@nextsoft.cz>
References: <200803041514.42783.michal.rokos@nextsoft.cz> <alpine.LSU.1.00.0803041458220.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:31:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZ6V-0001kJ-JT
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760371AbYCDPaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760589AbYCDPaT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:30:19 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:56644 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760340AbYCDPaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:30:17 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 1BB938D6; Tue,  4 Mar 2008 16:30:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 5C8BE8D8;
	Tue,  4 Mar 2008 16:30:14 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12780-01; Tue, 4 Mar 2008 16:30:14 +0100 (CET)
Received: from 89-24-113-79.i4g.tmcz.cz (89-24-113-79.i4g.tmcz.cz [89.24.113.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 9863D872;
	Tue,  4 Mar 2008 16:30:13 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LSU.1.00.0803041458220.22527@racer.site>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76100>

Hello,

On Tuesday 04 March 2008 15:59:02 Johannes Schindelin wrote:
> On Tue, 4 Mar 2008, Michal Rokos wrote:
> > +AC_RUN_IFELSE(
> > +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> > +		[[char c;
> > +		FILE *f = fopen(".", "r");
> > +		if (! f) return 0;
> > +		if (f && fread(&c, 1, 1, f) > 0) return 1]])],
> > +	[ac_cv_fread_reads_directories=no],
> > +	[ac_cv_fread_reads_directories=yes])
>
> I do not see the issue addressed that I saw on msysGit.

ahh, sorry I've included some old one. Now it's
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
+		[[char c;
+		FILE *f = fopen(".", "r");
+		return f && fread(&c, 1, 1, f)]])],
+	[ac_cv_fread_reads_directories=no],
+	[ac_cv_fread_reads_directories=yes])

I've tried to reproduce, but I failed to do so. When I put "return 0;" it 
detect that "no"; when I return something else, "yes" is detected - as it 
should.

The C snippet in configure script looks like:
$ac_includes_default
int
main ()
{
char c;
                FILE *f = fopen(".", "r");
                return f && fread(&c, 1, 1, f)
  ;
  return 0;
}

Does your autoconf create the same thing?

Michal
