From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/10] ref-filter: add option to match literal pattern
Date: Fri, 10 Jul 2015 09:43:06 -0700
Message-ID: <xmqqfv4wklph.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDbOM-0007UK-MO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 18:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbbGJQnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 12:43:10 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36218 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbbGJQnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 12:43:08 -0400
Received: by igrv9 with SMTP id v9so16750569igr.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=On4+9wN14fIBazpnGZ425KNie9x9S3ZwmRNJrouwyk8=;
        b=ynj4sFJSvXb8ilaPKJUfJJ+nvcgpTPN3ltN0icDpBGHV3O56jN0ZhtM7Bba9cNM5Cb
         VN6sOmJsycqgwMVJ0pNPwaSihnF0NMRYgKyPQY1v7C+hbokSJvhzTmaH5hjtn1nd4CNM
         pi4uwr+WTmtKE0gYHzjUhk96oxM/bst5n0PppubAOCKIuNht9ZNcn/HWqyxp+jkA8rPG
         0A24JeIEZAY6JY2VjDFvdQprWzZ15tWYCtjyG3l9VXO2u6guy/uEYvnU2yK4K28BFXdZ
         x2KLMzhsVw+EXNAhibQVcNXvpVc6fHNIYKTe5hdbJT1YBvz0V+rNEb2Ffw7U9yTyx7Me
         WEXA==
X-Received: by 10.50.72.41 with SMTP id a9mr4018215igv.51.1436546588211;
        Fri, 10 Jul 2015 09:43:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id qs10sm1725465igb.14.2015.07.10.09.43.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 09:43:07 -0700 (PDT)
In-Reply-To: <1436437671-25600-5-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 9 Jul 2015 15:57:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273823>

Karthik Nayak <karthik.188@gmail.com> writes:

> Since 'ref-filter' only has an option to match path names
> add an option for regular pattern matching.

There is nothing "regular" about the pattern matching you are
adding.

Everywhere else we use patterns on refs we call wildmatch(), which
is an enhanced implementation of fnmatch(3), and you are doing the
same in this new codepath.

Just drop that word from here (and if you said something similar in
the documentation, drop "regular" ffrom there as well).  It would
invite confusion with regular expression matching, which we will not
do for refs.
