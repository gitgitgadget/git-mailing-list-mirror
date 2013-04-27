From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 05:19:43 -0500
Message-ID: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2Fx-0002wJ-Ru
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab3D0KVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:13 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48189 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab3D0KVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:12 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so4742816oag.16
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=pZl6De5NzuE+h13e0dr4Dqsbwbpxhh580K28Ucnr7E0=;
        b=nQTEaJ+6o6xlpSFf/SPptyWDTeyM9aTOrZ41iinj2d4DpDcUZ6Q7bFUBdewoJ9IJlh
         LG546RFsYLaAavWbZ58cbehoEUcJ8CQ9vRZlyr2hmjJQz+OOz+9l6VL8snE13KzXMbs7
         0TDwZOYVjGwPo3NrUj95inAxCw4HV1EOkPJCY4EJEL/0qMZ7QrEKApyOG1NqxY3aZIQC
         3mxFAARn+DH+BWX0DOJUBamh0eOKpdrXBss8AR/uTD3DmxLcnT2aLx2t7H6gosaXlBNe
         4zjhQZ79ykIav9yhMJb//gcBFq6cXEc101oHHInqCrvH2R5ps779s14ScCk+xMlOwquw
         5fVw==
X-Received: by 10.182.127.7 with SMTP id nc7mr24542575obb.94.1367058072155;
        Sat, 27 Apr 2013 03:21:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id cn9sm3546170obb.3.2013.04.27.03.21.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222625>

Hi,

Basically while trying to understand the code for path completion, I found that
a lot of code was duplicated, and for not much gain.

I also noticed that doing 'git add file' doesn't add the trailing space as
before. It's not clear if it should be possible to do that with -o filenames,
but after all, what do -o filenames gives us? Nothing we can't do ourselves,
apparently.

However, in zsh the -f option does give us lots of niceties, so there's a patch
to allow that in a zsh way.

Also, add the missing tests.

Cheers.

Felipe Contreras (11):
  completion: add file completion tests
  completion: document tilde expansion failure in tests
  completion; remove unuseful comments
  completion: use __gitcompadd for __gitcomp_file
  completion: refactor diff_index wrappers
  completion: refactor __git_complete_index_file()
  completion: avoid compopt -o filenames
  completion: get rid of __gitcomp_file()
  completion: add space after completed filename
  completion: remove __git_index_file_list_filter()
  completion: zsh: add proper file support

 contrib/completion/git-completion.bash | 168 +++++----------------------------
 contrib/completion/git-completion.zsh  |  41 +++++++-
 t/t9902-completion.sh                  |  77 +++++++++++++++
 3 files changed, 140 insertions(+), 146 deletions(-)

-- 
1.8.2.1.1031.g2ee5873
