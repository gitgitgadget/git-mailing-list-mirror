From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Thu, 8 Aug 2013 08:09:49 +0700
Message-ID: <CACsJy8AUrrMuW9TgT=gCfFVNq8H0zNjCsZwBY_0Ty-tdEgUYyQ@mail.gmail.com>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <7vsizkpv21.fsf@alter.siamese.dyndns.org> <20130712071157.GL10217@login.drsnuggles.stderr.nl>
 <20130807102716.GA10217@login.drsnuggles.stderr.nl> <7v61vhc7wn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 03:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7EkD-0004dF-Co
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 03:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab3HHBKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 21:10:21 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:62882 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab3HHBKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 21:10:20 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so4726133obb.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FRsDB+srbldkNYXuVqVrKpxBSrdC4WNyUWF7fRM2fVM=;
        b=nWOSuRn0QapAE/qfRlLPJGVT6lKJkuI2TWzd0ARAE11lWI/9I6CQ8C2C4U96ME6tEw
         N3lAhHSVEjMzk9KrbYui3g46YoxKbAJWgQsivWwRyN6kA57h1lQWty00/GoaNLCPfpQF
         ykYTdgBrWlvTxGfHbsUjCUPs7N+hqsLoBhdr94fdg+qOK0itR0Nvq10y9h2f/xCQY9gp
         YFllommp7xzIfP8zlxXjNKaA06r73iNUhl/R/HaWGhuVE9mCrd8YFcvNBtko0al6lGf6
         xyUS7neUkDKVF0UPMVWr9jD8Y5sfkK0lOnXZkuFwKMbp4XQtqo52JZ37CwkwQyDiH63m
         pAgQ==
X-Received: by 10.60.143.68 with SMTP id sc4mr2627059oeb.24.1375924220223;
 Wed, 07 Aug 2013 18:10:20 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 7 Aug 2013 18:09:49 -0700 (PDT)
In-Reply-To: <7v61vhc7wn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231854>

On Thu, Aug 8, 2013 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthijs Kooijman <matthijs@stdin.nl> writes:
>
>>> > In your discussion (including the comment), you talk about "shallow
>>> > root" (I think that is the same as what we call "shallow boundary"),
>>> I think so, yes. I mean to refer to the commits referenced in
>>> .git/shallow, that have their parents "hidden".
>> Could you confirm that I got the terms right here (or is the shallow
>> boundary the first hidden commit?)
>
> As long as you are consistent it is fine. I _think_ boundary refers
> to what is recorded in the .git/shallow file, so they are commits
> that are missing from our repository, and their immediate children
> are available.

Haven't found time to read the rest yet, but this I can answer.
.git/shallow records graft points. If a commit is in .git/shallow and
it exists in the repository, the commit is considered to have no
parents regardless of what's recorded in repository. So .git/shallow
refers to the new roots, not the missing bits.
-- 
Duy
