From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Thu, 2 Oct 2014 10:22:50 -0400
Message-ID: <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZhHX-0005H4-P9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 16:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbaJBOWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 10:22:53 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:42534 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbaJBOWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 10:22:51 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so3332191wgh.4
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=laQTKF6nDuDRPDYOqBxPo4bmf4JcKZvzewg5O0+aBww=;
        b=REkpRtuxKNvqqcQg+Rtvz9OARdG4k/6FMnphMBp1td48l6iliHVrp8RuLjkK47nVz+
         VLFy7NiiJ6kRMaKD+rMxi0jmb2L4b0OH07ly0KN8z5i3ZxOzT+SY44HkU+iHJyQG5S+H
         U1bKgZoA9IPLbjlE9Sing+6tutLEJ1ooKd1lsk+u2UFXq7rWnY6Nm78uraEivQs99JEm
         M8S3OLQn9FP3Rrg7VIZnKQfshuwwbyq79AYQJ7pddBMQ1aNOviU/2goBpAY4gBbjMJbD
         VZDdNnbAdd0HaAaD+KoDChHIWzZ1HvbuiUljgqATlWbbVY9xlc+U8q2JbAtFKW/KYYXV
         z8LA==
X-Received: by 10.194.94.196 with SMTP id de4mr75323401wjb.86.1412259770251;
 Thu, 02 Oct 2014 07:22:50 -0700 (PDT)
Received: by 10.194.125.229 with HTTP; Thu, 2 Oct 2014 07:22:50 -0700 (PDT)
In-Reply-To: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257809>

On Thu, Oct 2, 2014 at 9:57 AM, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> I always though during fetch I have to specify a refspec and that a
> sha1 would not be accepted as a ref. Firing some like 'git fetch
> origin <sha1>' should be forbidden. But in fact I see that such a
> fetch command succeeds if you already have that object in your local
> repo.
>
> My question: is it allowed to fetch sha1's? Shouldn't fetch fail if you try it?
>
> See here:
>
>> git clone -q https://github.com/chalstrick/dondalfi.git
>> cd dondalfi
>> git ls-remote
> From https://github.com/chalstrick/dondalfi.git
> ce08dcc41104383f3cca2b95bd41e9054a957f5b HEAD
> af00f4c39bcc8dc29ed8f59a47066d5993c279e4 refs/foo/b1
> ...
>> git show af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> fatal: bad object af00f4c39bcc8dc29ed8f59a47066d5993c279e4
>> git fetch origin af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> error: no such remote ref af00f4c39bcc8dc29ed8f59a47066d5993c279e4
>> git fetch origin refs/foo/b1
> remote: Counting objects: 3, done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From https://github.com/chalstrick/dondalfi
>  * branch            refs/foo/b1 -> FETCH_HEAD
>> git fetch origin af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> From https://github.com/chalstrick/dondalfi
>  * branch            af00f4c39bcc8dc29ed8f59a47066d5993c279e4 -> FETCH_HEAD

My understanding is that you are allowed to ask for a SHA1, but most
git servers refuse the request. But if you already have the SHA
locally, then git doesn't neet to bother asking the server for it, so
there's no request to be refused.

But it's been a while for me since I did any git development, so it's
possible I missed something.

-Dan
