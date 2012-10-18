From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP-PATCH 0/3] Cleaning up "notes" in log output
Date: Wed, 17 Oct 2012 19:20:15 -0700
Message-ID: <1350526818-354-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 04:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfj8-0003OE-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 04:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2JRCUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 22:20:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab2JRCUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 22:20:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B599B83F1
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=BxNUlG7+skhjMxT15Ggol/eFWG4
	=; b=wH8dUvBKSHFKEF+iffWDWJnLMkjJS1V7ISOy9BfLlFF1WmRGs+vkZ7v0v3a
	2POSRJ4X5Luq6VmjoiTsTPoh50J9rSc8kQoklAZcmkgjVhs5e0fBhuTRT52f4ZZV
	He1E3CjMiUTxWwsVimKRuTaEJ1k9eQjuNrJSxj4RpK9oJkBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Jl3FM1LC2LZiz7FeYQc56kw4130gE
	UE13TqvHt57grrvNKXGf0C2fq65VS2Lkx5lqZ4iTvIOJVrQ7jF/89KZUouv7pQ7D
	uK24Sw3K2G+CSREHZxf+V1SfvE0DWADtUevt3v678E18WGAT8U3xRikTgOTrLtUM
	Ys0zojye0mVBrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3BCE83F0
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BC2283EF for
 <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:20 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
X-Pobox-Relay-ID: 5D8BD2C8-18CA-11E2-BA91-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207953>

This is only the preparatory step.

The obvious next one that follows will swap the "add-sign-off" logic
and appending of notes, so that sign-off will come before the notes.
And then, we will insert "---" before we add notes, leave a bit in
the rev_info for the later step in the codepath to tell it that it
does not have to add another "---", and tweak the existing codepath
that adds "---" to refrain from doing so.

Junio C Hamano (3):
  pretty: remove reencode_commit_message()
  pretty: prepare notes message at a centralized place
  pretty_print_commit(): do not append notes message

 builtin/blame.c |  5 +++--
 commit.h        |  4 +---
 log-tree.c      | 17 ++++++++++++++++-
 pretty.c        | 22 ++++------------------
 4 files changed, 24 insertions(+), 24 deletions(-)

-- 
1.8.0.rc3.112.gdb88a5e
