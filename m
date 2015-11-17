From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Tue, 17 Nov 2015 21:17:43 +0100
Message-ID: <CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net> <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net> <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de> <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 21:18:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zymhn-0003yD-IE
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 21:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbbKQUSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 15:18:15 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35208 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbKQUSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 15:18:14 -0500
Received: by lfdo63 with SMTP id o63so12977612lfd.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p22K7vyvI1Xp1Z4dC65EoOS+ecAD0BaMk4e+0HSnmDU=;
        b=qsCMm0E762blx1Moxtwktde/hstpFpEvQDut9Khpf90ceFEZTa/fRxtjS1j9qOoyUH
         v3vuwmExJeGWFFXX+lcbAGaKrI11He8Hoxe8LQRNIOFsx3rYWO1ZgdngCOvJ3MfLnriJ
         11TXkwhfMbSj/1LjQ1y/H8ZiA1Gny3RT1xgpcKEVP2YYfwOlkD++L5KP654v4mZoOSYU
         FZ1albY2AcfyySOpMWuSLDxGwcudaMxQRjKXsykpZw8ziD27eUIMXBIivlKoCNe0z8Jd
         dwa5M8bseZ48TAnsknUD60WlYnz7uz7WPpc1LqBzyumY3P0lBcIDFlH6WhJr/0IYcJHB
         L7GQ==
X-Received: by 10.25.126.5 with SMTP id z5mr20637572lfc.112.1447791493073;
 Tue, 17 Nov 2015 12:18:13 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Tue, 17 Nov 2015 12:17:43 -0800 (PST)
In-Reply-To: <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281416>

On Mon, Nov 16, 2015 at 8:25 PM, Stefan Beller <sbeller@google.com> wrote:
> Instead of having to search all branches for the requested sha1, we could have
> some sort of data structure to make it not an O(n) operation (n being
> all objects
> in the repo).
>
> Maybe I overestimate the work which needs to be done, because the server has
> bitmaps nowadays.

Quote from [1]

> If we take the kernel history in rev-list and pick two commits that
> are roughly ~10,000 commits apart from one another, JGit can compute
> the rev-list --objects between these two commits in about 120
> milliseconds (git-core should be faster, or at least comparable).

I think we should be fine (note that --objects is a lot heavier than
commit walking). Though.. I just tried it on git.git. 10k commits
(without --objects) take about 200ms with C Git..

[1] http://marc.info/?l=git&m=133374018207891&w=2
-- 
Duy
