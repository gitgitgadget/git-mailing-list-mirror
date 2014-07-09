From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Wed, 9 Jul 2014 08:58:31 +0700
Message-ID: <CACsJy8Dqe7Ts7y0wxknq61rYUtaWfTNBqVa3i+db=qGG0vQgVw@mail.gmail.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
 <1404619619-4774-4-git-send-email-dturner@twitter.com> <xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
 <xmqq7g3obsqm.fsf@gitster.dls.corp.google.com> <CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
 <xmqqwqbnaii3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:59:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4hA4-0000XR-JH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 03:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbaGIB7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 21:59:04 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:55066 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbaGIB7D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 21:59:03 -0400
Received: by mail-qg0-f42.google.com with SMTP id e89so5896753qgf.15
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 18:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9tMT2hLaDcZiTE2DoQhxJseZ+kwnfycXG7FP6OH36Tg=;
        b=mspyg0tU/gFacVL4x6Ge6jLKxyOumBArHReMNPuZbzgjCm/iwo8jno/Vgxx/r0UqvS
         dOWUoV7zy/eLtVnJaeTOkqvqQ6sfDxQctGczwVcf2gVqc4NtjDmTM3KHBzTYOxKc/H+q
         0s4b3OemxQrCiygENh9dLaOEIi4QGG8pAjuTZJ4tCSvvtvyjt4FBuDf9aERyGLYRtBUM
         Udo34klcVy9LZK2ug/3Gz9DOsbYOJ25qAsNoZY5d/JlK3vmdrJUDd43qJaj35Wm35xtj
         mWREUJsPpzRWbfRycLL8h19oaXh21XvTTQ5JAmT0VPIbppIMCyvYEuk3E80pt6PX7WZD
         xnyg==
X-Received: by 10.140.91.164 with SMTP id z33mr61180839qgd.65.1404871141802;
 Tue, 08 Jul 2014 18:59:01 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 8 Jul 2014 18:58:31 -0700 (PDT)
In-Reply-To: <xmqqwqbnaii3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253059>

On Wed, Jul 9, 2014 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I wonder if we need to update_main_cache_tree() so many times in this
>> function. If I read the code correctly, all roads must lead to
>> update_main_cache_tree(0) in prepare_to_commit().
>
> I think prepare-to-commit is too late; it does not want to know if
> the index it was given to create a tree out of is the one that the
> user will keep using after this invocation of "git commit" or just a
> temporary one used for partial commit.  The cache-tree rebuilt there
> is what is recorded with commit_tree_extended() in cmd_commit(), but
> if you are doing a partial commit, these generic code paths are
> given a temporary index file on the filesystem to work on, and
> cache-tree in that will not help user's later operation.

Right. Thanks for checking.
-- 
Duy
