From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [RFC v2] reflog: show committer date in verbose mode
Date: Mon, 3 Jun 2013 19:20:18 +0800
Message-ID: <CANYiYbG-f+bM0jP0f-R-ciuR0sR13+8FcYkTas-X0LOh1mPRfg@mail.gmail.com>
References: <517a09251fbbc81073fbd53f04a3f4b58cb8b3f7.1370224175.git.worldhello.net@gmail.com>
	<CALkWK0k-cikpwue4iQDGJgP4NrGdkCw2r=dzzP78+QbsA5BiMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 13:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjSoK-0004Z7-4U
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 13:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727Ab3FCLUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 07:20:21 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:39314 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab3FCLUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 07:20:19 -0400
Received: by mail-wi0-f173.google.com with SMTP id hi5so2555834wib.12
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1wY93PdbzW/ipcroKApkYMWPLDXZrYjQ0CQYecNHOCY=;
        b=lTPyN+Zyc3EmqQQ9F2gbfb09O4DciWqvf9MOb6zAFElv2yCefmXKjoGfMNxIWLkNTn
         a71O1fXFAscdIhLzybTK6/AghbykgL623ICDco/zaHzw7rcVLQo80/3q/LFdRDM9vaaX
         HSWco6nd7ti3MKHFNlx3avfTcJWrIrOi/QGQ0JZT5BWb4xlDMlwShEL7ukWjaRKVH97k
         VHAw6utq243m13sYO6yk+xkfV8izCm5UJXn19iFN84Su/o0jbOgGmA95kXi2YNf+JRNr
         MRwv74EI2m0LYOQaHpNYntwtuei3Vga/fY5pPlX8m5Igm6Kc0jQfmdj4sR6t/mtsIBPj
         m4GA==
X-Received: by 10.180.198.80 with SMTP id ja16mr12064618wic.53.1370258418104;
 Mon, 03 Jun 2013 04:20:18 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Mon, 3 Jun 2013 04:20:18 -0700 (PDT)
In-Reply-To: <CALkWK0k-cikpwue4iQDGJgP4NrGdkCw2r=dzzP78+QbsA5BiMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226213>

2013/6/3 Ramkumar Ramachandra <artagnon@gmail.com>:
> Jiang Xin wrote:
>> It will be nice to add this pretty formatter automatically when run
>> `git reflog` in verbose mode. And in order to support verbose mode, add
>> new flag "verbose" in struct rev_info.
>
> Sorry I missed earlier revisions of this patch.  Generally speaking,
> "verbose" is a bad way to control format-specifiers.  Why not add to
> the list of pretty-format specifiers (like oneline, short, medium,
> full)?  Also, this patch is extremely pervasive in that it teaches a
> poorly defined "verbosity" to a very low layer: revision.c/revision.h.

I also feel bad when adding new flag "verbose" into rev_info. = =b

CommitDate is more significant than AuthorDate for reflog. In order to
show CommitDate, at least we provide "fuller" formatter, such as
"git reflog --pretty=fuller". It's output is not as compact as:

    $ git reflog show \
       --pretty="%Cred%h%Creset %gd: %gs%n    %Cblue%ci (%cr)%Creset%n    %s"

Introduce new pretty-format like this is not suitable I think. Maybe
I have to define my own alias and use it myself. ;-)


-- 
Jiang Xin
