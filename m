From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] teach git-checkout -B WAS builtin/checkout: DWIM with -f -b
Date: Tue, 22 Jun 2010 01:19:39 +0800
Message-ID: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 21 19:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkfV-0007Uv-63
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999Ab0FURUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:20:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63896 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757643Ab0FURUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:20:13 -0400
Received: by pxi12 with SMTP id 12so1459027pxi.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rDVPlsm3d/igDMRMrSn1uZJ0usAFYJTwGnj8GXuW/o8=;
        b=woMHcDkXQh08RzL3VwzZbR+9kVTEc9iJR91eMQIJ1xO2mvBFLJ+8eSgs2SlK7ltQ/l
         nKVvTPJ8oHm+MybYinE8u9XUK7oT42KgNAfr5P2m/lPb9ugU/NSE0h+8GgI8dPecWtWR
         1urguOq3AZDSvDzmlwOibclj+H1GOnXiT+oG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sR2KA+ZBHQPWHjG8Xfm+CLFpTsJvpsNcDXq/zNyb2eiOTRkrV9yZyZDPBnSlH8YjTL
         8sAMLQIbk/VUXT617sMpdmJRQl9TlGa+GsUPS2wFor5oQxar4jTwapfM6btgn7TUppyN
         DZn1xNN7MmthgaOIRRY9U7MBuJV0a/FYxG0ZQ=
Received: by 10.115.102.20 with SMTP id e20mr4185454wam.194.1277140809745;
        Mon, 21 Jun 2010 10:20:09 -0700 (PDT)
Received: from localhost.localdomain (cm134.zeta152.maxonline.com.sg [116.87.152.134])
        by mx.google.com with ESMTPS id b6sm32760016wam.21.2010.06.21.10.19.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 10:20:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149420>

Right now, the -f/--force in git-checkout doesn't carry over to -b
operations - ie. you can't do git checkout -b branch on an existing
branch.

This patch allows you to do this with the -B option, so that one can do

  git checkout -B branch ref

which is equivalent to

  git branch -f branch ref && git checkout branch

Contents:
[PATCH 1/3] add tests for checkout -b
[PATCH 2/3] builtin/checkout: change -b from an OPTION_STRING to a OPTION_SET_INT
[PATCH 3/3] builtin/checkout: learn -B

Tay Ray Chuan (3):
  add tests for checkout -b
  builtin/checkout: change -b from an OPTION_STRING to a OPTION_SET_INT
  builtin/checkout: learn -B

 Documentation/git-checkout.txt |   15 +++-
 builtin/checkout.c             |   46 +++++++----
 t/t2018-checkout-branch.sh     |  166 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 18 deletions(-)
 create mode 100755 t/t2018-checkout-branch.sh
