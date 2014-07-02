From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 0/4] hashmap improvements
Date: Thu, 03 Jul 2014 00:18:40 +0200
Message-ID: <53B48540.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:18:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Src-0007yx-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbaGBWSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:18:44 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53737 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbaGBWSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:18:41 -0400
Received: by mail-wi0-f174.google.com with SMTP id bs8so10428180wib.13
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=dvCelU3U7c/fZ/+n/3hP3E+6qpBa1rH+vMG9Bbigb2o=;
        b=MkNQG4zys/19J/zmgJqgnywCesLwyUeaJFrZUzVOYNXjKrSHa23PMNz0mhgVqloa/D
         a1HmSn417nCmxZq9+gjc2+6rS7HXgqoZ6sB8vl2YlmmpLN4/Ug0HUHVoqsSlQPDSeb8i
         bOEc059gGnoP7e6U49fWmXp4rjI4HRpTZNNfM3y6HBD08XnNbscI7vyhVJNQtLEjCP73
         NBlAz+hl+BfapMye4L11hhul5DtYU26KUNHvvjGRAtPxGQmB4ds4w0mVR6Zo1iGLr/t1
         9gU5TQFEH6Lz5zizqUEedefR1wi3Id0gQLxoTUQgFe7iKQKo3pVDuklonqqEb7dbraTu
         GMvA==
X-Received: by 10.180.97.195 with SMTP id ec3mr6936049wib.13.1404339520008;
        Wed, 02 Jul 2014 15:18:40 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hi2sm57771291wjb.29.2014.07.02.15.18.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 15:18:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252844>

Here are a few small hashmap improvements, partly resulting from recent
discussion of the config-cache topic.

Karsten Blees (4):
  hashmap: factor out getting an int hash code from a SHA1
  hashmap: improve struct hashmap member documentation
  hashmap: add simplified hashmap_get_from_hash() API
  hashmap: add string interning API

 Documentation/technical/api-hashmap.txt | 54 ++++++++++++++++++++++++++++++---
 builtin/describe.c                      | 13 ++------
 decorate.c                              |  5 +--
 diffcore-rename.c                       | 11 +++----
 hashmap.c                               | 38 +++++++++++++++++++++++
 hashmap.h                               | 27 +++++++++++++++++
 khash.h                                 | 11 ++-----
 name-hash.c                             |  5 ++-
 object.c                                | 13 +-------
 pack-objects.c                          |  5 ++-
 t/t0011-hashmap.sh                      | 13 ++++++++
 test-hashmap.c                          | 25 ++++++++++-----
 12 files changed, 159 insertions(+), 61 deletions(-)

-- 
1.9.4.msysgit.0.dirty
