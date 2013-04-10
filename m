From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/7] completion: reorg and performance improvements
Date: Wed, 10 Apr 2013 01:57:50 -0500
Message-ID: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPozp-000797-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab3DJG7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 02:59:00 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:33543 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3DJG67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:58:59 -0400
Received: by mail-qe0-f45.google.com with SMTP id 1so69428qee.18
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=XtoIZl/FzwX4qIZco5K5XvRedL7q9ZKdtParBAjWrAc=;
        b=Rccq02KSmXrL4SX7ROu+6RkZSEEzu8L6pFVnfH40PAKt2aB8SHpqoFVdex/S8N7ECi
         DVGKs2SATrnD5AhIJiyuh7MkGZRBRxxMd9yAeqx6RwybUpZMZ4jZ8dDwdccOYM0vs6y0
         TjhmRkdnAlDqxvJv4CL9/VP6rnairFd1Hrcj7XMyTsRsjAbE6RCv9jEYgqBKUiHcgQEF
         2+ECeKSTf1WtD51sEKsiQB8AjmItRftrr4rdHf5LieoyAF9j4HHrGVZEtJDdMR9ukoph
         VNxh3DkuwMgntzk3B9vFfNJ99GA1b8CLNNXffQPJBV2/NgzY2V6IdCGLY46QGehzSRkX
         sysw==
X-Received: by 10.224.184.70 with SMTP id cj6mr1125436qab.54.1365577139343;
        Tue, 09 Apr 2013 23:58:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id o6sm29480476qek.3.2013.04.09.23.58.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:58:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220663>

Hi,

I sent these some time ago for comments, but I think they are ready. Basically
some reorganization in order to achieve some performance improvements, also,
fix a few bugs.

Felipe Contreras (7):
  completion: trivial test improvement
  completion: get rid of empty COMPREPLY assignments
  completion: add new __gitcompadd helper
  completion: add __gitcomp_nl tests
  completion: get rid of compgen
  completion: get rid of __gitcomp_1
  completion: small optimization

 contrib/completion/git-completion.bash | 71 +++++++++++++---------------------
 t/t9902-completion.sh                  | 65 ++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 46 deletions(-)

-- 
1.8.2.1
