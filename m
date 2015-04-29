From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] rebase -i: redo tasks that die during cherry-pick
Date: Wed, 29 Apr 2015 15:32:33 -0400
Message-ID: <CABURp0odQWJC9LfQMywHKUarKAe7EY45fHET8xVVEsoBYDzBPg@mail.gmail.com>
References: <1430261720-9051-1-git-send-email-hordp@cisco.com>
 <42512fad738e0ec47a8cdb6e6e92e994@www.dscho.org> <xmqq7fsu6ek4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phil Hord <hordp@cisco.com>, Git <git@vger.kernel.org>,
	Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:33:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnXj9-0006tC-B9
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 21:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbD2Tcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 15:32:54 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33025 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbD2Tcy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 15:32:54 -0400
Received: by iecrt8 with SMTP id rt8so50858352iec.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PC1TVyd/VRDq/DpefwfgEPQ2a3h6oWEezgwij1WaPx0=;
        b=0LFYuf08fwQpFltsD6tGgQG4XaICSJkXR2KDNa+pT8j/dB2xamuOuwbo6CSyjUkxiD
         0KD2JyzKBu05FszHo+h+4Dg0Ii94/OvpDz+ZVsY+W8x4gZSEREJGz0kwVJwXun/z3uNy
         5Z22fYCkPxu26z86DTMzVKCSHXkruXX3L/7k/A4BLQQ0OcMwZDTGBsKRxXiQRxVSIP/b
         zmhEKJ3PmableSwFMNz5Tz/RzlOILJx4WkLbLMh9Vq6RQi8LUWgAO6jAYt0nxnH1JWgn
         RmL/2B3mvc/OJml2A3krXwkaJRLFfA4tivmTRzl2sWMKaftpPRKV7MzXyoJtCrurY5YR
         nP8Q==
X-Received: by 10.50.30.202 with SMTP id u10mr6453595igh.28.1430335973435;
 Wed, 29 Apr 2015 12:32:53 -0700 (PDT)
Received: by 10.107.139.202 with HTTP; Wed, 29 Apr 2015 12:32:33 -0700 (PDT)
In-Reply-To: <xmqq7fsu6ek4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267993>

On Wed, Apr 29, 2015 at 1:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks, will queue.
>
> Aside from the "much more invasive" possibility, the patch makes me
> wonder if it would have been a better design to have a static "todo"
> with a "current" pointer as two state files.  Then reschedule would
> have been just the matter of decrementing the number in "current",
> instead of "grab the last line of one file and prepend to the other
> file, and then lose the last line".

That's an interesting idea.  Changing it now would impact anyone who
now depends on the current todo/done behavior, and I imagine there
are many.
