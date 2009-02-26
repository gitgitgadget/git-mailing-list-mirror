From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Pickaxe search clean-up and optimization
Date: Wed, 25 Feb 2009 22:52:02 -0800
Message-ID: <cover.1235629933.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 07:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lca82-0006C2-ER
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 07:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbZBZGwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 01:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZBZGwM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 01:52:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZBZGwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 01:52:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 21E09125C
	for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B6726125B for
 <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:07 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.91.gf9a36
X-Pobox-Relay-ID: 2692D1E6-049B-11DE-9C26-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111528>

This little series refactors the diffcore-pickaxe a bit and then optimizes
its search for "needle" inside the haystacks.

Junio C Hamano (4):
  diffcore-pickaxe: refactor diffcore_pickaxe()
  diffcore-pickaxe: micro-optimize has_match() function
  diffcore-pickaxe: further refactor count_match()
  diffcore-pickaxe: optimize by trimming common initial and trailing
    parts

 diffcore-pickaxe.c |  176 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 118 insertions(+), 58 deletions(-)
