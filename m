From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 09:12:04 -0700
Message-ID: <xmqq8uaazu3v.fsf@gitster.dls.corp.google.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRXsmi=UxRr-3rnt919d86jD6uMuTqdDxCComYLXk1TYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 18:12:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHDfy-0002X9-8c
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 18:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbbGTQMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 12:12:13 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32787 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbGTQMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 12:12:07 -0400
Received: by pdbnt7 with SMTP id nt7so32923964pdb.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZT25OWKA4X+SN3xLU9ryMUkGnBl6He7D8w0y1UmI5yE=;
        b=cajf4Rb0Rx5eftlv1ytuZlwKUWtCShG7xniiOsUTXxQKLYR4y6N2AAtSiOw+gvnqpU
         oLalKn9jVy9Fisxmx96NWT0aHVdenCYBXPSFeqs++nl9eWAjXLWEX0S6+p+Fv42ejvwk
         c9fLFXrDnZY0Ri+w0e6Hmd1EBHM21LIC8mZmxitk2eMNdJmBZDyobnx9u4uEscIezR/n
         lnRLs/66vLmmm2zbHXdV8MbrZ1Ze2Kt7WEJGIeAeSz1uKh/+JxNRQ7+B0TV0DJ7dPOFh
         9V3SMgQHe5ZbzV5YoSh3q52o6xKGSdt3qalaHtkfYBEuAX3YKXoUDOvn7vWg1MB7OvzH
         4ozA==
X-Received: by 10.66.102.103 with SMTP id fn7mr62315781pab.85.1437408727168;
        Mon, 20 Jul 2015 09:12:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id o8sm22587742pdp.70.2015.07.20.09.12.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Jul 2015 09:12:05 -0700 (PDT)
In-Reply-To: <CAPig+cRXsmi=UxRr-3rnt919d86jD6uMuTqdDxCComYLXk1TYw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 19 Jul 2015 19:49:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274328>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a new atom "align" and support %(align:X) where X is a number.
>> This will align the preceeding atom value to the left followed by
>> spaces for a total length of X characters. If X is less than the item
>> size, the entire atom value is printed.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7561727..b81a08d 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -53,6 +55,7 @@ static struct {
>>         { "flag" },
>>         { "HEAD" },
>>         { "color" },
>> +       { "align" },
>
> Not a new issue, but some compilers (Solaris?) complain about the
> trailing comma.

Hmm, are you sure?  I thought we avoid trailing comma for enum
definitions, but not a list of values like this.
