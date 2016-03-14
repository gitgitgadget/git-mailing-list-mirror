From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 12/17] rebase-todo: introduce rebase_todo_item
Date: Mon, 14 Mar 2016 14:43:59 +0100
Message-ID: <CAP8UFD0Fw1ZOQzPfF=bbEsCOhkoHfV5B5ayprxR6kWr6vApT5Q@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-13-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 14:44:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afSn1-00080k-39
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 14:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbcCNNoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 09:44:03 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36346 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbcCNNoC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 09:44:02 -0400
Received: by mail-lb0-f170.google.com with SMTP id x1so239398731lbj.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nxzVvjoGPQsKBxFsL9hIbDVPJ1xnFpX7yFDM3o2v3fk=;
        b=TOShDZPM2aJTU+l0s8kZdNg1OPa3zif9kjhXmBbur+IYYZDoI4mExf/uIoe41huV/V
         koxz+OyVRYb/1ZoZh0PhTfOA8KMLowo3yA1ul0vDB64k6TJx5lt7/PXdTHnItVhhu5Qz
         0bIVD/G/JzGSrHWdYKRrl1mwOGRhrX6FTb3qDBSbIpq+XXgzEUco2ItsiO5NI6HPqa2o
         u0T2dNAKeKljmt5RUCvxeYnAFdXynEQmB7C4IXOXr4O+zWm8fF9XG6g/hGDwvjRKppyA
         NNeBMbfQVh/Wutzd8+VAwoUfGnp51YPzBRBzzYNyqmQFd3d7Lq76ACo4MRHpp4oV3Rti
         HZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nxzVvjoGPQsKBxFsL9hIbDVPJ1xnFpX7yFDM3o2v3fk=;
        b=ky1X0I48fBBWrmn5elv1l1GjYkQUcnVVQZj8Zk7e9QWKZBuMl9gxzc4NjTNuQxhFr8
         JIdE6gWCFb07i9QUL9S7sveCQzZ8ZpcTFvtpJ+cI5p3K2lTRDKbWzodUzCxxMxYbOdPn
         Vwyb5UqzC+04Jc9F/gF0i8meRPue/eeJ/vh5y+rHbe1/7ypfm4FmmtbSsa+wS0aDkIAj
         AGfhPgftnXGVDRPFUfiR3knxymTaTFmAwqVHsN4K1wr6w/2t393l9vFqpuf8mHHqSNiE
         0anei868U5YYBOKqXGg+DMFeKH6Chw3s38Dkv2UmETbI3x9+GrAcwVhA73a7GnPmkhaB
         g+9A==
X-Gm-Message-State: AD7BkJKi5OqT75UpzImki8aDyq00A60H4+ncB9RBkVaQewjJq6ncGf5Hm978rNBHTB1gfBb9nCPpCiR4WjWjmg==
X-Received: by 10.112.134.138 with SMTP id pk10mr7632922lbb.16.1457963039709;
 Mon, 14 Mar 2016 06:43:59 -0700 (PDT)
Received: by 10.25.137.130 with HTTP; Mon, 14 Mar 2016 06:43:59 -0700 (PDT)
In-Reply-To: <1457779597-6918-13-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288778>

On Sat, Mar 12, 2016 at 11:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> In an interactive rebase, commands are read and executed from a todo
> list (.git/rebase-merge/git-rebase-todo) to perform the rebase.
>
> In the upcoming re-implementation of git-rebase -i in C, it is useful to
> be able to parse each command into a data structure which can then be
> operated on. Implement rebase_todo_item for this.

sequencer.{c,h} already has some code to parse and create todo lists
for cherry-picking or reverting multiple commits, so I am wondering if
it would be possible to share some code?

Thanks!
