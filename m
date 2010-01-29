From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Thu, 28 Jan 2010 21:33:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001282125410.1681@xanadu.home>
References: <20100129012350.GD20488@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 03:33:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nagfq-0007VG-Uk
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 03:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab0A2CdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 21:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299Ab0A2CdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 21:33:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43886 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab0A2CdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 21:33:24 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWZ00BFULRN6N30@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Jan 2010 21:33:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100129012350.GD20488@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138294>

On Thu, 28 Jan 2010, Shawn O. Pearce wrote:

> If a blob is larger than the configured big-file-threshold, instead
> of reading it into a single buffer obtained from malloc, stream it
> onto the end of the current pack file.  Streaming the larger objects
> into the pack avoids the 4+ GiB memory footprint that occurs when
> fast-import is processing 2+ GiB blobs.

Yeah.  I've had that item on my todo list for ages now.  This 
big-file-threshold principle has to be applied to 'git add' too so a big 
blob is stored in pack file form right away, and used to bypass delta 
searching in 'git pack-objects', used to skip the diff machinery, and so 
on.


Nicolas
