From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Mon, 24 Oct 2011 17:59:31 +0200
Message-ID: <4EA58B63.8040800@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx> <20111023162944.GB28156@sigill.intra.peff.net> <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx> <7vipne50lz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 17:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIMwD-0007Le-Me
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 17:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932Ab1JXP7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 11:59:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:60183 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826Ab1JXP7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 11:59:40 -0400
Received: from [192.168.2.104] (p4FFD8D85.dip.t-dialin.net [79.253.141.133])
	by india601.server4you.de (Postfix) with ESMTPSA id 7736D2F8038;
	Mon, 24 Oct 2011 17:59:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vipne50lz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184176>

Am 24.10.2011 09:07, schrieb Junio C Hamano:
> Thanks.
>=20
> This approach may be the most appropriate for the maintenance track, =
but
> for the purpose of going forward, I wonder if we really want to keep =
the
> "estimate and allocate a large pool, and carve out individual pieces"=
=2E
>=20
> This bulk-allocate dates back to the days when we didn't have ondisk =
vs
> incore representation differences, IIRC, and as the result we deliber=
ately
> leak cache entries whenever an entry in the index is replaced with a =
new
> one. Does the overhead to allocate individually really kill us that m=
uch
> for say a tree with 30k files in it?

Probably not; unpack_trees() does that already.  (It calls
create_ce_entry() via unpack_nondirectories() via unpack_callback() via
traverse_trees()).

Ren=E9
