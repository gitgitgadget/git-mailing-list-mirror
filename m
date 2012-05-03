From: th.acker66@arcor.de
Subject: Large repo and pack.packsizelimit
Date: Thu, 3 May 2012 13:57:58 +0200 (CEST)
Message-ID: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 13:58:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPufe-0008Qb-BB
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 13:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab2ECL6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 07:58:00 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:56916 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab2ECL57 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 07:57:59 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 990085A567
	for <git@vger.kernel.org>; Thu,  3 May 2012 13:57:58 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 9449633A3C0
	for <git@vger.kernel.org>; Thu,  3 May 2012 13:57:58 +0200 (CEST)
Received: from webmail07.arcor-online.net (webmail07.arcor-online.net [151.189.8.8])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 90257197B3C
	for <git@vger.kernel.org>; Thu,  3 May 2012 13:57:58 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 90257197B3C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1336046278; bh=ronuQsFadUN/NP0wYQ+6bVqgZCRMIDYcdU8HqlDB8DY=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=QN+MO09/QUUUGxIabV2PvAGEb9BPiswb2AKWLchxOh2X0DhfWVIPkxiKjnn4jZ5vr
	 zHJDoFbE9Gd8ZWglhhMhIAba6z8uhWAUw7zp54mULvLdR7nFNh6d0v3yND3o5jA+PW
	 uMp7yg9w3diZT7vLp3rM6xTfHe3qjexYk1qFSCaE=
Received: from [194.138.39.56] by webmail07.arcor-online.net (151.189.8.8) with HTTP (Arcor Webmail); Thu, 3 May 2012 13:57:58 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196900>

Hello,

I am using MSysgit 1.7.9 on WinXP 32bit and have a very large repo (10GB in .git; 20GB in source tree).
I had to set pack.packsizelimit=1024MB to prevent "out of memory" during repacking in git-gc 
and everything seemed to work fine.

When I tried to clone this repo an "out of memory" occured because the packs to be transferred
by the git protocol are not limited by pack.packsizelimit. I "fixed" this by setting transfer.unpackLimit=100000
and thus transferring only loose objects. This is very slow but it works.

In this cloned repo now git-gc again causes "out of memory" because it tries to pack all loose
objects in one go thereby seemingly not respecting pack.packsizelimit ... 
(Setting --window-memory=512m in git-repack did not help here.)

Am I doing anything wrong here or is this a bug/feature in git?

BTW1 Repo is very large but contains only one really large file with 1.2GB; all other files are smaller than 256MB.
BTW2 I cannot use 1.7.10 due to the http authorization bug.


---
Thomas
