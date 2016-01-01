From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: [PATCH v1] Fix t3400 on a case insensitive file system
Date: Fri, 1 Jan 2016 16:08:57 +0100
Message-ID: <56869689.7030604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 01 16:09:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF1KL-00029o-2w
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 16:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbcAAPJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jan 2016 10:09:09 -0500
Received: from mout.web.de ([212.227.15.14]:63995 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbcAAPJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 10:09:08 -0500
Received: from [192.168.2.107] ([79.223.114.113]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LfzgJ-1Zupjp43qt-00pZsf; Fri, 01 Jan 2016 16:09:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
X-Provags-ID: V03:K0:ZzUqp+ago5X7MYQ8L7DtREswhGEKG0DuU0qD0boCs03scgZE71w
 xM+Q9hUJivSurl9KXo1nS7/hYYq0cIz1D89xUgaUma8E08/3/kI3MjHa50xW/FDU6QFO7g6
 1gEUWRhCIOr2gPvKD3Fr033diE/LRIz2OBO0GDFjAJK1yDJqCFbOtA3JlZjRVKBfEz2K8XC
 q9BMHdLImDglgwv6d7CEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QaC1sOaPeNs=:i6sQKOCd68U9V0LhyKKOXj
 +feaLTzpS5VcPVlkoGPyK4OgULmgpwtQKZDsVKvA7o5so6iCWCQi8oFn5xLH/yhg/u9l8kZWj
 lFQPDvHfbEfSzDj+iWxKj/r/RsZ2i7ucyT50KlJsuaZFPBzuSRBO9AE8yb8FXrKTzJymDGe53
 QeBJxnz7xI9SND3jWHy+m/qlDi0uW1pT2VYolX731LO+Jg4eDoDz0kU19cp5QSEZdTkRJyE82
 zGKr7IVHWjpoUeN/MIpTT+hWAbk2ELjCR4WPXDdA9VdnjkS6SQE0V+TOlPP5kepz3gDK0D8Uc
 pq+OsmG/wZ2vyt9LXMAmPIOdlmmLtwlISbmiFMxNdlKY0UFen98ISMZYDvM8Tx3h+2runZ4fH
 YulxtLixVU2o6DjPS9GsmPrG0UERIq4KbUuRgc1HVjdDeJlRNKYRfhxDpOQlycosX8cboyAjo
 ACexQXp+q+RQRwq2XdaedEs4FmqUWczELzJ22WLY+sMnG7agUFP/qKlWPTslHVXXONkDcK2EP
 5ZKY/e4Vz4D3phwFXQoMiTOI7bRTNF/MYNBxFUqKU7ZyO2W9lz8uaLDJA5we/QJ4u1Te2kaiK
 Tc1/Rwn1K1uHQsdEfzgP0JqmpZTN8kv6sYVFg7vL10FHdl6eTxYY3SqUS9lr6SewTM1N7svOa
 cwsMb12/ccub/CBW+Kx899+qtKeue0/vK6+CFE47yp91GNdDnnmSLinhRI+lBpX3bXpg893Eu
 kQSjoi0bw41e75G8rKaqOW6gJAZvecZm/p23N5qai3ILgx5WNTsWjg5mkIGvC/trIBIUyR2f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283255>

On a case insenstive file system x is the same as X.
When a file named "X" exist, e.g. ">x && git add x" does not work as ex=
pected,
use file name "Y" instead.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t3400-rebase.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 5ed4012..2eebd22 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -259,11 +259,11 @@ test_expect_success 'rebase duplicated commit wit=
h
--keep-empty' '
 	git reset --hard &&
 	git checkout master &&
 -	>x && git add x && git commit x -mx &&
-	echo x >x && git commit x -mx1 &&
+	>Y && git add Y && git commit Y -mY &&
+	echo Y >Y && git commit Y -mY1 &&
  	git checkout -b duplicated HEAD~ &&
-	echo x >x && git commit x -mx2 &&
+	echo Y >Y && git commit Y -mY2 &&
 	git rebase --keep-empty master
 '
 -- 2.6.2.403.g6abe3ff.dirty
