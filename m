From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v2 00/23] backend-struct-db
Date: Wed, 13 Aug 2014 14:55:45 -0700
Message-ID: <CAL=YDWkg1D1JyBhT0Jr4ur+fv3rp9tGm+a-gSYBaixaAHKQ_EQ@mail.gmail.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
	<xmqqmwb82im7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:55:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHgWM-0001Dj-PO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 23:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaHMVzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 17:55:47 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:54382 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaHMVzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 17:55:46 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so478646vcb.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MI6DtVSpxOI1xeAlQzY0zEeH0r04vsf4XiQ4XyBIVaM=;
        b=PwLXieBjcHsCnmvvoOFvv0DMmCKj4jGv+D8SPwO4q5WVKCO/6pnufWG6LtpguPzPB8
         hquLbQOAzm0wyEp+EGMLooMzuhpl5hMZ8jH/3HavF9hwKb4EwFfj5VqGZayOTOR1Ar5c
         NpFBgi9gVQORsPhx9FZLN9QhyQnZYXPGW7BvIjDYx6eDY7Q/aqjouACypqzKsCMS4dnA
         CjUW8gUe9v63f9YGA4S9V4/vlRqCsDSBsaNGuM/zhNGRBWWpVbvthRQH/1aKiOo3T6Dp
         kEosfnGsOhhp3H6Kj1PCBQe1mLibQLNcFAy5KbbANb87KFuwZRT+9Je7ZtYzggk+g053
         FOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MI6DtVSpxOI1xeAlQzY0zEeH0r04vsf4XiQ4XyBIVaM=;
        b=XwrAYxh7+O8yr5w4z2hmVhw0p+MdGgFLFsPC6x91RPdn9642Oef7/iXV5fdcbsiHjp
         FSZoWamEx5UP5WucKgceoxj221YULCWxgacEMuAzkKlgcmEcjwJZONwhNQmXsSMEUHjV
         yzq4LsAiHg/8rqwU2EuaMQwP87SLoOqysmCjoKAfkoks14Nb1AjT63E4dcADikAC6TGR
         wBIZ+jbe7StEl4dobnSzwO7OfGbBSGdVOtPmZZ34nXOnfTmoHoE5ZHowUDgI8BUOIoqY
         NgXjp0bOhebngQSvMUy3K20DuQWz3zz4rAeqUsfjDsTsJ16JTpmAklfcMbqyxgJBwUbz
         g8fQ==
X-Gm-Message-State: ALoCoQnJ7Ibbi1IJKYtRC02qb01R7xJuOSHjsDYdI5NnqgGuMPQzMxkwOPwoYO1TxcmbTXdXCZ0D
X-Received: by 10.221.56.5 with SMTP id wa5mr326386vcb.25.1407966945790; Wed,
 13 Aug 2014 14:55:45 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Wed, 13 Aug 2014 14:55:45 -0700 (PDT)
In-Reply-To: <xmqqmwb82im7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255254>

On Wed, Aug 13, 2014 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> 15 of the patches, the refs-common.c patches, focuses on moving all backend
>> agnostic refs functions to a common file. This file will contain all
>> backend agnostic refs functions.
>>
>> The last 6 patches adds a backend structure with the methods we need to
>> describe a pluggable backend. Currently we only have one built in backend,
>> the current files based backend. These patches do not change any of the
>> behavior other than that we now call the methods through backend specific
>> wrapper functions rather than calling them directly.
>>
>> At this stage we now have a defined set of methods needed for a refs
>> backend and we can start building and adding new types of ref backends
>> to git.
>
> Very nice ;-).
>
> I would have expected that refs.c would be the generic one and refs-be-*
> would be the backend specific ones, though; that way you do not have to
> introduce a new file refs-common.c at all, no?
>

Makes sense.
Let me do those changes and then I will re-post sometime next week
once I get additional feedback on it.


regards
Ronnie Sahlberg
