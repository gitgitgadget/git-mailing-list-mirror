From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Mon, 16 May 2016 23:41:18 -0400
Message-ID: <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
References: <20160517032247.25092-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 05:41:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Vt6-0000tm-G5
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbcEQDlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:41:36 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36276 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbcEQDlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:41:35 -0400
Received: by mail-ig0-f195.google.com with SMTP id c3so567054igl.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=IuHcj+MvDUKVc8F0MG1KQrmWchDpQAuRRjn3sSElIQU=;
        b=Fs/CcV7+TKF2lsNXGg+huKps6X9tIcKXkQiAwUWla6ElLlnSNHVCg4oOoIRm201tYW
         aEeRvAPO19TTQJmO8+T7SKGgOO7WZE2eGSmJQaIRdz5rgWzJ5E/NJ44cBcoZNTZuDfkO
         mGLvD4VMYjQaGXtdribYhZQPeChvgoie9HS3NB1YpgKF6n0iuuu/kI+v7MK1+f5wmAjV
         LQlGsYgL9aLN7UJ2wEhrad/VXhr2NbdpB3p7EBRW4kmEp1BXDw970P1y1XFim2DNTGMF
         En6gVzYWgQ+hwYkR/pab+Ed14Y1Oek5UQqpPNFV4WV+NsxeD+8bK0WoP49qBG1fEr6Z3
         jM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IuHcj+MvDUKVc8F0MG1KQrmWchDpQAuRRjn3sSElIQU=;
        b=blaJGwTJQasT8KOh4j8PDxbB96TLgz1/b5BrNen9RwKyimssj5lUPokIVHSSItSaIp
         1SUHV+o7Te3ZuIwq/kDp654BNbVZDJ6kuZyMEJxvYRIaru7EojVRtkUNwXNPjhXROk2o
         rzbukzpDaroKppp3kHDXOH/+WiZFg8BwfVxv9+EDydAQL5i2yg/GJn6RhiQsBdqrW/AO
         A2Fqwttm4cdEGQpSQiXMkyV6p/8r4YlnrG156g6WueBOPCdW5wqrlTWSabO7ux1ODb1y
         peQvLAwG8yhYhJSJ5DaVr+cLV8RfWgXQGEk09RCo5kCu6waKEYw3AWf2fjlrd7iz69wK
         ZJFg==
X-Gm-Message-State: AOPr4FVabPuMA738OTw1zALaqNSEuWX93HUuLwxXiLzPL/I3lb06n1ckRLwaApiwqWEeVQncJlzBgRvYezMNig==
X-Received: by 10.50.6.15 with SMTP id w15mr13753944igw.91.1463456478104; Mon,
 16 May 2016 20:41:18 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Mon, 16 May 2016 20:41:18 -0700 (PDT)
In-Reply-To: <20160517032247.25092-1-sbeller@google.com>
X-Google-Sender-Auth: SiDpBGBUK2bS-SvbSkqhi7hvA04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294847>

On Mon, May 16, 2016 at 11:22 PM, Stefan Beller <sbeller@google.com> wrote:
> When using automated tools to find memory leaks, it is hard to distinguish
> between actual leaks and intentional non-cleanups at the end of the program,
> such that the actual leaks hide in the noise.
>
> The end goal of this (unfinished) series is to close all intentional memory
> leaks when enabling the -DFREE_ALL_MEMORY switch. This is just
> demonstrating how the beginning of such a series could look like.

Considering the signal-to-noise ratio mentioned above, the goal seems
reasonable, but why pollute the code with #ifdef's all over the place
by making the cleanup conditional? If you're going though the effort
of plugging all these leaks, it probably makes sense to do them
unconditionally.
