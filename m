From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/9] completion: general cleanups
Date: Sat, 27 Apr 2013 15:09:58 -0500
Message-ID: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBT0-0008SN-66
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab3D0UL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:26 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:56671 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab3D0ULZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:25 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so5051982oah.14
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=fDx1Vq4dFlu8E6aUQh5Py1I+QFtGo4R0EZgkCJeGh2Q=;
        b=PfM1XOwoNWxrWUGUZLjhj7KcHT3NIRbSaNu/D6CH/ZSZtbxUrOQRiZFAEfaDCGdDq+
         nzBwjawxvhA9p1XX15v4bfIa8eCc2r1ovV5kmGV2yvS9H6bQE6UlR9ebAu9hdMAaYm8/
         Iga+l3/IvQBRvfFPsh+0xoaM1zGxDcpsZrsrWH8clvFmc/2Jt/Ig3wfz60AngcdM5X8R
         P6s+h4LWVVSwhKVjpzZJGvZKjvdQI2AABIob877hHc57u9wOClkhNzYJSYu18BX5g0U8
         6nZGhrM6fkwVEPGFX58s32b8vAoWUQHTd/Af0imSmMgoWGJjAPejuT5ylpkm/JftGRvP
         N/aQ==
X-Received: by 10.182.99.199 with SMTP id es7mr5787287obb.5.1367093485102;
        Sat, 27 Apr 2013 13:11:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ru4sm13341193obb.4.2013.04.27.13.11.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222682>

Hi,

In the previous series I didn't notice -o filenames actually did something
useful, so in this series it's still used, however, for versions older than 4,
we use a hack to enable it. This allows us to get rid of a lot of compat code.

I also got rid of some wrappers, and fixed a regression: spaces were not added
at the end of the completion.

The result is that now we have the same completion for bash < 4, bash >=4, and
zsh. Although we already had that for the last two, now the code is simpler.

The only difference is that bash < 4 doesn't add a trailing space, like before
fea16b4 (git-completion.bash: add support for path completion).

Also, add the missing tests.

Cheers.

Felipe Contreras (9):
  completion: add file completion tests
  completion: document tilde expansion failure in tests
  completion; remove unuseful comments
  completion: use __gitcompadd for __gitcomp_file
  completion: refactor diff_index wrappers
  completion: refactor __git_complete_index_file()
  completion: add hack to enable file mode in bash < 4
  completion: add space after completed filename
  completion: remove __git_index_file_list_filter()

 contrib/completion/git-completion.bash | 145 +++++++--------------------------
 t/t9902-completion.sh                  |  77 +++++++++++++++++
 2 files changed, 107 insertions(+), 115 deletions(-)

-- 
1.8.2.1.1031.g2ee5873
