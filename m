From: tboegi@web.de
Subject: [PATCH v1 0/3] CRLF-Handling: bug fix around ce_compare_data()
Date: Sun, 15 May 2016 08:37:43 +0200
Message-ID: <1463294263-20135-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:32:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1pbe-00061f-Q9
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbcEOGcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:32:41 -0400
Received: from mout.web.de ([212.227.15.14]:53817 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbcEOGcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:32:41 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LiFT1-1bOoUx36iB-00nORm; Sun, 15 May 2016 08:32:36
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:yx0qtGVjB0i68EEtLmERW2dyLbiamoRSfEGAbBM/FgetjQXXrgd
 N8qSJVB2cmwDkHlyUt9YNTaydA4pFNSio92YJ/bJ+SYoBemtgGzroelGK2O1OObnfTWrr7w
 efkkFHWSneHq/YCKijdblF7P7Y9UhOd+z3oScM4lm76/2xmErRfOPk74UY5Zu0nliLYJnQl
 Pr4can2w/lNOHC0FozMYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yq40GqoYoY4=:Ty0gRFwyNKkbmdqMz10NKY
 J2aViEPyr1vMSjSpz6qy1HsLNEqBmcDVASBZHqMQEg+Y+jt6Gv+rFrpAMfPxM8CLFGRVcZx5d
 5R+DFwWno7k9276py5saYZCT9GFBQoBVkDjvn2+MgS+lDeK8qOLqTe8YtV4cVxNWys2iq8NQM
 RU1gyHiJSqVGrBoZKjvcQ4MXtcX85A9b96rPUy7gwPu5pW0/7hMYM6ie4m+K5ek4ntrpFvBm0
 gos3UZUSOi8/3VgfPa8+tysHitPb7N9OPPAP75606YaLgBbi0boc1UofteFJmxLmNBY6O+gm2
 UAzutHuVUYLUrriOspUd+FLpazuVf9mh3FUpSJI4WYmOG3IqLx+RYzRJGcUhLi//3X4AAc20N
 1hAZyY+uTqMLVWQLSCOrddT71c9eNICD0c3EAHQa83J+bn0J1Vvzso4iAvgkZpydAR1Dmh9Fe
 BzGJC5HwqNM4VBaCazmORhZ0C+BFyUZUvzdM5+c0vDTcmsfHs2b1XE5uOfbP18Xx6f9MCYaLN
 YlHldt9CZWpV3tq7JT0j8P5eCPIuSeRPx6X8UmxZyHUxlTN3HnqyGoG849QT1J4wbELAKhvRr
 n/kWBPW4ntO2rhquTEcEHT0eqFeo0DSfMoq5pV/PNgpS+TYpiKYVbbwl7b9tF5D6eTN4E+NAd
 G9cjeBv9jpEIcJ8CMz/ocwv4la8cD4a/mul9ymG4XxzOOdYqHWLE9LnRSE4WW67TAAVZqPKos
 bbXnHv4oO/fEBxIkFS0vE5IpKOACQ28fTCMapKNtWibiS34YS+0VBOCRjG5ctETu1VNBI0af 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294637>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Break up the old 10/10 series about CLRF handling into smaller
series.

1/10..4/10 are now found in tb/core-eol-fix

This series includes 3 from the 10/10 series:
09/10 t6038; use crlf on all platforms                    #now 1/3
05/10 read-cache: factor out get_sha1_from_index() helper #now 2/3
10/10 Fix for ce_compare_data(), done right.              #now 3/3

The most important patch is 3/3

The reminding 3 patches,
stream-and-early-out,
convert-unify-the-auto-handling-of-CRLF
more-safer-crlf-handling-with-text-attr
Need to be re-done, re-sorted and re-written, thanks for all the commen=
ts.

Torsten B=C3=B6gershausen (3):
  t6038; use crlf on all platforms
  read-cache: factor out get_sha1_from_index() helper
  convert: ce_compare_data() checks for a sha1 of a path

 cache.h                    |  4 ++++
 convert.c                  | 33 ++++++++++++++++++++++-----------
 convert.h                  | 23 +++++++++++++++++++----
 read-cache.c               | 33 +++++++++++++++++++++------------
 sha1_file.c                | 17 +++++++++++++----
 t/t6038-merge-text-auto.sh | 37 +++++++++++--------------------------
 6 files changed, 90 insertions(+), 57 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
