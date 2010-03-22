From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 15:52:58 +0800
Message-ID: <41f08ee11003220052v26b1843ftcfbccec693971eec@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
	 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtcRu-0005Qm-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab0CVHxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 03:53:00 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62059 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0CVHw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 03:52:59 -0400
Received: by qyk9 with SMTP id 9so3081235qyk.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=582wfhhTc99FjroCSynp4U4ICd+gs9hwoyjz/PkfU8g=;
        b=PwnihzHD52ZhWwlt5gTzgxuVb0p0aiZemrGBynGrVCAiog9IZFfyzXz4y7SrMMu1bN
         NSsTM0TY4m2woCh7UOsD+CFVsN5LWzn4UjXme2SZy6MUTsrop4aJz+M+FwrjAzytSgMn
         XmGuEoX0UWPLfkeOX2KWwO0Qf7HG42tlD3wd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=A+cu6FmESKgM+8fM82A478CgwUrekPgd5qtQ01IrhhMJRbYvMvJYjxV1fJvbrZmfKN
         Ims+1QGnnxsPlHtynI9rvTVEW/6SH6R3Al3OqNjSIqQAZqe/elJPmyGjIYxnxSIjuR3h
         7rmvuwrGMjZ+Cmifw+pQg9O6+YsNyBUWkUOSk=
Received: by 10.229.228.83 with SMTP id jd19mr1697516qcb.72.1269244378941; 
	Mon, 22 Mar 2010 00:52:58 -0700 (PDT)
In-Reply-To: <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142907>

On Mon, Mar 22, 2010 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Bo Yang <struggleyb.nku@gmail.com> writes:
>
>>> When you want to know where the first few lines of Makefile
>>> came from, and if blame says the first line came from 2731d048, that
>>> really means that between the revision you started digging from and the
>>> found revision, there is no commit that touched that particular line, but
>>> equally importantly, that before that found revision, there wasn't a
>>> corresponding line in that file---blame stopped exactly because there is
>>> nobody before that found revision that the line can be blamed on.
>> ...
>> Yes, this is not satisfying. But as I understand, the line level
>> history browser will do more than just this. It will not stop on 'step
>> 4', it can follow the change history recursively and deeply, to find
>> more.
>
> I am actually questioning the existence of "recursively and deeply to find
> more"; the reason blame stopped at a particular commit is exactly because
> there is no more---otherwise it wouldn't have stopped there but kept
> digging deeper.

I think an example may explain me well.

commit 1 of the file:
line 1 rev 1
line 2 rev 1

commit 2 of the file:
line 1 rev 2
line 2 rev 2

commit 3 of the file:
line 1 rev 3
line 2 rev 3

If we run, git blame file, it will show two lines are blamed on commit
3. Line level utility will also show rev2 and rev1 to users as the
format like what git log provide. I think git blame focus on who
produce the current code range. And the line level browser will
provide more than that, it also answer, how the lines evolved into
current condition.

I hope I explain everything clearly. :)

Regards!
Bo
