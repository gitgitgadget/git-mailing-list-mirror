From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Wed, 15 Jul 2015 14:04:36 -0400
Organization: Twitter
Message-ID: <1436983476.7540.4.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	 <1436316963-25520-2-git-send-email-dturner@twopensource.com>
	 <559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	 <559D92CF.7000408@kdbg.org> <xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
	 <1436399058.4542.26.camel@twopensource.com>
	 <xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
	 <1436478800.4542.61.camel@twopensource.com>
	 <xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
	 <559F4A55.1070309@alum.mit.edu> <1436848402.5074.21.camel@twopensource.com>
	 <xmqqd1ztxubj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 20:04:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFR2y-0005Ts-2a
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 20:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbbGOSEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 14:04:40 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36220 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbGOSEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 14:04:39 -0400
Received: by qgy5 with SMTP id 5so21883928qgy.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 11:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=V8Ojo71+bl9SkHo44Fn1RCyv9bTzBVkJXE9k9GdwrMU=;
        b=lNFLqMUN0pcuHNvPZXvfUBJnHAj24r04UFJanh8aZk1IvtSmmdIQgOMPfHLiRk2wxp
         2UhwC/uwGSage5ESv5aMnZ0Bjp7WONA0w27di74jVxEjFH0zbQzxGyVREozQWX9EWhl3
         yj8TO5st+peBfDNPpd2JIyWmH3kSExORJyi5NQqiOG/Y9Vk8Mi1fBk5ayWSm5Cf6qPJt
         +q4AuCOmOcyGj7kntZgmho+5+eC7xuw7AET7GLwP6rh6J62XnkHF1aDISUNPcs8tDIDt
         P3yn8oTrR3GBgLCeoNk5JNct5LKjLlRoclNTaAZ1JltHhE4TI3uHmcJBY0lD4U9Lz3Wp
         4Wxg==
X-Gm-Message-State: ALoCoQnzr3Zx8W0SQJcEHb+sRt2o6eZ0TcMJ+PpYVcRXQpJQwfIO5Nw/dZ9hFJohr7UK/GeQw5ms
X-Received: by 10.55.41.229 with SMTP id p98mr10008162qkp.99.1436983478453;
        Wed, 15 Jul 2015 11:04:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v44sm2647058qgd.21.2015.07.15.11.04.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2015 11:04:37 -0700 (PDT)
In-Reply-To: <xmqqd1ztxubj.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273990>

On Wed, 2015-07-15 at 09:24 -0700, Junio C Hamano wrote:
> > On reflection, I think that this would also be a reasonable approach to
> > take for stash, which does not fall into any of the listed categories.
> > It's not a pseudoref because it's not all-caps and it starts with refs/.
> > Unlike other pseudorefs, it needs a reflog.  But like HEAD and unlike
> > other refs, it (and its reflog) wants to be per-worktree.
> 
> I think we want stash, unlike HEAD, to be shared across worktrees,
> and contrib/workdir gets this right.
> 
> So there is nothing that makes refs/stash like CHERRY_PICK_HEAD at
> all.

I just did a brief survey here and folks here agree with you.  So, I'll
adjust my patches accordingly.

> > Are there
> > other ref-like-things in this category (which I'll call "per-worktree
> > refs")?  I guess one set of these is submodules' HEADs.
> 
> I've been assuming that a secondary worktree of superproject will
> get its own & corresponding secondary worktree of a submodule, which
> would automatically give per-worktree "submodule's HEADs" and
> everything else that has to be per-worktree.  Am I missing something
> or are there any more need for underlying machinery than what we
> currently have for secondary worktrees for a single project tree?

That sounds good to me, but judging by the docs, that's not yet
implemented.  So I'm going to worry about that when it is implemented.
