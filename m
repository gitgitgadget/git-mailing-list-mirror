From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 12/13] tag.c: implement '--format' option
Date: Mon, 17 Aug 2015 12:04:59 -0700
Message-ID: <xmqqwpwtd9d0.fsf@gitster.dls.corp.google.com>
References: <1439661643-16094-13-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:05:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPiX-0002bX-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbbHQTFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:05:03 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33589 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbHQTFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:05:02 -0400
Received: by pabyb7 with SMTP id yb7so114335971pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ukluiW4uhISeiUbIB1UrxKcGoezGW7wovpPXavg3rfY=;
        b=SIXIsE4UPyo91kpnfcjvup97oYF60QZ7+X+QO/Bwv70x14XqvIzJyixNpeiiujjygn
         OHDoNQwIhyHkRZG2KU226/ucsENTiaEHyRifv+DVoQBsfgB1rc3WCpvDVNrEstr1oAnr
         d/cnkSItv4W2NIr+7ntVtoHbb8VLA5izN/tXL/16IhIAak+0VDkPxAOHmpk0o5Z3fdpZ
         PNDD8RjzRxOnXWEFaTnJG6rYEx+bJ61W9p2SUqy3tzJG9RSkpaLo/pATOdQk8YC3vjoA
         Z6yH5X+SjBCPyuYap4xlzasBAMYLC7dCiMJq1R4+lh/jn53NAaBYOi5lNF88sGYsjLo5
         wp0Q==
X-Received: by 10.68.111.165 with SMTP id ij5mr5290104pbb.59.1439838301463;
        Mon, 17 Aug 2015 12:05:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id v4sm15502519pdg.79.2015.08.17.12.05.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:05:00 -0700 (PDT)
In-Reply-To: <1439661643-16094-13-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 15 Aug 2015 23:30:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276075>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Implement the '--format' option provided by 'ref-filter'.
> This lets the user list tags as per desired format similar
> to the implementation in 'git for-each-ref'.
>
> Add tests and documentation for the same.

Hmm, do we want "--format" added to "tag -l" and "branch -l" in the
first place?  Scriptors should be using "for-each-ref" plumbing in
the first place, and the point of unifying these three is to share
filtering features among them, which would make "for-each-ref" able
to express what the other two can do.  I'd hesitate to add too much
flexibility to "branch -l" and "tag -l" Porcelains to entice people
to script around them.
