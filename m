From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Tue, 12 May 2015 22:48:36 -0700
Message-ID: <xmqqvbfxauyz.fsf@gitster.dls.corp.google.com>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
	<xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
	<20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
	<20150513013637.GB3066@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 07:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsPX9-0006VM-1t
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbbEMFsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:48:38 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33106 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbbEMFsi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:48:38 -0400
Received: by igbpi8 with SMTP id pi8so108632642igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RvD3xIdTFfHGAZ20eU5lB9VtezX8rUi7rPW/Q16WGBo=;
        b=B/ocycvz3+WzHxnRvcnfuMnGzUr128Ha/wHOv2qGAZp8q4o8+DR/8WEj8UdUEPPgiU
         VIO8blLzKDkMWhT2DKdPLrL7SlymBA6+04E12jcMbnAdWpm6c1J04J55wt6N2Tw6AJvX
         iWyQzV0LSx2FfMrkMkMmLps16RBmbakW3fyZgWbWpXaLfUHUbwRMYht6A3w5dTEuj2hF
         HLHn0hjAAZ77M2ddzb/LpGWu8G8SEc7/kr0D1/XymdvO7vN7JxDUMl6EVnn5I0brpCgG
         2d5Zepgvj0uWZHcspVfD3iaqLJeZKc18OO0jZf5SSWobvFkc5fNs2GtIkr/aMCKXecIp
         bHBw==
X-Received: by 10.50.43.137 with SMTP id w9mr1184591igl.30.1431496117802;
        Tue, 12 May 2015 22:48:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id fm3sm2914892igb.1.2015.05.12.22.48.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 22:48:37 -0700 (PDT)
In-Reply-To: <20150513013637.GB3066@peff.net> (Jeff King's message of "Tue, 12
	May 2015 21:36:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268938>

Jeff King <peff@peff.net> writes:

> Of course, that is not a guarantee that nobody scraped stderr, but at
> least it makes me feel better that they're Doing It Wrong. :)
>
> It would be nice if we had some actual data points. I followed the link
> Christian gave to Ingo's old post, but I didn't see the actual script
> there. There is:
>
>   https://github.com/grosser/git-autobisect/blob/master/lib/git/autobisect.rb
>
> which does seem to scrape stderr. Bleh.

Heh, anything ending with .rb is a bleh to me ;-)

>> So perhaps if we keep
>> 
>> 	<40 char sha1> is the first bad commit
>> 
>> and then replace the diff-tree output with "show -s", then the
>> result would be good enough, I would say.
>
> That seems like a reasonable first step, at the very least. I wonder if
> we should also better document the exit code and BISECT_LOG semantics,
> and explicitly tell people not to scrape stderr.

Yeah, that would also be a good first step, whichever comes first.
