From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 15 Apr 2016 18:25:41 +0700
Message-ID: <CACsJy8AyZKLC4Fsa8+BKqvRSAJOQSPBramjLC0ubrhW+fWQtxA@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
 <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com> <1460573236.5540.83.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 13:26:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar1tH-0007WS-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 13:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbcDOL0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 07:26:14 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36582 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcDOL0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 07:26:13 -0400
Received: by mail-lf0-f46.google.com with SMTP id g184so141627600lfb.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6cGOVgc9AxMPTtZti6d8gVKdYqEJXAjHJOl2D0et7XI=;
        b=kBcRmU+krL/HJam0uz1Z7S8Yb/g/E/xqkIfNXP8BPwBC8841814Emc5lmy+UNBRr6h
         TwxReOBbcoGlOcDgW7tIBZTvVFW5OvzaetWu/Y1OteCOYnkhMe+Z+JpGU9oRZxz0rsZt
         Kz7AGXbMl0w1ZYyftDZAhODDzgRzE2QH/NSsYj7sATeC68XkryTHIqAV79q1CPBBtZeG
         Cu3XMNztjqng1lSyYRi9mUQkIueKwfcPvGI0Aor4BA788T3998ICx8CqUTqh18jz1eZC
         R7nu1+M95D1m79zMCihHHJBSgH1Bopjx8ft6OZqAmP1Ns0xqYAVyleNfj9kzdIpkOGXO
         OcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6cGOVgc9AxMPTtZti6d8gVKdYqEJXAjHJOl2D0et7XI=;
        b=kwBwXXIltgBsss8hDXQzYlRyeGfHbL+/DQU04zDLxFfWToL9PhkUPws8WyQ+uaofUd
         sS1ao7Q5isvtW23JnG1n9rkpUp7S7e3ApXi5uzIsgwOUCwAyvJS1Nr7ukfu8EfotV4T6
         y+rwNgUAjXKHAFAevdSSIdw538RZtgrWr7rkHTEZ3OQNU4xW+Rjh5VWjLnkqJPE6Z/j5
         a/xV6I6VOIykStE/MkszYIcLcIkcIfYj2zefBJD1ekzWHZheyndY6xfmCQoQDwMYE55R
         umpNW3i8zBv2/etxg7O5fz0317rcbBdBV2ejfrdGjGvDMoMdRPOpSTYHEUBV5lWpLBgX
         X/Ow==
X-Gm-Message-State: AOPr4FXUs/U5RnXYiZzYR9kY+BK53PQucdnWNEUUvorZOn9FMN4JmNCqF3A3w9o/iBbKq0+ccthounsVrEW3wA==
X-Received: by 10.25.152.147 with SMTP id a141mr8761426lfe.83.1460719571589;
 Fri, 15 Apr 2016 04:26:11 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 04:25:41 -0700 (PDT)
In-Reply-To: <1460573236.5540.83.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291602>

On Thu, Apr 14, 2016 at 1:47 AM, David Turner <dturner@twopensource.com> wrote:
>> > +       fd = unix_stream_connect(socket_path);
>> > +       if (refresh_cache) {
>> > +               ret = write_in_full(fd, "refresh", 8) != 8;
>>
>> Since we've moved to unix socket and had bidirectional communication,
>> it's probably a good idea to read an "ok" back, giving index-helper
>> time to prepare the cache. As I recall the last discussion with
>> Johannes, missing a cache here when the index is around 300MB could
>> hurt more than wait patiently once and have it ready next time.
>
> It is somewhat slower to wait for the daemon (which requires a disk
> load + a memcpy) than it is to just load it ourselves (which is just a
> disk load).

You forgot the most costly part, SHA-1 verification. For very large
index, I assume the index-helper is already in the middle of hashing
the index content. If you ignore index-helper, you need to go hash the
whole thing again. The index-helper can hand it to you if you wait
just a bit more. This wait time should be shorter because index-helper
is already in the middle of hashing (and in optimistic case, very
close to finishing it).
-- 
Duy
