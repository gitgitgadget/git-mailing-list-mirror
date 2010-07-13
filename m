From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/2] Preparing the graph API for external users
Date: Tue, 13 Jul 2010 23:23:37 +0200
Message-ID: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net,
	Lars Hjemli <hjemli@gmail.com>, nanako3@lavabit.com,
	adam@adamsimpkins.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmxK-00066v-BI
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0GMVXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:23:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:63069 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab0GMVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:23:45 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00APZM3JA650@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:23:43 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 1BAFD1EA5B92_C3CD95FB	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:23:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id BA51A1EA3585_C3CD95EF	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:23:42 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00746M3I0N00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:23:42 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150918>

Hi,

I'm playing around with some CGit patches for enabling an ASCII-art
commit graph to be displayed on CGit's 'log' page. These patches reuse
the ASCII-art commit graph that is produced by 'git log --graph'.

However, in order to allow proper reuse by CGit, I need to make a
couple of changes to the graph API:

The first patch exposes graph_next_line() in the graph.h API. This
function is needed to drive the graph generation from CGit. (Since
the graph_show_* functions print directly to stdout, they can not be
used by CGit.)

The second patch allows CGit to use a different coloring mechanism
than the default ANSI color escapes in graph.c. CGit replaces the
column_colors array of ANSI escapes in graph.c with its own array that
contains HTML <span> tags (which are then styled to the appropriate
colors using CSS).

For reference, the corresponding CGit patches that generate the commit
graph on CGit's log page will follow as a separate patch series.


Johan Herland (2):
  Make graph_next_line() available in the graph.h API
  Enable custom schemes for column colors in the graph API

 graph.c |   50 +++++++++++++++++++++++++++-----------------------
 graph.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 23 deletions(-)
