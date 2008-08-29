From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git-aware HTTP transport
Date: Fri, 29 Aug 2008 15:55:44 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808291546570.1624@xanadu.home>
References: <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
 <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
 <20080828145706.GB21072@spearce.org>
 <7vwsi0a2op.fsf@gitster.siamese.dyndns.org> <48B784FD.3080005@zytor.com>
 <7vej488gcu.fsf@gitster.siamese.dyndns.org> <20080829173954.GG7403@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:57:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZA5p-00039I-SU
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 21:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbYH2Tzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 15:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYH2Tzu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 15:55:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56708 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYH2Tzu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 15:55:50 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D00IR8OOWG9V1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 15:55:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080829173954.GG7403@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94320>

On Fri, 29 Aug 2008, Shawn O. Pearce wrote:

> Yet another draft follows.  I believe that I have covered all
> comments with this draft.  But I welcome any additional ones,
> as thus far it has been a very constructive process.
> 
> The updated protocol looks more like the current native protocol
> does.  This should make it easier to reuse code between the two
> protocol implementations.
[...]

> pkt-line Format
> ---------------
> 
> Much of the payload is described around pkt-lines.
> 
> A pkt-line is a variable length binary string.  The first four bytes
> of the line indicates the total length of the line, in hexadecimal.
> The total length includes the 4 bytes used to denote the length.  A
> line is usually terminated by an LF, which must be included in the
> total length if present.
> 
> Binary data is permitted within a pkt-line so implementors should
> ensure their pkt-line parsing/formatting routines are 8-bit clean.
> The maximum length of a pkt-line's data is 65532 bytes (65536 - 4).

Shouldn't that be 65531, since you cannot represent 65536 with 4 hex 
digits?

> 	C: 001bcapability include-tag
> 	C: 0019capability thin-pack
> 	....
[...]
>      The "capability" command requests a single protocol feature
>      to be enabled by the server.  Typically these are used to
>      describe aspects of the pack that will be returned.  See
>      below for more details on the current capabilities.

Why not having all capabilities listed at once on a single line instead?  
That's more or less what the current protocol does already.


Nicolas
