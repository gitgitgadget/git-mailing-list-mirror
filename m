From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [BUG] git archive formats and dashdash
Date: Thu, 10 Dec 2009 23:26:36 +0200
Message-ID: <20091210212636.GA27722@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 22:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIqX7-0003ri-QC
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 22:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761025AbZLJV0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 16:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760972AbZLJV0d
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 16:26:33 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:53469 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516AbZLJV0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 16:26:33 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id C0465EB7BF
	for <git@vger.kernel.org>; Thu, 10 Dec 2009 23:26:38 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A06D70BAACB; Thu, 10 Dec 2009 23:26:38 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id AF3C22BD46
	for <git@vger.kernel.org>; Thu, 10 Dec 2009 23:26:37 +0200 (EET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135041>

--format option of git archive stops working if -- is used:

Shell session:
----------------
$ git archive -o test3.zip --format=zip master -- exec_cmd.c
$ file test3.zip
test3.zip: POSIX tar archive

# Eh...

$ git archive -o test4.zip --format=zip master exec_cmd.c
$ file test4.zip
test4.zip: Zip archive data, at least v1.0 to extract

# That worked.

----------------

The bug seems to be in that archive appends the --format
option to its arguments, not taking into account that there
may be -- before that point, disabling option interpretation.

Git version 1.6.6-rc2

-Ilari
