From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Segfault in "git remote show <remote-name>"
Date: Tue, 26 May 2009 10:27:15 -0400
Message-ID: <76718490905260727v7261391uab169167978e4522@mail.gmail.com>
References: <40aa078e0905250910v268faa66p29a0183db26cb0df@mail.gmail.com>
	 <20090525190121.GA3979@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 26 16:30:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8xfP-0003O1-55
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 16:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbZEZOaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 10:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbZEZOaA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 10:30:00 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:63102 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbZEZO37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 10:29:59 -0400
Received: by gxk10 with SMTP id 10so6633973gxk.13
        for <git@vger.kernel.org>; Tue, 26 May 2009 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ILO8DH1nFy22iweIcZ+bsQMCxPQrHkKrKEnhqj2ehaY=;
        b=Gi/PaP0kpMyluoPHzWnwG5E945fTNh7ydI3kRMK0gCT1aylUbHR/WTt/fYJDChJ39g
         5CC4kyna9xhSXhmsjNL/5s4weG8NurvIUfJ+wV5hyDbHQd8w9650rMGDUGFVwsnx5yPY
         FyfIyxMqZhqOMgvk882mr3GR/dAo2c1tysMYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xtsHrkuOCIRPtNG3xYpy2nvp48rNVYMP7pxHxPxg/z4+N5T/S0+sXlik0ObxXUEAer
         YEZnfTxck4kjYmdI/D7IMfHTnrlTlJamHniiePDxy8AbmsDdDE3xRZ/dhITD79xvly5z
         PSoK3MJvSP+pdtxdhSXUNkaWhsYjpgdP617F0=
Received: by 10.151.69.4 with SMTP id w4mr16935881ybk.135.1243348035586; Tue, 
	26 May 2009 07:27:15 -0700 (PDT)
In-Reply-To: <20090525190121.GA3979@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120003>

On Mon, May 25, 2009 at 3:01 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> Subject: [PATCH] fix segfault showing an empty remote
>
> In case of an empty list, the search for its tail caused a
> NULL-pointer dereference.
>
> Reported-by: Erik Faye-Lund <kusmabite@googlemail.com>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Acked-by: Jay Soffian

> ---
>
> On Mon, May 25, 2009 at 06:10:12PM +0200, Erik Faye-Lund wrote:
>> I've been messing around a bit, trying to set up a gitosis repo to
>> mirror one of my projects. Now, I added the remote to my project, but
>> when running "git remote show <remote-name>", I'm getting a segfault
>> in builtin-remote.c at line 303 ("while (ref->next)"), because ref
>> itself is NULL.
>
> This should fix it.

Thanks.

> I simply copied this from other uses of match_refs. I wonder if this calls
> for a find_link_ref_tail() function, but I didn't know where to put it.

Since the primary use case is in combination with match_refs(),
remote.[ch] perhaps.

j.
