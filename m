From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 22:45:02 +0530
Message-ID: <CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-5-git-send-email-artagnon@gmail.com> <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
 <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com> <7v61ymop61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 19:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbwLn-0003f4-PK
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 19:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab3EMRPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 13:15:47 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:65072 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3EMRPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 13:15:46 -0400
Received: by mail-ia0-f181.google.com with SMTP id y25so2386987iay.12
        for <git@vger.kernel.org>; Mon, 13 May 2013 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VYJBj+gUCR4MTTe5nhaX43A+w3LvgRbtN7VPkSQ42UA=;
        b=VAmssI5jKPZjpHfWT4oN39AYTik7aEbHslynCyTS+q9zgNA70UgqnpJptYuxnZ35v1
         60z8svrCHCmXVreNJ1144Rg3KcI7Io1WOuuQ3eizrVAmB4qt96lx53mNVBE8/DyNZSJH
         FAhz58voyuswONzPr8Ouj0nj0NIn0LibOJRNoPic1BkOHwS6p47A7TEdA8gmb5G7mIdn
         E4PzwFUsRbU7nKrXLOARwdcPNQ+vSb96rqb3yC+vcVKc+zO1bJu4zdmPWZLVU+PRK54R
         seUtmjoMZHiXj7jVS7FjRjJNLS05t2D38zSDIUf6dbNAv91rAsiRm4Peflr5xYyicL8n
         kE2g==
X-Received: by 10.50.73.65 with SMTP id j1mr10887821igv.49.1368465346398; Mon,
 13 May 2013 10:15:46 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 10:15:02 -0700 (PDT)
In-Reply-To: <7v61ymop61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224180>

Junio C Hamano wrote:
>         git stash store [-m <message>] [-e <error message>] $stash_sha1

1. The message is NOT optional.  If the user says 'git stash store
b8bb3fe9', what "default message" can we possibly put in?  There is
absolutely no context: no branch name, nothing.  So, the best we can
do is "generic WIP".  What is the point of putting in such a useless
message?

2. We have already determined that the command is NOT for end user
interactive use.  So, why do we need a default error message at all?
The last statement is an update-ref, and you can infer whether it
succeeded or failed from the exit status.

3. Why are we designing a command-line interface?  git stash store
"$stash_sha1" "$message" is sufficient for scripts, and there is
absolutely no point in parsing '-m', '-e', or any such thing.
