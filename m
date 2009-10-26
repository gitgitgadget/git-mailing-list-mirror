From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Mon, 26 Oct 2009 02:01:06 -0700
Message-ID: <4AE56552.70407@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <20091025160213.GA8532@localhost> <7vzl7eocd6.fsf@alter.siamese.dyndns.org> <20091026082931.GA6192@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 26 10:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2LS2-0000Jk-6w
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 10:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbZJZJBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 05:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbZJZJBG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 05:01:06 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:47003 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbZJZJBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 05:01:05 -0400
Received: by gxk8 with SMTP id 8so13245968gxk.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=nWUePrR7NbNYb+FmxHxJrdVW13RPDs1MvHp/P4GV17w=;
        b=R2f9oZuJkylAyp9UAigAQhS0fZpUEZK27zholnbgbGm/FcheYPDGXJYzcI9GPySm17
         v90o5EQtLpfnUENN4GXH5vIiM6PSUSwuIQAXkunFCyHQqV6sN66uqeEsmdpBccP+gqRo
         IvqM+HRbE+/eB9KdBxgr5CuR3Sn6k4O0HaMQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=XNa9IMF4YT5RedojkxsUNFcmpnqJ82a5Lw0DhS1idfNWR0EkwZ9Z4oiGZXnturCPOe
         atbcg52OTOMLB2Qws+8qR7SqfeikpAVWmf8d7jnjXFd2S6Bjml7BBam9O+V84z1K2IXM
         PIb0zK+9ukYCiXyuOQ0+O+pFs2hDXQszIhsNk=
Received: by 10.101.29.20 with SMTP id g20mr2318145anj.34.1256547669674;
        Mon, 26 Oct 2009 02:01:09 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 7sm1159914yxg.50.2009.10.26.02.01.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 02:01:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <20091026082931.GA6192@localhost>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131246>

Clemens Buchacher wrote:
>> I need to know, to sift acks/kudos based on facts that I can use to decide
>> when to release it to 'master', from wishful thinking that I shouldn't,
>> especially after seeing an obvious issue like the one reported by Stephen
>> Boyd a few days ago (http://mid.gname.com/4AE0190E.8020803@gmail.com/).
>
> I cannot follow that link. If you're referring to the "completion of
> commands available only in build environment" issue, that could also be
> considered a feature, because it allows completion of user-defined scripts.
>
> Why does your PATH include the build directory during make, Stephen?

The Makefile says:

git-completion.bash: git-completion.bash.in git-completion.bash.generate
        # Generate completions for binaries we have just built
        PATH="$(shell pwd)/../..:$$PATH" ./git-completion.bash.generate

Having user-defined scripts is a good point. Generating the completion
like this removes the possibility of such scripts from appearing in the
completion. Unless users are putting their own "git-*" scripts in their
build directory (sounds odd to me).

Personally, I'd rather keep it dynamic but I can see how it's useful to
get the 10x speedup. It would be really cool if we could have the best
of both worlds, where I keep my dynamic loading, but others can build
the completion and get the speedup.
