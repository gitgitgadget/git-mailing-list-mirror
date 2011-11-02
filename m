From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCHv2] Improve use of select in http backend
Date: Wed,  2 Nov 2011 21:21:26 +0100
Message-ID: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLhK5-0004Nm-1M
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab1KBUWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:22:04 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:35239 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1KBUWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:22:03 -0400
Received: from localhost.localdomain (ip-109-43-0-1.web.vodafone.de [109.43.0.1])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id ADFF226E42FD;
	Wed,  2 Nov 2011 21:21:57 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.33.g09c6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184664>

I've split my previous patch into two, since the two parts actually do
different things.

The first patch uses curl_multi_fdset to use the file descriptors of the http
connections in the call to select, in effect waking up immediately when new
data arrives.

The second patch uses curl_multi_timeout (if available) to get a better
recommendation for how long to sleep from curl instead of always sleeping
for 50ms.
