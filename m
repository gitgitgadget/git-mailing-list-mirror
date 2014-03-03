From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] commit.c:record_author_date() use skip_prefix() instead
 of starts_with()
Date: Mon, 3 Mar 2014 14:52:56 -0500
Message-ID: <CAPig+cQrnKRDo88qq=3Ujjjwv0rn4H+eovAeAnmODUDPr00m8g@mail.gmail.com>
References: <1393703299-7977-1-git-send-email-tanayabh@gmail.com>
	<53144450.3080006@alum.mit.edu>
	<xmqqmwh7qg6v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYvA-0000G5-Up
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbaCCTw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:52:58 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:50294 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120AbaCCTw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:52:56 -0500
Received: by mail-yk0-f172.google.com with SMTP id 200so11701038ykr.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Tn2jVLRLlg8EPnKMjDcpZrEKvpwsMK5qPThTVedkqU=;
        b=lkg/+ECUohsnRj4IERWF+lc+QhPGKdJVqIgW4Pf9j+wm5bGHMy25to3/xd9/QHKikR
         6Ezdks3TuGoRbgzDEJdWCz6e/qLl6RRL6iNPDDV14by26rQUh/H7oIDpfTSk2YwsXs/E
         uUjUK9ajiDBvvGOQuy4M5KXj7d5SSCxdSXO3wzFKxsRY1uFX62rYlomXHJhoaM5bxAse
         xOtihFex60Gg4HnSsuEjhWw6vukFFcv4ALFGMWZ3E+0v5FO+QmYby5jszOb/yius5W8p
         DAxSXQQR3oDsUFsZTSx98B56hhMVgFocB2ks1M53U792aVRXHnd8q0swTv4OgPaiVvJ/
         I4+A==
X-Received: by 10.236.74.73 with SMTP id w49mr3563947yhd.87.1393876376274;
 Mon, 03 Mar 2014 11:52:56 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 11:52:56 -0800 (PST)
In-Reply-To: <xmqqmwh7qg6v.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: RJ6lx0ln-6yL4qWRbdvHpzeYhDM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243263>

On Mon, Mar 3, 2014 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>>> -            if (!starts_with(buf, "author ")) {
>>> +            if (!skip_prefix(buf, "author ")) {
>>
>> If this is the only change, there is not much point, is there?  How does
>> this help?  Perhaps there is some way to take advantage of the
>> difference between starts_with() and skip_prefix() to simplify the rest
>> of the function?
>
> I admit I lost track, but wasn't there a discussion to use
> starts_with/ends_with when appropriate (namely, the caller is
> absolutely not interested in what the remainder of the string is
> after skipping the prefix), moving away from skip_prefix()?  Isn't
> this change going in the wrong direction?

Yes, it would be going in the wrong direction if this was all there
was to it, but the particular GSoC microproject [1] which inspired
this (incomplete) submission expects that the potential student will
dig deeper and discover how skip_prefix() can be used to achieve
greater simplification in record_author_date() and in other places in
the same file.

[1]: https://github.com/git/git.github.io/blob/master/SoC-2014-Microprojects.md
