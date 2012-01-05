From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] More on pulling signed tags
Date: Wed, 4 Jan 2012 16:30:43 -0800
Message-ID: <CA+55aFxuHjADrnT4METD=JRqhO0L1tKv=_pB9aOODbokM7rd-g@mail.gmail.com>
References: <1325715058-11984-1-git-send-email-gitster@pobox.com>
 <7vsjjvnh4e.fsf@alter.siamese.dyndns.org> <7vobujngl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 01:31:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RibEd-0007E9-HV
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 01:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab2AEAbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 19:31:07 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:59037 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab2AEAbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 19:31:05 -0500
Received: by mail-we0-f174.google.com with SMTP id m1so1632wer.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 16:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=JRMfeykMp1VLi7Ftf2TkuaFu5RH+yCBR2PJop/VAacU=;
        b=QrUa8ER1TDQzoRo+TuB3RJ1YUEbzG6YTNFF23T65Hbn7lrPdt90Z31c1zigxJ2Eo72
         iTAVg2CMlhH6lWr+/X7P2It8o5LHpPqCDffDNwBvQYTZTja4eJvJW45K6X5lugSXSkSV
         4vo27S6OpGkiZPI2alKm0RtfLaiiZZVNd37i8=
Received: by 10.216.133.198 with SMTP id q48mr112192wei.22.1325723464634; Wed,
 04 Jan 2012 16:31:04 -0800 (PST)
Received: by 10.216.172.213 with HTTP; Wed, 4 Jan 2012 16:30:43 -0800 (PST)
In-Reply-To: <7vobujngl3.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: c0xXnL5jg_d5sT2kaXNKphOqSD0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187959>

On Wed, Jan 4, 2012 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> ... and this is a fix-up patch on top of the series. With this, the output
> becomes like this:

Looking good, this is very useful. The hacks to extract the signatures
with 'git cat-file' were pretty ugly.

This is also nice for the case where the person doing the merge
doesn't yet have the pgp key something was signed with, so when you do
the "git pull", you get the "unknown key" thing instead of a "good
signature" message in the editor buffer.

It *used* to be the case that you had to abort the merge, fetch the
key, and re-pull in order to verify the key.

Now you can just say "ok, I'll commit the merge" and finish up, then
fetch the key, do "git show --show-signature", and if it doesn't show
up as good (which would be very rare) you can then 'git reset'
instead.  Which while less anal, is a lot more convenient.

                    Linus
