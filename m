From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 18:39:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com> <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix> <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix> <7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:37:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFt71-0005Zb-Sq
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZLBRfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbZLBRfA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:35:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:41912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755281AbZLBRe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:34:59 -0500
Received: (qmail invoked by alias); 02 Dec 2009 17:35:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 02 Dec 2009 18:35:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SA6IuEicSk2fowAEUtrAHFxAIx19HnF+y8ehX8R
	SfgcyIM8FDv7Iw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091202160446.GA32667@Knoppix>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134359>

Hi,

On Wed, 2 Dec 2009, Ilari Liusvaara wrote:

> And if mappings http -> curl, https -> curl, ftp -> curl are to remain 
> explicit in main git binary, I would put them into table and build stub 
> remote-curl if NO_CURL is defined instead of special casing the error in 
> main git binary (but I consider that worse than just removing the 
> association from main git binary).

This is definitely a good direction, and it would be even better if the 
absence of the remote helper was also handled gracefully.  Just think 
about a (as of now fictious) git-remote-http.rpm relying on git-core.rpm 
and libcurl.rpm.  If you do not want to access http:// URLs, you can 
install just git-core.  Once you encounter an http:// URL you need to 
access, you install git-remote-http.  Keeping git-core.  (I like to call 
this setup "modular".)

Of course, I never understood why the backend should know the 
implementation detail that it is based on cURL, so it would be even more 
modular (at least by my definition) if there was no hard-coded mapping 
(Sverre -- Cc'ed -- seemed to like URLs of the form "svn::http://..." and 
"cvs::pserver..." to trigger looking for a remote helper explicitely).  I 
find the compiled-in mapping rather limiting.

Ciao,
Dscho
