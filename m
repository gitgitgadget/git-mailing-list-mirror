From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 14:50:51 +0530
Message-ID: <CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com> <CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuNV-0000Rn-Vq
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab3EPJVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:21:34 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:57967 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab3EPJVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:21:31 -0400
Received: by mail-ia0-f181.google.com with SMTP id y25so3210080iay.40
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9+cvRUbhn6sKxhMdvkmCuW73ehODTL1HCNPxcjFR2VQ=;
        b=alHdQzVXcAntVKakskRngO5NQYLzRK11K4xUcxwb9WU3jUyQ8me89GficEeRHFM8ZT
         YCdNwsIJpbaWvuVnw3uiIIBm6qRujXQ4X7DPIo80g1K2q5YiKLXnB5/4X9MIOXoCGCyk
         T+CL6M8uLAvfnDg5BOfv1e338dG09vq8uWEqOey33eZnXuc04/Zf8OoCd+djefcySzg3
         4nCjpl+O7a6vvj7+MkLIWuuqlSUfV+EAflHu09lW6rS3g2+ok9V0GKX22QEmbWXfxHW5
         3bOWmEFZPZclgmKk9Z+LVMacu7ur/w1VuZ+enXQkWW7+BTl+uREc8XQH7Cwm86rNyzOl
         Ja3Q==
X-Received: by 10.50.66.197 with SMTP id h5mr8280882igt.63.1368696091463; Thu,
 16 May 2013 02:21:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 02:20:51 -0700 (PDT)
In-Reply-To: <CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224520>

Felipe Contreras wrote:
> And is going to change soon.

Your point being?  How will this patch interact with push.default = matching?

>> branch.<name>.push should probably be named
>> branch.<name>.downstreamref and be used only for informational
>> purposes (@{d} and git status)?
>
> That makes absolutely no sense.

I said downstreamref, not downstreamrefspec.

> [branch "master"]
>           remote = origin
>           merge = refs/heads/master
>           pushremote = github
>           push = refs/heads/fc/master
>
> [branch "fc/old-remote/hg"]
>           remote = .
>           merge = refs/heads/master
>           pushremote = github
>           push = refs/heads/fc/remote/hg
>
> Tell me how you express that without 'remote.branch.push'.

[remote "origin"]
    push = refs/heads/master:refs/heads/fc/master

[remote "."]
    push = refs/heads/fc/old-remote/hg:refs/heads/fc/remote/hg

Advantage being you can do:

[remote "origin"]
    push = refs/heads/*:refs/for/*

While you can't with branch.<name>.push.
