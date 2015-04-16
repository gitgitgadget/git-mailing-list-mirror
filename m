From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] UTF8 BOM follow-up
Date: Thu, 16 Apr 2015 11:39:04 -0700
Message-ID: <1429209548-32297-1-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 20:39:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yioh2-0006ue-3f
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbbDPSjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:39:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752073AbbDPSjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:39:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A807D4A37F;
	Thu, 16 Apr 2015 14:39:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iI0+
	FwHBPnfFi7mIaVbXbElZF5M=; b=VsJ0odsTEAjViIj3kfqAmNLhdjWI8yuZdyS1
	2qlld1IwEO0C1MFGqatMmNsqdjxsIK8uTkwNv71EF58niWWkpBeOWUG+vv3jA5ML
	rnOzTqLbFS0N9r3GiZVxEkpPXxgkt1Unh6K3gcz97naVYfzD0rj2rORKeWEyGz+z
	qbiaQ4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ohj/IlmMY46Y9gCYaqAv4cBeuZ3vzbwAki5NG5oDFxGkGSp8uc+O429y+C68CTKe
	ISgAQSXIY8QE96SqTCHiim4G21ph9w3Sv+zbHa5jlgM4LbaQF15X8p1IyxqIDZuF
	mnfGbxe+00C6ruXFPlkCMIMzfxy7pJemzBh16GjrAdA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D2A54A37C;
	Thu, 16 Apr 2015 14:39:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F4AB4A37A;
	Thu, 16 Apr 2015 14:39:09 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: DE5DF280-E467-11E4-A787-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267322>

This is on top of the ".gitignore can start with UTF8 BOM" patch
from Carlos.

Second try; the first patch is new to clarify the logic in the
codeflow after Carlos's patch, and the second one has been adjusted
accordingly.

Junio C Hamano (4):
  add_excludes_from_file: clarify the bom skipping logic
  utf8-bom: introduce skip_utf8_bom() helper
  config: use utf8_bom[] from utf.[ch] in git_parse_source()
  attr: skip UTF8 BOM at the beginning of the input file

 attr.c   |  9 +++++++--
 config.c |  6 +++---
 dir.c    | 10 +++++-----
 utf8.c   | 11 +++++++++++
 utf8.h   |  3 +++
 5 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.4.0-rc2-171-g98ddf7f
