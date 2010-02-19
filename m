From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/4] utf8.c: strbuf'ify strbuf_add_wrapped_text()
Date: Fri, 19 Feb 2010 23:13:28 +0100
Message-ID: <4B7F0D08.6040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nib6S-00057Z-RL
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0BSWNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 17:13:34 -0500
Received: from india601.server4you.de ([85.25.151.105]:43429 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab0BSWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 17:13:34 -0500
Received: from [10.0.1.100] (p57B7E04C.dip.t-dialin.net [87.183.224.76])
	by india601.server4you.de (Postfix) with ESMTPSA id ECC7E2F806C;
	Fri, 19 Feb 2010 23:13:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140486>

The strbuf parameter of strbuf_add_wrapped_text() in utf8.c is
optional; if it's missing, results are directly written to stdout.
By removing this flexibility and converting it to only call "pure"
strbuf functions, this series cleans up the code a bit and enables
an optimization, which is added in the last patch:

  [PATCH 1/4] utf8.c: remove print_wrapped_text()
  [PATCH 2/4] utf8.c: remove print_spaces()
  [PATCH 3/4] utf8.c: remove strbuf_write()

  [PATCH 4/4] utf8.c: speculatively assume utf-8 in strbuf_add_wrapped_text()

 builtin-shortlog.c |   17 ++++++++++++--
 utf8.c             |   61 +++++++++++++++++++++++----------------------------
 utf8.h             |    1 -
 3 files changed, 42 insertions(+), 37 deletions(-)
