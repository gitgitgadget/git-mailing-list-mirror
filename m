From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 09:06:25 -0700
Message-ID: <CAJsNXTm5uhWYB+oiz=3WQQKFQ=i=+oO0L6cgGBB+2cm5BgfFCg@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
	<CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:07:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJRT6-0004kc-3C
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 18:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905Ab2JCQG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 12:06:27 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:64732 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747Ab2JCQG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 12:06:27 -0400
Received: by lagh6 with SMTP id h6so3070990lag.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=JtFpCawaBV9Nsa0o4CXtHSslf7Xb2JPhICeLX0Q17k4=;
        b=PaWvAe3oSvtDXtCiDyFJRNZCmXIvvhBBKracC8nf3JzLg/dvoEQo/hsMNKMMb8ShnG
         D+pheFM+8pKYxv0z7tPGokJ9aD/qi8mO0Xujqy5u6ZqkJvxwCND8l1sXnNyoF0K2Pgc1
         b36rd9u1DfZrgk3Mx951S6FNRnUA8r/MBHsaLs/b58iL4xXlN5EWfE0bng10AR6NS6Av
         DMYwtp8MqXNueKdAnHL7MsaqdUrrpF5pCCY7ie/tKB351h6bS7+AgoK7dPrflt2ftS/1
         e5nE78YZnqUQxvqsJ/JYbnWP4zTG/eJ3yZpLFI2/KJgrLRPEPyHIYaqz4M3BLL5ZK7W8
         VQnA==
Received: by 10.112.83.196 with SMTP id s4mr1833016lby.29.1349280385453; Wed,
 03 Oct 2012 09:06:25 -0700 (PDT)
Received: by 10.112.57.161 with HTTP; Wed, 3 Oct 2012 09:06:25 -0700 (PDT)
In-Reply-To: <CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com>
X-Google-Sender-Auth: uCwUYpP0ZkmQKpp9gi_p-LpLOsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206909>

On Wed, Oct 3, 2012 at 7:25 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hi Phil,
>
>> Perhaps the confusion arises from the the meaning of "the safety".  In
>> this case, the safety mechanism in place is to prevent you from
>> creating a child commit which has the same "tree" contents (working
>> directory) as the parent commit.  It will not be the same commit
>> because it has different parent(s) than its parent commit; but the
>> tree (working directory) is the same and git normally prevents you
>> from doing this because normally this is an accident, a mistake.
>>
>> --allow-empty tells git you intend to do this and so it should bypass
>> this "no changed files" safety mechanism.  It is not a safety to
>> prevent you creating a new commit with the exact same sha1; the safety
>> is concerned only with the exact same "working directory" file
>> contents.
>>
>> Can you suggest a rewrite of this description which would make it more clear?
>
> Instead of:
>
> "Usually recording a commit that has the exact same tree as its sole
> parent commit is a mistake, and the command prevents you from making
> such a commit. This option bypasses the safety, and is primarily for
> use by foreign SCM interface scripts."
>
> I would suggest:
>
> "Usually recording a commit that has the exact same tree as its sole
> parent commit is not allowed, and the command prevents you from making
> such a commit. This option allows to disregard this condition, thereby
> making a commit even when the trees are the same. Note that when the
> tree, author, parents, message and date (with the precision of one
> second) are the same as those of an existing commit object, no new
> commit object is created, and the identity of the existing one is
> returned."

But that's true of 'git commit' generally; it has nothing to do with
--allow-empty.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
