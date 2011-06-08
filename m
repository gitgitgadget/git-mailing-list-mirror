From: Romain Geissler <romain.geissler@gmail.com>
Subject: Reference name and check-ref-format
Date: Wed, 8 Jun 2011 14:50:00 +0200
Message-ID: <67B97116-1D1A-417B-87F2-6E24260E3BFF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 14:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUIDD-0002uj-8r
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 14:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab1FHMuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 08:50:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65157 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab1FHMuB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 08:50:01 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so326931wya.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:cc:to:mime-version:x-mailer;
        bh=cZqDP+Hg5MhGCE2tRFpFFmgzmPfG0cHHYCPAMFQ8uW8=;
        b=lmc+fQvB0qBgATyHc23Gxco1v3v2uGuEkmWfnrxKybtwxoaegUXbVHH96qBbfQtmn2
         UI0zXMGRzBqXH5J7wXADQ2X+EgCG7xoUe4zaAI/BBpOXMGGUtZfCXBwILZ7EvjchhqA6
         uCiOsOa/y+XinUvKUuMnsMV0RJCmDh8npdDfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=cUqDm2hCph12TtFKZrYQwNwy5t5g5NdKVMCdaebrDacKJVRP5UrC+Eyc1stRXjca7b
         KegYc45gc9SH6qDkVZ7ngAr3BDJXOZ5DvFaPwu/QOjLBY+lpltqmoFdJZtcz8Aujs6Bb
         DjpBsZNPdSuL++W59Ws7I/mqmhbpmYoFYnSIg=
Received: by 10.227.176.136 with SMTP id be8mr195194wbb.18.1307537401155;
        Wed, 08 Jun 2011 05:50:01 -0700 (PDT)
Received: from ensi-vpn-23.imag.fr (ensi-vpn-23.imag.fr [129.88.57.23])
        by mx.google.com with ESMTPS id ej7sm392514wbb.36.2011.06.08.05.50.00
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 05:50:00 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175364>

Hello,

While writing a git client based on libgit2 (https://github.com/Romain-Geissler/git2), i have to rewrite git-check-ref-format. The man documentation about that command is clear enough, and there is no issue to implement it. Seven from the eight naming rules described in this man make sens to me, but i can't understand why is there a need for the second one:

 2. They must contain at least one /. This enforces the presence of a category like heads/, tags/ etc. but the actual names are not restricted.

The implementation respects that rule, and thus git check-ref-format HEAD will return 1. But why does a reference name must have a slash ? HEAD, FETCH_HEAD and others are references, but do not contain any slash. And this do not prevent us to use such refs anywhere in git. That even works with "non-magic" git reference, if we create by ourself a reference file in the root of our $GIT_DIR, and can be use as a reference name in any git command except with git-check-ref-format.

I am utterly wrong or is there difference between what's specified in git-check-ref-format and what git really does ?

Romain Geissler