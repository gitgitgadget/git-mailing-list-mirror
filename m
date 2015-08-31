From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 14:44:34 -0400
Organization: Twitter
Message-ID: <1441046674.25570.15.camel@twopensource.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	 <1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	 <CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:44:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWU4Q-0005ai-WA
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbbHaSoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:44:39 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32807 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbHaSoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:44:38 -0400
Received: by qkdv1 with SMTP id v1so11049269qkd.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=9obdBiYvT+aV/sytAgUB6LlWaOSs0ffgwBhLZ9hkYgE=;
        b=bX9o52S0iFQ/ucBr3PcdwRbqlFlN0tprkRP+W35q8j2NHS4E7cpTliPb2gDm/I5nGu
         GHaFpdsr/tTyYcdIvMfVgK8gcVwl8cbkH8Jj5RFnxBn4HpMnA3hs8530R92BA+F20WZh
         zZM1e4D3yE7f84VUi9ASwUIHzH3+eRN8UhS9TJs/NAQNxEg2+t27uByQTOTGioYvCLvs
         gqLcczrScT0yy13uIAfjaJ8BskBdy40Xvkry/MDlCwhFoHLtAuY1EkhCavJKaa+7iKAa
         0nzXkNadCnRWBgVSE0pJtotRXP5QJIiYOvjn4JpH4c16tcfrQaAukWDPsBgIS6pZxIg2
         Tprg==
X-Gm-Message-State: ALoCoQmrggTEmyyfJ11NtOAZT8SVWPgIdsYdibdyE98IqpqSqb3uqcLZq0osCt1AO7+yweDDyOuA
X-Received: by 10.55.198.11 with SMTP id b11mr11802456qkj.53.1441046678082;
        Mon, 31 Aug 2015 11:44:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p6sm6727656qkl.12.2015.08.31.11.44.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 11:44:37 -0700 (PDT)
In-Reply-To: <CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276907>

On Mon, 2015-08-31 at 01:11 -0400, Eric Sunshine wrote:
> Stepping back a bit, is a for-each-foo()-style interface desirable?
> This sort of interface imposes a good deal of complexity on callers,
> demanding a callback function and callback data (cb_data), and is
> generally (at least in C) more difficult to reason about than other
> simpler interfaces. Is such complexity warranted?
> 
> An alternate, much simpler interface would be to have a function, say
> get_worktrees(), return an array of 'worktree' structures to the
> caller, which the caller would iterate over (which is a common
> operation in C, thus easily reasoned about).
> 
> The one benefit of a for-each-foo()-style interface is that it's
> possible to "exit early", thus avoiding the cost of interrogating
> meta-data for worktrees in which the caller is not interested,
> however, it seems unlikely that there will be so many worktrees linked
> to a repository for this early exit to translate into any real
> savings.

The other benefit is that there is no need to worry about deallocating
the list.  But that might be too minor to worry about.
