From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH 2/4] Allow reading svn dumps from files via file:// urls.
Date: Wed, 11 Jul 2012 13:49:46 -0400 (EDT)
Message-ID: <33a7c123-9db7-4f27-960b-d13db9a71f97@mail>
References: <7vbojmfd1u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 19:57:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp1AL-0000s6-HU
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 19:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178Ab2GKR51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 13:57:27 -0400
Received: from hq.genarts.com ([173.9.65.1]:41550 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932130Ab2GKR51 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 13:57:27 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2012 13:57:26 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A6FF7BE3C84;
	Wed, 11 Jul 2012 13:49:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fvn1Z-HgZpyW; Wed, 11 Jul 2012 13:49:46 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id D69CBBE3D01;
	Wed, 11 Jul 2012 13:49:46 -0400 (EDT)
In-Reply-To: <7vbojmfd1u.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201318>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Dmitry Ivankov" <divanorama@gmail.com>
> Cc: git@vger.kernel.org
> Sent: Wednesday, July 11, 2012 1:00:29 PM
> Subject: Re: [PATCH 2/4] Allow reading svn dumps from files via file:// urls.
> 
> Dmitry Ivankov <divanorama@gmail.com> writes:
> 
> > Florian Achleitner <florian.achleitner.2.6.31 <at> gmail.com>
> > writes:
> >
> > > Especially for testing and development it's useful to bypass
> > > svnrdump and replay the svndump from a file without connecting to
> > > an svn server.
> > > 
> > > Add support for file:// urls in the remote url.  e.g.
> > > svn::file:///path/to/dump When the remote helper finds an url
> > > starting with file:// it tries to open that file instead of
> > > invoking svnrdump.
> >
> > file:// is a bad choice because file:// style repo urls are valid
> > for svn and it's for local repos rather than dumpfiles.
> 
> Thanks; I had the same reaction when I saw it.
> 
> > Maybe something like dumpfile:// instead?
> 
> If dumpfile:// pseudo URL is an established convention in the
> Subversion land, that sounds like a sensible direction, but if that is
> not the case, it may be cleaner if you can find some other way to
> convey the information to the backend out-of-band, instead of
> overloading it in the URL used to access the repository.

Others may have a different opinion, but in my experience dump files are always handled via stdin/stdout in Subversion land.  For example:

http://svnbook.red-bean.com/en/1.7/svn.ref.svnadmin.c.dump.html
http://svnbook.red-bean.com/en/1.7/svn.ref.svnadmin.c.load.html
http://svnbook.red-bean.com/en/1.7/svn.reposadmin.maint.html#svn.reposadmin.maint.filtering

I'm not sure that helps in this scenario, but that was the convention I grew used to.

Stephen
