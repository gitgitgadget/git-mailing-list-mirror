From: Eugene Sajine <euguess@gmail.com>
Subject: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 16:30:06 -0400
Message-ID: <CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 22:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDYH-00056b-0d
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037Ab3ILUbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:31:41 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48726 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab3ILUaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:30:08 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq15so4117487wib.6
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=koiIxDNc+iq/v2TU3VN/6W1UEh9S2B7g38gyJfHuagY=;
        b=zkSvxQd0rVrLgA2baT+RPHNgiw4YDawa5OyXL9iJ1x6ymUOq5ZucOyVexzuuS7YfVl
         TO9Be0P8Mjbg+i24AG9SR8fuKmM4rAvVRk0gXR0t+5OJXQ8jN08+OUPEA8f2BD0lAibM
         dpZbzyTG/Zxh1Nrly0FAyB4stkFmkmeB6YBtFm55rStF3sfOUCRn6f2g8/gCXYnaos9e
         We5D3lyZap7Fd5FL5T+WhfJTHzOVUFFLKYWhrqGIXkdWhsToCz/Xio0pHvdsEjGnGASC
         /GNwDUG8ijBWtmUFWenMR7cpzl+1FB/PzIwXFtYM8B4CdeQmGXWkZiwenByNvOEjAGo2
         z9VA==
X-Received: by 10.180.75.239 with SMTP id f15mr7442199wiw.43.1379017806973;
 Thu, 12 Sep 2013 13:30:06 -0700 (PDT)
Received: by 10.216.218.197 with HTTP; Thu, 12 Sep 2013 13:30:06 -0700 (PDT)
In-Reply-To: <CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234694>

On Thu, Sep 12, 2013 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> Is it possible to have access-hook to be executed after receive?
>
> The whole point of access-hook is to allow it to decide whether the
> access is allowed or not, so that is a non-starter.
>
> A notification _after_ successful push update is usually done via
> the post-receive hook in the receiving repository, I think.


Junio,

Thanks for the reply!

This is interesting: i always thought about the access-hook as
something to be executed when the repo is accessed, not just
verification if access is allowed - your definition is much more
limiting.

we have about 1400 bare repos - so i would like to avoid the
configuration of each one of them. I could probably find a way to
automate it, but already having access-hook in current implementation
makes me reluctant to go this way, because it is so much easier to use
centralized manager.

So are you really sure that it is a non-starter to have
--before-service/--after-service options for access-hook?

Thanks,
Eugene
