From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH 5/6] revert: add --ff option to allow fast forward
 when cherry-picking
Date: Tue, 02 Feb 2010 08:56:25 +0100
Message-ID: <4B67DAA9.4050709@gnu.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org> <c07716ae1002010443p4e0443feke14e5f877584640f@mail.gmail.com> <4B66E53D.8050204@gnu.org> <201002020613.48067.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 08:56:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcDd3-0005wy-G5
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 08:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929Ab0BBH4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 02:56:30 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:52320 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab0BBH42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 02:56:28 -0500
Received: by bwz23 with SMTP id 23so314584bwz.21
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 23:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YytmPE3Kkx+pCowGC97MN6mKV025y1NSpCmxQm/3mgc=;
        b=IsCqZoZKdRO71fbMYDaLekBTHIaUCT73v6sj7KxEl62NJlUpw4/M5k+U4QPb284GM0
         W0QAp1YWS0TmOJVXqLAy4f1Cw8Nmo/fwq8XYm+wYAmBWBfgeay+pDWlnyPH5mK0MZhEg
         72+Irl4V+pybh1tzXXN2kgKD6Nbmlmnvuje6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=E2HcUIErLl2VH/hieW/OZSWbHLTTnRnT3irQ6AA8o4rnSxbOd6snJ56MMeKZIqf86P
         Qm0MeeTIgoyMFgBGJXq4C5T3efbXsExavq6nGpZwscvPSwNj/xEngoAWwvr/KSo67Dm0
         tCUq1otnLQg4mWKa0O36NAq3R5HPXo8QZiY+E=
Received: by 10.204.29.10 with SMTP id o10mr4217581bkc.82.1265097386639;
        Mon, 01 Feb 2010 23:56:26 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 13sm2513869bwz.14.2010.02.01.23.56.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 23:56:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <201002020613.48067.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138691>

>> and that even without
>> setting the variables, "git cherry-pick" will pick a new commit date but
>> "git cherry-pick --ff" wouldn't.  The latter, I think is the only
>> difference that is worth pondering further.
>
> Because --no-ff could be used when the GIT_COMMITTER_* and GIT_AUTHOR_* env
> variable should be respected? Or because we should check if one of these
> env variable is set and, if that is the case, we should not fast forward?

I wish it could be the former, at least in the long run; after all git 
merge fast-forwards by default, and it doesn't adjust its behavior if 
GIT_COMMITTER_* is passed.

Anyway, your plan of starting with --ff and changing the default to 
--no-ff later seems fine.  Maybe you can add --no-ff now already, though 
it would be a no-op.

>> Note that "-e --ff" would error out; however if --ff would be the
>> default, "-e" would probably choose between fast-forward and
>> non-fast-forward depending on whether the commit message was edited.
>
> Yeah, but let's change the default later please.

Sure.

Paolo
