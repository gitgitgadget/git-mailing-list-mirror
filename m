From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 19:22:58 +0530
Message-ID: <CALkWK0my3kET2hdZre57NiNxiENoZ+XVLYjU-XMs+Xoche9QoQ@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
 <CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
 <CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
 <CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
 <CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com>
 <CAMP44s1eB+bvg7vnG5S3SBACHTrkpCqJNX-Q2tzEVdvzFWvkcA@mail.gmail.com>
 <CALkWK0nBUHHkqOQannMu5Kjs00Fro8KBbiocfsT4Uf74jO9FgA@mail.gmail.com> <CAMP44s2HPXnudioSSj0O_r2PbmbAqcyTORJNhRL_a=NWu_niBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 15:53:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucycs-0007R0-9g
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab3EPNxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:53:39 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50473 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3EPNxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:53:39 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so6468065iec.35
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SiaXYKc5M5fQIfYowWCQO9Y0qcwjG5TK3OfI3LD3RFA=;
        b=AtW3fSDGTsAPNgfFPyXmqI/EAUglSU1l15QWG3kTmj7AKA1X2F6VfDvLb5T2vvqXFa
         dlH/2cOvTq6YQPY5XpWDF0Amf9hRJbvFuwZMaG8KGZPaLCv2MhHLcn5SeYQoSszymkwV
         bEmLl2bgfMtdLML9yKuc6z+QlQlqVGvY/THduRmraQSsOsxXS3B5cfI/4gw8QhRPUUAh
         akIh7qFD+bMmiKtHZmrWLhX41c4e4w7Y9YIPh8ZdvriDxAGY4hL4b2n31CAW/ahChyff
         9OON9vr6SI847iDbgUgzt84DaBCgnECq29iC+Iekin0m1qWaydJ/3KkJgxmtl7p78Khg
         bo9Q==
X-Received: by 10.50.66.140 with SMTP id f12mr9146470igt.63.1368712418588;
 Thu, 16 May 2013 06:53:38 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 06:52:58 -0700 (PDT)
In-Reply-To: <CAMP44s2HPXnudioSSj0O_r2PbmbAqcyTORJNhRL_a=NWu_niBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224568>

Felipe Contreras wrote:
> Does branch.<name>.merge overrides remote.<name>.fetch? No. They
> complement each other.

I often wonder if you are reading what you're responding to:

remote.<name>.fetch is operated on by fetch, while branch.<name>.merge
is operated on by merge; they are really orthogonal.

> The same that 'git pull' does when both branch.<name>.merge and
> remote.<name>.fetch are set.

Are you reading this?

git pull _fetches_ from remote.<name>.fetch and _merges_ from
branch.<name>.merge.  What is "the same" in git push terms?  It's a
simple question; which ref does push update: the one specified by
remote.<name>.push or branch.<name>.push?

> Of course it would work. Does @{u} stop working when remote.<name>.fetch is set?

It doesn't work when _only_ remote.<name>.fetch is set: you need
branch.<name>.merge to determine @{u}, just like you would need
branch.<name>.push to determine @{d}.

> It is a downstream branch.

Which commit does git show @{d} show you?  There is no ref called
refs/for/master.
