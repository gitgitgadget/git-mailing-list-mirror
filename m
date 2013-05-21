From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 23:26:50 +0530
Message-ID: <CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
 <1369132915-25657-2-git-send-email-artagnon@gmail.com> <7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 19:57:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqoZ-0001Z9-BD
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3EUR5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:57:31 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46036 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3EUR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:57:31 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so2559224iec.34
        for <git@vger.kernel.org>; Tue, 21 May 2013 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u71ItQA8sTTveAYzLIPa6NFU+estJVTfl6lf/TfiME8=;
        b=jRWhf7U9KcbkFV3g12G79zLqYO5Y0gnJqvXJ8zHb8Ejd50g7m/attFODiuHKGl8wH+
         zCcsDUq8ELfAfd6LfpTVVR0CqfAwPtZY3x+iqMC4ouD3KiYl2CZUUziVSCQNVj9nmzPf
         zxwZsqEqOO4K7Zd9peBMxI4lMTFter4OMqXX5gIJquDyNitly+zA0DHvkjGv+j3a2o92
         eDTkzRrZRCV5N5sFLaqLVLEgZ2PSkf3GydgO1llEFBVX2FwyQy9JcZIuentg5hR5d7Hd
         XMsqirn04yMQWYha6uSdm4pDh0gfin1r8Q12TF3QVxPhQ9t7tPGLM5n+0yp2YejVC/jG
         HXxQ==
X-Received: by 10.42.47.77 with SMTP id n13mr1774442icf.12.1369159050587; Tue,
 21 May 2013 10:57:30 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 10:56:50 -0700 (PDT)
In-Reply-To: <7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225053>

Junio C Hamano wrote:
> Does a failure in interpret-branch-name that issue these error
> messages always followed by die() in the caller?  I know you looked
> at the cases you noticed as an end-user (like the above "git show @{u}"
> example), but if some codepaths did this:
>
>         if (interpret-branch-name()) {
>                 you do not seem to have upstream defined,
>                 so I will helpfully do something else that
>                 you probably have meant.
>         }
>
> this patch will break that codepath you did not look.

How can that ever happen in a non end-user case?  That failure
requires a string containing "@{u}" to be constructed and passed as an
argument.  Why would we ever programmatically construct "@{u}" to find
the upstream?

To put it another way: unless an end-user facing application finds an
"@{u}" while parsing argv and passes it on to interpret-branch-name,
isn't it impossible for an "@{u}" to end up in the argument?
