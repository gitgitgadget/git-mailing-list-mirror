From: Junio C Hamano <gitster@pobox.com>
Subject: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Wed, 05 Aug 2015 10:03:41 -0700
Message-ID: <xmqqmvy54qhe.fsf@gitster.dls.corp.google.com>
References: <349031438778845@web22j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ivan Chernyavsky <camposer@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN26X-0003T9-6K
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbHERDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:03:44 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35882 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHERDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:03:44 -0400
Received: by pacrr5 with SMTP id rr5so5489700pac.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=p+AE6dZ8bH/M66QGJeDosb4SzfSU/G82DeOaYG/2Quw=;
        b=O/GZPfkNKKLlC6Kx+ah1Uedbhs0HmjLTF+J8mgU7iSrfdWmpi/IFECLsqUu4fEqbU7
         5vVdxszz+5PazwG4XHwbY9JCmvFpjEVkAdpQiCd/v1+4Rbtnvm/13H3XBGISMqNONhtm
         KvFzDhV3lB8P7koU3HEFoQKbsthQmFBmPIlVGvH8G7eN1fYeIZFO/Q5gL1/mHybRsX+0
         x/viKBvwPIA2MJJVRenc+9tnIw/r4tn+861C+peEyZb2xIUr6by98Y8NQN4Y393Wtg/W
         jLAOvwW5Ak17Indxxk0b2PJ2G3QDajaPpkTCaaUqLWpd2MxnqBO1jD+KSW8brbw6CUr+
         Dnqg==
X-Received: by 10.66.66.130 with SMTP id f2mr21879195pat.120.1438794223591;
        Wed, 05 Aug 2015 10:03:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id nl10sm3518517pdb.38.2015.08.05.10.03.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 10:03:42 -0700 (PDT)
In-Reply-To: <349031438778845@web22j.yandex.ru> (Ivan Chernyavsky's message of
	"Wed, 05 Aug 2015 15:47:25 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275376>

Ivan Chernyavsky <camposer@yandex.ru> writes:

> For some time I'm wondering why there's no "--grep" option to the "git
> branch" command, which would request to print only branches having
> specified string/regexp in their history.
>
> So for example:
>
>     $ git branch -r --grep=BUG12345
>
> should be roughly equivalent to following expression I'm using now for the same task:
>
>     $ for r in `git rev-list --grep=BUG12345 --remotes=origin`; do git
> branch -r --list --contains=$r 'origin/*'; done | sort -u
>
> Am I missing something, is there some smarter/simpler way to do this?

I think people do things like:

    git log --all --decorate --grep=...
