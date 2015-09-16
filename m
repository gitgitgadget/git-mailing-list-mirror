From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Wed, 16 Sep 2015 15:54:50 -0700
Message-ID: <xmqqpp1ikm9x.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915161619.GN29753@sigill.intra.peff.net>
	<xmqq8u86m2i4.fsf@gitster.mtv.corp.google.com>
	<20150916223901.GA24945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:54:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLbM-0007fc-H0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbIPWyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:54:53 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33893 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbbIPWyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:54:52 -0400
Received: by padhy16 with SMTP id hy16so1027444pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sp1tnWv1SibqywG7KKmkz++Hgdqpm5+CCfQ7XJZc3EU=;
        b=wKukkCVrq/6xUZz5VvFL++7Zrz3sZgpwUlNg/pMMm5sn3fZjvgtq/ZqWfjSVgpN+1N
         EPjcI9RFUIAtZprmtUkrjSkuMfVEw/O4gZEqYeP0oyfnc8Z+S0jYuEW6Sp3vvrUg9DUi
         zY6j/1UZFXCzXoxlfnhUsPhOWAKa2sIwO8yeNrmJ/xsmca9/CignKM+hGhPBgRqmqbKT
         vsdXrE8uayiGqeYCjCA4FpIsB0GSMMhFWcf3UuW/o2FxbmRGn1bhyJVtSuQmKlZl13Jy
         19O3zFpHgU5JEf2pZR/+b0H+UfbqgXCCx8RsZw4FtNV7aGOBpbAUM7wcpAShA2SOvJId
         CQkg==
X-Received: by 10.68.250.5 with SMTP id yy5mr64716937pbc.34.1442444092052;
        Wed, 16 Sep 2015 15:54:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id bi2sm184544pbb.45.2015.09.16.15.54.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 15:54:51 -0700 (PDT)
In-Reply-To: <20150916223901.GA24945@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 18:39:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278084>

Jeff King <peff@peff.net> writes:

>> Is this conversion correct?  This seems to me that the caller wants
>> to create an IMAP folder name immediately under the root hierarchy
>> and wants to have the leading slash in the result.
>
> Ugh, you're right. This is the "other" style Eric mentioned earlier.
>
> This looks like the only one in the patch (there are many that did not
> check buf.len at all, but if we assume they were not invoking undefined
> behavior before, then they are fine under the new code).

Yes, I should have said that earlier to save one roundtrip.

Thanks for working on this.
