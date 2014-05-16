From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH 0/2] Pretty print truncate does not work
Date: Fri, 16 May 2014 17:06:29 +0400
Message-ID: <cover.1400242108.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlHrF-0001Kv-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 15:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbaEPNH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 09:07:26 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:60577 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaEPNHY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 09:07:24 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so1912240lbi.15
        for <git@vger.kernel.org>; Fri, 16 May 2014 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=W1dp45jfWe2SRnLsn9avZUDimRhlCKzxO6t42st5AvU=;
        b=pgBJ6VyLOLMJtmaOvU4GzGfe0F6jW1YIyLpj+kM9IKa/gCbwJ8rsLYQBI4Ec2pNsMT
         qcfcchItxM6IyBGOVS7x1FPyhVYMff/NtdqBPZX9Hm/AEBMogOkO91qfFcHSjnFnNfNZ
         ZCXBYHoJ0xSMVnM2l9ycD0zR6HH9Zph6I+rBxzEGPOke8FeQeIGFr0f464vKXGh0eFfO
         AhCzEL9XUx/EjAnkIJdvcZtDt7ccVPOuEdTbbx7eosli5UTQs4lDtBfZlN6R9HqmM8/y
         4k/TaBvoHEA2mJ3jnnMJUqI8upuoNIiaDYqxuwr7m8sTV0JMdK437rIY2lVm2ifkP9Vx
         ASYA==
X-Received: by 10.112.189.103 with SMTP id gh7mr11408756lbc.35.1400245642828;
        Fri, 16 May 2014 06:07:22 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id mk2sm8485680lbc.8.2014.05.16.06.07.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:07:22 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249300>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

Following patches are:
1. failing tests
2. Fix patch

Alexey Shumkin (2):
  t4205 (log-pretty-formats): Add failing tests for the case when
    i18n.logOutputEncoding is set
  pretty.c: format string with truncate respects logOutputEncoding

 pretty.c                      |   7 +-
 t/t4205-log-pretty-formats.sh | 169 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 2 deletions(-)

-- 
1.9.2-15
