From: Ben Tebulin <tebulin@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Wed, 14 Aug 2013 11:47:13 +0200
Message-ID: <520B5221.3040308@gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org> <5204E018.4000808@gmail.com> <877gfok59m.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ben Tebulin <tebulin@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 14 11:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Xfn-000196-8O
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759814Ab3HNJrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 05:47:19 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48957 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759800Ab3HNJrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 05:47:18 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so1712622wiw.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0bsTVee8PnhmFjTjxNPt0jAITKABhi6ZqolLzeqjUF0=;
        b=CB60YpB21iFrbskclGWfAxv+0ODmmxmAaxIUdZgt+Tj4sR9+PLVDHEJhaZ6MMGLOom
         qDWIK/x7OTyopfnef1THWxW/gfp2sinea4qIc3z9oVwe5o0oCPbcuq2KFpSK3M41O1I2
         LhL+vXraJoijAHunl4SAqqHLwsUxuIlsDZvAU99XBAJlhSbpO+CC1nuxlQ+++XJtZJmj
         2CRrQbqQVlae9DZTlxrbyPsXbNtWs6lmp8PJZX/Y+Svrsb97J8MP7s+2G/QT9RATC6c3
         zdxbw1eWUXlCZeJY8UTxOoOi0mTeOhb7l+qz3kYahzcmDxzxi9wG5hSckE5x6jA5TJ0J
         fEOg==
X-Received: by 10.180.109.35 with SMTP id hp3mr1544500wib.52.1376473637210;
        Wed, 14 Aug 2013 02:47:17 -0700 (PDT)
Received: from [127.0.0.1] (ulmg-5d845cdb.pool.mediaWays.net. [93.132.92.219])
        by mx.google.com with ESMTPSA id a8sm1818820wie.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 02:47:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <877gfok59m.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232280>


> My best theory so far:
> malloc()/free() actually use mmap()/munmap() for large allocations.
> mallopt(3) tells me that [...]

Many things I don't grab at first go :-)

Last night I did a long git-bisect of the kernel and was able to
pinpoint a change in the Linux memory management as cause (see my
pre-prepared email I just sent).

Would that fit into your theory?

> You could try to gather some data on this by  [...]
Before I dive into that maybe you could throw a quick look at the
causing Kernel change (which reading from the words _could_ be related)
if this fits into the picture?

If yes, I'm happy to try to assist you in further pinning this issue down!
