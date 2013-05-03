From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Another use of "@"?
Date: Fri, 3 May 2013 01:39:24 -0500
Message-ID: <CAMP44s3pN22yfvs_PTzGFfp2cxm3gFMU0ofZ0bNBnzB_yfo+6Q@mail.gmail.com>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9eY-0005BT-CW
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933282Ab3ECGj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:39:29 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:55553 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932967Ab3ECGj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:39:26 -0400
Received: by mail-la0-f52.google.com with SMTP id fm20so1238714lab.39
        for <git@vger.kernel.org>; Thu, 02 May 2013 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9O79dT4WpfzhUTDrWXwly0QGV97cr7ro3aye1ptvSrk=;
        b=L3zF65xeSc5GeuFk6GWsjnDLqwX0/6v+cQUM6G5hcRTbb9qSuUAsi3pKTD/sWEA3ui
         kOD+NoUU7Bk1JITJKlsLw6sRvXB3tYFOFKGFzaF9yvdf66tWDQfxwxHiRvkFUzFMHrhU
         +yZV1QRBqWblhhAAgFoWVk7VnGU9byy949DfJMPQ4jT9JMPIydZ1KvcucBh3CBUoRiRj
         i21OAw3xSK9iJ7Ku3YM7xX+Ymr9er+ne94SJfiaZVV+6flayVJTE4wcjN3h+DayWKS5T
         NI0LLTJKzjS7LEv1Ek/EKb5b6tHKCxdiND+VPRlYbEkoAZ0JjGh6SyZzKHOo0pTb8lIG
         wS7w==
X-Received: by 10.112.22.198 with SMTP id g6mr3748096lbf.135.1367563164908;
 Thu, 02 May 2013 23:39:24 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 23:39:24 -0700 (PDT)
In-Reply-To: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223288>

On Thu, May 2, 2013 at 9:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Hi,
>
> My setup is a bit peculiar where I do git development on three
> different machines. Say I updated branch long-branch-name on machine
> A. Then I continue my work on machine B. I would want to hard reset
> that long-branch-name on machine B before resuming my work. What I
> usually do is
>
> git co long-branch-name
> git diff A/long-branch-name
> git reset --hard A/long-branch-name
>
> but typing long-branch-name (even with TAB completion) is not fun.
> Could I do this (or something similar) instead?
>
> git co long-branch-name
> git diff A/@
> git reset --hard A/@

Maybe this would make more sense:

%git co long-branch-name
%git reset --keep A/long-branch-name

If you have changes but they don't conflict, they will be carried
over, and it they do conflict, the reset won't continue. I think in
most cases there will be no conflict, so the times you need to do 'git
diff' will be rather small.

Yes, many times I would like an idiom that would just replace
something with the current branch, like your A/@, but I don't know
where the right place for that would be.

Also, I feel we are missing some kind of branch, like a
remote-specific upstream, so instead of 'git reset A/foo' you would do
'git reset A@{u}'. By default the remote-specific upstream would be
the same name of the branch, but it could be configured.

Moreover, we should probably have common aliases distributed (e.g. git co).

-- 
Felipe Contreras
