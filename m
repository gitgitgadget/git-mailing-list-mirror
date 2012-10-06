From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Sat, 6 Oct 2012 13:43:47 +0700
Message-ID: <CACsJy8Cn0rAV+u+8tzD2HOm1XkfKBPkFJVrPQAojMBtYe6wxRg@mail.gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com> <7vy5jku549.fsf@alter.siamese.dyndns.org>
 <CACsJy8BWJg0sr-6iG4LwJjkSM46=CBgddDac4dDR2o3HZ8_25g@mail.gmail.com> <7vk3v4rwkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 08:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKO7q-0008Jy-1y
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 08:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab2JFGoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 02:44:19 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34402 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2JFGoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 02:44:18 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5699140iea.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Rw2zRciNLvEwiujKf7lWRUx0DFaWOyH7xGPMpBZ0B6I=;
        b=rh7Iu2y9Vbf1K9h+0+G8SRzXsbO/kTB9TN5m0pWxBt4OY2AIriZYQOXt7zleXgTr0l
         LjeHnadkXYZED1hbq+nvlT6TE3oqMpcslMGiaKLjiQM5wsVYVMtFpX1cdCufzAyB3uvl
         uH6MpEMAABzr8UHMbhnOeSaZq9/cYb+r8M41VuAgmyL3YNQFr2k0f59HKF/Cehhfbpr4
         UO7ov6msOsLTB0rfaeBkqSJJWDPmBQEjdTLzC2gwxBHoA2XXcSCB7ND3/FYvMGsaDD+r
         mt00y7SfY5EeOAAiarthWaszdEES5WUaKRn4p6z5qQlIzI1497GjgVZSgT2cFplyimUb
         a15Q==
Received: by 10.50.158.194 with SMTP id ww2mr953511igb.40.1349505858268; Fri,
 05 Oct 2012 23:44:18 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Fri, 5 Oct 2012 23:43:47 -0700 (PDT)
In-Reply-To: <7vk3v4rwkv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207133>

On Sat, Oct 6, 2012 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Or the user might think "path/ attr1" sets attr1 for all files under
>> "path/" because it does not make sense to attach attributes to a
>> directory in git.
>
>    ...
>
>    We may not have a need to assign a real attribute to a directory
>    right now, because nothing in Git asks for an attribute for a
>    directory. But that does not necessarily mean we would never need a
>    way to give an attribute to a directory but not to its contents.

Exactly why we should not make "path/ attr" no-op. If we want to make
it meaningful some day in future, I don't think we want those no-ops
lay around and suddenly cause changes in behavior with a new version
of git.

> If one does not think it through, the "path/ excluded" example might
> appear that there is no difference between setting exclude to the
> path itself and setting it to path and everything underneath it, but
> that comes largely from the nature of "exclude" attribute (think of
> "exclude" attribute as "exclude itself and everything under it).

>From a user perspective, the thinking through portion is usually less
than the try-and-see.

> There is no reason to assume other attributes we may want to give to
> a directory share the same "recursive" kind of semantics.
-- 
Duy
