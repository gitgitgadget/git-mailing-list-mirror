From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/8] loosening "sender" prompt in send-email
Date: Wed, 14 Nov 2012 16:30:30 -0800
Message-ID: <20121115003029.GA17550@sigill.intra.peff.net>
References: <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
 <20121113074720.GA18746@sigill.intra.peff.net>
 <CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
 <20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 01:30:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnM4-0000co-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992483Ab2KOAaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:30:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48787 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992470Ab2KOAad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:30:33 -0500
Received: (qmail 8897 invoked by uid 107); 15 Nov 2012 00:31:21 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 19:31:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 16:30:30 -0800
Content-Disposition: inline
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209766>

On Tue, Nov 13, 2012 at 11:48:45AM -0500, Jeff King wrote:

>   [1/6]: ident: make user_ident_explicitly_given private
>   [2/6]: ident: keep separate "explicit" flags for author and committer
>   [3/6]: var: accept multiple variables on the command line
>   [4/6]: var: provide explicit/implicit ident information
>   [5/6]: Git.pm: teach "ident" to query explicitness
>   [6/6]: send-email: do not prompt for explicit repo ident

Here is a re-roll of the series based on comments from Jonathan (changes
from the first version noted below):

  [1/8]: test-lib: allow negation of prerequisites
  [2/8]: t7502: factor out autoident prerequisite

These two are new, and allow us to use the same prereq from t7502 in
t9001.

  [3/8]: ident: make user_ident_explicitly_given static

Expanded the commit message to explain history of the variable.

  [4/8]: ident: keep separate "explicit" flags for author and committer

Same as before.

  [5/8]: var: accept multiple variables on the command line

 - Expanded tests to include "git var -l"
 - Use $GIT_* variables to create test "expect" files, which should make
   them less brittle.
 - Fixed "git var -l foo" to print usage instead of ignoring foo (i.e.,
   keeping the behavior the same).
 - Update usage message to match new feature.

  [6/8]: var: provide explicit/implicit ident information

Updated documentation to describe what "explicit" means. No functional
changes.

  [7/8]: Git.pm: teach "ident" to query explicitness

Improved Git.pm documentation. No functional changes.

  [8/8]: send-email: do not prompt for explicit repo ident

Test the implicit ident case, both when we have implicit ident and when
we don't. No changes to send-email.

-Peff
