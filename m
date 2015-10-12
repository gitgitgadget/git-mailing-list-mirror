From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 09:02:35 -0700
Message-ID: <xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561B69AE.8050403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 18:02:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlfYg-0004CQ-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 18:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbbJLQCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 12:02:39 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35730 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbJLQCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 12:02:38 -0400
Received: by pabve7 with SMTP id ve7so99639731pab.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TT2LASe3Ech+cgwvdGzVMPD6aJJa18NZ15GpN/Lhd3o=;
        b=kuwRQu/pbbwRG5h3t0icZhxhOx9RKxRc21LjSsECNzplqk5woRMDVMIZcPJDSqBJb3
         Jp92UGHRhUv62rNjsvh+P+u4eE+nz7fTCLWmuvTttksUGCEAHpF36AooLijgIIbAlE7j
         AdqpI/6Xdj20ECQvIBNVtICLx925f9TC8KKKgndL9TqgVvmIGzI5fkEHmmgr4npTh0Rm
         4GS1IA1tnae0HzvZkg4wJuvYwbrOHLpEiOtVbCqEFHcOk5QPg1zu1MPFrKa4d89vwhKp
         XisVpINYDCROX6Q2BndHnlfKZlUghhg1HFLEfwyJJYijNJ8xzGW9yT1hr19/W6Z1cj+q
         e8Ew==
X-Received: by 10.68.69.40 with SMTP id b8mr35526931pbu.84.1444665757719;
        Mon, 12 Oct 2015 09:02:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id ou1sm19182735pbb.0.2015.10.12.09.02.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 09:02:36 -0700 (PDT)
In-Reply-To: <561B69AE.8050403@gmail.com> (Sebastian Schuberth's message of
	"Mon, 12 Oct 2015 10:05:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279377>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Semantically, it does not seem correct to me that configuarion goes to
> the install step. As "make test" will build git anyway, I'd instead
> propose to get rid of "install" and just say:
>
> before_script: make configure && ./configure
>
> script: make --quiet test

Very good point.  Do we even need to do anything in the "install"
target?  We aim to be able to testable without any installed Git,
and not running "make install" at all, ever, would be one way to
make sure that works.

This is a slightly related tangent, but we saw a few build issues
reported recently on customized configurations like NO_PTHREAD.  If
we are to start using automated tests, I wonder if we want to build
(and optionally test) with various combinations of the customization
options (e.g. NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL etc.)

Thanks.
