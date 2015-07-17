From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: don't update files flagged for deletion
Date: Fri, 17 Jul 2015 13:05:19 -0700
Message-ID: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
References: <1437162532-31933-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Anatole Shaw <git-devel@omni.poc.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 22:05:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGBsr-0007Q0-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 22:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbbGQUFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 16:05:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32905 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbGQUFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 16:05:21 -0400
Received: by padck2 with SMTP id ck2so65578274pad.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CoJosSV6rnosFlqEzVjinOanEeKrwT28GXOk7HaaYlY=;
        b=o72ikH4jeEwkEuPDzK/C1ymQGb8E+XDbQdXARU3egdX1L63CMC2k51x0aYoyJUYntl
         X9WvTPg4F97GjPyEl9ahLEebbN93CWSfeiCxmDFPXxQdwneq9XorJVLE87l7ysanavbp
         Epsi69b7sB0xD61Y5dBDhp7E5g4FumR4JpQC1+pRuPFAL484hr24z5B74xppBT2e+MLr
         yPcJSqbTpY40vxDtlNDe40uoEWwW4m/GGu+MjZgcbwy9u+0Y9hhMt7Q3SV6E5eRyoAh8
         fwek3PKMKs4/XkFHyjpKwxYqiI9tqrV7NjICk7MlBxeKZAgj0hQyLxAHEqgnf3RA/l1K
         93qA==
X-Received: by 10.68.190.197 with SMTP id gs5mr10342229pbc.81.1437163520893;
        Fri, 17 Jul 2015 13:05:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id 1sm12112952pds.79.2015.07.17.13.05.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 13:05:20 -0700 (PDT)
In-Reply-To: <1437162532-31933-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 17 Jul 2015 15:48:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274099>

David Turner <dturner@twopensource.com> writes:

> Don't update files in the worktree from cache entries which are
> flagged with CE_WT_REMOVE.  This is fixes merges in sparse
> checkouts.

s/This is/This/;

But more importantly, what is missing is "why" it is a good fix.
i.e. things like:

 - why is it wrong to update what is marked with CE_UPDATE bit to be
   updated in the working tree when CE_WT_REMOVE bit is on?

 - how that incorrect operation breaks which operation in what way?

 - how does the changed code fix that breakage?
