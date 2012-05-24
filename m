From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] sha1_loose_object_info: do not complain out loud
 on non-existent objects
Date: Thu, 24 May 2012 20:12:30 +0700
Message-ID: <CACsJy8CpqR4WGoYqNpUESigqTgHr0cL4gK2t7sCcb8P5StX3-w@mail.gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com> <1337782191-10091-6-git-send-email-pclouds@gmail.com>
 <CACsJy8A5Xv8_KY2z4eQvm2e=3e=KjDJyVM+-d0dmXntHJ-6efg@mail.gmail.com> <7vvcjm28ff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 15:13:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXXqm-00068r-1R
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 15:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab2EXNNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 09:13:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34751 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab2EXNNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 09:13:02 -0400
Received: by wgbdr13 with SMTP id dr13so8306163wgb.1
        for <git@vger.kernel.org>; Thu, 24 May 2012 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=y8sbqq60GL4ad2v1Slxi1DM8oPUAXnKMlFUboqO7TRI=;
        b=if4m5RmcTil14SJMBK8negd2wV1gQ7gEXYZTpe+y5ajAz8BojcZKY3quRNhVMzhiIc
         LKIyGoHlgGNMhM3kjYDvn9JZP5C232dOgMbm11yIWXjhFMW5O0OLjDgLHbN0L562n7jo
         7LEW94oz4nmsdaszjEL6RJEi0tvDj25/ouIKtVzkxTc9JkyAfoeAR2xnztkFvTXVUYgs
         JmJK06LNYsBzqUJoDLsRx34lQ8M0Yqj0jAYnVsxYox5HM/PnPEYMGNM8ZPIsW98IEfcF
         UPNcAJfK5KwVD0fQbb6vtZSEDUzkh+uGKaP8cOzZGirZTA2QSJm2qBNV9HHVnBBG+PUS
         Vzrg==
Received: by 10.216.216.95 with SMTP id f73mr3445461wep.149.1337865181250;
 Thu, 24 May 2012 06:13:01 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 24 May 2012 06:12:30 -0700 (PDT)
In-Reply-To: <7vvcjm28ff.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198371>

On Wed, May 23, 2012 at 11:01 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> while it's still making sense for me, i think it's more logical =C2=A0=
to
>> move the check to the caller, where "entry in pack?" check is also
>> done.
>
> I think most of the callers of sha1_object_info_extended() are using =
this
> function, saying "We expect this object to exist somewhere, perhaps i=
n
> pack or perhaps in a loose form, and trying to see what it is", and t=
hey
> rely on the first error message "unable to find" to be issued.

hmm.. if you see it from that angle, yes it makes sense

> So in that sense, I do not see how this patch makes any sense at all.
> Care to point out a codepath where we throw a random 20 bytes at it i=
n
> order to see if an object with the given object name exists? =C2=A0Th=
at would
> be the only case where "unable to find" might be an unwanted error
> message.

packed_delta_info(), fast-import (I think) and cat-file do not check
for object existence before calling this.
--=20
Duy
