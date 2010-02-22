From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 13:14:29 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002221310130.1946@xanadu.home>
References: <20100214011812.GA2175@dpotapov.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
 <20100222173122.GG11733@gibbs.hungrycats.org>
 <37fcd2781002221005l2a8ecb64y3be84eaaacd27cdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njcnl-0001JL-Ny
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab0BVSOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:14:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53020 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab0BVSOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:14:30 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY9003539C5N7M0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 13:14:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <37fcd2781002221005l2a8ecb64y3be84eaaacd27cdc@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140704>

On Mon, 22 Feb 2010, Dmitry Potapov wrote:

> Currently, we calculate SHA-1, then lookup whether the object with this
> SHA-1 exists, and if it does not, then deflate and write it to the
> object storage. So, we avoid deflate and write cost if this object
> already exists. Moreover, when we deflate data, we create the temporary
> file in the same directory where the target object will be stored, thus
> avoiding cross-directory rename (which is important for some reason, but
> I don't remember why).  So, creating the temporary file requires the
> knowledge first two digits of SHA-1, which you cannot know without
> calculation SHA-1.

Even that initial SHA1 calculation can be done in chunks.  Worth doing 
for large enough files only though.


Nicolas
