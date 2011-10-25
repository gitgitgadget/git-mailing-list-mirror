From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Tue, 25 Oct 2011 10:56:15 +0100
Message-ID: <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com> <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 11:56:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIdkZ-0001zl-L3
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 11:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab1JYJ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 05:56:46 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57662 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab1JYJ4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 05:56:45 -0400
Received: by pzk36 with SMTP id 36so965280pzk.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=thy2mdrrvw2IbvenmncZu6+fmgKiZ6ORy8Zj7Pc+VAc=;
        b=r9HWDn7VEHi4Nkjs4rz7OhZYPPaaRAVWJgTei9WMNTLd1hDh/gas1O02Ea21/o3qPH
         IyTV9eGBycYnYrWhyYU0/sa3eyKSCKPiX08GKZYOXF4dXdBOJDn01MYCI6H5l68pm+9O
         vmE2+Y7z/XXC1ON3TkUmzu0tMIm8da6JMZmUA=
Received: by 10.68.73.103 with SMTP id k7mr45768691pbv.30.1319536605079; Tue,
 25 Oct 2011 02:56:45 -0700 (PDT)
Received: by 10.68.54.3 with HTTP; Tue, 25 Oct 2011 02:56:15 -0700 (PDT)
In-Reply-To: <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184199>

On Mon, Oct 24, 2011 at 7:01 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> I for one welcome our new branch deleting overlords :).
>
> You mention that checkpointing solves some of the concerns raised by
> others in this thread, would automatic checkpointing be way to make
> sure everything is as it should be?

Apparently I did not explain myself correctly. Let me try again :)

This is what I am doing:

1) import topic
2) checkpoint
3) diff-tree and processing
4) exit if processing returns ok
5) reset topic to another HEAD
6) goto 1)

In this scenario it is the checkpoint that "breaks" everything because
it will write the original tree to disk. When fast-import exits it will
find the old tree on disk but not within "topic" tree.

So, no, I don't think that automatic checkpointing would make anything
easier. Quite the opposite!

-- 
Vitor Antunes
