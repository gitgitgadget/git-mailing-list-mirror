From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Mon, 26 Jan 2009 11:41:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261141070.14855@racer>
References: <be6fef0d0901242208p635264e5jc1f95d784cd51450@mail.gmail.com>  <7vpribdszr.fsf@gitster.siamese.dyndns.org> <be6fef0d0901251752p5b34c053pb24dce8a35b06fce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 11:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LROxW-0005kT-Cn
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 11:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbZAZKlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 05:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbZAZKlF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 05:41:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:33542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750943AbZAZKlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 05:41:03 -0500
Received: (qmail invoked by alias); 26 Jan 2009 10:40:59 -0000
Received: from pD9EB294D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.77]
  by mail.gmx.net (mp005) with SMTP; 26 Jan 2009 11:40:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7EFF/lpS7OByibSMxJ5oFLLrpOLQqewafymICY7
	d4/WuW02GnYO7J
X-X-Sender: gene099@racer
In-Reply-To: <be6fef0d0901251752p5b34c053pb24dce8a35b06fce@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107184>

Hi,

On Mon, 26 Jan 2009, Ray Chuan wrote:

> On Mon, Jan 26, 2009 at 4:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> @@ -304,17 +312,7 @@ static void start_fetch_loose(struct
> >> transfer_request *request)
> >>
> >>       git_SHA1_Init(&request->c);
> >>
> >> -     url = xmalloc(strlen(remote->url) + 50);
> >> ...
> >> -     strcpy(request->url, url);
> >> +     request->url = get_remote_object_url(remote->url, hex, 0);
> >> ...
> >> -     curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> >> +     curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
> >
> > The original code gave a separate "url" to setop() but this gives the same
> > string.  Does curl_easy_setop() copies the given string away?  IOW is this
> > change safe?
> >
> 
> curl strdup's it, so this is safe.

I might have mentioned that things like this _need_ to go into the commit 
message.

Ciao,
Dscho
