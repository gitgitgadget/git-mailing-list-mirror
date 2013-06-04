From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Tue, 4 Jun 2013 18:22:15 +0530
Message-ID: <CALkWK0kGrCDhDFL5THBTTVARTnfY2xucbJaGJGKj8OYv3Q1pBA@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
 <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
 <CALkWK0nFDdfGKeRqKKTTMSm4zqHDOt_iGc1aA7LgD9=y2DJO5A@mail.gmail.com> <CACsJy8DA4oCj3WPmJY6aA7Gq3Xx4xqZ2XxxiZUuR6TqgK=f6Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqjV-0003Ah-M9
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab3FDMw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:52:58 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:37522 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab3FDMw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:52:57 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf17so117711bkc.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VSt3sbuptMXa/x25EXXQ80S+Fgx68FznxsUOUHb8e5o=;
        b=EqAvAKVIDauIkJ1LOXLe6oNJQnHG1voLm+FdN96P+rOrFt4PQMkZUI2Mi3N+oscdsL
         y3u5yf6bprHRFAOuDuGo/cDpcDOiub9WRs+31ePmEzQnuhSIvoZbjOTvBmDc2D5Xztu7
         u1Bgot3N5MNk6nwSRVEesPphImz3Xx6wrd1FRcg+SalMA/GyW3bMurKGUG22fND7Yl0e
         J3g8YdzvU75xOnjntk4uzp9Bsm6akvSJQAI+DUw3gDOa3AyyXcuiZhX0oO08FI19Hnnw
         ENZEM/HBZW0eLbm6Tpyu/5g3MghriyuQH8mwnQarYWEjaKZFoxLf8+Y0K7jwxcbPX/ms
         s2qQ==
X-Received: by 10.204.109.200 with SMTP id k8mr8174526bkp.82.1370350375739;
 Tue, 04 Jun 2013 05:52:55 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Tue, 4 Jun 2013 05:52:15 -0700 (PDT)
In-Reply-To: <CACsJy8DA4oCj3WPmJY6aA7Gq3Xx4xqZ2XxxiZUuR6TqgK=f6Ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226361>

Duy Nguyen wrote:
> Nobody should ever parse these output
> with scripts. The color can be generated from color.branch.*.

How do we implement color.branch.(current|local|remote|plain)?  In the
current code, we take a crude approach by hand-constructing argc, argv
strings and passing it to cmd_for_each_ref().  There are no
conditionals in the format syntax (and introducing one is probably not
a good idea either): so, I'm guessing these configuration variables
have to be read by for-each-ref?

> A bigger
> problem is show_detached(), --[no-]merged, --with and --contains. We
> need to move some of those code over to for-each-ref.

I saw that you fixed this.

> Another problem
> is the new "branch -v" seems to less responsive than old "branch -v"
> because (I think) of sorting, even if we don't need it.

Does your track-responsiveness patch fix this?

> I checked out
> your branch, made some more updates and pushed out to my
> for-each-ref-pretty again. Changes are:

*pants* Sorry, I'm finding it hard to keep up.
