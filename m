From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Thu, 17 Sep 2015 08:45:14 -0700
Message-ID: <xmqq37ydkq2d.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915161619.GN29753@sigill.intra.peff.net>
	<xmqq8u86m2i4.fsf@gitster.mtv.corp.google.com>
	<20150916223901.GA24945@sigill.intra.peff.net>
	<xmqqpp1ikm9x.fsf@gitster.mtv.corp.google.com>
	<20150916225700.GA26015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 17:45:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbNE-00047h-Db
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbIQPpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:45:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34140 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbIQPpR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 11:45:17 -0400
Received: by padhy16 with SMTP id hy16so23093994pad.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TR+9HqOa0KXdORZefpF0r+90x5bW3xKR+x/PRZRU1YM=;
        b=n0xCNf2o3aZ7OpHS9oKJfxYeqANsI8OcvzHyRq6BDxiOEia6vLwGY/TW8imaIdpmAs
         BYqIH44wVXVyFJWHWstqxzLXvvxe55dHg3+GlSlg8K5PdfNzueW+EDEhWJ9YOotmMQaY
         cI58u/QHIvQ76YrFbR8g+f/WU31WQmJaOGwaO5CnlxPWd8GOKDj7Xt1KiUiumDrSpWlk
         kGVcu0Vq9gCG9E6rM7m4dq1uwfN5GPysVdJF+V/+vgeQz2Jkf+m/Pg5sa7FzpNWkLsIm
         ZcumEyXY3+gwC8FO+P2TV2PCUCUcUdsv4JLn4iXg5BQUZflO++/4BpOC4ixhzNYS4tCp
         D2rw==
X-Received: by 10.66.97.73 with SMTP id dy9mr4675884pab.115.1442504716589;
        Thu, 17 Sep 2015 08:45:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id jv5sm4167531pbc.47.2015.09.17.08.45.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 08:45:15 -0700 (PDT)
In-Reply-To: <20150916225700.GA26015@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 18:57:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278125>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 16, 2015 at 03:54:50PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> Is this conversion correct?  This seems to me that the caller wants
>> >> to create an IMAP folder name immediately under the root hierarchy
>> >> and wants to have the leading slash in the result.
>> >
>> > Ugh, you're right. This is the "other" style Eric mentioned earlier.
>> >
>> > This looks like the only one in the patch (there are many that did not
>> > check buf.len at all, but if we assume they were not invoking undefined
>> > behavior before, then they are fine under the new code).
>> 
>> Yes, I should have said that earlier to save one roundtrip.
>> 
>> Thanks for working on this.
>
> For my re-roll, I've just omitted changing that caller. I think we can
> leave it as-is; it is not worth trying to introduce a new helper for the
> one site.

Yup, I think the decision is sensible.

Thanks.
