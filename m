From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/14] Remove unused code from imap-send.c
Date: Tue, 15 Jan 2013 09:06:18 +0100
Message-ID: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1YB-0002Hs-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab3AOIGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:06:55 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:54676 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab3AOIGy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:06:54 -0500
X-AuditID: 12074411-b7fa36d0000008cc-36-50f50e1d464b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 01.B9.02252.D1E05F05; Tue, 15 Jan 2013 03:06:53 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5M029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:06:52 -0500
X-Mailer: git-send-email 1.8.0.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqCvL9zXAoH2+jUXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfsO9zCVnCEu2Li7X6mBsYD
	nF2MHBwSAiYS/04KdzFyApliEhfurWfrYuTiEBK4zCjx68lORgjnDJPEw11fmUCq2AR0JRb1
	NIPZIgJqEhPbDrGA2MwCDhKbPzcygtjCArYSC3evAKthEVCVeHe3kx3E5hVwlpj87xATxDYF
	idc7L7FOYORewMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyPE94I7GGec
	lDvEKMDBqMTDa2rwJUCINbGsuDL3EKMkB5OSKG8H19cAIb6k/JTKjMTijPii0pzU4kOMEhzM
	SiK8Pu+AynlTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKErwKvEBDBYtS
	01Mr0jJzShDSTBycIIILZAMP0IZX3ECFvMUFibnFmekQRacYFaXEef/wACUEQBIZpXlwA2BR
	+opRHOgfYV5RkD08wAiH634FNJgJaPCmvZ9BBpckIqSkGhglr0jo819gtz/sz/dO74b9Qy11
	Hvci+70Tvt8SC7ff/k0h+KLL/927W39NL64VeTapZf+/wDXG/ds+F9nt2qWxX+LqRDljrxeB
	RgeTtyZP5trGonmm6ME+M79HQst2Ls4y4v362sa/+/l+RY6VIc05O7/VfBFOl/B+9NEv6POu
	nAWhl1f4/+RVYinOSDTUYi4qTgQAZsCno60CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213604>

This is a re-roll, incorporating the feedback of Jonathan Nieder
(thanks!).

Differences from v1:

* Added comments to get_cmd_result() at the place where the
  "NAMESPACE" response is skipped over.

* Added some comments to lf_to_crlf(), simplified the code a bit
  further, and expanded the commit message.

* Replaced erroneously-deleted space in "APPEND" command in
  imap_store_msg().

I also moved the patch rewriting lf_to_crlf() to the end of the
series, because it is not just dead-code elimination like the others.

Michael Haggerty (14):
  imap-send.c: remove msg_data::flags, which was always zero
  imap-send.c: remove struct msg_data
  iamp-send.c: remove unused struct imap_store_conf
  imap-send.c: remove struct store_conf
  imap-send.c: remove struct message
  imap-send.c: remove some unused fields from struct store
  imap-send.c: inline imap_parse_list() in imap_list()
  imap-send.c: remove struct imap argument to parse_imap_list_l()
  imap-send.c: remove namespace fields from struct imap
  imap-send.c: remove unused field imap_store::trashnc
  imap-send.c: use struct imap_store instead of struct store
  imap-send.c: remove unused field imap_store::uidvalidity
  imap-send.c: fold struct store into struct imap_store
  imap-send.c: simplify logic in lf_to_crlf()

 imap-send.c | 308 +++++++++++-------------------------------------------------
 1 file changed, 55 insertions(+), 253 deletions(-)

-- 
1.8.0.3
