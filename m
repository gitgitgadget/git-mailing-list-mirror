From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] refs: add a new function set_worktree_head_symref
Date: Fri, 8 Apr 2016 02:42:58 -0400
Message-ID: <CAPig+cQYktE08zy3nSqxm924P0foW91RtHcapmRBy_Fwh9S_Ug@mail.gmail.com>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
	<cover.1459087958.git.k@rhe.jp>
	<39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
	<CAPig+cQym57U-izza5_Hn0xCDcG0MHFMcWJFc==ohKnr7acFWQ@mail.gmail.com>
	<20160408063713.GA17696@chikuwa.rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Fri Apr 08 08:43:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQ8I-00006d-PW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbcDHGnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:43:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35396 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbcDHGm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:42:59 -0400
Received: by mail-io0-f196.google.com with SMTP id q128so15140229iof.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=UAPg+2IHayjYScaEOZwbP0jOK+j0oWmB+XQXA8v8nw8=;
        b=qk10hy4qyhOA5Tsd3O1MwLqNqTpLvsUjnh1WFNb3HOQ+HoK7Gso2NSUq8iKWg755dj
         3yCYBYasLpxsip+gg8c9oniy/ghsnN07sV4ZgJWK1+L/XkrynVeqap8XIEYWI5KPMIxq
         rd4FSMM3S1HXb5/ZBa28WuINR007Q4DL3PBlviEOR0Hu8wEU4vztWOpbTGs15kWUheqb
         tyEDcUkGld74l6iv47/99dgA+DWz4va7fA5vKLuuVFPOZlzqGt7/uozpWPH24E+biQY0
         BbwbxDz0Q4a511X2UPq8htQIs3XoieD9cW+A73BJVAPOhuNeyzZ+PnfS/kEETFYEWUfp
         9rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UAPg+2IHayjYScaEOZwbP0jOK+j0oWmB+XQXA8v8nw8=;
        b=QMuJh0YTtZUAJbfdebZGk0AGnmVZ5xOK/WEUzY+VROVz9FS5xvzLtsC4eUjXUgKDnk
         yxaiuEZ6upPPIWmIfKN+mA/M09QuVdrQvG+kxqppyzI0x7vweKIXBOFt7rGCWetIKceh
         cZr7NoVDYLYjdHBOI07yW6WAh7E1ZfzsxKZ9ysuOEODGVwuUg4/f59CDNJxPmFTCevpF
         WeuLxEaHbK8zpmfTH6a/ld/YqfcMDnMxhJiYgK+tBc1/T3WC2TIqfGXYobA53Iegi/AN
         I9nPBDWER1Xm9SebNqtZPWhEBHSJ8ZuGwcRnbrSWsRziwbM0t2zFPx9IxzFGav3W/YkF
         ieXg==
X-Gm-Message-State: AD7BkJIvoNPYwZA5Pthk5Q5OUzAtEwz4es27wKQxtYH5Yfh5jicFmcaQMslepuGoXKbtclA2sgFCDQWFtLXUwA==
X-Received: by 10.107.47.41 with SMTP id j41mr7067160ioo.168.1460097778642;
 Thu, 07 Apr 2016 23:42:58 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Thu, 7 Apr 2016 23:42:58 -0700 (PDT)
In-Reply-To: <20160408063713.GA17696@chikuwa.rhe.jp>
X-Google-Sender-Auth: hNoItxW7nayn1uguokyQq0dvVws
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290999>

On Fri, Apr 8, 2016 at 2:37 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> On Thu, Apr 07, 2016 at 05:20:10PM -0400, Eric Sunshine wrote:
>> On Sun, Mar 27, 2016 at 10:37 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
>> > +int set_worktree_head_symref(const char *gitdir, const char *target)
>> > +{
>> > +       static struct lock_file head_lock;
>> > +       struct ref_lock *lock;
>> > +       struct strbuf err = STRBUF_INIT;
>> > +       struct strbuf head_path = STRBUF_INIT;
>> > +       const char *head_rel;
>> > +       int ret;
>> > +
>> > +       strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
>> > +       if (hold_lock_file_for_update(&head_lock, head_path.buf,
>> > +                                     LOCK_NO_DEREF) < 0) {
>> > +               error("%s", err.buf);
>>
>> 'err' has not been populated at this point, so I suspect that this
>> error message is likely to be rather uninformative.
>
> Yes, unable_to_lock_message() is missing. Thank you for pointing it out.

You're welcome. As this patch is already in Junio's "next" branch, if
you post a fix, it should be incremental atop "ky/branch-m-worktree",
rather than as a re-roll of this series.
