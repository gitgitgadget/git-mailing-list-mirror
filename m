From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 11:28:30 -0700
Message-ID: <CAOeW2eF67Tj0Mq+g+-3UFyh_Xvt=ZcKDc9LjCKGwu9y2G39NBQ@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
	<7vhas7fefs.fsf@alter.siamese.dyndns.org>
	<CAOeW2eHprw73+zqVbJRird1eE7ayU_KjCUSoieYsGi1rbL5QBQ@mail.gmail.com>
	<7vzk5yen99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 20:28:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0zNU-0004FK-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 20:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab2HMS2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 14:28:31 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61283 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab2HMS2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 14:28:31 -0400
Received: by ggdk6 with SMTP id k6so3526603ggd.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lCyHxqz+kEMLrgf6F7OAARjNOR5doYIAAC4MMt884og=;
        b=Hoaq4WeysQnrms9BNIqHCT+Yl5HLpXlv7BfKEv97bpArtbo0fa5T2S3bQnUYeBBPGM
         Q2gRarU6Q8MO4lMW76ZAUlMKt/F/uNBKd8shYgk9Qnn2pRAe8YRmT19k6OaZZL1JQdsH
         IrQVPs/2x/vAWx/wD6jO9+KQDM0ATYCGIG0aQvNirrDnY0B7SUHXq7Cc/9l/FYOudHbp
         cHMtIOOt0dL8CA+rSM900uAh+MTL6vRAKNUntCWxYnlrG5o0lJDLpUigZSJpp6cTi58N
         +IkFjE67eXKWEU+SBPtuqw+L8N9Wsv+cBYqR6sWFtCwAVOR0QYoqxCuklX77cpHLlZLU
         //GA==
Received: by 10.68.224.170 with SMTP id rd10mr19341501pbc.106.1344882510265;
 Mon, 13 Aug 2012 11:28:30 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 11:28:30 -0700 (PDT)
In-Reply-To: <7vzk5yen99.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203352>

On Mon, Aug 13, 2012 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>
>> ... so is a migration desired? Or just
>> change the default for --no-walk from "sorted" to "unsorted" in git
>> 2.0?
>
> I think the proper support for Johannes's case should give users
> more control on what to sort on, and that switch should not be tied
> to "--no-walk".  After all, being able to sort commits in the result
> of limit_list() with various criteria would equally useful as being
> able to sort commits listed on the command line with --no-walk.
> Think about what "git shortlog A..B" does, for example. It is like
> first enumerating commits within the given range, and sorting the
> result using author as the primary and then timestamp as the
> secondary sort column.
>
> So let's not even think about migration, and go in the direction of
> giving "--no-walk" two flavours, for now.  Either it keeps the order
> commits were given from the command line, or it does the default
> sort using the timestamp.  We can later add the --sort-on option that
> would work with or without --no-walk for people who want output that
> is differently sorted, but that is outside the scope of your series.

Makes sense. The shortlog example is a good example of sorting that
completely reorders the commit graph sometimes even making sense for
ranges. Thanks!
