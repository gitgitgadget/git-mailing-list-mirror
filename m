From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give better 'pull' advice when pushing non-ff updates to current branch
Date: Mon, 23 Apr 2012 19:17:25 -0700
Message-ID: <xmqqvckpho0a.fsf@junio.mtv.corp.google.com>
References: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:17:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMVJt-0002jO-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab2DXCR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:17:28 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:44333 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab2DXCR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 22:17:27 -0400
Received: by wejx9 with SMTP id x9so5286wej.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 19:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=yLqTEgeTKmoGb7IydLGFeRAoahK8on1Jo1sVMoLCkiU=;
        b=jRmznvumRIMhldQPQuA009/bqlCEi3lGqefN63iYfzgh+U0NHboyObk7RisKwv4hXB
         3ftBG9HbMp3AJdFTr/tCnSE+imuAaQ3MQbxriQ91WxzuOf4Qjz+63zKHbDDFt02NcqDF
         nKCxLwni1oSdXDrB+u4pb0YEfNpydsvHA6Y0N+8v3Gt09cxaUykizE6SJ46JJtU15pG5
         pNzM8heVO6f0DPMnHQUSCXQKER9mMJyT+5QOekg9L7v2Kwm5pgIiMjT7gBGksuDMBhiN
         r9UckFkVh181l7SnhWfd3MiZhSAGst8Q9Y59/T+YcEWc1Of5T49XLth7PJQNk1kqXNMV
         6TWA==
Received: by 10.14.127.10 with SMTP id c10mr4255401eei.2.1335233846398;
        Mon, 23 Apr 2012 19:17:26 -0700 (PDT)
Received: by 10.14.127.10 with SMTP id c10mr4255386eei.2.1335233846292;
        Mon, 23 Apr 2012 19:17:26 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si16374462een.0.2012.04.23.19.17.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 19:17:26 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 1B48120004E;
	Mon, 23 Apr 2012 19:17:26 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 651CEE120A; Mon, 23 Apr 2012 19:17:25 -0700 (PDT)
In-Reply-To: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
	(Christopher Tiwald's message of "Mon, 23 Apr 2012 18:45:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk+QolVz6IBemNLZ7fdh/HhDFJSEskpL/8nbuGUD9JRNO9zYbQist44srhshfMxBPP8MInR+0XZ3Clf/VbDnQYtbq9au/slhL1AfkSuTGMshWk8T3rmf6mAu3pfGOCEFMXZAi/8Tm2bQbjg/ht5tpnRYePnemYEwkhCH6T+WNOcl0oEFb0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196178>

Christopher Tiwald <christiwald@gmail.com> writes:

> Suppose a user configured a local branch to track an upstream branch by
> a different name or didn't set an upstream branch at all. In these
> cases, issuing 'git pull' without specifying a remote repository or
> refspec can be dangerous. In the first case, 'git pull --rebase' could
> rewrite published history. In the second, 'git pull' without argument
> will fail.

The latter case of stopping without causing damage is hardly dangerous,
so I'll ignore that for now, but I am not sure what you mean by the
former.  A "devel" branch has "master" from "origin" (or whatever
branch.devel.remote is set) as its upstream (i.e. "devel" and "master"
are different strings).  "git pull" will then fetch "master" from the
other side, and either merge that into "devel" or rebuild "devel" on top
of it if you gave "--rebase".

But if you used "master", not "devel", as the name of your local branch,
I do not see anything changes.  You may have published the tip of
"master" to a third repository before doing "pull --rebase", and you may
be rebasing the history leading to that commit.  Even if there is no
third repository, your "master" may be pushed to some other branch of
"origin", so the story is the same.  If your counter-argument is "but
but but I will never ever push my 'master' to names other than 'master'
at 'origin'", then in your original settings where your local branch is
called "devel", you will never ever push you 'devel' to branches other
than 'master' at 'origin', exactly because its upstream is set to
'master'.

So what makes it dangerous is the use of "--rebase", if anything, isn't
it?  It does not seem to have much to do with how the local branches are
named.
