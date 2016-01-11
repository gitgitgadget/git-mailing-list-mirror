From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 22:01:02 +0100
Message-ID: <20160111210102.GE10612@hank>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
 <xmqqh9ikxbv7.fsf@gitster.mtv.corp.google.com>
 <20160111192844.GD10612@hank>
 <xmqqmvsbx62d.fsf@gitster.mtv.corp.google.com>
 <xmqqio2zx5mz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIja0-00057h-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933237AbcAKVAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:00:41 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34161 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbcAKVAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:00:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id b14so28093541wmb.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lIARztRB/L0JV5HrGmGPQKUwjffXQMKPmMptYqhvcm4=;
        b=ozrUrPd0k2U/qaDP2giuNUXBepXOREcKjotT19QSeaJIgosrVTL5z+9eDgFj8KoMeb
         U49bzH3Y76QUkavwHb/6F6ocHl7cYky3jYDp5PJ+SZWEwGpfVQbWP/J+2l971MG2k9Ty
         3x3TeWyyVauY4NVQ1cnKzemli2FYp4vG0MzW9q5FHdvlRd7ra2oqYEdx8IVjz6YCCgp0
         6W6nIu/QVvTlcN6/5pOmd6zEHubCV27Ub6758L/ZnrbR8Zhcr95Mqz7VwFavkYxGLSep
         cKkEp4+wQNWnA7PDBc1En+wjcQoY4zMb4ip72F6NORYnpFoorIUQtbhV6nEOlj763F1r
         fNRA==
X-Received: by 10.28.134.147 with SMTP id i141mr16712508wmd.87.1452546038793;
        Mon, 11 Jan 2016 13:00:38 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id aq3sm6244515wjc.1.2016.01.11.13.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 13:00:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqio2zx5mz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283716>

On 01/11, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I however fail to see why that necessitates to change use_index to
> > no_index, making the code harder to follow by introducing double
> > negation.
>
> Oh, perhaps your thinking is that there are multiple ways that
> use_index can become 0 (i.e. it could come from the config, could
> come from an explicit --no-index, or it could come from the new
> default behaviour), and the error messages deep in the callchain
> (long after option parsing is done) want to react to these
> differences.

Yes, that's what I was thinking, sorry if I wasn't clear before.
Though I think the a bit more generic error messages are just fine, so
we can avoid the double negation.

> To that I am somewhat sympathetic, but then use_index can become 1
> (rather, no_index can become 0) in multiple ways (i.e. it can be
> because the user is just using the command as designed for its
> primary use case, or the user explicitly said --no-no-index), so I
> am not sure.
>
> In either case, I do not have a strong objection.  Avoiding double
> negation is merely a moderately strong general preference.
