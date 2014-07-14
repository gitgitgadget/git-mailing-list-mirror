From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 15:32:08 -0700
Organization: Twitter
Message-ID: <1405377128.3775.34.camel@stross>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	 <1405140276-32162-4-git-send-email-dturner@twitter.com>
	 <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	 <xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
	 <53C41456.2000006@ramsay1.demon.co.uk>
	 <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
	 <53C42453.1090109@ramsay1.demon.co.uk>
	 <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6onB-0004yv-VX
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 00:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbaGNWcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 18:32:14 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:37919 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251AbaGNWcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 18:32:13 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so3851983qaq.15
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 15:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=/zgv7NICGjNxLRsdZNKJHD+fVCjoLL8YjhTnBdqNUeI=;
        b=QdD1t4ei0RNvLh8iXysIlVx7RSjdtlXabiJEp/a59h9Mw1ld93uyj0WrX2fzWEsdci
         7IfANiS511lebk3OZy1K2AQtGeyjIal+EvANNg8OyL+pVGmGyyJEL/D/l2Lq8CRqxaeJ
         b6sREgPkflXQu8I1dgeHdLbMxINzGEYITBxwbwOFC0loeRF7sPUfEM7wjIWqqhJnGZuQ
         3l+/c/Fjhbw6xeZ9cV/tyoWaS6dRCkK162V3+KRt8tUOQBoZJkTLtbkkU5lk/tiY6sQn
         Sg2mDQX8F4QTdEGdT2qa6/ePlc/5b8Teopq+s5EBRsDv5Zn9imVIntyvpWpmlZ3FcUND
         IVsw==
X-Gm-Message-State: ALoCoQkGaY1tQ5haOjyAQyg0rk65hXR0E4ddEjkgeTxzqhU82nSZPrqvN6uXn0qVQH3d1xcocKcv
X-Received: by 10.224.152.5 with SMTP id e5mr26424046qaw.65.1405377132506;
        Mon, 14 Jul 2014 15:32:12 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id h5sm10395382qgf.19.2014.07.14.15.32.10
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 15:32:11 -0700 (PDT)
In-Reply-To: <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253545>

On Mon, 2014-07-14 at 15:16 -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
> > On 14/07/14 18:51, Junio C Hamano wrote:
> >> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> >> 
> >>> that the merge commit 7608c87e fails. Looking at the details of the
> >>> merge resolution, made me think of Duy's split index work.
> >> 
> >> Yes, there is a deliberately dropped hunk from dt/cache-tree-repair
> >> in that merge, because the topic relied on being able to say "here
> >> is the file descriptor, write the index to it", which no longer is
> >> available with the split-index topic.
> >
> > Ah, OK. Sounds like everything is under control then.
> 
> Wasn't, but now I think it is ;-)
> 
> David, could you please double check the conflict resolution at
> 882426ea (Merge branch 'dt/cache-tree-repair' into jch, 2014-07-14),
> at about the middle between master..pu?  By eyeballing
> 
>     git diff 882426ea^ 882426ea
> 
> we should see what your series would have done if it were based on
> top of the nd/split-index topic.  The most iffy is the first hunk of
> change to builtin/commit.c, which is more or less my rewrite of what
> you did on top of 'master'.

LGTM.  And the tests all pass.

> The change to builtin/checkout.c also seems somewhat iffy in that we
> treat the_index.cache_tree (aka "active_cache_tree") as if cache
> trees are something we can manipulate independent of a particular
> index_state (which has been the rule for a long time), even though
> in the world order after nd/split-index topic, cache_tree_update()
> can no longer be used on a cache-tree that is not associated to a
> particular index_state.  It is not a problem with your series, but
> comes from nd/split-index topic, and it might indicate a slight
> unevenness of the API (i.e. we may want to either insist that the
> public API to muck with a cache-tree outside cache-tree.c must be
> accessed via an index-state and never via a bare cache-tree
> structure, by insisting that cache_tree_fully_valid() to take a
> pointer to an index-state as well; or we may want to go the other
> way and allow API users to pass a bare cache-tree without the
> index-state when the latter is not absolutely necessary, by changing
> cache_tree_update() to take a cache-tree, not an index-state).

I agree that some sort of API updates like would be an improvement. But
this seems to work for now.
