From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git deletes files when rebasing an amended merge-commit.
Date: Thu, 08 Oct 2015 09:06:07 -0700
Message-ID: <xmqqegh5s5u8.fsf@gitster.mtv.corp.google.com>
References: <CAJqY2NUHg-7ghiNA7m+Q36LPhgG6tC6QDg2BP6f52fvDv6uAWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Hans Weltar <hansweltar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 18:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkDhu-0004lg-Vf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 18:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934460AbbJHQGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 12:06:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33863 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934148AbbJHQGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 12:06:08 -0400
Received: by padhy16 with SMTP id hy16so58697527pad.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bcxKXabEnp8CO/a4eQ4pGJFcDiIRvUHyQHSkhMfOJwY=;
        b=ST+4RQppjZzn638B+NieCQhY+CCuEdDoQmSUGTTbMF4A0woDkuKpbiinHh0vBcFUSn
         3zWCAONC//Sm+N6G2o01u1FazLnKd0GEdJdi8qRMp3OdyRT8zP2UqMYRM0BzpQGqt4mm
         131bn3EP03SJoJ/A3XoWHgWM9I5MV2hcwSffMDgCHT5XeioSnCGGivHN8ikmKDOVm/zU
         8Rb3/wS3I53qjl4ZgpN24ORTt1jL+WV1g0rPcdXXtqteP5t57Mxrf9S/GFqQfsjmGLTj
         JhkJ/aXq0gWZfzhM7P3ZOYsLVUeJniCzrQy+a6fX9OFod1S/I6WqaZ7osEByxrlr7ey1
         i0zA==
X-Received: by 10.66.226.37 with SMTP id rp5mr9123558pac.49.1444320368579;
        Thu, 08 Oct 2015 09:06:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id d13sm46334362pbu.17.2015.10.08.09.06.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 09:06:08 -0700 (PDT)
In-Reply-To: <CAJqY2NUHg-7ghiNA7m+Q36LPhgG6tC6QDg2BP6f52fvDv6uAWQ@mail.gmail.com>
	(Hans Weltar's message of "Thu, 8 Oct 2015 14:56:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279242>

Hans Weltar <hansweltar@gmail.com> writes:

> When you have a fast-forwardable merge commit, you can amend this
> commit to hold additional changes.

The real issue may be that there is a difference between "you can"
and "it is a good idea to", though ;-)

I think the fast-forwardable-ness is a red herring in your example;
rebase by default replays the patches commit by commit to flatten
the history, and evil merges where your result does not match a
mechanical merge result will be lost, and that is true even if you
were dealing with a real merge.

I'd imagine that you would need something like

http://thread.gmane.org/gmane.comp.version-control.git/198125/focus=198516

where it proposes a mode of rebase that picks the change in the
first parent chain.

Thanks.
