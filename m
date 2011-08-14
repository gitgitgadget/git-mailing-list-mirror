From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 11:48:19 -0500
Message-ID: <20110814164819.GA12747@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <CALkWK0m0KyZkOqVWJET=_Xy5GxwVfpPkB0OO1b2hJ8aN_x7hGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 18:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsdrU-0007LS-3h
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 18:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab1HNQs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 12:48:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58450 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab1HNQs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 12:48:26 -0400
Received: by gwaa12 with SMTP id a12so2844631gwa.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h6hf9MvGRO6cWXPQwAh8ZoUZbDlltv/vUN55AP2NfyQ=;
        b=PmdxeV0t/e+anx5UqIKKQCtLKYNzd21TCa4ffSXyaBS+SxR/lUhGnWLQSDH8u4SmGa
         k8JoDyPqw1yUCbqpgBhZUebNB22Ct2cvlxntMzF/zUZWYDkQvs++0+9bTg8oXHxC4hcn
         DXCjMBVZ/Ecj0TQXyq9HxVUiGFAz64h8D9jRU=
Received: by 10.147.54.19 with SMTP id g19mr3074556yak.21.1313340506448;
        Sun, 14 Aug 2011 09:48:26 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-227.dsl.chcgil.ameritech.net [68.255.108.227])
        by mx.google.com with ESMTPS id f4sm2856042yhn.27.2011.08.14.09.48.25
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 09:48:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0m0KyZkOqVWJET=_Xy5GxwVfpPkB0OO1b2hJ8aN_x7hGA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179336>

Ramkumar Ramachandra wrote:

> Putting an "int aggressive = 1" and passing the variable instead of
> the literal is a little inelegant.

What about a flag word, like for example read_sha1_file_extended()
takes?

[...]
>> Do you think there might
>> be scripts out there relying on being able to use "git read-tree
>> --reset -u HEAD" to clear away a failed cherry-pick before trying
>> again, and if so, can we do something about it?
>
> I'm not sure we can do anything about it -- we should probably put
> some kind of warning in the commit message?

That's necessary at a minimum.

I actually _don't_ think there might be many scripts relying on "git
read-tree --reset -u HEAD" to clear away a failed cherry-pick, simply
because very few people seem to use plumbing these days :) and those
who do might be of a mindset to use "git apply" instead of
cherry-pick.  But it would be prudent to run a code search to check
and to think carefully about the effect on people who did use the
"read-tree --reset && cherry-pick again" idiom.

Hope that helps.
Jonathan
