From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Sat, 2 Jun 2012 17:33:55 +0700
Message-ID: <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com> <20120601093757.GE32340@sigill.intra.peff.net>
 <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Christoph Buchner <bilderbuchi@phononoia.at>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Salfl-0007JI-Gf
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 12:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760168Ab2FBKe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 06:34:28 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:51079 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760160Ab2FBKe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 06:34:27 -0400
Received: by weyu7 with SMTP id u7so1875242wey.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rtpMIPgxMA3YNjETCdy8KD7p9mPg2PaZvp/pQ8VhS5o=;
        b=k/vCzWD+0qRXB9cRo/5wFJg4VzBiq+whsEYayuD7LqM6tH2Xb6EPUHaUcuWzotGqSE
         kF5nqgB2QUo14h7LFHfLJE0xZYjVUmPgYnKO4kdtPd76DPrFwG/M073rUpCQXCS9qJOY
         hdll+nM1CLk6JfFx0TDGpY2i7uLmaxy+TCIhZ27kbzVeDkO63fuI4ekGQCfhZD4O75zf
         9cOSVCcOdTHdTdBvRiEeP/+6QmESo2zzY/73H/Sy0aN3xlO94x3ZR36BewdOqFPPX0Hv
         XH2juuIVh/VDa3JRgsG5055ZwPtGLusKwur9/3h9BxXf8Sr69+MHpong3XIw/KmlusxV
         rFCA==
Received: by 10.216.216.95 with SMTP id f73mr4590510wep.149.1338633266431;
 Sat, 02 Jun 2012 03:34:26 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 2 Jun 2012 03:33:55 -0700 (PDT)
In-Reply-To: <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199036>

On Fri, Jun 1, 2012 at 11:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> No, I don't think anybody is working on it at the moment (at least I
>> do not see anything near the time of that old discussion, nor do I
>> recall it being discussed since).
>>
>> +cc Clemens, in case he had any work-in-progress as a result that did
>> not end up getting published.
>
> I think the way the codepath for -i feeds path to excluded() is wrong.
>
> The excluded() interface relies on the fact that the caller has
> already checked foo/ before calling it for foo/bar; when asked to
> see if "foo/bar" is excluded, it does not consider if "foo/" is
> excluded---the caller should have already checked it.

Sparse checkout deals with the exact same problem and it reconstructs
a tree structure from cache list, before feeding to excluded(). I
thought of generalizing it (e.g. for this case), but with v5 in
progress, we'll probably have tree-based index soon. "ls-files -i"
could be fixed by then.
-- 
Duy
