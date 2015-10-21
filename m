From: Daniel Steinborn <daniel.steinborn@lrz.de>
Subject: Poor git write performance to NFS
Date: Wed, 21 Oct 2015 15:14:59 +0200
Message-ID: <56278FD3.3010103@lrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 15:20:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZotJe-0001vm-9i
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 15:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbbJUNUR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 09:20:17 -0400
Received: from postout1.mail.lrz.de ([129.187.255.137]:57232 "EHLO
	postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbbJUNUO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 09:20:14 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2015 09:20:14 EDT
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 3ngskF3l0bzycZ
	for <git@vger.kernel.org>; Wed, 21 Oct 2015 15:15:01 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=lrz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lrz.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:user-agent:date:date:message-id:subject:subject:from:from
	:received:received; s=postout; t=1445433301; bh=qrZWhjrcmMIQGgkx
	8aySIjAYzY59BAwLv36Xgm06/Xs=; b=lobIoXphsygAaiw4oqTxZom9a8f6yL38
	TViP2/T9FGF/nPCeaLK/sXRcUdNuZwSh1/Moc86QdSN9gT/aaVY2Q9fsngYxcjno
	DSgGLB8O1+8JMBNjJbW3nHR8YRgUeqRTCDGEttL60wsX/nzTOMXXz7d4lJ4i4JA/
	C0jnThFWyjtXYgSwPt6tUN5kgKL9cNR4vyyA3HDZNEOe4berLqrtcDVBvpxxqihG
	WM6jJPD0uV/mW2tVMGLSMkwO/HsxhKIQqcNJ7Id9HmvK/XntoNW3nNtz0l70v+dm
	N9pbydxl9dzkiTeYbC8TYcpojtr5V0k5Ki9k9FgXST5wh0lA76bGEw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.891
X-Spam-Level: 
X-Spam-Status: No, score=-2.891 tagged_above=-999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, LRZ_FROM_PHRASE=0.001,
	LRZ_FROM_PRE_SUR=0.001, LRZ_FROM_PRE_SUR_PHRASE=0.001,
	LRZ_MSGID_AN_AN=0.001, LRZ_MSGID_HU8_HU7=0.001, LRZ_MSGID_MOZ=0.001,
	LRZ_MSGID_SPAM_68=0.001, LRZ_TO_SHORT=0.001, LRZ_UA_MOZ=0.001]
	autolearn=no
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id UnXgzDdHwwrg for <git@vger.kernel.org>;
	Wed, 21 Oct 2015 15:15:01 +0200 (CEST)
Received: from badwlrz-cldst01.ws.lrz.de (unknown [IPv6:2001:4ca0:0:f000:fab1:56ff:febb:c1bd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 3ngskF1LDVzyV2
	for <git@vger.kernel.org>; Wed, 21 Oct 2015 15:15:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279981>

Hi,

currently we are experiencing poor write performance when a repository=20
is pushed to a nfs volume. Interestingly, this seems to be a problem in=
=20
newer git versions:

v1.7.12.4: Very good performance

v2.1.4: Bad performance, up to 6 times slower

Are there any changed default settings or new features that can be the=20
reason for that problem?

The tests are done on a Debian 8.2 VM.

Please ask for specific details if they are neccessary.

Thanks for your help! Best regards, Daniel Steinborn

--=20
Daniel Steinborn
Leibniz-Rechenzentrum
Boltzmannstra=C3=9Fe 1
85748 Garching bei M=C3=BCnchen
