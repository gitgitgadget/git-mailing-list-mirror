From: "Anton Wuerfel" <anton.wuerfel@fau.de>
Subject: libcurl dependency for implementing RFC3161 timestamps
Date: Wed, 9 Mar 2016 12:24:22 +0100
Message-ID: <59de05c280143e7dd3ead6139df7a525.squirrel@faumail.uni-erlangen.de>
References: <e57d18f6010c0b581b38a3daef145221.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: anton.wuerfel@fau.de, i4passt@cs.fau.de, phillip.raffeck@fau.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 12:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adcEK-0003h2-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 12:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcCILYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 06:24:32 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:57797 "EHLO
	mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932208AbcCILY2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 06:24:28 -0500
Received: from boeck2.rrze.uni-erlangen.de (boeck2.rrze.uni-erlangen.de [131.188.11.32])
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 3qKrf01NJ8zPn5y
	for <git@vger.kernel.org>; Wed,  9 Mar 2016 12:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fau.de; s=fau-2013;
	t=1457522664; bh=oaF/cx4S3g0r+cAJ+9g7VHEc3TiXPB81OlD3P7IPNOg=;
	h=In-Reply-To:References:Date:Subject:From:To:Cc:From:To:CC:
	 Subject;
	b=h8GPYDgfa7FFpzf4eLkzHr6ifLmr524dh/ED/wuX6+litcQsDVhKyP+eEB7yxMkAt
	 megz8f8unYDKXsVw2bKNyGZi4Se3zy5OLU0IUnzLDsA6/+rcbf2MazhOnY3xOYkVsX
	 lGIsw+qIIo3CEdTsO6A3/vfzpjMrY86HCVbRZFsuqnaebojttVGILXvfVo8LQd7fMN
	 kwxpDaKplQTEE9QinqTX2/KPcHW8dPygaU7JrVjJCOpwyBMSp8uPO8oppGxoYEcb2v
	 3fIsO/lx+ZOaTvGtymVKWcQw1hKCQNxvXfarn7nPkEWRLl3k5gBs2lf/Pop13VAtSq
	 oVrMlM71dr3xg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
Received: from mx-rz-2.rrze.uni-erlangen.de ([IPv6:::ffff:131.188.11.21])
	by boeck2.rrze.uni-erlangen.de (boeck2.rrze.uni-erlangen.de [::ffff:131.188.11.32]) (amavisd-new, port 10026)
	with LMTP id ug_R5ZkI_IYH; Wed,  9 Mar 2016 12:24:22 +0100 (CET)
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 3qKrdy3kp2zPn57;
	Wed,  9 Mar 2016 12:24:22 +0100 (CET)
X-RRZE-Submit-IP: 131.188.11.38
Received: from faumail.uni-erlangen.de (smtp.uni-erlangen.de [131.188.11.38])
	by smtp.uni-erlangen.de (Postfix) with ESMTP id 3qKrdy36tGzPn4l;
	Wed,  9 Mar 2016 12:24:22 +0100 (CET)
Received: from 131.188.42.190
        by faumail.uni-erlangen.de with HTTP;
        Wed, 9 Mar 2016 12:24:22 +0100
In-Reply-To: <e57d18f6010c0b581b38a3daef145221.squirrel@faumail.uni-erlangen.de>
User-Agent: SquirrelMail/1.4.23 [SVN]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288481>

Hello,

for implementing RFC3161 timestamps in git tag, HTTP POST requests have to
be sent via libcurl. We already changed http.c to our needs.

Is there any best-practice how to introduce this libcurl dependency? There
are several options:

-As git tag is a builtin part of the main git executable, introduce a
libcurl dependency for the main executable (maybe not best-practice).

-Move git tag to a separate git-tag binary and introduce a libcurl
dependency to this new submodule.

-Create an own submodule like git-http-timestamp with a libcurl dependency
and call it from git tag and from other places where timestamp signatures
are needed.

Regards,
Phillip Raffeck
Anton Wuerfel
