From: tboegi@web.de
Subject: [PATCH v4 0/2] CRLF: ce_compare_data() checks for a sha1 of a path
Date: Tue, 17 May 2016 18:41:06 +0200
Message-ID: <1463503266-3552-1-git-send-email-tboegi@web.de>
References: <573A993F.8020205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 18:36:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2hyT-0003ao-D1
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 18:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbcEQQf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2016 12:35:56 -0400
Received: from mout.web.de ([212.227.15.3]:53811 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbcEQQfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 12:35:55 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MHYLM-1b1bVc18zk-003KBj; Tue, 17 May 2016 18:35:52
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <573A993F.8020205@web.de>
X-Provags-ID: V03:K0:KVcMUixb0SEsMqVVLgpwWM8aSHT2iFdpOteihAaXUkp8oHJzl3W
 nXQUP2lNX+1TKgOlad+xKSC8QFreaTd+nAxUC5EeMUdEOv4McXFMaevxqhbxIOeFaSm1DNS
 OGNyOpK+ktaXvZSHNa+vAi/IfQUtPFR6fGZOi3KImtPYpBZq7ojKWR8WcfInLrK41hHv5kX
 KO9aL2xHKeWPIPyBzox5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nvhFOek/c7o=:RSpUfPewa9H3MoEHn5ydyJ
 Nu9nMr/bm7LOaGEGbx5Az3aB2UXuLsHoQa2zmOHgEMM14BOJhvVAzRgmmHfQdjdCcfWSwC1WP
 BVmSBHBWUWjqj/gZuX+jujqMKu74kyQ7jq1TrIIETUtIEcpsr7c/3JyRNbPeYKINEq7bUU9Mk
 uMiRwor6Ksqhj4JbswWnPbDLDHEbjg0g3/CIbKCp9R95LELc4LKcpHtF4EZoJAVUc5bAJPwrF
 4ShL8VjInbDv0EaQKhVo3diNgyUXrb5nm6s/b1CNdArwYINeb2UHiSGJIyMbwlOO6psi38GyG
 p4F3VQZoAW4QDrUv7D9r1Yiuqh78nOo/z/yGwlfSxMddV4qlnpntHzZoT9uGr1fRtJEAVT/Py
 Pl7VVSUqe1bxMah1IswUZOtFxqZrT1TEYCkDuI07UShtAmYjgDVhp6yS307dsQlLbAqtFAJBB
 BvFGo6446iJc+0xCwl8qZ/qKQ+uZQOXyF/WoFWmm/Czl398wxxg7N5/bZc5TSxJFCud2LmPwo
 F+/6dbwPZBZS7gtomEOxEn2C4wrx0gTLT5VVGt9hRmLejIQuEYCtUjaDwUOhDNoH7dHItmCVj
 2B4nDrfM6uX2m89NZNplArM9drjpl2Oomk558B/FAU1yThKY6E4vBL5IHD5CLXtFdBnaWrroU
 59aC74qxk0YrE8HOkCc6jLV++HkqkkinmJdI98lyl1GtwNXHYVTkY6ykHy3JoYOW/PHAG5S6b
 Y9zqCucTyV3sitTu+oPdRaVO8W1eMc7RVxRoDX6ZZNRmX/2aRqGGXvzMffsQcD1mHisyUa4H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294870>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Break up the old 10/10 series about CLRF handling into smaller
series. This is a small bugfix, when merge.renormalize is used
with core.autocrlf (and no attributes are set).
Prepare the refactoring to use the streaming interface.

Torsten B=C3=B6gershausen (2):
  read-cache: factor out get_sha1_from_index() helper
  convert: ce_compare_data() checks for a sha1 of a path

 cache.h      |  4 ++++
 convert.c    | 34 ++++++++++++++++++++++------------
 convert.h    | 23 +++++++++++++++++++----
 read-cache.c | 33 +++++++++++++++++++++------------
 sha1_file.c  | 17 +++++++++++++----
 5 files changed, 79 insertions(+), 32 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
