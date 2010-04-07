From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 07 Apr 2010 10:47:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004071044070.7232@xanadu.home>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
 <w2kec874dac1004070730rd1e5c149x88a7d6b4b649792f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_JJpL0tH62lTAW87k/ntWMw)"
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWaS-0004mi-SG
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab0DGOub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:50:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55514 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab0DGOua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:50:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I00GZYH2DVPB0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 10:47:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <w2kec874dac1004070730rd1e5c149x88a7d6b4b649792f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144229>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_JJpL0tH62lTAW87k/ntWMw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 7 Apr 2010, Shawn Pearce wrote:

> On Wed, Apr 7, 2010 at 6:17 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Yet, the memset() issue comes up only because pthread_t is meant to be
> > an opaque type.  The only information we would need here is the actual
> > thread ID as returned by gettid() on Linux or GetCurrentThreadId() on
> > Windows, and then the read_mutex_owner could be a simple atomically
> > modifiable integer.  But what about other pthread-capable non Linux
> > systems?
> 
> Indeed.  If Windows threads are atomic words, then actually you don't
> need that double mutex in the emulation layer, and can instead use the
> atomic word to determine ownership.  Which makes this entire debate
> somewhat moot, doesn't it?

Well, indeed.


Nicolas

--Boundary_(ID_JJpL0tH62lTAW87k/ntWMw)--
