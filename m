From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/3] Recursion-free unpack_entry and packed_object_info
Date: Wed, 27 Mar 2013 21:03:39 +0100
Message-ID: <cover.1364414442.git.trast@inf.ethz.ch>
References: <87620faky3.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Nicolas Pitre" <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwa5-0004uq-R4
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab3C0UDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:03:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2716 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960Ab3C0UDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:03:51 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 21:03:44 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 21:03:48 +0100
X-Mailer: git-send-email 1.8.2.344.g1440b22
In-Reply-To: <87620faky3.fsf@linux-k42r.v.cablecom.net>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219317>

From: Thomas Rast <trast@inf.ethz.ch>

Almost the same as last time.  Changed: the rename suggested by Junio

> The only little concern I may have is this cmp_* function tells us
> "I found it!" by returning true, which is counter-intuitive to the
> readers of the caller (not the callee).
> 
> I think it makes sense to compare delta-base-cache entries only for
> equality, so eq-delta-base-cache-entry might be a better name for
> it, perhaps?

and a small reword to patch 3's commit message to make it clearer at
which stage we unpack the deltas.


Thomas Rast (3):
  sha1_file: remove recursion in packed_object_info
  Refactor parts of in_delta_base_cache/cache_or_unpack_entry
  sha1_file: remove recursion in unpack_entry

 sha1_file.c | 411 +++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 266 insertions(+), 145 deletions(-)

-- 
1.8.2.344.g1440b22
