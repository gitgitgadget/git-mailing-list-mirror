From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH V2 0/3] strbuf: improve API
Date: Mon,  6 Jun 2016 17:13:37 +0200
Message-ID: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:14:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wEp-0008Rd-HY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbcFFPOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:14:31 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:58367 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871AbcFFPOa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 11:14:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4A1392074;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rmGZ_vy_7QFp; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 33D162071;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 2C9592079;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrZOuwslzJYT; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-032048.grenet.fr [130.190.32.48])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 04AA72055;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc1.1.geac644e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296516>

This patch series implements an improvment of the strbuf API, allowing
strbuf to use preallocated memory. This makes strbuf fit to be used
in performance-critical operations.

* The first patch is simply a preparatory work, adding tests for
existing strbuf implementation.
* The second patch is also preparatory: rename a function for the third
patch.
* Most of the work is made in the third patch: handle pre-allocated
memory, extend the API, document it and test it.

As said in the third commit message, the idea comes from Michael Haggerty.

William Duclot (3):
      strbuf: add tests
      pretty.c: rename strbuf_wrap() function
      strbuf: allow to use preallocated memory

Makefile               |   1 +
pretty.c               |   7 ++++---
strbuf.c               |  82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
strbuf.h               |  44 ++++++++++++++++++++++++++++++++++++++--
t/helper/test-strbuf.c | 229 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
t/t0082-strbuf.sh      |  48 ++++++++++++++++++++++++++++++++++++++++++++
6 files changed, 394 insertions(+), 17 deletions(-)
