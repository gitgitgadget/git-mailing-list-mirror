From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fast-forwarding tags
Date: Wed, 25 Sep 2013 12:28:20 -0700
Message-ID: <20130925192820.GZ9464@google.com>
References: <20130925113651.GA19023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOulB-0004Gk-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab3IYT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:28:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63368 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3IYT2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:28:24 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so263472pad.16
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1K6/tNb6ys1ZfKsOZL0AAQB7RVD3w7NWgE6QRrzjMdk=;
        b=nq5dfY0+VF1ktV64PHHdIWS7gW/7qOaD1G5xJifS2B3mhfVntvUj5bw15K3BPXfc/d
         Ph7WrBldfHja9tRNsbZzrPKmpx4r6+Wg+4M0Xbz+b0mwc/3z5CocAsr8aldgHNRjs7vy
         GIsc8+qerr5RmQo34VrgAZkRawAZDUt5qQ0NYfWN5+Mp//AjVo6nHlv6APWAq9i1rhTm
         ZvYJNqDXLwUQ1q0z2yKyXwY3kLIXA1WnAIp9mNkkz6eqpxs1KbJj8XwdGiDTtxRE+guB
         M9H00WaIbdP34NoUF9Vg3zT1Jj7SO2LdJcd0a6zZFasZmHMf8arGCthzlBNwKahqLHKI
         znWQ==
X-Received: by 10.68.253.1 with SMTP id zw1mr3332248pbc.30.1380137304195;
        Wed, 25 Sep 2013 12:28:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ed3sm25441618pbc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 12:28:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130925113651.GA19023@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235368>

Hi,

Michael S. Tsirkin wrote:

> Linus favors one-time use signed tags, e.g. for_linus.
> Unfortunately if I push to such a tag without -f,
> I get an error ("already exists").
> Would it make sense for there to be an option that makes it behave like
> a head, and allow fast-forward?

Nah, I think I prefer keeping the safety. :)

Are you pushing with "git push --tags", "git push --follow-tags", "git
push origin tag for-linus", or "git push origin for-linus"?  It's
possible that the last two should *always* allow overwriting tags
(regardless of whether the change is a fast-forward update), though I
haven't thought it through carefully.  In the former two cases, the
check for moving an existing tag seems useful and worth preserving.

In the meantime, a command like "git push origin +for-linus" seems
like a pleasant way to get the job done.  That way, nothing bad
happens if you get distracted and forget to add the for-linus argument
(unlike "git push -f origin").

Thanks,
Jonathan
