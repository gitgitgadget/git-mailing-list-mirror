From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: version 2.4 seems to have broken `git clone --progress`
Date: Mon, 11 May 2015 14:06:15 -0700
Message-ID: <xmqq8ucu3jug.fsf@gitster.dls.corp.google.com>
References: <CA+6di1=Qvp3oaw0moMg8XMFd5vgc0v1L0CC2ppEDOF8QA9N6Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: "Jack O'Connor" <oconnor663@gmail.com>,
	Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon May 11 23:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yruu6-0006AJ-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 23:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbbEKVGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 17:06:18 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35099 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbEKVGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 17:06:17 -0400
Received: by igbyr2 with SMTP id yr2so83197219igb.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BNgP1RxiOytEcJ9lumIEPULlI6fTEn0TfaNYbORlIt8=;
        b=hCN0TsBjYVFL/A0NVNUPP58tvOyHW+7BCbCWQxXwm49MVX6Ci7w7nxxj5ROXV0eaEC
         TscweJ6hSnttmDBrO/Xf2ADZKBqaYYZigi3VB8QO1uI4OTFaH/gboQv6hIvq/y5u+crl
         w/D6y+y3gD02b22dknf/xPLSsWgotyElz2NPBydXzJ55DWLhucPW2iio3T+LgY/P5jfN
         ABFuHYfL8tKcOq8mZrvQJICt6iq8b4QtYjOUIlSmZJI9aOxtwJgVRVY/T7YeeTE2AjMZ
         ++CHcms00wK/X7dhJOavCiteaSCfjTQwhlGW5InKjl8XPkdsiixSvgve9C7q9gIeXXFi
         IWmA==
X-Received: by 10.50.72.8 with SMTP id z8mr1874069igu.36.1431378377235;
        Mon, 11 May 2015 14:06:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id kl1sm663365igb.15.2015.05.11.14.06.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 14:06:16 -0700 (PDT)
In-Reply-To: <CA+6di1=Qvp3oaw0moMg8XMFd5vgc0v1L0CC2ppEDOF8QA9N6Mg@mail.gmail.com>
	(Jack O'Connor's message of "Mon, 11 May 2015 15:51:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268824>

"Jack O'Connor" <oconnor663@gmail.com> writes:

> In git 2.3.7 I could run the following command and see progress in the
> terminal, despite the redirection of stdout and stderr:
>
>     git clone https://github.com/oconnor663/dotfiles --progress 2>&1 | cat
>
> As of 2.4, that command no longer shows progress. When I bisect, the
> responsible commit is 2879bc3b0c3acc89f0415ac0d0e3946599d9fc88
> ("transport-helper: ask the helper to set progress and verbosity
> options after asking for its capabilities"). Can anyone suggest a
> workaround?
>
> -- Jack O'Connor

That commit is by Mike Hommey <mh@glandium.org> so I'd imagine that
CC'ing the author of the patch would be the first thing to do ;-)

I am kind of surprised that the commit changes behaviour, though.
If I didn't hear that you had trouble in 2.4, I would have suspected
85cb8906 (progress: no progress in background, 2015-04-13) instead.
