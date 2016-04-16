From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Sat, 16 Apr 2016 07:22:50 +0700
Message-ID: <CACsJy8DYms0+FjyfbqBKeS6XcJiGEdV9t=Xtn0epoOKNig_cuQ@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
 <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com>
 <1460573236.5540.83.camel@twopensource.com> <CACsJy8AyZKLC4Fsa8+BKqvRSAJOQSPBramjLC0ubrhW+fWQtxA@mail.gmail.com>
 <1460751695.5540.94.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:23:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arE1H-0007Ai-59
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbcDPAXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:23:22 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33232 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcDPAXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:23:21 -0400
Received: by mail-lf0-f42.google.com with SMTP id e190so163029003lfe.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DiJw9cuaJR0C50jVAxrAHGXMZhi0mJoc1XP69nBcS1c=;
        b=j4fqgDGKpXXML49SY/xW/HTN5ezzQUPazsVAwbLADcUO3jkMmo5ztxbSn2ppYvOiFV
         GzEj0Ywx5596xJdUZaYVMXGib4RERgrq2bTvqYPc1Kk/N0BYbYtSjRhwaVSfMnTJPkhv
         WDd44Xaf2S+Egt+r144DDYA/mtu67tk2Be7DjmgbkUWEFzD8LzoQmIoPsIi8neLQws18
         sgWApTx/KJajeoKzPrHnLdBAE1uwY6ZRuxCJaxcnSCdnXPGOds7uckxKY2KNhtRdvC9o
         dr20s26Llwahnec4fmDeVSHIROirokNoIj9kjqrMED4Q4W5YeKZuqs2uVQ0o2G0tW5xv
         QYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DiJw9cuaJR0C50jVAxrAHGXMZhi0mJoc1XP69nBcS1c=;
        b=asuvmXbg3SmYY6Zs+7Vtb6EEKqxxxnvhuCQyCHrvAxFZVaU59qTH5nfwW59c5THGHW
         ypqtEFaV6eQB64GEOsAi+4I8oRrG1zOfrqu8PYW0hakZGsGqTXUBVGvUpIUQDZqj99Jp
         Dw4vbP0mg0LbPEEtooeOasevzEcIfwSKHCzkEktmuen4f/ZxPMIa4CeVCXu7ZELJTXyU
         rQsyCnoNjsIzXDLphP7Uv0AkqTnoa9CfUzR815FFQcQR1CaTVyQmZ7ZtpayGZvOEOC33
         hFz/lZiy8GLOhkVrcVY33lVhAgt0VEVfZmPlw+y1LT4HNW1SZm2iZCgVHtG5ukCK3Fsa
         FD7A==
X-Gm-Message-State: AOPr4FXQj7edP2SOlb0DdomLlBH4RaAI8jQrgwajhpF0kWOn9bPmFD+zG+YLqiwlNSUcbg6RTxXwC6JzoPUouw==
X-Received: by 10.25.22.87 with SMTP id m84mr4672086lfi.118.1460766200041;
 Fri, 15 Apr 2016 17:23:20 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 17:22:50 -0700 (PDT)
In-Reply-To: <1460751695.5540.94.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291705>

On Sat, Apr 16, 2016 at 3:21 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2016-04-15 at 18:25 +0700, Duy Nguyen wrote:
>> On Thu, Apr 14, 2016 at 1:47 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > > > +       fd = unix_stream_connect(socket_path);
>> > > > +       if (refresh_cache) {
>> > > > +               ret = write_in_full(fd, "refresh", 8) != 8;
>> > >
>> > > Since we've moved to unix socket and had bidirectional
>> > > communication,
>> > > it's probably a good idea to read an "ok" back, giving index
>> > > -helper
>> > > time to prepare the cache. As I recall the last discussion with
>> > > Johannes, missing a cache here when the index is around 300MB
>> > > could
>> > > hurt more than wait patiently once and have it ready next time.
>> >
>> > It is somewhat slower to wait for the daemon (which requires a disk
>> > load + a memcpy) than it is to just load it ourselves (which is
>> > just a
>> > disk load).
>>
>> You forgot the most costly part, SHA-1 verification. For very large
>> index, I assume the index-helper is already in the middle of hashing
>> the index content. If you ignore index-helper, you need to go hash
>> the
>> whole thing again. The index-helper can hand it to you if you wait
>> just a bit more. This wait time should be shorter because index
>> -helper
>> is already in the middle of hashing (and in optimistic case, very
>> close to finishing it).
>
> You're right -- I did forget that part.
>
> In "index-helper: use watchman to avoid refreshing index with lstat()",
> we switch from just poking to poking and waiting for a reply.  Then in
> "read-cache: config for waiting for index-helper", we make that waiting
> optional.  So what if I just remove that patch?  Does that solve it?
>

Yes. I think so.
-- 
Duy
