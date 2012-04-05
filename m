From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 5 Apr 2012 23:49:57 +0200
Message-ID: <87r4w1vofu.fsf@thomas.inf.ethz.ch>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
	<CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
	<8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
	<CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
	<871uomrubl.fsf@thomas.inf.ethz.ch>
	<8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
	<871uomq64c.fsf@thomas.inf.ethz.ch>
	<BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
	<878virfx11.fsf@thomas.inf.ethz.ch>
	<2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
	<87r4we9sfo.fsf@thomas.inf.ethz.ch>
	<5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
	<7vk423qfps.fsf@alter.siamese.dyndns.org>
	<CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
	<1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com>
	<4F7ABA19.7040408@alum.mit.edu>
	<C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
	<alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
	<D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <david@lang.hm>, Michael Haggerty <mhagger@alum.mit.edu>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Thomas Gummerer <italyhockeyfeed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFuZH-0005es-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 23:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab2DEVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 17:50:04 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:12921 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489Ab2DEVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 17:50:03 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 5 Apr
 2012 23:49:57 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 5 Apr
 2012 23:49:59 +0200
In-Reply-To: <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> (Thomas
	Gummerer's message of "Wed, 4 Apr 2012 22:05:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194814>

Thomas Gummerer <italyhockeyfeed@gmail.com> writes:

> -- Proposed solution --
> The proposed solution is to redesign the index to a B-tree based format. This
> allows changes to the index in O(log(n)) time, with n being the number of
> entries in the index. 

> -- Solutions that were also considered --
> - Append-only data structure
> - Database format
> - Padded structure

This is quite complete already, which I think is great, but it's still
missing one "obvious" approach: a directory-tree based layout that uses
"flat" storage.  That is, the entries grouped by directory and thus
arranged into the "natural" tree, so as to allow parsing only part of
it.  But not pulling any tricks to make it easy to change; a nontrivial
change would mean a rewrite.  How good do you think that could be?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
