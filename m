From: Shawn Pearce <sop@google.com>
Subject: Re: Excluding some refspecs from git push?
Date: Sun, 24 Jul 2011 12:19:33 -0700
Message-ID: <CAH+XAApbbMSPW9XJPjYnmqNiECoWBz5du6CeD_hfAww9o_LcXA@mail.gmail.com>
References: <20110724004650.408741c5@x34f>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, repo-discuss <repo-discuss@googlegroups.com>
To: Paul Sokolovsky <paul.sokolovsky@linaro.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql4El-0003qd-PK
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab1GXTT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 15:19:59 -0400
Received: from smtp-out.google.com ([216.239.44.51]:30298 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab1GXTT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 15:19:57 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p6OJJuVI012560
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 12:19:56 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1311535196; bh=+s+P3HrfoH0PNf7z8NPhUc10hpE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WeMEWIxv1eKS1mx3FNYAO0cJ8a3aLNU9Q8UtLMf5n05stpWIwqS1bu9dXx1W9e1KU
	 6FbWiwSTD7zXS5vVBx1Mg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:from:date:
	message-id:subject:to:cc:content-type:x-system-of-record;
	b=RFaZs4OA6jiSTUADE5hTH/5BwJ5QsB5XfoiMzN01WOJLiv0fN1MQi+eLXJRuWiVg5
	MoSJkXrBmWyh2aokf/lNA==
Received: from yic15 (yic15.prod.google.com [10.243.65.143])
	by hpaq3.eem.corp.google.com with ESMTP id p6OJJrgs001965
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 12:19:54 -0700
Received: by yic15 with SMTP id 15so2225834yic.26
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SxG4RCpBjtfu8PLitqh/Ao+6pEG6ODUPy6yyrdQZILw=;
        b=coW8TYDplcYL+M4VHIQQj2gPy0YhIa3Ty1jZPDeL2rk3KjjFSxTHNu1Svmoy1zDCRL
         hAJmgXOsquoO+dnpbCTw==
Received: by 10.91.42.20 with SMTP id u20mr3620092agj.107.1311535193326; Sun,
 24 Jul 2011 12:19:53 -0700 (PDT)
Received: by 10.91.203.15 with HTTP; Sun, 24 Jul 2011 12:19:33 -0700 (PDT)
In-Reply-To: <20110724004650.408741c5@x34f>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177772>

On Sat, Jul 23, 2011 at 14:46, Paul Sokolovsky
<paul.sokolovsky@linaro.org> wrote:
> Is there a way to exclude some refspec from being processed by "git
> push"? What I'm looking for is a syntax like:
>
> push some-remote 'refs/*' '!refs/meta/config'
>
> , with the meaning of "push all refs except refs/meta/config". What I'm
> trying to do with this is to find out a generic way to mirror git
> repositories managed by the Gerrit tool
> (http://code.google.com/p/gerrit/), which since version 2.2 uses
> refs/meta/config branch to store repository-local configuration, so
> should not be mirrored between two Gerrit's.

Unfortunately no. But you should be able to just mirror the namespaces
that matter:

  refs/heads/*
  refs/tags/*

Its not a good idea to mirror refs/meta/config unless you want the
same access controls, *AND ITS REALLY NOT A GOOD IDEA TO MIRROR
refs/changes/* BETWEEN GERRIT SERVERS*. Yes, that last part is worth
writing in full caps.
