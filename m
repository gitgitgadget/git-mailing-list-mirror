From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 03/11] Allow programs to not depend on remotes having urls
Date: Thu, 30 Jul 2009 02:24:33 +0200
Message-ID: <200907300224.33244.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <1248656659-21415-4-git-send-email-johan@herland.net>
 <81b0412b0907290157y56255296qd3374f22ec3c7883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:24:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJRq-0007Lu-7j
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbZG3AYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755642AbZG3AYe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:24:34 -0400
Received: from mx.getmail.no ([84.208.15.66]:50887 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754966AbZG3AYe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:24:34 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK008NOJSYA4B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:24:34 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK003LHJSXG620@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:24:34 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.30.1516
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <81b0412b0907290157y56255296qd3374f22ec3c7883@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124422>

On Wednesday 29 July 2009, Alex Riesen wrote:
> On Mon, Jul 27, 2009 at 03:04, Johan Herland<johan@herland.net> wrote:
> > diff --git a/builtin-fetch.c b/builtin-fetch.c
> > index 817dd6b..3f32db6 100644
> > --- a/builtin-fetch.c
> > +++ b/builtin-fetch.c
> > @@ -346,12 +346,17 @@ static int store_updated_refs(const char
> > *raw_url, const char *remote_name, +               if (url) {
> > +                       url_len = strlen(url);
> > +                       for (i = url_len - 1; url[i] == '/' && 0 <= i;
> > i--) +                               ;
> > +                       url_len = i + 1;
> > +                       if (4 < i && !strncmp(".git", url + i - 3, 4))
> > +                               url_len = i - 3;
> > +               } else {
> > +                       url = "foriegn";
>
> Typo. Should be "foreign".

Thanks. Will be fixed in the next iteration of this topic.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
