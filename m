From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 16:56:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com> <20090813144327.GK1033@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 16:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbbjG-0002qt-Ak
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 16:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbZHMO4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 10:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbZHMO4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 10:56:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:52212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752990AbZHMO4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 10:56:24 -0400
Received: (qmail invoked by alias); 13 Aug 2009 14:56:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp017) with SMTP; 13 Aug 2009 16:56:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7j7ILonO7MwaMBTCN6q11+uPQEj/AVMgXP8HS7w
	/xjeEiBERnVoB1
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090813144327.GK1033@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125825>

Hi,

On Thu, 13 Aug 2009, Shawn O. Pearce wrote:

> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>
> > +Note that options specified by the frontend override any options the
> > +user may specify to git fast-import itself.
> 
> Hmmph.  Do we really want that?  I would think the command line options 
> should override the stream, such that we can then do something like:
> 
>   hg fast-export >foo
>   git fast-import --export-marks=mymarks <foo
> 
> even though 'option export-marks=bar' appears in foo.

I guess the reason is that this is harder to implement.  The problem is 
that you _have_ to parse the command line options first.  So you need to 
record with every option you set that it has been set by the command line, 
and must not be overridden by the in-stream options.

OTOH,

	hg fast-export |
	sed '1,/^blob/s/^option export-marks=.*$//' > foo

is relatively easy.

Ciao,
Dscho
