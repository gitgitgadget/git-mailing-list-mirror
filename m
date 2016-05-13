From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/5] pathspec labels [WAS: submodule groups]
Date: Fri, 13 May 2016 16:13:21 -0700
Message-ID: <20160513231326.8994-1-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 14 01:13:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MH4-00085Y-FE
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbcEMXNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:13:33 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36481 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbcEMXNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:13:33 -0400
Received: by mail-pa0-f53.google.com with SMTP id bt5so44633851pac.3
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TrHNkS9qVQiveiNhutmcUmRzJs/5WDxV8/EO1WohNao=;
        b=fa8wIwbFt4fsXToQxIp87IeaEGX1/Pq+cRwpQVu5mGnQlytouJIQBZ3iP+nks02swq
         /VfYjO3UlgK8Oft6qMzWaJascHzRZuoLQJ7yRDsT/iIQ1d9XLRsH26DNJT8s9lLYl4Al
         VM7qHJhy7/tD/7w/hEreY3KBrptu6FCc+iGwqNAzg17VygGvLvBARr5YQUTeIFb9JoWN
         2TfANFrn6192aPPZUGwVibX4PQnLltbJIHLRzIOQwGPJiNBDP/4Ji/l/2MX7UNa0A+du
         +B9ZFRGDrrmcEdoaXuqVxYOjTCLcE2JBjw7/cpHC6o7cabfC/5WXw975jo1DqNGQI40c
         BvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TrHNkS9qVQiveiNhutmcUmRzJs/5WDxV8/EO1WohNao=;
        b=CuBpMnIola6eUAFpHOH9TEvai7pMCFhsgd4YmmJANiheqfGA4UeHbjpddy+tN6IDFf
         BGIJgeIbZJnf3DXCeO94NT7dyuYIIrJ2IbHnarNOJXk2RJZRiLSECSabbI55ieJRjgcI
         W0ZXtiF8H776Dp7XpPD6zclQ2AxmulfWWmJ4rNzAO34iVMhlISG0D02NOpmh6akEHLij
         PY7uG6m2eNHiFaXTjzmfZ4Y0XdIhqBaElWWDTnZWnZscHGgkp6DcEiPBOCB+LiGiojm3
         zLuEc1bFXl6jAljocqXInnZfbQ0E/lHNcr9fZqML6nZ8QOHoKnimL24Ja6L/OB8rISkr
         FkVg==
X-Gm-Message-State: AOPr4FVafbsX1xqouKo81/P6Q/GhH/4QN2+WASSkirzDz5cmAjO+JS8koOMKygRynrDJ7zQs
X-Received: by 10.66.217.137 with SMTP id oy9mr27010761pac.103.1463181212024;
        Fri, 13 May 2016 16:13:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e84e:cb12:277e:4f09])
        by smtp.gmail.com with ESMTPSA id 126sm28888731pfg.93.2016.05.13.16.13.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 16:13:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g6647087.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294594>

I am happy with the results of the label experiments. (Mainly writing the tests)

>> Isn't the former be "label="

> I do not know what you mean by the latter.  I would understand
>"pretend this has all the labels under the sun", though.

See the new tests what I mean. It cleared up for me as well when writing them.

> I am wondering where we should sanity check (and die, pointing out
> an error in .gitattributes file).  Is this function a good place to
> reject TRUE and FALSE?

TRUE and FALSE are solved issues in this series. However we still want
funny characters not be used. What if we want to use them as 
special characters in the future? (e.g. 'label*' for 'labelA' or 'labelB'
or label{A,B} for the same)

I think it is too late in the matching, so ideally we would check label
names when they are assigned (i.e. while editing the .gitattributes file)
That is not in our control, though.

And during use of match_pathspec it is already to late to die(...)
for bad labels, because the labels may not be in control for the user
(She just cloned the repository and wants to inspect certain files,
which are labeled "$*&^".) So for now we just output a warning for
these cases, in the hope that content creatos upstream respect the
recommendation for labels.

Feedback welcome!

Thanks,
Stefan

Stefan Beller (5):
  Documentation: fix a typo
  Documentation: correct typo in example for querying attributes
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: record labels

 Documentation/gitattributes.txt               |  14 ++-
 Documentation/glossary-content.txt            |   4 +
 Documentation/technical/api-gitattributes.txt |   2 +-
 dir.c                                         |  50 ++++++++
 pathspec.c                                    | 110 +++++++++++------
 pathspec.h                                    |   1 +
 t/t6134-pathspec-with-labels.sh               | 164 ++++++++++++++++++++++++++
 7 files changed, 305 insertions(+), 40 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- 
2.8.2.401.gb7348ac.dirty
