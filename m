From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: ag, **, and the GPL
Date: Wed, 19 Nov 2014 07:48:23 +0700
Message-ID: <CACsJy8BYBKMqWiNQ=xFjS8s_6GCeoA+UZ-HQ_V1qnsvQG6jOKA@mail.gmail.com>
References: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
 <1416333456.27401.1.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthew Kaniaris <mkaniaris@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 01:49:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqtS8-0003ky-TO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 01:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639AbaKSAs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 19:48:56 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38243 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbaKSAsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 19:48:54 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so8391834ier.4
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dzmFu3/T78Tf2Y93fXm24pz75x81MPKNv8m23Bq8Frs=;
        b=lWGSxAI0iZhy2fMBC1WedSbrllA1LktbH0EWp7YgpcUN/wxeWQ0j40Lk5O0dF2tdcj
         hECpZd4DPrx06k6u9Gb/yx3x+quPutXc5rILEw5vSDU3HPBDk83sDfjHPYJi8IP3CvNo
         9GYeBf+igGW0SXc3ZqKlPKqPbHNusWKPCacIYz4QvsF/Anx/cwFJATvcljwNhTUbSDqv
         C2EMP+jGgmwKQXaTIK6h3Qy9qRFpFIrz7RrbUvp/kaGUoGeJskXBESdfVK1Q3A/TQSnG
         C+xOWXm+1E8KDuIeFS72omhdRJX6kg9ftCj3h50LOZHBSBa1NaJ1Sl5bdN/9aXvVOiQb
         OlSw==
X-Received: by 10.50.43.167 with SMTP id x7mr7146340igl.41.1416358133748; Tue,
 18 Nov 2014 16:48:53 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Tue, 18 Nov 2014 16:48:23 -0800 (PST)
In-Reply-To: <1416333456.27401.1.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 12:57 AM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2014-11-17 at 20:50 -0800, Matthew Kaniaris wrote:
>> The Silver Search (https://github.com/ggreer/the_silver_searcher), is
>> a small, open source, cross platform searching utility written as a
>> replacement for ack.  One of the major benefits of Ag (and a source
>> for much of its speed) is that it obeys .gitignore.  However, Ag
>> currently treats gitignores as regexs which produces incorrect results
>> for e.g. **.  I'd like to add support to ag to obey the .gitignore
>> spec but I'm not keen on implementing yet another fnmatch clone.  Ag
>> is licensed under the Apache License Version 2.0 which to the best of
>> my understanding is incompatible with the GPLv2.  Would you grant me
>> permission to reuse wildmatch.c (and necessary includes) for use in
>> Ag?
>
> I already implemented this without using any git code at
> https://github.com/novalis/the_silver_searcher.  The patch was rejected
> because it slowed down ag slightly (or perhaps because it was overly
> complex).

Interesting. Do you have a direct link to that discussion (I don't
know how to navigate that novalis link). Generally you (or ag) should
avoid fnmatch/wildmatch whenever possible. Hitting those *match()
_will_ slow things down (and git tries hard to avoid it). I had some
optimizations on top of rsync wildmatch to handle "*" case better, but
I don't think it'll make big difference in practice.
-- 
Duy
