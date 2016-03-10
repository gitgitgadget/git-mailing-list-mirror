From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Thu, 10 Mar 2016 18:59:11 +0700
Message-ID: <CACsJy8D7+sXF9gRj15kidgK_xzSVHqChSFdqHpJ3PwxMOw2rHA@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de> <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adzFs-0002da-3S
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 12:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbcCJL7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 06:59:43 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33739 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcCJL7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 06:59:42 -0500
Received: by mail-lb0-f171.google.com with SMTP id k15so109469790lbg.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 03:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=utZWN+yxbVa6Y/91da8PVb7uM/uM6i7GgtNSHxoDM1I=;
        b=oup4KKcRPlFnNNV38gblikwomb0k3a7ow7CCS/Ey4J6vMZXXqS7GjULP4KBjegzxH7
         2/gSkxmx+KOLibrQM08XmCP8OC7E1ZNN/OIjbFRB4w9JLK721X8EjEiNRhzWrlighmxK
         EtA26Ka6ansTWBtV5IKPaNsTakf3b8ikbVFeC4BTwduOV+GPqSYFPYep6DjVtp81XvDR
         6AdH8YJE7suIAKwqWfJfDvFbloWJpnGOe5VCrpDYeiXHRoBKuBFOXSWrNx+aoWsvMax1
         hzaQ2ElQNyyLKc0cZUGWRWK7OgOKT/DLborC6bTFmhuijx3g2I9Q+/cTFVhOVZK2X9tu
         mSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=utZWN+yxbVa6Y/91da8PVb7uM/uM6i7GgtNSHxoDM1I=;
        b=PGPCPEXSbxVrldYmQjk9nY4MLHxMyhwye2DPmtL4mDxqS1wR3b0cZhrx4HpN1VqWbO
         9yLgvMVadjvesjkWc7fIwwG2RXrq+qX8glVOnOcJYUR+jRpr9eg9WoOu9AyLFLy+++ta
         +XyZPb2C1zau8gkt4t+wd59FiZLMLxbOtzzMX7wH48sDfL9JjQVgUS1OszGV7qKLvrqn
         TpVnVULlHCEFdRnl1eNMxEhB0PXBGjQb7ODj8KaEQ0QYwATjQas5yHINANPQ0lyFWt4W
         SRvqYdYJ3ouIMD5doqwnNGzY0YXeFuRl6KsnmCKKqCtYUWRhiP6fonGDAZuUgRlZupcL
         +0xQ==
X-Gm-Message-State: AD7BkJKj4aYz6k74ypHlgYmV2GP2He/P3jvrc/hMlTRb3Xb8K+DxHO4mvMRfgGYig7C87vgUAVTmL/40wKJXPA==
X-Received: by 10.25.24.100 with SMTP id o97mr1143869lfi.112.1457611181127;
 Thu, 10 Mar 2016 03:59:41 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 03:59:11 -0800 (PST)
In-Reply-To: <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288617>

On Thu, Mar 10, 2016 at 6:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> It gets rather tiresome, and also typo-prone, to call "git branch xyz
>> upstream/master && git worktree add xyz xyz" all the time.
>
> You can actually do "git worktree -b xyz xyz upstream/master" for the
> same effect. Maybe we can avoid "xyz" duplication with "-b -" or a new
> option name?

Another option is just do "worktree -b xyz . upstream/master"

when the destination already exists and is a directory, the real
worktree location is <dest>/<branch name>. Similar to "mv abc def"
becomes "mv abc def/abc" when def is already a directory.
-- 
Duy
