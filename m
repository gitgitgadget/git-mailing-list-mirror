From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Tue, 3 Nov 2015 11:26:47 +0100
Message-ID: <CAHVLzcnm6qUhcuuP36Q7Yvf9rUAu-KK4j5-Rzmzd_CFCaRwYug@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
 <CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
 <CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com> <CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtYo7-0000sX-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 11:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbKCK1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 05:27:10 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34086 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbbKCK1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 05:27:08 -0500
Received: by lfgh9 with SMTP id h9so12234293lfg.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 02:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AO1hl1birb1c8w8H7q6Xw4OFyElSyUE1nLc5synLE4Y=;
        b=bLxLqEY/5gyjRmQ1jTfp23uDkemj0sFA8URd92V6DXsOOdsLKvBsRmjGcERAkHUsaN
         gmtHH+Ff6IxMBwjlOCbg0eLpcU3T+pNoXN5lcaUkMFvKXB0TE/+bcNpOHvW5YuIhITtb
         +FXK8Ex2y41yj0bTc9ZITd3fQzLksbmOIiY08vap52iSBP09PGTeuJIqet1F0TSJCaxw
         OqV/vmR89DA9AfnxSGLbzoMMTOlFwT7lyeZjyEYvxztWMG8XkLOhzQBkbxoVf1pG+Yy9
         QCaHPcgfbCHCARpAQohAFzJlAsd7KpGSJl69GFXQJMA+MLjHW5eM57/7UAStbB7C6FNV
         5Xww==
X-Received: by 10.112.168.10 with SMTP id zs10mr12564974lbb.101.1446546427247;
 Tue, 03 Nov 2015 02:27:07 -0800 (PST)
Received: by 10.25.198.133 with HTTP; Tue, 3 Nov 2015 02:26:47 -0800 (PST)
In-Reply-To: <CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280789>

On Tue, Nov 3, 2015 at 10:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> It was from last year. I may have measured it but because I didn't
>> save it in the commit message, it was lost anyway. Installing watchman
>> and measuring with webkit.git soon..
>
> Test repo: webkit.git with 104665 tracked files, 5615 untracked,
> 3517 dirs. Best numbers out of a few tries. This is best case
> scenario. Normal usage could have worse numbers.
>
> There is something strange about the "-uno" measurements. I don't
> think watchman+untracked cache can beat -uno..  Maybe I did something
> wrong.
>
> 0m0.383s   index v2
> 0m0.351s   index v4
> 0m0.352s   v2 split-index
> 0m0.309s   v2 split index-helper
> 0m0.159s   v2 split helper untracked-cache
> 0m0.123s   v2 split helper "status -uno"
> 0m0.098s   v2 split helper untracked watchman
> 0m0.071s   v2 split helper watchman "status -uno"
>
> Note, the watchman series needs
> s/free_watchman_shm/release_watchman_shm/ (I didn't do a good job
> of testing after rebase). And there's a small bug in index-helper
> --detach code writing incorrect PID..


Impressive improvements!

Ciao,
Paolo

-- 
Paolo
