From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Wed, 19 Mar 2014 17:17:18 -0700
Message-ID: <20140320001718.GM15625@google.com>
References: <20140314235735.GA6959@ibr.ch>
 <20140315001855.GK15625@google.com>
 <xmqq61nceidp.fsf@gitster.dls.corp.google.com>
 <20140318221844.GA828@google.com>
 <xmqqfvme5cql.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQQfm-0000Ep-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 01:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbaCTARW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 20:17:22 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62206 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174AbaCTARV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 20:17:21 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so103162pdj.12
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sWGiVdnPAxICvqRdkBAkfIl8WU3tlWEp1qPN1pqny4c=;
        b=raulvDw948rkikBASL38q8p4OyKc+DxsT4BwfraC5KPGH3OpjKMgM8+MH8zUeCYBx5
         GHedPylOyKNzAb28n0zhXe7Ijdv8YYn9TCw3KqDBiPjfVDEuGoZuQ8Wi+6ZdqiH3Hk9c
         ARSm5MxeOD5dkYykJBmyifi/IMPS0z8pvnWrtsDwJmkojcp1EGR3ognZ/xrKGdcKYH/W
         TxZbCVzAKEmnrwexHavA5tWWOqw5hXQCwPW1N5nLpJGipRg3bdeSD/m1mu8UU6Y5162K
         H8rpLtjZUaNUKzT7cIvcc37I9jlrF15A+UVcKrEmmouW7Jwyo0lY/M7Wth0PiAafhuBp
         GyiA==
X-Received: by 10.68.60.131 with SMTP id h3mr42891782pbr.50.1395274641326;
        Wed, 19 Mar 2014 17:17:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vg1sm217938pbc.44.2014.03.19.17.17.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 17:17:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvme5cql.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244511>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> We currently use "echo" all over the place (e.g., 'echo "$path"' in
>> git-sh-setup), and every time we fix it there is a chance of making
>> mistakes.  I wonder if it would make sense to add a helper to make the
>> echo calls easier to replace:
>
> I agree that we would benefit from having a helper to print a single
> line, which we very often do, without having to worry about the
> boilerplate '%s\n' of printf or the portability gotcha of echo.
>
> I am a bit reluctant to name the helper "sane_echo" to declare "echo
> that interprets backslashes in the string is insane", though.  For
> these "print a single line" uses, we are only interested in using a
> subset of the features offered by 'echo', but that does not mean the
> other features we do not want to trigger in our use is of no use to
> any sane person.

In a portable script, uncareful use of 'echo' is always insane.

In a script tailored to an environment where echo behaves consistently
it is perfectly reasonable to use 'echo', but that's a different
story.  In the context of git, saying "Here is the thing you should
always use instead of echo" is a good thing, in my opinion.

Hoping that clarifies,
Jonathan
