From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] index-pack: Honor core.deltaBaseCacheLimit when
	resolving deltas
Date: Tue, 15 Jul 2008 03:18:00 +0000
Message-ID: <20080715031800.GD1700@spearce.org>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org> <1216001267-33235-2-git-send-email-spearce@spearce.org> <1216001267-33235-3-git-send-email-spearce@spearce.org> <1216001267-33235-4-git-send-email-spearce@spearce.org> <1216001267-33235-5-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807142255240.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIb4D-00010l-UU
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbYGODSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755806AbYGODSD
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:18:03 -0400
Received: from george.spearce.org ([209.20.77.23]:52177 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680AbYGODSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:18:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1719B3836B; Tue, 15 Jul 2008 03:18:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807142255240.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88511>

Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 13 Jul 2008, Shawn O. Pearce wrote:
> 
> But this patch is suboptimal as it actually recreate the same memory 
> pressure, to a lesser degree, this series is meant to solve.  If you do:

Arrgh.  Good catch on review.  I'll post a replacement patch shortly
that doesn't suffer from this problem.  Thanks!
 
> > +		struct object_entry *obj = c->obj;
> > +		void *raw = get_data_from_pack(obj);
> > +		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
> > +			c->data = patch_delta(
> > +				get_base_data(c->base), c->base->size,
> > +				raw, obj->size,
> > +				&c->size);
> > +			free(raw);

-- 
Shawn.
