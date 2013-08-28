From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/23] Preliminary pack v4 support
Date: Tue, 27 Aug 2013 22:58:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308272241470.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <xmqqioyrfa5m.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1308271153370.14472@syhkavp.arg>
 <xmqq8uzndqws.fsf@gitster.dls.corp.google.com>
 <CACsJy8AttNxePUG9cKw9ihAmRd=kFpcsgwe2yj_FRQbhc-akCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 04:58:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEVxS-0005Tx-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 04:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab3H1C6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 22:58:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60870 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab3H1C6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 22:58:04 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS800FJE08R4W50@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 22:58:03 -0400 (EDT)
In-reply-to: <CACsJy8AttNxePUG9cKw9ihAmRd=kFpcsgwe2yj_FRQbhc-akCg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233175>

On Wed, 28 Aug 2013, Duy Nguyen wrote:

> On Tue, Aug 27, 2013 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > As you have "0-index" escape hatch for SHA-1 table, but no similar
> > escape hatch for the people's name table, I can see why it may be
> > cumbersome to fix a thin pack by only appending to a received
> > packfile and updating a few header fields, though.
> 
> We also need an escape hatch for path name table.

Well, right. I think this is probably the cleanest solution if we don't 
want to update the commit/tree dictionary table with new entries (they 
could simply be appended at the end).  That wouldn't work for the SHA1 
table though, so perhaps a secondary table for the appended objects 
could then be carried into the pack index file.

> But what if we store
> appended objects in OBJ_REF_DELTA format where base ref is empty
> tree/commit and cached by sha1_file.c?

I don't follow you here.  Missing objects need to be added to the pack, 
they can't be cached anywhere.

> We won't need to update
> dictionary tables. Parsing is a bit ugly though (e.g. v3 tree with v2
> base) but we have to deal with that anyway because people can have v2
> and v3 packs mixed in.

Absolutely.


Nicolas
