From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternative to manual editing with git add --patch
Date: Wed, 14 Oct 2015 10:50:32 -0700
Message-ID: <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com>
References: <561E6FBB.7060302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sven Helmberger <sven.helmberger@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 19:50:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmQCF-0001WB-TZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 19:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbbJNRuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 13:50:35 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32784 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbbJNRue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 13:50:34 -0400
Received: by pabrc13 with SMTP id rc13so60469091pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fpCcHBTcJUURaVXcMQPLZIptbJXHooSbWkfjeYGDcao=;
        b=HjCNuG+Cljb+IzvkYshXZOPXl6EYKve3PcDuDRMnPyvPa39yAEDl1AzxnjCqImy0uR
         /TDs9tcHlzXep9h+uL91cROAPNjaiSoWtj510qWtOVTNilMExqIWVum41QCR6LRcHZgq
         6+gJJjQLD2WjuwBNPVC9dRpetUul6MLfjYYxA7BZEfi2Z+j8D+wrLYn11fAGYeAZ3S3p
         zT7cEz9zNREIPvu4cP6UC00NIFlil1tBl02KDoliDubOm/iyBQCQflb/Oh/Kt/uK9Y+K
         68POES2pjCsHYfn2WY5hx/cvOuBwGbthHfld0LJzOs6A2y55ZYKY1/sfSgWkjbSpsryb
         wh5A==
X-Received: by 10.67.5.66 with SMTP id ck2mr4815405pad.137.1444845034028;
        Wed, 14 Oct 2015 10:50:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id bh4sm10809598pbb.62.2015.10.14.10.50.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 10:50:33 -0700 (PDT)
In-Reply-To: <561E6FBB.7060302@gmx.de> (Sven Helmberger's message of "Wed, 14
	Oct 2015 17:07:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279584>

Sven Helmberger <sven.helmberger@gmx.de> writes:

> I hope this hasn't been discussed before.
>
> I'm a big fan of cleanliness in commits and therefore often use git add
> --patch to sort code changes I made into the right commits etc.
>
> What I then often encountered was the situation where I happened to have
> inserted consecutive lines of code that conceptually belong to different
> commits. Normally I can nicely split patches, but not in this case,
> making manually editing the patch the only alternative.
>
> Shouldn't there be at least a way to quickly say line-by-line if you
> want to have it added or not?

I think this has been discussed a few times (and you should actually
hope that is the case---it shows that something that allows you to
split a hunk that consists of consecutive lines is not an obscure
and useless feature wish).  But I do not think we saw anybody came
up with a convincingly usable design (not the code design but how
the user interaction specifies where the hunk is cut in the first
place), let alone a prototype for it, so that we can discuss
further.  At least not yet.

As a quick-and-dirty change, you could invent a new variant of
's'plit that breaks a N-line hunk into N hunks with 1-line each, but
obviously that would not be a pleasant-enough UI to be called usable
when you have a hunk that adds 100 lines.  Perhaps "Split this hunk
into two by ending the earlier one immediately before the line that
has this substring" or something might be an idea?
