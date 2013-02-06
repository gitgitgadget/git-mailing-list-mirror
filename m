From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] connect.c: Tell *PLink to always use ssh protocol
Date: Wed, 06 Feb 2013 22:58:49 +0100
Message-ID: <5112D219.3020604@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 22:59:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3D1O-0007Py-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 22:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab3BFV6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 16:58:52 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:11297 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755489Ab3BFV6v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 16:58:51 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 840ED42E370;
	Wed,  6 Feb 2013 22:58:48 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 554194220F2;
	Wed,  6 Feb 2013 22:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=LPSEoZUokIChN35a5ACttpTd
	Kbk=; b=1eN9kkmyl0R/yvSnPsdeqk/rFBixM+iTgii5aQ3KHxhmVn2vyT8iAU8W
	F0jZGy3QKRYMXvCedQSm4IYvQGYYoJZwM5zD7o+cynPqVz2EOwkgxXbiyFuFk+bB
	rfuoN6ylGmM//FulOPlJKeGyQzX+nC8skcsFsjV93D4VlILXsO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=gCp5ujtTHD7lMWEAbu
	w1Q237riWlfX7Ip5yzRoKB7ieoOmV/PjZeRK3cGXVX8LNdu0gYCwTVQVK7YeUaDk
	WrR7K1gSony56nGwm+6zpiYG3bSnyLRaaVElPD6IPegXTq69yuMsQ3EMTuOf9tuS
	nFEf8s9Z+cDqLJPHVUUBQomww=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id EAF96422050;
	Wed,  6 Feb 2013 22:58:47 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43915466; Wed, 06 Feb 2013 22:58:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_800_899 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215647>

Default values for *plink can be set using PuTTY. If a user makes
telnet the default in PuTTY this breaks ssh clones in git.

Since git clones of the type user@host:path use ssh, tell *plink
to use ssh and override PuTTY defaults for the protocol to use.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 connect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/connect.c b/connect.c
index 49e56ba..d337b6f 100644
--- a/connect.c
+++ b/connect.c
@@ -625,6 +625,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		if (!ssh) ssh = "ssh";
 
 		*arg++ = ssh;
+		if (putty)
+			*arg++ = "-ssh";
 		if (putty && !strcasestr(ssh, "tortoiseplink"))
 			*arg++ = "-batch";
 		if (port) {
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
