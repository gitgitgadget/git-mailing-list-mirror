From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Tue, 4 Jun 2013 20:11:25 +0700
Message-ID: <CACsJy8BpeP0y+wFbNJioR-TwyV1P77moz0x2ZDXzqz2ZKWTahg@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
 <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
 <CALkWK0nFDdfGKeRqKKTTMSm4zqHDOt_iGc1aA7LgD9=y2DJO5A@mail.gmail.com>
 <CACsJy8DA4oCj3WPmJY6aA7Gq3Xx4xqZ2XxxiZUuR6TqgK=f6Ww@mail.gmail.com> <CALkWK0kGrCDhDFL5THBTTVARTnfY2xucbJaGJGKj8OYv3Q1pBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 15:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujr1t-0007bU-UC
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 15:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3FDNL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 09:11:58 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:63250 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab3FDNL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 09:11:56 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so313030obc.3
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E/VZu5YVZZK84vHTzWmx4vtWfPvvZK9dayDSKF9QdSY=;
        b=oTOVP3f4pYmLsCxk9WSPypcWYQYYlpAP/Q8oB0dpgWq9dNtMFCj4Mt1RetXeRzNqX4
         AguGQU6guWr610Yq/tqF7OOzrNSqLuDliw/JkvnUej6Ki90xL4Lpdit6MFL2r6o4Kemk
         o9qpdGHJhhgdKtX1ZiNIAdn9c2xVjVXh+bg5dD/NtgvstbZmBvdCbQkBafszDveiNUwe
         PSjQ8WC2Ni3yGC3uRfrkKATVMFNQTN74/H8q7AfASSTD24P6nXBtRBrbP8LQfO9OVc0h
         GoMXM7/U8rWjJ+OQyNrYWfJ/xJzMgiHMgsIgSDjLtHGmMc22HqXamZB47kMlU5buGEBJ
         00FQ==
X-Received: by 10.182.19.168 with SMTP id g8mr12301150obe.21.1370351516519;
 Tue, 04 Jun 2013 06:11:56 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 4 Jun 2013 06:11:25 -0700 (PDT)
In-Reply-To: <CALkWK0kGrCDhDFL5THBTTVARTnfY2xucbJaGJGKj8OYv3Q1pBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226365>

On Tue, Jun 4, 2013 at 7:52 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> Nobody should ever parse these output
>> with scripts. The color can be generated from color.branch.*.
>
> How do we implement color.branch.(current|local|remote|plain)?  In the
> current code, we take a crude approach by hand-constructing argc, argv
> strings and passing it to cmd_for_each_ref().  There are no
> conditionals in the format syntax (and introducing one is probably not
> a good idea either): so, I'm guessing these configuration variables
> have to be read by for-each-ref?

Maybe. I don't really like the idea that for-each-ref reads _branch_
config. We could introduce the same set of keys but in
color.for-each-ref namespace. %C(auto) will take care of the logic and
choose the correct color key. When we replace branch's listing code
with for-each-ref, I think we could somehow override for-each-ref keys
with branch ones in-core. Too hacky?

>> A bigger
>> problem is show_detached(), --[no-]merged, --with and --contains. We
>> need to move some of those code over to for-each-ref.
>
> I saw that you fixed this.

Nope. --[no-]merged and --contains seem easy. show_detached is still
WIP, mostly because detached HEAD may or may not show when you provide
a pattern to git-branch (e.g. git branch --list 'foo*') and because
HEAD is always the first item, regardless of sorting order.
get_head_description also seems more porcelain-ish than a plumbing
feature..

>> Another problem
>> is the new "branch -v" seems to less responsive than old "branch -v"
>> because (I think) of sorting, even if we don't need it.
>
> Does your track-responsiveness patch fix this?

Yes.

>> I checked out
>> your branch, made some more updates and pushed out to my
>> for-each-ref-pretty again. Changes are:
>
> *pants* Sorry, I'm finding it hard to keep up.

Sorry that branch was in a better shape the day I sent my previous
email. Then I kind of used it as a playground with --[no-]merged,
--contains and stuff :-P
--
Duy
