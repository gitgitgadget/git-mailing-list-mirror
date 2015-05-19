From: Junio C Hamano <gitster@pobox.com>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Tue, 19 May 2015 09:01:10 -0700
Message-ID: <xmqq617oa75l.fsf@gitster.dls.corp.google.com>
References: <20150519132958.GA21130@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Tue May 19 18:01:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YujxH-0005f0-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbbESQBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:01:15 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38225 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbbESQBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:01:12 -0400
Received: by igcau1 with SMTP id au1so17722796igc.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dR8pukGwpLlqUDHL9R+i144PjwEh1yIPa6Meq8ipfko=;
        b=0VOCC4oCFA9dhbIj+p/OECmHhrgZlnUiS0oo7TIIhaKKq6pWf3OgZN4MzOo5jyJKcj
         pO3RBeweiuXvQ/mXjP9fhHwS4mblWpn4g+dW0K+EQCIhtyIuFEBtli0zlLnQK5u6WGDl
         gurbYfMzl7+tZ8iECm4vCC7EtwSLI5Iv6fH2fPSBFpK0hrMycem9rKs/F7ei/yTXBhCK
         uklyZGMzehtVO6I4BjFvdW0lDX5WIAwV1PfDrm9jvwaVmNA2qcXpdAZ8vFEjT2e62nDa
         Gl8d3Zf4cjxx9P2i1pujiBdzjpxZgrLR3jc+S+tS5FFw0ZyjfrMqTOD0Gs4mOhjto+tg
         K4MA==
X-Received: by 10.43.39.1 with SMTP id tk1mr13742983icb.26.1432051272020;
        Tue, 19 May 2015 09:01:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id j4sm8137487igo.0.2015.05.19.09.01.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 09:01:11 -0700 (PDT)
In-Reply-To: <20150519132958.GA21130@frolo.macqel> (Philippe De Muyter's
	message of "Tue, 19 May 2015 15:29:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269365>

Philippe De Muyter <phdm@macq.eu> writes:

> Trying to understand, I have eventually done "git log" on my branch and
> on v3.15 with the following commands :
>
> git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
> git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits

Either

    git log --oneline v3.15..HEAD ;# show what I have not in theirs

or

    gitk v3.15...HEAD ;# show our differences graphically

may give you a better picture than what you did, which was to
artificially flatten the topology and lose the crucial information
as to which commit is the parents of which other commit.
