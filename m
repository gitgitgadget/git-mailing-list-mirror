From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Sat, 15 Feb 2014 08:39:47 +0700
Message-ID: <CACsJy8BdRd8yLjtYqGqQd2b1f550GLq6duZCD3JNiTO+K3GK6w@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
 <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
 <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
 <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
 <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
 <52FBC9E5.6010609@gmail.com> <loom.20140213T193220-631@post.gmane.org>
 <52FD4C84.7060209@gmail.com> <CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
 <CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
 <52FE68C9.3060403@gmail.com> <CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
 <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
 <CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
 <CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
 <CACsJy8AQNmmW40R-H7kz1dmwiaSKVgu+GP=Jt1qTKgfbZoMkMA@mail.gmail.com> <CAAErz9gO3NrAF5Zhu277NLqBv-4otQVWGBP6fX00x2OJ3v0_fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@google.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zachary Turner <zturner@chromium.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 02:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUEy-0001SZ-5B
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 02:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbaBOBkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 20:40:19 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39111 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaBOBkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 20:40:18 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so18996939qab.26
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 17:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MH2PwHz7BC98Nkcua0L3nbasCww1GfsgbKxO3tAODyE=;
        b=n+vhHdg92Qr0fBWQOo9dwoUfkOhUK/eok8EL1ktmVLziXWPa0Xjc9PIVuqyaaNsGAp
         SsiGr8g9JX0bNE7EBTwc7tYNtUXrHksQ3PdPo6wsfELaq4LiCx2S1cjpuBQzhScIdbOa
         cptObyNlp7TzxYkfPrRzB4oz/kkuNJP4wiNMxMd3Vc3oguNDJVqGIRdXiJbaAxhrgPiN
         kglm9Ke5Jaq7znoIeJIpUhgWtPeJyjGWYRqdIAU/EkBMUs7bwttvrLNIU+eQexvEDkvh
         jq0TGfiVOKyPfLvw/As48WZ3I0mmI7MAVMuVwXqnMFyCIwJN2vNF/X9UIcWYChbD8vaf
         tuzA==
X-Received: by 10.224.24.67 with SMTP id u3mr18906121qab.10.1392428417284;
 Fri, 14 Feb 2014 17:40:17 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 14 Feb 2014 17:39:47 -0800 (PST)
In-Reply-To: <CAAErz9gO3NrAF5Zhu277NLqBv-4otQVWGBP6fX00x2OJ3v0_fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242170>

On Sat, Feb 15, 2014 at 8:15 AM, Zachary Turner <zturner@chromium.org> wrote:
> Even if we make that change to use TLS for this case, the
> implementation of pread() will still change in such a way that the
> semantics of pread() are different on Windows.  Is that ok?
>
> Just to summarize, here's the viable approaches I've seen discussed so far:
>
> 1) Use _WINVER at compile time to select either a thread-safe or
> non-thread-safe implementation of pread.  This is the easiest possible
> code change, but would necessitate 2 binary distributions of git for
> windows.
> 2) Use TLS as you suggest and have one fd per pack thread.  Probably
> the most complicated code change (at least for me, being a first-time
> contributor)

It's not so complicated. I suggested a patch [1] before (surprise!).

> 3) Use Karsten's suggested implementation from earlier in the thread.
> Seems to work, but it's a little confusing from a readability
> standpoint since the implementation is not-thread safe except in this
> specific usage contex

[1] http://article.gmane.org/gmane.comp.version-control.git/196042
-- 
Duy
