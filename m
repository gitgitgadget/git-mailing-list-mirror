From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Wed, 15 Jul 2015 16:59:33 +0700
Message-ID: <CACsJy8DF_GXgmZWJ-1iOvoy6SD6kj6u=zprbQA9k6W-Ev6V38w@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
 <xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com> <CAPig+cTXAdGFmq+QkNAgmHJuZgM6-Ckg_-StrTQUxmJSpX4=Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 12:00:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFJU5-0006zp-3p
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 12:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbbGOKAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 06:00:06 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38003 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbbGOKAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 06:00:03 -0400
Received: by iggf3 with SMTP id f3so32176428igg.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QqZgJwzevBCBABNuJJNa1YrA6gxJ/jdFgKTUSQhK4LY=;
        b=YOJfWeygIEkNs/5YLaasPrZ2Gr4R+lOkiqJ2xQImJ875+kbyIktHdrFC0HXScxQ0dT
         B9Xw59/H0W2Kcgl7ng2WNQOmyrmCpWlQ07ckuLKsjLV9Y9E0L004hA8L6zXLVJbFauFE
         43lTci7fukm7f3hULfGtKjneypFigDHwC1PqmSw29kcdinzaMc/TOylah/g2dG80fqXn
         nKQmC2o2kpYSVVD+6wKWFaKl9nuxWTUxi8T141b2jXiXkpWvgf1gdLkViq4R3er4QdB9
         t/170WJeUdbqPRBzPUjICyE241AhPAK/OYV2yTXdJDNo6Uy0gi6hpRekMFEyigXzIjs8
         gpJw==
X-Received: by 10.107.155.12 with SMTP id d12mr4176960ioe.131.1436954402508;
 Wed, 15 Jul 2015 03:00:02 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 15 Jul 2015 02:59:33 -0700 (PDT)
In-Reply-To: <CAPig+cTXAdGFmq+QkNAgmHJuZgM6-Ckg_-StrTQUxmJSpX4=Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273983>

On Wed, Jul 15, 2015 at 1:48 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>  - check_linked_checkout() when trying to decide what branch is
>>    checked out assumes HEAD is always a regular file, but I do not
>>    think we have dropped the support of SYMLINK_HEAD yet.  It needs
>>    to check st_mode and readlink(2), like resolve_ref_unsafe() does.
>
> Hmm, I wasn't aware of SYMLINK_HEAD (and don't know if Duy was). The

I'm aware of it. I just didn't remember it when I wrote this code.

> related code in resolve_ref_unsafe() is fairly involved, worrying
> about race conditions and such, however, I guess
> check_linked_checkout()'s implementation can perhaps be simpler, as
> it's probably far less catastrophic for it to give the wrong answer
> (or just die) under such a race?

And if I remember correctly Mike Haggerty had a series to refactor ref
parsing code and reuse in this place (it was my promise to do it, but
he took over). I think the series was halted because refs.c was going
through a major update at that time. I think we could leave it as is
for now and completely replace it at some point in future.
-- 
Duy
