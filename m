From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 27 Aug 2013 15:59:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271553530.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-10-git-send-email-nico@fluxnic.net>
 <xmqqy57ndtxb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPQN-0006A7-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab3H0T7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:59:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33938 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3H0T7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:59:31 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700BJ7GV2JR20@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 15:59:26 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id CA8ED2DA052D; Tue, 27 Aug 2013 15:59:25 -0400 (EDT)
In-reply-to: <xmqqy57ndtxb.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233154>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > +	/* parse the "tree" line */
> > +	if (in + 46 >= tail || memcmp(in, "tree ", 5) || in[45] != '\n')
> > +		goto bad_data;
> > +	if (get_sha1_hex(in + 5, sha1) < 0)
> > +		goto bad_data;
> 
> Is this strict enough to guarantee roundtrip hash identity?  Because
> get_sha1_hex() accepts hexadecimal represented with uppercase A-F,
> you need to reject such a "broken" commit object, no?

BTW, is there any such objects in existence where sha1 ascii strings are 
represented using uppercase letters?  Because there would be a simple 
way to encode that fact in the pack v4 sha1 reference... but that change 
has to happen now.

I'm already claiming we won't support mixed case though.


Nicolas
