From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded in
 the pack
Date: Sat, 29 Oct 2011 01:30:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110290128320.30467@xanadu.home>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
 <CAJo=hJt-YZcdxw+D=1S4haPmY-8-LLjXD=MvDGeWbdJ88_VOGw@mail.gmail.com>
 <alpine.LFD.2.02.1110290031540.30467@xanadu.home>
 <CAJo=hJsEzkFV9k8N+GAwWddmEZH8pQeJZrg_MXD72stbAW0ceQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_kq3m0A+sSrIcmz5Qel5mjQ)"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 01:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJvt7-0004f0-LT
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 01:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933868Ab1J1Xa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 19:30:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40793 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933780Ab1J1Xa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 19:30:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LTS003YYULSQ410@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Oct 2011 19:29:52 -0400 (EDT)
In-reply-to: <CAJo=hJsEzkFV9k8N+GAwWddmEZH8pQeJZrg_MXD72stbAW0ceQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184438>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_kq3m0A+sSrIcmz5Qel5mjQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 28 Oct 2011, Shawn Pearce wrote:

> On Fri, Oct 28, 2011 at 15:48, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 28 Oct 2011, Shawn Pearce wrote:
> >> - The immediate next byte encodes the extended type. This type is
> >> stored using the OFS_DELTA offset varint encoding, and thus may be
> >> larger than 256 if we ever need it to be.
> >
> > I'd say it is just a byte.  No encoding needed.  Let's not be silly
> > about it.  If we really have more than 255 object types one day (and I
> > really hope this will never happen) then the value 0 in that byte could
> > indicate yet another extended object type encoding.  But I truly hope
> > we'll have pack v9 or v10 by then and that we'll have obsoleted the
> > current 3-bit encoding completely at that point anyway.
> 
> Yes. I probably wouldn't code the parser to use a varint here. I would
> say the extended types stored in this byte must be >= 8, and must be
> <= 127. Any values out of this range are unsupported and should be
> rejected. We can later reserve the right to set the high bit and
> switch to the OFS_DELTA varint encoding if we need that many more
> types, and we explicitly define codes 0-7 as illegal if detected here
> in the extended byte field.

I wouldn't go as far as rejecting codes 1-7 as illegal though, but I 
otherwise agree with what you say.


Nicolas

--Boundary_(ID_kq3m0A+sSrIcmz5Qel5mjQ)--
