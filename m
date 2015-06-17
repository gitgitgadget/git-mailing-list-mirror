From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib.sh: fix color support when tput needs ~/.terminfo
Date: Wed, 17 Jun 2015 13:15:30 -0700
Message-ID: <xmqqvbem5bx9.fsf@gitster.dls.corp.google.com>
References: <1434567986-23552-1-git-send-email-rhansen@bbn.com>
	<1434567986-23552-3-git-send-email-rhansen@bbn.com>
	<20150617194315.GE25304@peff.net> <5581D099.7090200@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JkH-0008PD-4x
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbbFQUPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:15:33 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35994 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbbFQUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:15:32 -0400
Received: by igbiq7 with SMTP id iq7so76115307igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=g2fjL76Bt+S2tFDFYfV/oAjhSxpJgVdRwocGXtilsCM=;
        b=g7834NM8/dRO2pNL9Xdfsel3Qbi/MYXRkGIBqI/nGmYQbHa0stXkw4aVgkmod5Ria9
         j957rpNLE23bn7c2ZmYHkLgY740yTXt8VPA+tTVVvvhjIqySqU3RZKDWBFH4Ko2AA84a
         xwwIdeV9ppDObgnsWEpm4uayfckYks/6TKFHV2X9ByPLArcgHbgtxKCv9bH8LoiJ2zms
         7bWcuCYbQb/F3bkVQHEvX2hBHBBlwNd6MM4x7u1wOzlK1P/Hg41hiX7C5z+BTVq4Zw4Y
         h/oz/CLLY6GwYn+CLX3v4LZ2EGwcIEQVQ3bq9gFtepDhMyWuQLGO5KkLwBQchGHp57ke
         rRUQ==
X-Received: by 10.50.143.104 with SMTP id sd8mr37592405igb.14.1434572131809;
        Wed, 17 Jun 2015 13:15:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id h10sm3274993iod.44.2015.06.17.13.15.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 13:15:31 -0700 (PDT)
In-Reply-To: <5581D099.7090200@bbn.com> (Richard Hansen's message of "Wed, 17
	Jun 2015 15:55:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271906>

Richard Hansen <rhansen@bbn.com> writes:

> We could test if the variable is set first (test -n "${foo+set}"), at
> the cost of a bit more complexity.
>
>> I do not mind it so much as you have
>> it, but it does mean adding a new field needs to update two spots.
>
> I also don't like the duplicate list of color types, and I considered
> doing something similar to what you suggested, but I decided against it.
> I'm a bit worried about bizarre syntax errors or code execution if
> say_color() is used improperly.  ('eval' with uncontrolled variables
> makes me nervous.)

I originally had the same reaction to your use of `eval` (with or
without being guarded by the case to limit to known 5 ones).  But
the uncontrolled-ness of this use of eval is to the same degree of
uncontrolled-ness of any test_expect_{success,failure} scriptlet,
so...

I like this "save to variables instead of using tput" approach very
much either way.  Well done.

Thanks.
