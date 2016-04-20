From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 10/15] update-index: enable/disable watchman support
Date: Wed, 20 Apr 2016 15:50:40 -0400
Organization: Twitter
Message-ID: <1461181840.5540.171.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-11-git-send-email-dturner@twopensource.com>
	 <CACsJy8D34SKcA0dsG0ZrsOZiOFLwgEuG-TJ914t4qFV1xZGnew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:51:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asy9O-0005eB-GX
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcDTTu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:50:59 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35391 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbcDTTun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:50:43 -0400
Received: by mail-qk0-f177.google.com with SMTP id q76so8096405qke.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=R90oyYV5TZrCMYck4ZiwzqCUqYcOCNnnZpaiS3lFV/Y=;
        b=yk52EDHbvTenUJZsKaEvIyHxnvc/WiMqUEb5lGzHAUg1vd1eUnYoywB4DWbC0CefiW
         ubeEOLY41ggE2QNPAUN3Kg50Zi88UlFkpheRM8PAXrsqZfgLfmKX1zuWtOPvfT0Svuy+
         1mAmgtDRNjyQuNUgo0Ai9INmUbZufpmSNlSQ9Th+FZ9a9qBoYgzhVb/5ayfFfojx4wGo
         n1bHcJTVwwnX0hZLMXYpnbJCgmZOQKSKCbjqL55s0RepQIcxRI+WoPtPCQO17hSdaGjs
         Ab+9+r0r9NH4AUjct07qQgMl57SP5kmJXTRKNrOh4qh1dT/g0ITfGZd6EC+hETvLQtXw
         bmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=R90oyYV5TZrCMYck4ZiwzqCUqYcOCNnnZpaiS3lFV/Y=;
        b=GHSHdkPHlkNBUOCT5exiDKYffmPFOyFYMG4VymuKb66uDM/TOlO1+GP1zppX60iIoY
         mrSy4Jm0qNiF+fZwd8z2EmRJfNbz4ecYHLB+m9WuY9iJLgNdCB8vlROBVmtwNvoz4QBb
         sOR5D58yxgm/fsJ5xBQkFoHAPEqJOJoyiNYhQ9Xqh7aJcB4WyxM+BKsx1V8sA0Qxji7t
         u6EynKr2yjdAoROJwIN76/pY6PFRWYGWHaMCA7WXyUwTD7PyntzqTnqbLO0ozWg4M6QU
         f7VTh+MiwvJ4zNnSY7aCXKimrU/YqzpICfbBGaHFhfF1xz1i/PETfVYza37O+6e3OKGO
         VB4A==
X-Gm-Message-State: AOPr4FVZ6OBWD/P9Fydf8aXJm2KbOBsgWhj6fYIyxjWQfYjkmlhD8xx3zVXOdY8r8cWZOQ==
X-Received: by 10.55.79.207 with SMTP id d198mr13902178qkb.49.1461181841844;
        Wed, 20 Apr 2016 12:50:41 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 139sm5539511qho.46.2016.04.20.12.50.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 12:50:41 -0700 (PDT)
In-Reply-To: <CACsJy8D34SKcA0dsG0ZrsOZiOFLwgEuG-TJ914t4qFV1xZGnew@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292066>

On Wed, 2016-04-20 at 06:45 +0700, Duy Nguyen wrote:
> On Wed, Apr 20, 2016 at 6:28 AM, David Turner <
> dturner@twopensource.com> wrote:
> > +       if (use_watchman > 0) {
> > +               the_index.last_update    = xstrdup("");
> > +               the_index.cache_changed |= WATCHMAN_CHANGED;
> > +       } else if (!use_watchman) {
> > +               the_index.last_update    = NULL;
> > +               the_index.cache_changed |= WATCHMAN_CHANGED;
> > +       }
> > +
> 
> We probably should warn people if index-helper is not built with
> watchman support, which makes this knob completely useless. If
> watchman fails to start, that's a separate problem..

Will warn.
