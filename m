From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/3] Expanding tabs in "git log" output
Date: Tue, 29 Mar 2016 16:15:06 -0700
Message-ID: <1459293309-25195-1-git-send-email-gitster@pobox.com>
References: <1458775426-2215-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 01:15:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2r1-0005L2-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509AbcC2XPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:15:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758491AbcC2XPM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 19:15:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DADA550FA7;
	Tue, 29 Mar 2016 19:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t0aqdroPJViM
	O18yOaivJIK3dRY=; b=TpewYUV+MR4qs+d+23ZjOWXK3aXOd7RXE7+jmMvdeiAb
	1jNJcQXf4++fj5JGlhnWMmijxv1k7gQL2fi4pgD3cTrJiea77c+cofpcEyzG6Nn7
	63uAmlLRBrueURDE5fhd69r+Y9adoMyAelqJinSw64o8plxcNBBp3qL7pTecUns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b2tcUm
	nZxd5byzXqvpc2hGOt4rHmFugsJPgzEdnQPpSzlln3/z0/ouFIbj4SRc5GnjTbIO
	JXJCnI+LFXl4x/d65tb3iz0cr1ySOikilnIP4osVcoTY1YivEtA6FYSfJdbdQqhI
	n9Di7UIgPHZgz+mjfKZADvI9Qm1WprjRoX8bU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D170F50FA5;
	Tue, 29 Mar 2016 19:15:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53CBC50FA3;
	Tue, 29 Mar 2016 19:15:10 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-gd29a7d9
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 155F843E-F604-11E5-AC10-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290222>

So here is the fourth try.  Previous round are at $gmane/289694,
$gmane/289166, and $gmane/288987.

I didn't quite find a good order to build this progressively, so
this series:

 - First adds the internal machinery and explicit --expand-tabs.
   This keeps Linus's authorship, but is different in that it is not
   enabled by default;

 - Then enable --expand-tabs by default for selected pretty formats;

 - And optionally, allow custom tab-width to be used.

Junio C Hamano (2):
  pretty: enable --expand-tabs by default for selected pretty formats
  pretty: allow tweaking tabwidth in --expand-tabs

Linus Torvalds (1):
  pretty: expand tabs in indented logs to make things line up properly

 Documentation/pretty-options.txt | 14 +++++++
 commit.h                         |  1 +
 log-tree.c                       |  1 +
 pretty.c                         | 87 +++++++++++++++++++++++++++++++++++-----
 revision.c                       | 10 +++++
 revision.h                       |  2 +-
 t/t4201-shortlog.sh              |  2 +-
 7 files changed, 106 insertions(+), 11 deletions(-)

-- 
2.8.0-215-gd29a7d9
