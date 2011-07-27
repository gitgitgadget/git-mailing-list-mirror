From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/18] revert: Save data for continuing after conflict
 resolution
Date: Wed, 27 Jul 2011 17:56:54 +0200
Message-ID: <20110727155654.GB29924@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-12-git-send-email-artagnon@gmail.com>
 <20110727050220.GG18470@elie>
 <CALkWK0=uA1ZRsmiVwmx_3HXL-v+Bi-ONPEk5kMsh1RG0ZeVQJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6Tw-0004zP-5O
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab1G0P5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 11:57:07 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:37701 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1G0P5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 11:57:06 -0400
Received: by eye22 with SMTP id 22so2054105eye.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E0CBefRcm9InBDYKF72S8ZBnQW51w8ggALnoX+vDy0Q=;
        b=Wyq44um0fKONako8LdwXe/2da+mhbX43Gyn7K+j5+l1bfcehoRdQDNMq7EHJPP1tBu
         y1wEDREU+6FsB7+uoVK9CKovBPdsUzbcHCxiFW5MWAQBZDKQeTxv8+e4cuMtZXC24V1a
         8vsWfA+I7Z98B8SYC0nQVzLgjrc/jvpaz4dq8=
Received: by 10.14.53.68 with SMTP id f44mr70364eec.180.1311782225022;
        Wed, 27 Jul 2011 08:57:05 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id v11sm3279eev.59.2011.07.27.08.57.02
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 08:57:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=uA1ZRsmiVwmx_3HXL-v+Bi-ONPEk5kMsh1RG0ZeVQJg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177979>

Ramkumar Ramachandra wrote:

> Junio complained about the warnings here [1], so I added MAYBE_UNUSED
> to suppress them temporarily.  Would you really like to see
> read_populate_todo and read_populate_opts being introduced MUCH later
> in the '--continue' patch?
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/176899

Hmm.  Yes, I suppose I would.

But as usual, what is relevant is not what I would like but what leads
to clear, functional, and maintainable code.  It is from that point of
view that the MAYBE_UNUSED is most problematic --- it suppresses a
useful and true hint when compiling that the codebase implements some
functionality that has no user.  For example, the warning would be
triggered if the function gets renamed and added again and this old
version is forgotten.
