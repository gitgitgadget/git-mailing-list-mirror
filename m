From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 14/23] pack v4: object data copy
Date: Tue, 27 Aug 2013 14:24:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271409320.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-15-git-send-email-nico@fluxnic.net>
 <xmqqli3ndt9z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 20:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEO01-0003EH-KX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab3H0S2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:28:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9101 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3H0S2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 14:28:11 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700L9WCHMNY11@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 14:24:58 -0400 (EDT)
In-reply-to: <xmqqli3ndt9z.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233133>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Blob and tag objects have no particular changes except for their object
> > header.
> >
> > Delta objects are also copied as is, except for their delta base reference
> > which is converted to the new way as used elsewhere in pack v4 encoding
> > i.e. an index into the SHA1 table or a literal SHA1 prefixed by 0 if not
> > found in the table (see add_sha1_ref).  This is true for both REF_DELTA
> > as well as OFS_DELTA.
> >
> > Object payload is validated against the recorded CRC32 in the source
> > pack index file when possible.
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> 
> The title somewhat confused me until I realized that this series is
> building a program that would convert existing data from a single
> pack into packv4 format, not a "pack-objects --pack-verison=4".

I initially started with extensions to pack-objects but that quickly 
became a big hassle to keep things working while experimenting.  So this 
tool is just a straight pack converter which in itself turned out to be 
quite complex already.  Eventually its code could be merged into 
pack-objects.


Nicolas
