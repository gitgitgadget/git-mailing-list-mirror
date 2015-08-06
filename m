From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Remove get_pathspec finally
Date: Thu,  6 Aug 2015 11:27:10 -0700
Message-ID: <1438885632-26470-1-git-send-email-sbeller@google.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 20:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNPtE-0001ti-Oq
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbbHFS1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:27:18 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34063 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbbHFS1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:27:18 -0400
Received: by pawu10 with SMTP id u10so68643957paw.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rRiR6xIf5fc8srpF+csYi3HLq6ZbEoQ5GjY76Fa7FAg=;
        b=WWo3aX1UZOyOPlInGrIF4oeAesrnxA+WzqUkd+hwIWMtZsTY27XNzIwt5TKGHGDemh
         /SKl0ARldzp2mHbBFBTjLg3N6b8Aw6Qd5KHz0xg7Vrmn+LDboDWcNtUTet2i7IX8n9Wk
         DcfXfDg/rDh+KMxl2xNmDPzp9feG9fWj0nBKazOYjqmlZkaNtIXiyhFbb0Ng5tNwwEDd
         xPbot+zO1YUMZG1S/O8XkdCKzB1KulNmZm2KjpTHCLX9vR83AtDZ7BcdlDU2QEQ4mGOJ
         PJI8e1JRBVE/VFZcA1A4VchgA0jYUC6x9wB3Eeuy0Uw+o6C7hURM+qg3b6yhjj9mHrKW
         6Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rRiR6xIf5fc8srpF+csYi3HLq6ZbEoQ5GjY76Fa7FAg=;
        b=YJbYs6jDqdd2qfrHaR9xew0mYGxosqyhipsDP0Me85UrabZhW5azwpZJON6rhM+LCs
         BU8N1JoGljE8Sstc61EgP/5rGvE4OoT9zJRNKA7uqE6ccxwhy3M/BYOcaEPqIlzEW/Wk
         IzEO14KfkfZOEQdvbpIMK3Jq+7deVVGBCV7XSvDJyjXKyc62tWcKTVXFdkrsp2TTWIdr
         kvGfHmF8nunKHQ/NUd1++ohh3BKkc1vdbOuJrg62cyCMOn4WKylwWuu9tmn9Sh6p58wG
         1c3YaLSYLtsS09IktOn0WDhGLsOALirUqV52wxQd6l+0kSzxlL9foHnKVA5JbAjVnUBG
         pLKA==
X-Gm-Message-State: ALoCoQlkPvaCM211xTSoF8K8BJphgL72Ai61EO7jFEu28NuwVEosUHe2FaAaFjjYmAoqpF2UiByQ
X-Received: by 10.68.117.142 with SMTP id ke14mr6030627pbb.93.1438885636556;
        Thu, 06 Aug 2015 11:27:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id o7sm7352112pdi.16.2015.08.06.11.27.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 11:27:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275434>

Remove the last caller of the get_pathspec function and the get_pathspec function
itself.

I stumbled into this as I was reading the documentation on pathspec, and the
first sentence

  get_pathspec() is obsolete and should never be used in new code.

made me wonder.

This replaces sb/remove-get-pathspec

Stefan Beller (2):
  builtin/mv: remove get_pathspec()
  pathspec: remove deprecated get_pathspec

 Documentation/technical/api-setup.txt |  2 --
 builtin/mv.c                          | 16 +++++++++++++---
 cache.h                               |  1 -
 pathspec.c                            | 36 -----------------------------------
 pathspec.h                            |  2 +-
 5 files changed, 14 insertions(+), 43 deletions(-)

-- 
2.5.0.239.g9728e1d.dirty
