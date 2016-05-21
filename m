From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v7 0/9] connect: various cleanups
Date: Sun, 22 May 2016 08:17:23 +0900
Message-ID: <20160521231732.4888-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 01:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4G9R-0005Vg-BW
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbcEUXRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:17:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55502 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbcEUXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:17:39 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b4G9E-0001Hf-PO; Sun, 22 May 2016 08:17:32 +0900
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295242>

Difference with v6:
- Dropped the core.gitProxy change as per discussion.
- Added a comment about the extra get_port.

Note that after this series, parse_connect_url can be further refactored to
avoid the kind of back-and-forth with host_end, get_host_and_port and
get_port.

Mike Hommey (9):
  connect: document why we sometimes call get_port after
    get_host_and_port
  connect: call get_host_and_port() earlier
  connect: re-derive a host:port string from the separate host and port
    variables
  connect: make parse_connect_url() return separated host and port
  connect: group CONNECT_DIAG_URL handling code
  connect: make parse_connect_url() return the user part of the url as a
    separate value
  connect: change the --diag-url output to separate user and host
  connect: actively reject git:// urls with a user part
  connect: move ssh command line preparation to a separate function

 connect.c             | 231 +++++++++++++++++++++++++++++---------------------
 t/t5500-fetch-pack.sh |  42 ++++++---
 2 files changed, 166 insertions(+), 107 deletions(-)

-- 
2.8.3.401.ga81c606.dirty
