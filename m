From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Please document git-http-backend/Apache timeout interactions
Date: Sun, 21 Feb 2016 23:17:44 +0100
Message-ID: <20160221221744.GA38068@sesse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 23:18:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXcKA-0005ET-KO
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbcBUWRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 17:17:51 -0500
Received: from cassarossa.samfundet.no ([193.35.52.29]:53401 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbcBUWRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 17:17:50 -0500
Received: from pannekake.samfundet.no ([2001:67c:29f4::50] ident=unknown)
	by cassarossa.samfundet.no with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <sesse@samfundet.no>)
	id 1aXcK1-000205-1M
	for git@vger.kernel.org; Sun, 21 Feb 2016 23:17:45 +0100
Received: from sesse by pannekake.samfundet.no with local (Exim 4.84)
	(envelope-from <sesse@samfundet.no>)
	id 1aXcK0-000AMR-VH
	for git@vger.kernel.org; Sun, 21 Feb 2016 23:17:44 +0100
Content-Disposition: inline
X-Operating-System: Linux 4.4.0 on a x86_64
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286832>

Hi,

I am running git-http-backend behind Apache as suggested in
git-http-backend(1). However, what it fails to mention is that
git-fetch-pack seemingly can be very slow in sending its request.
Consequently, mod_reqtimeout (on by default, as I understand it)
kicks in as an anti-DoS measure, and the user sees a 408 (timeout)
error.

Seemingly the simplest fix is to turn off mod_reqtimeout in the vhost
serving git (potentially with some <IfModule> around it):

   RequestReadTimeout header=0 body=0

Would you consider adding this to the documentation?

Thanks!

/* Steinar */
-- 
Homepage: https://www.sesse.net/
