From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v4 0/2] Add in-place editing support to git interpret-trailers
Date: Thu, 14 Jan 2016 17:57:53 +0100
Message-ID: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:58:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJlEG-0001UO-NE
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbcANQ6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:58:02 -0500
Received: from mail.zhinst.com ([212.126.164.98]:56267 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbcANQ6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:58:00 -0500
Received: from ziws06.zhinst.com ([10.42.0.7])
	by mail.zhinst.com (Kerio Connect 9.0.1) with ESMTP;
	Thu, 14 Jan 2016 17:57:56 +0100
X-Mailer: git-send-email 2.7.0.1.g5e091f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284066>

This patch series adds support for in-place editing to git
interpret-trailers akin to sed -i, perl -i.

v3->v4:
 - Reword a test title, as suggested by Eric Sunshine.
 - Add a test to verify that the original file is not clobbered/deleted
   on error, as suggested by Eric Sunshine.
 - Move code specific to in-place editing from process_trailers() into a
   separate function to keep the overall flow clean. Suggested by Eric
   Sunshine.
 - Drop unnecessary braces, as pointed out by Eric Sunshine.
 - Use a more meaningful title for patch 1/2. Suggested by Junio Hamano.

v2->v3:
 - Rephrase two error messages according to the suggestions by Matthieu
   Moy.

v1->v2:
 - Split patch to make review easier, as suggested by Matthieu Moy.
 - Rename FILE * function parameters to a more readable name, as
   suggested by Matthieu Moy.
 - Write output to temporary file and rename after successfully written
   in full to avoid losing the original file in case of an
   error/interrupt. Pointed out by Eric Sunshine.

Tobias Klauser (2):
  trailer: allow to write to files other than stdout
  interpret-trailers: add option for in-place editing

 Documentation/git-interpret-trailers.txt | 24 ++++++++++-
 builtin/interpret-trailers.c             | 13 ++++--
 t/t7513-interpret-trailers.sh            | 40 ++++++++++++++++++
 trailer.c                                | 69 +++++++++++++++++++++++++-------
 trailer.h                                |  3 +-
 5 files changed, 129 insertions(+), 20 deletions(-)

-- 
2.7.0.1.g5e091f5
